package com.interview.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.interview.dao.*;
import com.interview.entity.*;
import com.interview.service.*;

@Service
public class GoodTypeServiceImpl implements GoodTypeService {

	@Autowired
	GoodTypeMapper goodTypeDao;

	public int add(GoodType gt) {
		// TODO Auto-generated method stub
		return goodTypeDao.add(gt);
	}

	public List<GoodType> getList(String name) {
		// TODO Auto-generated method stub
		return goodTypeDao.getList(name);
	}

	public GoodType getById(Integer id) {
		// TODO Auto-generated method stub
		return goodTypeDao.getById(id);
	}

	public int edit(GoodType gt) {
		// TODO Auto-generated method stub
		return goodTypeDao.edit(gt);
	}
}
