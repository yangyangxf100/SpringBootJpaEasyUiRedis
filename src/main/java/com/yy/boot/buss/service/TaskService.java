package com.yy.boot.buss.service;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.yy.boot.buss.dao.TaskRepository;
import com.yy.boot.buss.model.Task;
import com.yy.boot.buss.vo.PageResult;

@Service
public class TaskService {

	private final TaskRepository taskRepository;

	public TaskService(TaskRepository taskRepository) {
		this.taskRepository = taskRepository;
	}

	/**
	 * 查询带分页
	 * 
	 * @param page
	 * @param task
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public PageResult findAll(Pageable page, Task task) {
		Specification<Task> specification = buildSpecification(task);

		Page<Task> pageList = taskRepository.findAll(specification, page);
		PageResult pageResult = new PageResult();
		pageResult.setRows(pageList.getContent());
		pageResult.setTotal(pageList.getTotalElements());
		return pageResult;
	}

	/**
	 * 查询全部
	 * 
	 * @return
	 */
	public List<Task> findAll() {
		List<Task> tasks = new ArrayList<Task>();
		for (Task task : taskRepository.findAll()) {
			tasks.add(task);
		}

		return tasks;
	}

	/**
	 * 查询全部
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Task> findAll(Task task) {
		Specification<Task> specification = buildSpecification(task);

		return taskRepository.findAll(specification);
	}

	/**
	 * 根据 id 查询
	 * 
	 * @param id
	 * @return
	 */
	public Task find(int id) {
		return taskRepository.findOne(id);
	}

	/**
	 * 添加
	 * 
	 * @param task
	 */
	@Transactional
	public void save(Task task) {
		taskRepository.save(task);
	}

	/**
	 * 根据 id 删除
	 * 
	 * @param id
	 */
	public void delete(int id) {
		taskRepository.delete(id);
	}

	/**
	 * 构建查询条件
	 * 
	 * @param obj
	 * @return
	 */
	private Specification<Task> buildSpecification(Task obj) {
		Specification<Task> specification = new Specification<Task>() {
			@SuppressWarnings("rawtypes")
			public Predicate toPredicate(Root<Task> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				List<Predicate> predicateList = new ArrayList<Predicate>();
				try {
					Field[] fields = obj.getClass().getDeclaredFields();
					for (Field field : fields) {
						field.setAccessible(true);
						Class fieldClass = field.getType();
						if (fieldClass.equals(String.class)) {
							if (!StringUtils.isEmpty((String) field.get(obj))) {
								predicateList.add(cb.like(root.get(field.getName()), "%" + field.get(obj) + "%"));
							}
						} else if (fieldClass.equals(int.class) || fieldClass.equals(Integer.class)) {
							if ((Integer) field.get(obj) != null & (int) field.get(obj) != 0) {
								predicateList.add(cb.like(root.get(field.getName()), "%" + field.get(obj) + "%"));
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				Predicate[] predicateArr = new Predicate[predicateList.size()];
				for (int i = 0; i < predicateList.size(); i++) {
					predicateArr[i] = predicateList.get(i);
				}
				query.where(predicateArr);

				return null;
			}
		};
		return specification;
	}
}
