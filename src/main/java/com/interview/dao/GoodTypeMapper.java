package com.interview.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.interview.entity.*;

public interface GoodTypeMapper {

	int add(GoodType gt);

	List<GoodType> getList(@Param("name") String name);

	GoodType getById(@Param("id") Integer id);

	int edit(GoodType gt);
}
