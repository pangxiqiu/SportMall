<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="ch">
<head>
	<base href="<%=basePath%>">
	<title>登录</title>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
	<script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<script type="text/javascript">
	function sub(){
		var unameText = document.getElementById("uname");
		var upwdText = document.getElementById("pwd");
		if(unameText.value ==""){
			alert("用户名不能为空");
			return false;
		}
		if(upwdText.value == ""){
			alert("密码不能为空");
			return false;
		}
		var loginform = document.getElementById("loginform");
		loginform.submit();

	}
</script>
<body>

<jsp:include page="main/TBhead.jsp"></jsp:include>


<div class="content content-nav-base  login-content">
	<div class="login-bg">
		<div class="login-cont w1200">
			<div class="form-box">
				<form class="layui-form" action="<%=basePath%>login.do" method="post" id="loginform">
					<legend>请登录</legend>
					<div class="layui-form-item">
						<div class="layui-inline iphone">
							<div class="layui-input-inline">
								<i class="layui-icon layui-icon-username iphone-icon"></i>
								<input type="tel" name="uname" id="uname"  placeholder="请输入用户名" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-inline iphone">
							<div class="layui-input-inline">
								<i class="layui-icon layui-icon-password iphone-icon"></i>
								<input type="password" name="pwd" id="pwd"  placeholder="请输入密码" autocomplete="off" class="layui-input">
								<div class="login">
									<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>
								</div>
							</div>
						</div>
						<a href="javascript:;" style="margin-left: 20px;" onclick="look()">忘记密码?</a>
						<a href="<%=basePath%>regist.do" style="margin-left: 110px;">注册用户</a>
						<!--<div class="layui-inline veri-code">
                          <div class="layui-input-inline">
                              <i class="layui-icon layui-icon-cellphone iphone-icon"></i>
                            <input type="tel" name="phone" id="phone" lay-verify="required|phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                            <input type="button" class="layui-btn" id="find"  value="验证码" />
                          </div>
                        </div>-->
					</div>
					<div class="layui-form-item login-btn">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit="" lay-filter="demo1" onclick="sub()">登录</button>
							<%--<input type ="button" value="登录" onclick="sub()" class="BUT-register">--%>
							<%--<a href="<%=basePath%>regist.do"><input type ="button" class="BUT-register" value="注册"></a>--%>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="main/Footer.jsp"></jsp:include>

<script>
	layui.use(['laydate','table'], function(){
		var laydate = layui.laydate;
		var table = layui.table;

		//执行一个laydate实例
		laydate.render({
			elem: '#start' //指定元素
		});

		//执行一个laydate实例
		laydate.render({
			elem: '#end' //指定元素
		});




		table.on('checkbox(table-product)', function(obj){
			console.log(obj)
		});



		//监听工具条
		table.on('tool(table-product)', function(obj){
			var data = obj.data;
			if(obj.event === 'detail'){

				x_admin_show('详细信息','<%=basePath%>back/product-image.do?pno='+data.pno,700,500)
			}
		});



		$('#do_search').on('click', function(){
			var typeno = $("#typeno").val();
			var pname=$("#pname").val();
			var vender=$("#vender").val();
			var pstate=$("#pstate").val();
			table.reload('table-product',{
				where:{
					typeno:typeno,
					pname:pname,
					vender:vender,
					pstate:pstate
				},
				page:{
					curr:1
				}
			});
		});


	});

	function look(){
		layer.msg('请联系管理员重置密码');
	}

</script>
</body>


</html>