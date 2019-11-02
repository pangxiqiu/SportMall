<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'error.jsp' starting page</title>
      <link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
      <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
      <link rel="stylesheet" href="<%=basePath%>css/font.css">
      <script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <style>
      div p{
          margin-bottom: 10px;
      }

  </style>
  <body>
     <div style="margin-top: 50px;font-size: 19px;">
        <p align="center"><i class="iconfont" style="font-size: 50px">&#xe6b7;</i>${msg}</p>
        <p align="center"><a href="javascript:;" onclick = "javascript:history.back()">返回</a></p>
     </div>
  </body>
</html>
