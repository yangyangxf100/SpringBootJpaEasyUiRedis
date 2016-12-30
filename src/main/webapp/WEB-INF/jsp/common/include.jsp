<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.text.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + (request.getServerPort() == 80 ? "" : ":" + request.getServerPort())
            + path + "/";
    int wrapThreshold = 100;
%>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<c:set var="basePath" value="<%=basePath%>"/>
<base href="${basePath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<link href="<%=basePath%>static/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>static/easyui/themes/icon.css" rel="stylesheet" type="text/css"> 

<script src="<%=basePath%>static/easyui/jquery.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath%>static/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="<%=basePath%>static/json2.js" type="text/javascript"></script> 


<script src="<%=basePath%>static/easyui/jquery.easyui.mobile.js" type="text/javascript"></script>
<link href="<%=basePath%>static/easyui/themes/mobile.css" rel="stylesheet" type="text/css">

 <SCRIPT LANGUAGE="JavaScript">
	 function formatDateTime(val, row) {
        if (val) {
        	var d = new Date(val);
        	return d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
        }
	};
	
	//检查 url
	 function checkurl(str_url) {
	     var checkfiles = new RegExp("((^http)|(^https)|(^ftp)):\\/\\/(\\\\w)+\\.(\\\\w)+");
	     return checkfiles.test(str_url);
	 }
	
	 /**
	  * 格式化需求方
	  */
	 function formatDemandId(val, row) {
	     var data = $('#condition_demandId').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	 /**
	  * 格式化信号源
	  */
	 function formatSourceId(val, row) {
	     var data = $('#condition_sourceId').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	
	 function formatCopyright(val, row) {
	     var texts = "";
	     if (val) {
	         var checkboxes = $('input:checkbox[name="copyright"]');
	         checkboxes.each(function () {
	             if (val.indexOf(this.value) > -1) {
	                 texts += this.nextElementSibling.innerHTML + ",";
	             }
	         });
	         return texts;
	     }
	     return "未知";
	 }
	 /**
	  * 格式化信号源
	  */
	 function formatkaoUserLogGroup(val, row) {
	     var data = $('#condition_kaoUserLogGroup').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	 /**
	  * 格式化节目单来源
	  */
	 function formatSrcId(val, row) {
	     var data = $('#condition_srcId').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	
	 function formattCategory(val, row) {
	     var data = $('#category').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	
	 function formattUpdatefrequency(val, row) {
	     var data = $('#updatefrequency').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	
	 function formattCopyRightArea(val, row) {
	     var data = $('#copyRightArea').combobox('getData');
	     if (!val) {
	         return;
	     }
	     var codes = val.split(",");
	     var result = "";
	     for (var j = 0; j < codes.length; j++) {
	         var code = codes[j];
	         for (var i = 0; i < data.length; i++) {
	             if (code == data[i].code) {
	                 result = result + data[i].name + ",";
	             }
	         }
	     }
	     return result.substring(0, result.length - 1);
	 }
	
	 function formattTerminalIds(val, row) {
	     var data = $('#terminalIds').combobox('getData');
	     if (!val) {
	         return;
	     }
	     var codes = val.split(",");
	     var result = "";
	     for (var j = 0; j < codes.length; j++) {
	         var code = codes[j];
	         for (var i = 0; i < data.length; i++) {
	             if (code == data[i].code) {
	                 result = result + data[i].name + ",";
	             }
	         }
	     }
	     return result.substring(0, result.length - 1);
	 }
	
	
	 function formattIsEnd(val, row) {
	     var data = $('#isEnd').combobox('getData');
	     for (var i = 0; i < data.length; i++) {
	         if (val == data[i].code) {
	             return data[i].name;
	         }
	     }
	     return "未知";
	 }
	
	 /**
	  * format 大文本
	  * */
	 function formattMoreValue(value, rowData, rowIndex) {
	     if (value == null || value == "null") {
	         return "";
	     } else {
	         return "<span style='cursor: pointer;' title='" + value + "'>" + value + "</span>";
	     }
	
	 }
	
	 function formattImg(value, rowData, rowIndex) {
	     if (value == null || value == "null") {
	         return "";
	     } else {
	         return "<img src='" + value + "' alt='" + value + "' style='width:40px;height:40px;'/>";
	     }
	 }
	 
	function formattStatus(value, rowData, rowIndex) {
          if (value == null || value == "null") {
              return "无效";
          } else if(value == '0'){
              return "无效";
          }else if(value == '1'){
              return "有效";
          }
      }
	
	 document.onkeydown = function (event) {
     	var e = event || window.event || arguments.callee.caller.arguments[0];
     	if (e && e.keyCode == 13) {
     		reSearch();
     	}
      };
      
      function reset() {
          $('#searchCondtion input').val("");
          $('#condition_isRecommend').combobox('setValue', '');
          $('#condition_status').combobox('setValue', '');
      }
      
      
 </SCRIPT>