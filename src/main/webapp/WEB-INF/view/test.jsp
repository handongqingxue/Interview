<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"
		+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript"
	src="<%=basePath %>resource/js/jquery-3.3.1.js"></script>
<style type="text/css">
.addGoodType_div,.editGoodType_div,.addGood_div,.editGood_div{
	display: none;
}
.getGoodTypeList_div,.getGoodList_div,.getGoodCount_div{
	margin-top: 10px;
}
.getGoodTypeList_div table,.getGoodList_div table,.getGoodCount_div table{
	width:100%;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	initGoodTypeSelectData();
	getGoodTypeList();
	getGoodList();
	getGoodCountList();
});

function addGoodType(){
	var name=$("#addGoodType_div #name").val();
	var sort=$("#addGoodType_div #sort").val();
	var memo=$("#addGoodType_div #memo").val();
	$.post(path+"goodType/add",
		{name:name,sort:sort,memo:memo},
		function(data){
			if(data.message=="ok"){
				showAddGoodTypeDiv(false);
				getGoodTypeList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function editGoodType(){
	var id=$("#editGoodType_div #id").val();
	var name=$("#editGoodType_div #name").val();
	var sort=$("#editGoodType_div #sort").val();
	var memo=$("#editGoodType_div #memo").val();
	$.post(path+"goodType/edit",
		{id:id,name:name,sort:sort,memo:memo},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				showEditGoodTypeDiv(false);
				getGoodTypeList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function getGoodTypeList(){
	var name=$("#getGoodTypeList_div #name").val();
	$.post(path+"goodType/getList",
		{name:name},
		function(data){
			var ggtListTab=$("#getGoodTypeList_div table");
			ggtListTab.empty();
			if(data.message=="ok"){
				ggtListTab.append("<tr>"
							+"<td>类名</td>"
							+"<td>创建时间</td>"
							+"<td>排序</td>"
							+"<td>备注</td>"
							+"<td>操作</td>"
						+"</tr>");
			
				var goodTypeList=data.goodTypeList;
				var gtlLength=goodTypeList.length;
				for (var i = 0; i < gtlLength; i++) {
					var goodType=goodTypeList[i];
					var id=goodType.id;
					var name=goodType.name;
					var createTime=goodType.createTime;
					var sort=goodType.sort;
					var memo=goodType.memo;
					ggtListTab.append("<tr>"
								+"<td>"+name+"</td>"
								+"<td>"+createTime+"</td>"
								+"<td>"+sort+"</td>"
								+"<td>"+memo+"</td>"
								+"<td>"
									+"<input type=\"button\" value=\"编辑\" onclick=\"showEditGoodTypeDiv(true,"+id+")\"/>"
									+"<input type=\"button\" value=\"删除\" onclick=\"deleteGoodTypeById("+id+")\"/>"
								+"</td>"
							+"</tr>");
				}
			}
		}
	,"json");
}

function showAddGoodTypeDiv(flag){
	if(flag){
		$("#addGoodType_div").css("display","block");
	}
	else{
		$("#addGoodType_div").css("display","none");
	}
}

function showEditGoodTypeDiv(flag,id){
	if(flag){
		$.post(path+"goodType/getById",
			{id:id},
			function(data){
				if(data.message=="ok"){
					var goodType=data.goodType;
					var name=goodType.name;
					var sort=goodType.sort;
					var memo=goodType.memo;
					$("#editGoodType_div #id").val(id);
					$("#editGoodType_div #name").val(name);
					$("#editGoodType_div #sort").val(sort);
					$("#editGoodType_div #memo").val(memo);
				}
				else
					alert(data.info);
			}
		,"json");
		$("#editGoodType_div").css("display","block");
	}
	else{
		$("#editGoodType_div").css("display","none");
		$("#editGoodType_div #id").val("");
		$("#editGoodType_div #name").val("");
		$("#editGoodType_div #sort").val("");
		$("#editGoodType_div #memo").val("");
	}
}

function deleteGoodTypeById(id){
	$.post(path+"goodType/deleteGoodType",
		{ids:id},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				getGoodTypeList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function initGoodTypeSelectData(){
	$.post(path+"goodType/getSelectList",
		function(data){
			if(data.message=="ok"){
				initAddGoodGoodTypeSelect(data.list);
				initEditGoodGoodTypeSelect(data.list);
			}
			else
				alert(data.info);
		}
	,"json");
}

function initAddGoodGoodTypeSelect(list){
	var goodTypeSel=$("#addGood_div #goodType_sel");
	for (var i = 0; i < list.length; i++) {
		var goodType=list[i];
		goodTypeSel.append("<option value=\""+goodType.id+"\">"+goodType.name+"</option>");
	}
}

function initEditGoodGoodTypeSelect(list){
	var goodTypeSel=$("#editGood_div #goodType_sel");
	for (var i = 0; i < list.length; i++) {
		var goodType=list[i];
		goodTypeSel.append("<option value=\""+goodType.id+"\">"+goodType.name+"</option>");
	}
}

function addGood(){
	var name=$("#addGood_div #name").val();
	var goodTypeId=$("#addGood_div #goodType_sel").val();
	var sort=$("#addGood_div #sort").val();
	var memo=$("#addGood_div #memo").val();
	$.post(path+"good/add",
		{name:name,goodTypeId:goodTypeId,sort:sort,memo:memo},
		function(data){
			if(data.message=="ok"){
				showAddGoodDiv(false);
				getGoodList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function editGood(){
	var id=$("#editGood_div #id").val();
	var name=$("#editGood_div #name").val();
	var goodTypeId=$("#editGood_div #goodType_sel").val();
	var sort=$("#editGood_div #sort").val();
	var memo=$("#editGood_div #memo").val();
	$.post(path+"good/edit",
		{id:id,name:name,goodTypeId:goodTypeId,sort:sort,memo:memo},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				showEditGoodDiv(false);
				getGoodList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function getGoodList(){
	var name=$("#getGoodList_div #name").val();
	var goodTypeName=$("#getGoodList_div #goodTypeName").val();
	$.post(path+"good/getList",
		{name:name,goodTypeName:goodTypeName},
		function(data){
			var ggListTab=$("#getGoodList_div table");
			ggListTab.empty();
			if(data.message=="ok"){
				ggListTab.append("<tr>"
							+"<td>名称</td>"
							+"<td>类型</td>"
							+"<td>创建时间</td>"
							+"<td>排序</td>"
							+"<td>备注</td>"
							+"<td>操作</td>"
						+"</tr>");
			
				var goodList=data.goodList;
				var glLength=goodList.length;
				for (var i = 0; i < glLength; i++) {
					var good=goodList[i];
					var id=good.id;
					var name=good.name;
					var goodTypeName=good.goodTypeName;
					var createTime=good.createTime;
					var sort=good.sort;
					var memo=good.memo;
					ggListTab.append("<tr>"
								+"<td>"+name+"</td>"
								+"<td>"+goodTypeName+"</td>"
								+"<td>"+createTime+"</td>"
								+"<td>"+sort+"</td>"
								+"<td>"+memo+"</td>"
								+"<td>"
									+"<input type=\"button\" value=\"编辑\" onclick=\"showEditGoodDiv(true,"+id+")\"/>"
									+"<input type=\"button\" value=\"删除\" onclick=\"deleteGoodById("+id+")\"/>"
								+"</td>"
							+"</tr>");
				}
			}
		}
	,"json");
}

function showAddGoodDiv(flag){
	if(flag){
		$("#addGood_div").css("display","block");
	}
	else{
		$("#addGood_div").css("display","none");
	}
}

function showEditGoodDiv(flag,id){
	if(flag){
		$.post(path+"good/getById",
			{id:id},
			function(data){
				if(data.message=="ok"){
					var good=data.good;
					var name=good.name;
					var goodTypeId=good.goodTypeId;
					var sort=good.sort;
					var memo=good.memo;
					$("#editGood_div #id").val(id);
					
					var goodTypeSel=$("#editGood_div #goodType_sel");
					var options=goodTypeSel.find("option");
					for (var i = 0; i < options.length; i++) {
						var option=options.eq(i);
						if(option.val()==goodTypeId)
							option.prop("selected",true);
					}
					
					$("#editGood_div #name").val(name);
					$("#editGood_div #sort").val(sort);
					$("#editGood_div #memo").val(memo);
				}
				else
					alert(data.info);
			}
		,"json");
		$("#editGood_div").css("display","block");
	}
	else{
		$("#editGood_div").css("display","none");
		$("#editGood_div #id").val("");
		$("#editGood_div #name").val("");
		$("#editGood_div #sort").val("");
		$("#editGood_div #memo").val("");
	}
}

function deleteGoodById(id){
	$.post(path+"good/deleteGood",
		{ids:id},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				getGoodList();
				getGoodCountList();
			}
			else
				alert(data.info);
		}
	,"json");
}

function getGoodCountList(){
	$.post(path+"good/getGoodCountList",
		function(data){
			if(data.message=="ok"){
				var ggcTab=$("#getGoodCount_div table");
				ggcTab.empty();
				if(data.message=="ok"){
					ggcTab.append("<tr>"
								+"<td>类型</td>"
								+"<td>商品数量</td>"
							+"</tr>");
				
					var gcList=data.gcList;
					var gclLength=gcList.length;
					for (var i = 0; i < gclLength; i++) {
						var gc=gcList[i];
						var goodTypeName=gc.goodTypeName;
						var goodCount=gc.goodCount;
						ggcTab.append("<tr>"
									+"<td>"+goodTypeName+"</td>"
									+"<td>"+goodCount+"</td>"
								+"</tr>");
					}
				}
			}
		}
	,"json");
}
</script>
</head>
<body>
<div id="addGoodType_div" class="addGoodType_div">
	添加商品类型:
	<div>
		类名:<input type="text" id="name"/>
	</div>
	<div>
		排序:<input type="text" id="sort"/>
	</div>
	<div>
		备注:<input type="text" id="memo"/>
	</div>
	<div>
		<input type="button" value="提交" onclick="addGoodType()"/>
		<input type="button" value="取消" onclick="showAddGoodTypeDiv(false)"/>
	</div>
</div>

<div id="editGoodType_div" class="editGoodType_div">
	编辑商品类型:
	<input type="hidden" id="id"/>
	<div>
		类名:<input type="text" id="name"/>
	</div>
	<div>
		排序:<input type="text" id="sort"/>
	</div>
	<div>
		备注:<input type="text" id="memo"/>
	</div>
	<div>
		<input type="button" value="提交" onclick="editGoodType()"/>
		<input type="button" value="取消" onclick="showEditGoodTypeDiv(false)"/>
	</div>
</div>

<div id="getGoodTypeList_div" class="getGoodTypeList_div">
	查询商品类型:
	<input type="text" id="name" placeholder="请输入类型名称"/>
	<input type="button" value="查询" onclick="getGoodTypeList()"/>
	<input type="button" value="添加" onclick="showAddGoodTypeDiv(true)"/>
	<table>
	</table>
</div>

<div id="addGood_div" class="addGood_div">
	添加商品:
	<div>
		名称:<input type="text" id="name"/>
	</div>
	<div>
		类型:
		<select id="goodType_sel">
		</select>
	</div>
	<div>
		排序:<input type="text" id="sort"/>
	</div>
	<div>
		备注:<input type="text" id="memo"/>
	</div>
	<div>
		<input type="button" value="提交" onclick="addGood()"/>
		<input type="button" value="取消" onclick="showAddGoodDiv(false)"/>
	</div>
</div>

<div id="editGood_div" class="editGood_div">
	编辑商品:
	<div>
		<input type="hidden" id="id"/>
		名称:<input type="text" id="name"/>
	</div>
	<div>
		类型:
		<select id="goodType_sel">
		</select>
	</div>
	<div>
		排序:<input type="text" id="sort"/>
	</div>
	<div>
		备注:<input type="text" id="memo"/>
	</div>
	<div>
		<input type="button" value="提交" onclick="editGood()"/>
		<input type="button" value="取消" onclick="showEditGoodDiv(false)"/>
	</div>
</div>

<div id="getGoodList_div" class="getGoodList_div">
	查询商品:
	名称:<input type="text" id="name" placeholder="请输入商品名称"/>
	类型:<input type="text" id="goodTypeName" placeholder="请输入商品类型"/>
	<input type="button" value="查询" onclick="getGoodList()"/>
	<input type="button" value="添加" onclick="showAddGoodDiv(true)"/>
	<table>
	</table>
</div>

<div id="getGoodCount_div" class="getGoodCount_div">
	查询不同类型下的商品数量:
	<table>
	</table>
</div>
</body>
</html>