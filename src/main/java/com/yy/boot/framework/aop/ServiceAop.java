package com.yy.boot.framework.aop;

import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;

/**
 * 打印 service 的請求響應信息 http://www.tuicool.com/articles/3qY7vqj
 * 
 * @author yang
 *
 */
@Aspect
@Component
public class ServiceAop {

	private static final String KEY_CONNECT_SYMBOL = "-";
	private Logger logger = Logger.getLogger(getClass());
	@Autowired
	private RedisTemplate<Object, Object> redisTemplate;

	@Value("${cache.flag}")
	private boolean isUseCache;

	private ValueOperations<Object, Object> valueOperations;

	long cacheSeconds = 60 * 60 * 3;

	@PostConstruct
	public void init() {
		valueOperations = redisTemplate.opsForValue();
	}

	/**
	 * 定义一个切入点.
	 */
	@Pointcut("execution(public * com.yy.boot.buss.service..*.*(..))")
	@Order(2)
	public void serviceAop() {
	}

	@Around("serviceAop()")
	public Object Interceptor(ProceedingJoinPoint pjp) {
		long beginTime = System.currentTimeMillis();
		MethodSignature signature = (MethodSignature) pjp.getSignature();
		Method method = signature.getMethod(); // 获取被拦截的方法
		String methodName = method.getName(); // 获取被拦截的方法名
		logger.info("请求开始，方法： " + methodName);

		Object result = null;
		StringBuilder reqKey = new StringBuilder();
		Object[] args = pjp.getArgs();
		for (Object param : args) {
			if (param instanceof Object[]) {
				Object[] objs = (Object[]) param;
				if (objs == null || objs.length == 0)
					continue;
				else
					reqKey.append("[");
				for (Object obj : objs) {
					appendValue(reqKey, obj);
				}
				reqKey.append("]");
			} else {
				appendValue(reqKey, param);
			}
		}

		if (isUseCache) {
			Object cacheRet = valueOperations.get(reqKey.toString());
			if (cacheRet != null) {
				return cacheRet;
			}
		}
		try {
			result = pjp.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}

		long costMs = System.currentTimeMillis() - beginTime;
		System.out.println(methodName + "请求结束，耗时：" + costMs + "ms");

		if (isUseCache) {
			valueOperations.set(reqKey.toString(), result, cacheSeconds, TimeUnit.SECONDS);
		}
		return result;
	}

	private void appendValue(StringBuilder paramValues, Object param) {
		if (param == null)
			return;
		if (param instanceof Collection || param instanceof Map) {
			Gson gson = new Gson();
			paramValues.append(gson.toJson(param) + KEY_CONNECT_SYMBOL);
		} else if (param instanceof String) {
			paramValues.append((param.toString().trim()) + KEY_CONNECT_SYMBOL);
		} else if (param instanceof Object) {
			Gson gson = new Gson();
			paramValues.append(gson.toJson(param) + KEY_CONNECT_SYMBOL);
		}
	}

}