<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/20
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>体育器材后台管理</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">

    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>
<body>
<!-- 顶部开始 -->
<div class="container">
    <div class="logo"><a href="index.html">体育器材后台管理系统</a></div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">

    </ul>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">${user.uname}</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
                <dd><a href="<%=basePath%>logout.do">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index"><a href="<%=basePath%>home.do">前台首页</a></li>
    </ul>

</div>
<!-- 顶部结束 -->

<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe6eb;</i>
                    <cite>主页</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="<%=basePath%>back/adminhome.do"><i class="iconfont">&#xe6a7;</i><cite>控制台</cite></a></li >
                </ul>
            </li>
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b8;</i>
                    <cite>用户管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="<%=basePath%>back/getUsers.do"><i class="iconfont">&#xe6a7;</i><cite>用户列表</cite></a></li >
                    <li><a _href="<%=basePath%>back/getAllVip.do"><i class="iconfont">&#xe6a7;</i><cite>会员等级列表</cite></a></li >
                </ul>
            </li>
            <li >
                <a href="javascript:;">
                    <i class="iconfont">&#xe6f6;</i>
                    <cite>产品管理</cite>
                    <i class="iconfont nav_right">&#xe6a7;</i>
                </a>
                <ul class="sub-menu">
                    <li><a _href="<%=basePath%>adminType/getAllType.do"><i class="iconfont">&#xe6f6;</i><cite>产品类别列表</cite></a></li >
                    <li><a _href="<%=basePath%>back/getAllProducts.do"><i class="iconfont">&#xe6f6;</i><cite>产品列表</cite></a></li >
                </ul>
            </li>

            <li>
                <a _href="<%=basePath%>Order/Orders.do"><i class="iconfont">&#xe6a2;</i><cite>订单管理</cite><i class="iconfont nav_right">&#xe6a7;</i></a>

            </li>
            <li>
                <a _href="<%=basePath%>com/companys.do"><i class="iconfont">&#xe6cb;</i><cite>快递公司管理</cite><i class="iconfont nav_right">&#xe6a7;</i></a>

            </li>
            <li>
                <a _href="<%=basePath%>com/companys.do"><i class="iconfont">&#xe74e;</i><cite>反馈管理</cite><i class="iconfont nav_right">&#xe6a7;</i></a>

            </li>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src="<%=basePath%>back/adminhome.do" frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
</html>
