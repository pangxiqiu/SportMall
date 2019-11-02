<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/23
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//    request.getRequestDispatcher("back/adminhome.do").forward(request,response);
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>欢迎页面-L-admin1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <%--<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />--%>
    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
</head>
<body>
<div class="x-body layui-anim layui-anim-up">
    <blockquote class="layui-elem-quote">欢迎管理员：
        <span class="x-red"></span>${user.uname}</blockquote>
    <fieldset class="layui-elem-field">
        <legend>数据统计</legend>
        <div class="layui-field-box">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">
                            <div carousel-item="">
                                <ul class="layui-row layui-col-space10 layui-this">
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>用户数</h3>
                                            <p>
                                                <cite>${adminData.userCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>会员数</h3>
                                            <p>
                                                <cite>${adminData.vipCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>反馈数</h3>
                                            <p>
                                                <cite>${adminData.commentCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>商品数</h3>
                                            <p>
                                                <cite>${adminData.productCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>订单数</h3>
                                            <p>
                                                <cite>${adminData.orderCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="javascript:;" class="x-admin-backlog-body">
                                            <h3>快递公司</h3>
                                            <p>
                                                <cite>${adminData.companyCount}</cite></p>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>
    <!--<fieldset class="layui-elem-field">
        <legend>系统通知</legend>
        <div class="layui-field-box">
            <table class="layui-table" lay-skin="line">
                <tbody>
                    <tr>
                        <td >
                            <a class="x-a" href="/" target="_blank">新版L-admin 2.0上线了</a>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <a class="x-a" href="/" target="_blank">交流qq:(370946531)</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>-->
    <fieldset class="layui-elem-field">
        <legend>系统信息</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <tbody>
                <tr>
                    <th>体育器材在线销售系统</th>
                    <td>v2.0</td></tr>
                <tr>
                    <th>服务器地址</th>
                    <td>http://localhost:8080/SportMall</td></tr>
                <tr>
                    <th>操作系统</th>
                    <td>WIN10</td></tr>
                <tr>
                    <th>运行环境</th>
                    <td>Apache_Tomcat/8.0.47 (Win64)</td></tr>
                <tr>
                    <th>java版本</th>
                    <td>8.0.2</td></tr>
                <tr>
                    <th>MYSQL版本</th>
                    <td>5.2.70</td></tr>

                </tbody>
            </table>
        </div>
    </fieldset>
    <fieldset class="layui-elem-field">
        <legend>开发团队</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <tbody>
                <!--<tr>
                    <th>版权所有</th>
                    <td>cdnuti(xuebingsi)
                        <a href="http://#/" class='x-a' target="_blank">访问官网</a></td>
                </tr>-->
                <tr>
                    <th>开发者</th>
                    <td>pxq(1102763781@qq.com)</td></tr>
                </tbody>
            </table>
        </div>
    </fieldset>
    <!--<blockquote class="layui-elem-quote layui-quote-nm">感谢layui,百度Echarts,jquery,本系统由L-admin提供技术支持。</blockquote>-->
</div>

</body>
</html>
