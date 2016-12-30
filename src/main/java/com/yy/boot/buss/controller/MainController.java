package com.yy.boot.buss.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yy.boot.buss.model.Task;
import com.yy.boot.buss.service.TaskService;
import com.yy.boot.buss.vo.PageResult;

/* Spring MVC Controller for JSPs */

@Controller
@RequestMapping("/task")
public class MainController {
	@Autowired
	private TaskService taskService;

	@Value("${mail.host}")
	private String host;

	/**
	 * 打开页面
	 * 
	 * @param request
	 * @return
	 */
	@GetMapping("/open")
	public String open(HttpServletRequest request) {
		return "task/loginMng";
	}

	/**
	 * 搜索
	 * 
	 * @param request
	 * @param task
	 * @param currentPage
	 * @return
	 */
	@GetMapping("/search")
	@ResponseBody
	public PageResult search(HttpServletRequest request, @ModelAttribute Task task, @RequestParam("page") int currentPage) {
		int size = 10;
		currentPage=currentPage-1;
		Sort sort = new Sort(Direction.DESC, "id");
		Pageable pageable = new PageRequest(currentPage, size, sort);
		return taskService.findAll(pageable,task);
	}

	/**
	 * 根据 id 查询
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping(value = "/{id}")
	@ResponseBody
	public Task getById(@PathVariable int id) {
		return taskService.find(id);
	}
	
	/**
	 * 根据 ids 删除
	 * @param ids
	 */
	@GetMapping(value = "/delete")
	@ResponseBody
	public void delById(@RequestParam("ids") String ids) {
		String[] arr = ids.split(",");
		for(String id : arr){
			taskService.delete(Integer.parseInt(id));
		}
	}
	
	/**
	 * 添加
	 * 
	 * @param task
	 * @param bindingResult
	 * @param request
	 */
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public void saveOrUpdate(@ModelAttribute Task bean, BindingResult bindingResult, HttpServletRequest request) {
		bean.setDateCreated(new Date());
		taskService.save(bean);
	}

}
