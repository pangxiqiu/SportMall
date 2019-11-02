<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<style>
	.sp-cart{
		margin-left: 20px;
	}



</style>

<div class="site-nav-bg">
	<div class="site-nav w1200">
		<p class="sn-back-home">
			<i class="layui-icon layui-icon-home"></i>
			<a href="<%=basePath%>home.do">首页</a>
		</p>
		<div class="sn-quick-menu">
			<c:if test="${user==null}">
				<div class="sp-cart"><a href="<%=basePath%>login.do">登录</a></div>
			</c:if>
			<c:if test="${user!=null}">
				<div class="sp-cart">您好:${user.uname}</div>
				<div class="sp-cart"  ><a href="<%=basePath%>user/getShopCar.do" style="color: #e54609;">购物车</a></div>
				<div class="sp-cart"><a href="<%=basePath%>logout.do" style="color:#000;">退出</a></div>
				<c:if test="${user.role==1}">
					<div class="sp-cart"><a href="<%=basePath%>back/adminindex.do">后台</a></div>
				</c:if>
			</c:if>

		</div>
	</div>
</div>



<div class="header" >
	<div class="headerLayout w1200">
		<div class="headerCon">
			<h1 class="mallLogo">体育器材商城</h1>
			<div class="mallSearch">
				<form action="<%=basePath%>home.do" method="get" class="layui-form" novalidate>
					<input type="text" name="pname" required  lay-verify="required" autocomplete="off" class="layui-input" placeholder="请输入需要的商品">
					<button class="layui-btn" lay-submit lay-filter="formDemo" type="submit">
						<i class="layui-icon layui-icon-search"></i>
					</button>
					<input type="hidden" name="" value="">
				</form>
			</div>
		</div>
	</div>
</div>
<div class="content content-nav-base  login-content">
	<div class="main-nav">
		<div class="inner-cont0">
			<div class="inner-cont1 w1200">
				<div class="inner-cont2">
					<a href="<%=basePath%>home.do" class="active">所有商品</a>
					<a href="<%=basePath%>home.do">热卖商品</a>
					<a href="<%=basePath%>user/myOrder.do?ostate=0">我的订单</a>
					<a href="<%=basePath%>address.do">地址管理</a>
				</div>
			</div>
		</div>
	</div>
</div>