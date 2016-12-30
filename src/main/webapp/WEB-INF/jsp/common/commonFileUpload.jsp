<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
    var callBackColumnName;
    //通用选择框调用方法，把需要回调设置文件路径的字段名称作为参数
    function openSingleFileUpload(callBack1) {
    	alert('ss');
        $('#dlg_commonFileUpload').dialog('open');
        callBackColumnName = callBack1;
    }
    function saveSingleFileUpload() {
        $.messager.progress();
        $('#frm_commonFileUpload').form('submit', {
            url: '<%=basePath%>tool/fileUpload',
            onSubmit: function (param) {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');
                    return false;
                }
                startProgress();
                return true;
            },
            success: function (data) {
                $.messager.progress('close');
                if (data) {
                    data = JSON.parse(data);
                    $("#" + callBackColumnName).val(data.pic);
                }
                $('#status').val("100%");
                $('#dlg_commonFileUpload').dialog('close');
            }
        });
    }

    function startProgress() {
        $.ajax({
            type: "post",
            dataType: "text",
            url: "<%=basePath%>tool/upfile/progress",
            data: "",
            success: function (data) {//data是没有小数的整型，
                $('#status').val(0 + "%");
                var num = parseInt(data);
                $('#status').val(num + "%");
                if (num < 100) {
                    setTimeout(startProgress(), 100);
                }
            }

        });
    }
</script>
<div id="dlg_commonFileUpload" class="easyui-dialog" title="文件上传" style="width:450px;height:135px;padding:0px;top:50px"
     data-options="closed:true,modal:true,shadow:true,buttons:'#tb3'">
    <form id="frm_commonFileUpload" method="post" enctype="multipart/form-data">
        <table id="dgd_result_commonFileUploadTask" width="100%" border="0" cellpadding="0" cellspacing="2">
            <tr>
                <td class="item_name">文件</td>
                <td class="item_value span3" colspan="3" id="tab_modify_position">
                    <input type="file" id="uploadURL" name="uploadURL" accept="image/*,video/*"
                           class="easyui-validatebox"
                           data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td class="item_name">进度</td>
                <td class="item_value span3" colspan="3">
                    <input id="status" name="status"
                           class="easyui-validatebox normaltext readonly" readonly/>
                </td>
            </tr>
        </table>
    </form>
    <div id="tb3">
        <a id="btn_saveChannel" href="javascript:void(0)" class="easyui-linkbutton" onclick="saveSingleFileUpload()"
           data-options="iconCls:'icon-save'">上传</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onClick="$('#dlg_commonFileUpload').dialog('close');"
           data-options="iconCls:'icon-cancel'">取消</a>
    </div>
</div>
