package com.yy.boot.framework.utils;



import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

public class ChangeRelection {
	/**
	 * 将源对象的值，放到与目标对象属性相同的值里面
	 * 
	 * @param sourceClass
	 * @param targetClass
	 * @param sourceObj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Object changeProValue(Class sourceClass, Class targetClass, Object sourceObj) {
		try {
			Object ret = targetClass.newInstance();
			Field[] target = targetClass.getDeclaredFields();
			for (int j = 0; j < target.length; j++) {
				String targetProperName = target[j].getName();
				Field[] source = sourceClass.getDeclaredFields();
				for (Field f : source) {
					String sourceProperName = f.getName();
					if (sourceProperName.equals(targetProperName)) {
						f.setAccessible(true);
						target[j].setAccessible(true);
						Object v = f.get(sourceObj);
						if(v==null){
							target[j].set(ret, null);
						}else{
							target[j].set(ret, v);
						}
					}
				}
			}
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sourceObj;
	}

	/**
	 * 将源对象的值，放到与目标对象属性相同的值里面
	 * 
	 * @param sourceClass
	 * @param targetClass
	 * @param objList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static List<Object> changeProValueList(Class sourceClass, Class targetClass, List<Object> objList) {
		List<Object> retList = new ArrayList<Object>();
		for (Object o : objList) {
			Object ret = changeProValue(sourceClass, targetClass, o);
			retList.add(ret);
		}
		return retList;
	}

	public static void changeObj(Object oldDto, Object newDto) throws Exception {
		// 获得所有的字段
		Field[] fields = newDto.getClass().getDeclaredFields();
		for (Field field : fields) {
			field.setAccessible(true);
			Class fieldClass = field.getType();
			if (fieldClass.equals(String.class)) {
				if (StringUtils.isEmpty((String) field.get(newDto))) {// 如果新的是空的,则将jiu的替换上去
					field.set(newDto, field.get(oldDto));
				}
			}else if (fieldClass.equals(int.class) || fieldClass.equals(Integer.class) ) {
				if ((Integer) field.get(newDto)==null) {// 如果新的是空的,则将jiu的替换上去
					field.set(newDto, field.get(oldDto));
				}
			}else  {
				if (field.get(newDto)==null) {// 如果新的是空的,则将jiu的替换上去
					field.set(newDto, field.get(oldDto));
				}
			}
		}
	}

	/**
	 * 找出有空的字段
	 * 
	 * @param className
	 * 		class
	 * @param obj
	 * 		要处理的对象
	 * @param fields
	 * 		要查看的属性
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static List<String> findEmptyFields(Class className, Object obj, String... fields) {
		List<String> retList = new ArrayList<String>();
		for (String field : fields) {
			try {
				Field f = className.getDeclaredField(field);
				f.setAccessible(true);
				
				Class fieldClass = f.getType();
				if (fieldClass.equals(String.class)) {
					String value = (String)f.get(obj);
					if(value != null && value.length()>0){
					}else{
						retList.add(field);
					}
				} else if (fieldClass.equals(int.class) || fieldClass.equals(Integer.class) ) {
					if(f.get(obj)==null){
						retList.add(field);
					}else{
						int value = (Integer) f.get(obj);
						if(value == 0){
							retList.add(field);
						}
					}
				}  else {
					if(f.get(obj)==null){
						retList.add(field);
					}
				}  
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}
		return retList;
	}
	
	
	public static void getFiledAndValue(Object newDto ) throws Exception {
		// 获得所有的字段
		Field[] fields = newDto.getClass().getDeclaredFields();
		for (Field field : fields) {
			field.setAccessible(true);
			Class fieldClass = field.getType();
			if (fieldClass.equals(String.class)) {
				if (!StringUtils.isEmpty((String) field.get(newDto))) { 
					System.out.println(field.getName()+":"+field.get(newDto));
				}
			}else if (fieldClass.equals(int.class) || fieldClass.equals(Integer.class) ) {
				if ((Integer) field.get(newDto)!=null) { 
					System.out.println(field.getName()+":"+field.get(newDto));
				}
			}else  {
				if (field.get(newDto)!=null) { 
					System.out.println(field.getName()+":"+field.get(newDto));
				}
			}
		}
	}
	
	public static void main(String[] args) throws Exception {
		 
	}
}
