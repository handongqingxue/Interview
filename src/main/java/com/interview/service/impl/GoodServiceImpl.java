package com.interview.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.interview.dao.*;
import com.interview.entity.*;
import com.interview.service.*;

@Service
public class GoodServiceImpl implements GoodService {
	
	@Autowired
	GoodMapper goodDao;

	public int add(Good good) {
		// TODO Auto-generated method stub
		return goodDao.add(good);
	}

	public List<Good> getList(String name, String goodTypeName) {
		// TODO Auto-generated method stub
		return goodDao.getList(name,goodTypeName);
	}

	public Good getById(Integer id) {
		// TODO Auto-generated method stub
		return goodDao.getById(id);
	}

	public int edit(Good good) {
		// TODO Auto-generated method stub
		return goodDao.edit(good);
	}

	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=goodDao.deleteByIds(idList);
		return count;
	}

	public List<Map<String, Object>> getGoodCountInTypeList() {
		// TODO Auto-generated method stub
		return goodDao.getGoodCountInTypeList();
	}

}
