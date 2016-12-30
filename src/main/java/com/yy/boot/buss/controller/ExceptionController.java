package com.yy.boot.buss.controller;


import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 错误页面
 * 
 * @author yang
 *
 */
@RestController
public class ExceptionController implements ErrorController {

	@RequestMapping(value = "/error")
	public String handleError() {
		return "客户端错误";
	}
	
	@Override
	public String getErrorPath() {
		return null;
	}

}
