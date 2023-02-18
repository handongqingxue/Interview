package com.interview.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.interview.entity.*;
import com.interview.service.*;

@Controller
@RequestMapping("/goodType")
public class GoodTypeController {
	
	@Autowired
	private GoodTypeService goodTypeService;

	@RequestMapping(value="/goTest")
	public String goTest() {
		
		return "/test";
	}

	@RequestMapping(value="/add")
	@ResponseBody
	public Map<String, Object> add(GoodType gt) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=goodTypeService.add(gt);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "�����Ʒ���ͳɹ�");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "�����Ʒ����ʧ��");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return jsonMap;
		}
	}

	@RequestMapping(value="/edit")
	@ResponseBody
	public Map<String, Object> edit(GoodType gt) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=goodTypeService.edit(gt);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "�༭��Ʒ���ͳɹ�");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "�༭��Ʒ����ʧ��");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return jsonMap;
		}
	}

	@RequestMapping(value="/getList")
	@ResponseBody
	public Map<String, Object> getList(String name) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<GoodType> gtList=goodTypeService.getList(name);
		
		if(gtList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("goodTypeList", gtList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��ȡ��Ʒ�����б�ʧ��");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/getById")
	@ResponseBody
	public Map<String, Object> getById(Integer id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		GoodType goodType=goodTypeService.getById(id);
		
		if(goodType!=null) {
			jsonMap.put("message", "ok");
			jsonMap.put("goodType", goodType);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��ȡ��Ʒ����ʧ��");
		}
		
		return jsonMap;
	}
}
