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
.addGoodType_div,.editGoodType_div{
	display: none;
}
.getGoodTypeList_div{
	margin-top: 10px;
}
.getGoodTypeList_div table{
	width:100%;
}
</style>
<title>Insert title here</title>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	
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
	<input type="text" id="id"/>
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
</body>
</html>