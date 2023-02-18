package com.interview.service;

import java.util.List;
import java.util.Map;

import com.interview.entity.*;

public interface GoodService {

	int add(Good good);

	List<Good> getList(String name, String goodTypeName);

	Good getById(Integer id);

	int edit(Good good);

	int deleteByIds(String ids);

	List<Map<String, Object>> getGoodCountInTypeList();

}
