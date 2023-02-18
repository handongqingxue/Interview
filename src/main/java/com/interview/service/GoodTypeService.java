package com.interview.service;

import java.util.List;

import com.interview.entity.*;

public interface GoodTypeService {
	
	int add(GoodType gt);

	List<GoodType> getList(String name);

	GoodType getById(Integer id);

	int edit(GoodType gt);

	int deleteByIds(String ids);

	List<GoodType> getSelectList();
}
