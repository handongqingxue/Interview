package com.interview.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.interview.entity.*;

public interface GoodMapper {

	int add(Good good);

	List<Good> getList(@Param("name") String name,@Param("goodTypeName") String goodTypeName);

	Good getById(@Param("id") Integer id);

	int edit(Good good);

	int deleteByIds(List<String> idList);

	List<Map<String, Object>> getGoodCountInTypeList();
}
