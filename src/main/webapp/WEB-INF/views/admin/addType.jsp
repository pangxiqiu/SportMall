<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/20
  Time: 17:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>添加类别</title>
</head>
<body>
<form action="<%=basePath%>back/addType.do" method="post">
<table>
    <tr>
        <td>类别名称</td>
        <td><input type="text" name="typename"> </td>
    </tr>
    <tr>
        <td>
            <input type="submit" value="提交">
        </td>
    </tr>
    <tr>
        <td>
            ${msg}
        </td>
    </tr>
</table>
</form>
</body>
</html>
