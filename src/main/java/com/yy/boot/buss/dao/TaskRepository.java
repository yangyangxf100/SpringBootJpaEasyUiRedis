package com.yy.boot.buss.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yy.boot.buss.model.Task;

public interface TaskRepository extends PagingAndSortingRepository<Task, Integer> ,JpaSpecificationExecutor {
}
