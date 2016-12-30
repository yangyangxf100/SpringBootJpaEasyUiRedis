package com.yy.boot.framework.aop;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 打印 web 层的请求和响应信息
 * 
 * http://www.tuicool.com/articles/3qY7vqj
 * 
 * @author yang
 *
 */
//@Aspect
//@Component
public class LogAop {

	private Logger logger = Logger.getLogger(getClass());
	ThreadLocal<Long> startTime = new ThreadLocal<>();

	/**
	 * 定义一个切入点.
	 */
	@Pointcut("execution(public * com.yy.boot.buss.controller..*.*(..))")
	@Order(1)
	public void webLog() {
	}

	/**
	 * 在切面执行之前
	 * 
	 * @param joinPoint
	 * @throws Throwable
	 */
	@Before("webLog()")
	public void doBefore(JoinPoint joinPoint) throws Throwable {
		startTime.set(System.currentTimeMillis());

		// 接收到请求，记录请求内容
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();

		// 记录下请求内容
		logger.info("URL : " + request.getRequestURL().toString());
		logger.info("HTTP_METHOD : " + request.getMethod());
		logger.info("IP : " + request.getRemoteAddr());
		logger.info("CLASS_METHOD : " + joinPoint.getSignature().getDeclaringTypeName() + "."
				+ joinPoint.getSignature().getName());
		logger.info("request param : " + Arrays.toString(joinPoint.getArgs()));

	}

	/**
	 * 在切入点return内容之后切入内容（可以用来对处理返回值做一些加工处理）
	 * 
	 * @param ret
	 * @throws Throwable
	 */
	@AfterReturning(returning = "ret", pointcut = "webLog()")
	public void doAfterReturning(Object ret) throws Throwable {
		// 处理完请求，返回内容
		logger.info("RESPONSE : " + ret);
		logger.info("SPEND TIME : " + (System.currentTimeMillis() - startTime.get()));
	}

}