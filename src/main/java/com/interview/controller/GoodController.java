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
@RequestMapping("/good")
public class GoodController {

	@Autowired
	private GoodService goodService;

	@RequestMapping(value="/add")
	@ResponseBody
	public Map<String, Object> add(Good good) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=goodService.add(good);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "�����Ʒ�ɹ�");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "�����Ʒʧ��");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return jsonMap;
		}
	}

	@RequestMapping(value="/deleteGood")
	@ResponseBody
	public Map<String, Object> deleteGood(String ids) {
		//TODO ��Է���Ķ�̬����ʵʱ��������
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=goodService.deleteByIds(ids);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "ɾ����Ʒ�ɹ�");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "ɾ����Ʒʧ��");
		}
		return jsonMap;
	}

	@RequestMapping(value="/edit")
	@ResponseBody
	public Map<String, Object> edit(Good good) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		try {
			int count=goodService.edit(good);
			if(count>0) {
				jsonMap.put("message", "ok");
				jsonMap.put("info", "�༭��Ʒ�ɹ�");
			}
			else {
				jsonMap.put("message", "no");
				jsonMap.put("info", "�༭��Ʒʧ��");
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
	public Map<String, Object> getList(String name, String goodTypeName) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Good> goodList=goodService.getList(name,goodTypeName);
		
		if(goodList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("goodList", goodList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��ȡ��Ʒ�б�ʧ��");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/getById")
	@ResponseBody
	public Map<String, Object> getById(Integer id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		Good good=goodService.getById(id);
		
		if(good!=null) {
			jsonMap.put("message", "ok");
			jsonMap.put("good", good);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��ȡ��Ʒʧ��");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/getGoodCountList")
	@ResponseBody
	public Map<String, Object> getGoodCountList() {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		//select gt.name,count(*) goodCount from good g,good_type gt where g.goodTypeId=gt.id GROUP BY g.goodTypeId
		List<Map<String, Object>> gcList=goodService.getGoodCountInTypeList();
		
		if(gcList.size()>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("gcList", gcList);
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "��ȡ��Ʒ�����б�ʧ��");
		}
		
		return jsonMap;
	}
}
