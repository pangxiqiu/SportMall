<%@ page language="java" import="java.util.*"  pageEncoding="utf-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
	<%--<script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>--%>
<link rel="stylesheet" type="text/css" href="css/regist.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/registForm.js"></script>

<script type="text/javascript">
/*校验用户名*/
function unameValid(){
	$.ajax({
   		type: "GET",
   		url: "<%=basePath%>isExist.do",
		data : {
			uname : $("#uname").val()
		},
		success : function(msg) {
			if (msg == true) {
				span.innerHTML = "<font color = 'red'>已存在</font>";
				return false;
			}
			else {
				span.innerHTML = "<font color = 'green'><font>";
			}
		}
	});

	var uname = $('#uname').val();
	var span = document.getElementById("unameAlert");
	//用户名正则，4到16位（字母，数字，下划线，减号）
	//输出 true
	var reg = /^[a-zA-Z][a-zA-Z0-9]{3,15}$/;
	if(reg.test(uname) == false){
		span.innerHTML = "用户名由英文字母和数字组成的4-16位字符，以字母开头";
		return false;
	}else{
		span.innerHTML = "<font color = 'green'></font>";
		return true;
	}
}

function name() {
	var uname = $('#uname').val();
	var span = document.getElementById("unameAlert");
	//用户名正则，4到16位（字母，数字，下划线，减号）
	//输出 true
	var reg = /^[a-zA-Z][a-zA-Z0-9]{3,15}$/;
	if(reg.test(uname) == false){
		span.innerHTML = "用户名由英文字母和数字组成的4-16位字符，以字母开头";
		return false;
	}else{
		span.innerHTML = "<font color = 'green'></font>";
		return true;
	}
}

	/*密码验证*/    
	function checkPwd(){
 	var pwd = $('#pwd').val();  
 	var span = document.getElementById("pwdAlert");
 	var reg = /^[a-zA-Z0-9]{4,10}$/;    
   	if(reg.test(pwd) == false){
    	pwdAlert.innerHTML = "<font color = 'red'>密码不能含有非法字符，长度在4-10之间</font>";
  		return false;
    }else{
    	pwdAlert.innerHTML = "<font color = 'green'></font>";
    	return true;
    }	
}
	function checkRePwd(){
		var repwd = $('#pwd2').val();
		var pwd = $('#pwd').val();
		var span = document.getElementById("rePwdAlert");
		if(pwd == repwd){
			span.innerHTML = "<font color = 'green'></font>";
			return true;
		}else{
			span.innerHTML = "<font color = 'red'>两次密码不一致</font>";
			return false;
		}
	}
	
	/*手机号验证*/
	function checkMobile(){
	    var tel = $("#tel").val();
	    var span = document.getElementById("telAlert");
	    var reg=/^1\d{10}$/;
	    if(reg.test(tel)==false){
	        span.innerHTML="手机号码不正确，请重新输入";
	        return false;
	    }else{
	    	span.innerHTML="<font color = 'red'></font>";
	  	    return true;
	    }
}
	

	/*表单提交*/
	function registForm(){
		var form = document.getElementById("registForm");
		
		var cname = unameValid();
		// var name = name();
		var cpwd = checkPwd();
		var crpwd = checkRePwd();
		var ctel = checkMobile();
		if(cname && cpwd && crpwd && ctel){
			form.submit();
		}
	}

</script>
	<style type="text/css">
		input[type="radio"] + label::before {
			content: "\a0"; /*不换行空格*/
			display: inline-block;
			vertical-align: middle;
			font-size: 18px;
			width: 14px;
			height: 14px;
			margin-right: .4em;
			border-radius: 50%;
			border: 1px solid rgba(16, 16, 16, 0.31);
			text-indent: .15em;
			line-height: 1;
		}
		input[type="radio"]:checked + label::before {
			width: 7px;
			height: 7px;
			background-color: rgba(16, 16, 16, 0.31);
			background-clip: content-box;
			padding: .2em;
		}
		input[type="radio"] {
			position: absolute;
			clip: rect(0, 0, 0, 0);
		}

		.btn-reg{
			width: 300px;
			height: 35px;
			background-color: #483D8B;
			color: white;
			text-align: center;
			border: 0px;
			border-radius: 2px;
		}
	</style>
</head>



<body>
<div class="content content-nav-base  login-content">
<div class="login-bg">
<div class="login-cont w1200" >
	<div class="form-box" style="left: 36%;top:5%;height: auto;">
		<form class="layui-form" action="<%=basePath%>regist.do" method="post" id="registForm">
			<legend>注&nbsp;&nbsp;&nbsp;&nbsp;册</legend>
			<div class="layui-form-item">
				<div class="layui-inline iphone">
					<div class="layui-input-inline">
						<%--<i class="layui-icon layui-icon-username iphone-icon"></i>--%>
						<input type="tel" name="uname" id="uname"  placeholder="请输入用户名" autocomplete="off" class="layui-input" onblur="unameValid()">
						<span id="unameAlert"></span></td>
					</div>
				</div>
				<div class="layui-inline iphone">
					<div class="layui-input-inline">
						<%--<i class="layui-icon layui-icon-password iphone-icon"></i>--%>
						<input type="password" name="pwd" id="pwd"  placeholder="请输入密码" autocomplete="off" class="layui-input" onblur="checkPwd()">
							<span id = "pwdAlert"></span>
						<%--<div class="login">--%>
							<%--<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>--%>
						<%--</div>--%>
					</div>
				</div>

				<div class="layui-inline iphone">
					<div class="layui-input-inline">
						<%--<i class="layui-icon layui-icon-password iphone-icon"></i>--%>
						<input type="password" name="pwd2" id="pwd2"  placeholder="请再次输入密码" autocomplete="off" class="layui-input" onblur="checkRePwd()">
						<span id = "rePwdAlert"></span>
						<%--<div class="login">--%>
						<%--<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>--%>
						<%--</div>--%>
					</div>
				</div>

				<div class="layui-inline iphone">
					<div class="layui-input-inline" style="display: flex;justify-content: space-around">
						<%--<i class="layui-icon layui-icon-password iphone-icon"></i>--%>
							<%--<select name="sex" id="sex" style="width:160px;height:23px;">--%>
								<%--<option value ="男">男</option>--%>
								<%--<option value ="女">女</option>--%>

							<%--</select>--%>
							<div>
								<input type="radio" name="sex" id="man" value="男" style="display: inline-block;" checked>
								<label for="man" >男</label>
							</div>
							<div>
								<input type="radio" name="sex" id="woman" value="女" style="display: inline-block;">
								<label for="woman">女</label>
							</div>

						<%--<div class="login">--%>
						<%--<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>--%>
						<%--</div>--%>
					</div>
				</div>
				<div class="layui-inline iphone">
					<div class="layui-input-inline">
						<%--<i class="layui-icon layui-icon-password iphone-icon"></i>--%>
						<input type="text" name="rname" id="rname"  placeholder="真实姓名" autocomplete="off" class="layui-input" >

						<%--<div class="login">--%>
						<%--<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>--%>
						<%--</div>--%>
					</div>
				</div>
				<div class="layui-inline iphone">
					<div class="layui-input-inline">
						<%--<i class="layui-icon layui-icon-password iphone-icon"></i>--%>
						<input type="text" name="tel" id="tel"  placeholder="请输入联系方式" autocomplete="off" class="layui-input" onblur="checkMobile()">
						<span id = "telAlert"></span>
						<%--<div class="login">--%>
						<%--<span style="margin-left: 50px;font-size: 14px;color: red">${msg}</span>--%>
						<%--</div>--%>
					</div>
				</div>
				<%--<a href="#" style="margin-left: 20px;">忘记密码?</a>--%>
				<%--<a href="<%=basePath%>regist.do" style="margin-left: 110px;">注册用户</a>--%>
				<!--<div class="layui-inline veri-code">
                  <div class="layui-input-inline">
                      <i class="layui-icon layui-icon-cellphone iphone-icon"></i>
                    <input type="tel" name="phone" id="phone" lay-verify="required|phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                    <input type="button" class="layui-btn" id="find"  value="验证码" />
                  </div>
                </div>-->
				<%--<td ><input type="button" value="注册" class="BUT-register" onclick="registForm()"/></td>--%>
				<%--<td ><a href="<%=basePath%>login.do"><input type="button" value="返回" class="BUT-register" /></a></td>--%>
			</div>
			<div class="layui-form-item login-btn">
				<div class="layui-input-block">
					<input type="button" class="btn-reg"  onclick="registForm()" value="注册"/>
					<br /><br>
					<a href="<%=basePath%>login.do">
						<input type="button"value="返回" class="btn-reg" style="background-color: white;color:#483D8B; "/>
					</a>
					<%--<button></button>--%>
					<%--<input type ="button" value="登录" onclick="sub()" class="BUT-register">--%>
					<%--<a href="<%=basePath%>regist.do"><input type ="button" class="BUT-register" value="注册"></a>--%>
				</div>
				<br />
			</div>
		</form>
	</div>
</div>
</div>
</div>
<jsp:include page="main/Footer.jsp"></jsp:include>
</body>
</html>
