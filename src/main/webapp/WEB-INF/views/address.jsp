<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/9
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"  isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>体育器材在线销售系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/regist.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
    <script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>


<style>
    #show {
        display: none;
        /*background-color:blue;*/
        width: 1198px;
        /*height:200px;*/
        border: 1px solid orangered;
    }

    .table-address {
        margin: auto;
    }

    .table-address td {
        height: 30px;
        text-align: center;
        /*border: 1px solid red;*/
    }

    .address-btn {
        width: 120px;
        height: 40px;
        border: 0px;

        background-color: lightgrey;
        border-radius: 3px;
        text-align: center;
        margin-left: 200px;
        margin-bottom: 40px;
    }
</style>
<body>

<jsp:include page="main/TBhead.jsp"></jsp:include>
<div class="content content-nav-base shopcart-content">
    <div class="banner-bg w1200" style="margin:35px auto;">

    </div>

    <button  style="margin-left: 200px;margin-bottom: 40px;"  class="layui-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>add-Address.do',500,400)">
        <i class="iconfont">&#xe6b9;</i>新增收获地址
    </button>

    <div class="cart w1200">



        <div class="cart-table-th">
            <%--<div class="th th-chk">--%>
                <%--<div class="select-all">--%>
                    <%--<div class="cart-checkbox">--%>
                        <%----%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="th th-price">
                <div class="th-inner">
                    收获地址
                </div>
            </div>
            <div class="th th-price">
                <div class="th-inner"  style="width: 220px">
                    收获地址
                </div>
            </div>
            <div class="th th-price">
                <div class="th-inner" style="width: 290px">
                    收件人
                </div>
            </div>
            <div class="th th-price">
                <div class="th-inner" style="width: 400px">
                    联系方式
                </div>
            </div>
            <div class="th th-amount">
                <div class="th-inner" style="width: 280px;text-align: right">
                   操作
                </div>
            </div>
        </div>
        <div class="OrderList" style="border: 1px solid #f5f5f5;">
            <table class="table-address">

                <c:forEach items="${address}" var="a">
                    <br>
                    <tr>
                        <td style="width: 160px;"><input class="CheckBoxShop check" type="radio" num="all"
                                                         name="select-address" value="${a.id}"></td>
                        <td style="width: 280px;">${a.address}</td>
                        <td style="width: 200px;">${a.receiver}</td>
                        <td style="width: 300px;">${a.tel}</td>
                        <td style="width: 120px;">
                            <input class="layui-btn" onclick="x_admin_show('修改收货地址','<%=basePath%>to-upAddress.do?id=${a.id}',500,400)"
                                   style="width: 100px;background-color: #1481ff;"  value="修改地址" >
                        </td>
                        <td style="width: 120px;">
                            <input class="layui-btn" value="删除" onclick="deleteAddress(${a.id})" style="width: 100px;background-color: #ff5320">
                        </td>
                    </tr>
                    <tr><td colspan="6" style="height: 10px;"></tr>
                </c:forEach>

            </table>
            <br>

            <%--<div class="order-content" id="list-cont">--%>
                <%--<c:forEach items="${address}" var="a">--%>
                    <%--<ul class="item-content layui-clear">--%>
                        <%--<li class="th th-chk">--%>
                            <%--<div class="select-all">--%>
                                <%--<div class="cart-checkbox">--%>
                                    <%--<input class="CheckBoxShop check" id="check" type="checkbox" num="all" name="select-all" value="${a.id}">--%>
                                        <%--${a.id}--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li class="th th-item">--%>
                            <%--&lt;%&ndash;<div class="item-cont">&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<a href="javascript:;"><img src="/images/${car.image}" alt=""></a>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;<div class="text">&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<div class="title">${car.pname}</div>&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;<p><span>厂家</span> <span>${car.vender}</span>  </p>&ndash;%&gt;--%>
                                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--${a.address}--%>
                        <%--</li>--%>
                        <%--<li class="th th-price">--%>
                            <%--${a.receiver}--%>
                        <%--</li>--%>
                        <%--<li class="th th-amount">--%>
                            <%--${a.tel}--%>
                        <%--</li>--%>


                    <%--</ul>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        </div>

    </div>
</div>

<jsp:include page="main/Footer.jsp"></jsp:include>

<script>
    function deleteAddress(id) {
        var msg = "确定要删除吗？\n\n请确认！";
        if (confirm(msg)==true){
            $.ajax({
                url:'<%=basePath%>deleteAddress.do',
                type:'get',
                data:{"id":id},
                async:'true',
                success:function (res) {
                    alert("删除成功");
                    window.location.reload();
                },
                error:function (res) {
                    alert("删除失败");
                }
            })
        }else{
            return false;
        }

    }
</script>
</body>
</html>