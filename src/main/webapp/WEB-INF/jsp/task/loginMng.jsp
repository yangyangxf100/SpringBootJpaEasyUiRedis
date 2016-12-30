<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../common/include.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>任务管理</title>
    <script>
        $(function () {
            createDataGrid();
            // 初始化页面状态
            initState();
        });

        // 初始化页面状态
        function initState() {
            $('#btn_add').addClass('disable');
            $('#btn_delete').addClass('disable');
        }
        var selectAlbumId = 0;
        function createDataGrid() {
            $('#dgd_result').datagrid({
                title: "任务管理",
                pagination: true,
                rownumbers: true,
                singleSelect: false,
                method: 'get',
                 fit: true,
                url: '<%=basePath%>task/search',
                queryParams: {
                },
                idField: 'id',
                toolbar: [
                    {
                        text: '添加',
                        id: 'btn_add',
                        iconCls: 'icon-add',
                        handler: open4Add
                    },
                    {
                        text: '编辑',
                        id: 'btn_edit',
                        iconCls: 'icon-edit',
                        disabled: true,
                        handler: open4Edit
                    },
                    {
                        text: '删除',
                        id: 'btn_delete',
                        iconCls: 'icon-no',
                        disabled: true,
                        handler: deleteObject
                    }
                ],
                onLoadSuccess: function () {
                },
                onDblClickRow: open4Edit,
                onSelect: function (rowIndex, rowData) {
                    selectAlbumId = rowData.id;
                    $('#btn_delete').linkbutton('enable');
                    $('#btn_edit').linkbutton('enable');
                    $('#btn_videoMng').linkbutton('enable');
                }
            });
        }

        //打开添加 对话框
        function open4Add() {
            $('#frm_login').form('clear');
            $('#dlg_login').dialog('open');
            $('#dlg_login').form('load', {
                status: 1
            });
            $('#id').val("0");
        }

         //打开编辑对话框 
        function open4Edit(rowIndex, rowData) {
            var id;
            if (rowData) {
                id = rowData.id;
            } else {
                var row = $("#dgd_result").datagrid("getSelected");
                if (!row) {
                    $.messager.alert("提示", "请至少选择一行！", "error");
                    return;
                }
                id = row.id;
            }

            var s = $(document.body).height();
            $('#dlg_login').dialog({
            	height: s*0.7
            }); 

            $('#frm_login').form('clear');
            $('#dlg_login').dialog('open');
            $.ajax({
                url: '<%=basePath%>task/' + id,
                type: "GET",
                success: function (data) {
                    if (typeof(data.errMsg) != 'undefined') {
                        $.messager.alert("提示", data.errMsg, "error");
                        return;
                    }
                    dealRetData(data);
                }
            });

        }

        //处理编辑数据
        function dealRetData(data) {
            $('#frm_login').form('load', data);
            if(typeof(data.profiles) != 'undefined'){
            	$('#profiles').combobox('setValues', data.profiles.split(","));
            }
            if(typeof(data.logo) != 'undefined'){
            	var jsonList = eval('(' + data.logo + ')');
                for (var key in jsonList) {
                    $("#" + key + "").val(jsonList[key]);
                }	
            }
        }

        //保存对象
        function saveObject() {
            $.messager.progress();
            $('#frm_login').form('submit', {
                url: '<%=basePath%>task/saveOrUpdate',
                onSubmit: function (param) {
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                        $.messager.progress('close');
                        return false;
                    }
                    return true;
                },
                success: function (data) {
                    $.messager.progress('close');
                    if (data) {
                        var result = eval('(' + data + ')');
                        $.messager.alert("提示", result.errMsg, "error");
                        return;
                    }
                    $('#dgd_result').datagrid("clearSelections");
                    $('#dgd_result').datagrid("reload");
                    $('#dlg_login').dialog('close');
                }
            });
        }

        //删除
        function deleteObject() {
            var rows = $("#dgd_result").datagrid("getSelections");
            if (rows.length==0) {
                $.messager.alert("提示", "请至少选择一行！", "error");
                return;
            }
            var ids= '';
            for(var i=0; i<rows.length; i++){
            	ids+=rows[i].id+',';
            }
            $.messager.confirm('确认', '确认删除？', function (r) {
                if (r) {
                    $.ajax({
                        url: '<%=basePath%>task/delete?ids=' + ids,
                        type: 'GET',
                        success: function (data) {
                            if (data) {
                                $.messager.alert("提示", data.errMsg, "error");
                                return;
                            }
                            $('#dgd_result').datagrid("clearSelections");
                            $('#dgd_result').datagrid("reload");
                        }
                    });
                }
            });
        }

        // 搜索
        function reSearch() {
            $('#dgd_result').datagrid('load', {
				id: $('#id').val(),
				name: $('#name').val(),
				description: $('#description').val()
            });
        }
    </script>

</head>
<body class="easyui-layout">
	<!-- search start -->
	<div id="searchCondtion" class="easyui-panel ms-panel-outer" title="查询条件" data-options="region:'north',collapsible:true" style="height:auto;overflow:hidden">
		     <header>
				<div class="m-toolbar">
					<div class="m-left">任务管理</div>				
					<div class="m-right">
						<a href="javascript:void(0)" class="easyui-linkbutton" onClick="reSearch()" data-options="iconCls:'icon-search'">搜索</a>
	                	<a href="javascript:void(0)" class="easyui-linkbutton" onClick="reset()" data-options="iconCls:'icon-reset'">重置</a>
					</div>
				</div>
			</header>
			<form id="ff">  
				<div style="margin-bottom:10px">
					<input id="name" name="name"  class="easyui-textbox" label="任务名称:" prompt="任务名称" style="width:100%">
				</div>   
				<div style="margin-bottom:10px">
					<input id="description" name="description" class="easyui-textbox" label="任务描述:" prompt="请输入任务描述" style="width:100%">
				</div> 
			</form>
	</div>
	<!-- search end -->
	
	

	<!-- list start -->
	<div data-options="region:'center'" style="border: 0;">
		<table id="dgd_result"  data-options="header:'#hh',singleSelect:true,border:false,fit:true,fitColumns:true,scrollbarSize:0">
	    	<thead>
	    	<tr>
	    		<th data-options="field:'ck',checkbox:true"></th>
	        	<th field="id" width="20" align="center">主键</th>
	        	<th field="name" width="80" align="center">任务名称</th> 
	        	<th field="description" width="80" align="center">备注</th> 
	        	<th field="dateCreated" width="80" align="center" formatter="formatDateTime">创建日期</th> 
	        	<th field="finished" width="80" align="center">状态</th> 
	    	</tr>
	    	</thead>
		</table>
	</div>
	<!-- list end -->

</body>



<!-- add start -->
<div style="dispaly:none">
    <div id="dlg_login" class="easyui-dialog" title="任务添加" style="width:80%;height:60%;padding:10px;top:100px;height:auto;"
         data-options="closed:true,modal:true,shadow:true,buttons:'#tb2'">
        <form id="frm_login" method="post">
			<div style="margin-bottom:10px">
				<input id="id_id" name="id" class="easyui-textbox" label="主键" readonly="readonly" style="width:100%">
			</div> 
		 
			<div style="margin-bottom:10px">
				<input id="id_name" name="name" data-options="required:true" class="easyui-textbox" label="任务名称:" prompt="请输入任务名称" style="width:100%">
			</div>  
			
			<div style="margin-bottom:10px">
				<input id="id_description" name="description" data-options="required:true" class="easyui-textbox" label="任务描述:" prompt="请输入任务描述" style="width:100%">
			</div> 
        </form>
        <div id="tb2">
            <a id="btn_saveObject" href="javascript:void(0)" class="easyui-linkbutton" onclick="saveObject()"
               data-options="iconCls:'icon-save'">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" onClick="$('#dlg_login').dialog('close');"
               data-options="iconCls:'icon-cancel'">取消</a>
        </div>
    </div>
</div>
<!-- add end -->

</html>
