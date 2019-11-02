<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/28
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/regist.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/xadmin.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<style>
    .show {
        display: block;
        /*background-color:blue;*/
        /*width: 1198px;*/
        /*height:200px;*/
        /*border: 1px solid orangered;*/
    }

    .table-address {
        margin: auto;
    }

    .table-address td {
        height: 30px;
        text-align: center;
    }

    .address-btn {
        width: 120px;
        height: 30px;
        border: 0px;
        background-color: lightgrey;
        text-align: center;
        margin-left: 500px;
    }
</style>
<body>

<jsp:include page="main/TBhead.jsp"></jsp:include>
<div class="content content-nav-base shopcart-content">
    <div class="banner-bg w1200">

    </div>
    <%--<div class="cart w1200">--%>
        <%--<div class="cart-table-th">--%>
            <%--<div class="th th-chk">--%>
                <%--<div class="select-all">--%>
                    <%--<div class="cart-checkbox">--%>
                        <%--<input class="check-all check" id="allCheckked" type="checkbox" value="true">--%>
                    <%--</div>--%>
                    <%--<label>&nbsp;&nbsp;全选</label>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th th-item">--%>
                <%--<div class="th-inner">--%>
                    <%--商品--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th th-price">--%>
                <%--<div class="th-inner">--%>
                    <%--单价--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th th-amount">--%>
                <%--<div class="th-inner">--%>
                    <%--数量--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th th-sum">--%>
                <%--<div class="th-inner">--%>
                    <%--小计--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th th-op">--%>
                <%--<div class="th-inner">--%>
                    <%--操作--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="OrderList">--%>
            <%--<div class="order-content" id="list-cont">--%>
                <%--<c:forEach items="${list}" var="car">--%>
                    <%--<ul class="item-content layui-clear">--%>
                        <%--<li class="th th-chk">--%>
                            <%--<div class="select-all">--%>
                                <%--<div class="cart-checkbox">--%>
                                    <%--<input class="CheckBoxShop check" id="check" type="checkbox" num="all"--%>
                                           <%--name="select-all" value="${car.id}">--%>
                                        <%--${car.id}--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li class="th th-item">--%>
                            <%--<div class="item-cont">--%>
                                <%--<a href="javascript:;"><img src="/images/${car.image}" alt=""></a>--%>
                                <%--<div class="text">--%>
                                    <%--<div class="title">${car.pname}</div>--%>
                                    <%--<p><span>厂家</span> <span>${car.vender}</span></p>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</li>--%>

                        <%--<li class="th th-price">--%>
                            <%--<del style="color: grey;">${car.price}</del>--%>
                            <%--<br/>--%>
                            <%--<br/>--%>
                            <%--<c:if test="${vip.id!=2}">--%>
                            <%--<span >--%>
                                <%--会员价:--%>
                            <%--</span>--%>
                            <%--</c:if>--%>
                            <%--<span class="th-su" id="price" name="price">--%>
                                <%--<fmt:formatNumber type="number" value="${car.price*vip.discount}" pattern="0.00" maxFractionDigits="2"/>--%>
                            <%--</span>--%>
                        <%--</li>--%>

                        <%--<li class="th th-amount">--%>
                            <%--<div class="box-btn layui-clear">--%>
                                <%--<div class="less layui-btn" onclick="reduce(${car.id})">-</div>--%>
                                <%--<input class="Quantity-input" type="" id="pcount" name="pcount" value="${car.pcount}"--%>
                                       <%--disabled="disabled">--%>
                                <%--<div class="add layui-btn" onclick="insert(${car.id})">+</div>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                        <%--<li class="th th-sum">--%>
                            <%--<span class="sum">--%>
                                <%--<fmt:formatNumber type="number" value="${car.price*vip.discount*car.pcount}" pattern="0.00" maxFractionDigits="2"/>--%>
                            <%--</span>--%>
                        <%--</li>--%>
                        <%--<li class="th th-op">--%>
                            <%--<span  onclick="javjavascript:return deleteCar(${car.id});">删除</span>--%>
                        <%--</li>--%>
                    <%--</ul>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="FloatBarHolder layui-clear">--%>
            <%--<div class="th th-chk">--%>
                <%--<div class="select-all">--%>
                    <%--<div class="cart-checkbox">--%>
                        <%--<input class="check-all check" name="selectall" type="checkbox" value="true">--%>
                    <%--</div>--%>
                    <%--<label>&nbsp;&nbsp;已选<span class="Selected-pieces">0</span>件</label>--%>
                    <%--&lt;%&ndash;<span >${vip.discount}</span>&ndash;%&gt;--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="th batch-deletion">--%>
                <%--&lt;%&ndash;<span class="batch-dele-btn">批量删除</span>&ndash;%&gt;--%>
            <%--</div>--%>
            <%--<div class="th Settlement">--%>
                <%--<button class="layui-btn" onclick="toggle()">选择地址</button>--%>
            <%--</div>--%>
            <%--<c:if test="${vip.ispostage==0}">--%>
                <%--快递：<span  id="postage" name="postage" style="color:#ee0000;font-size: 24px">10</span>&nbsp;元--%>
            <%--</c:if>--%>

            <%--<div class="th total">--%>

                <%--<p>总计：<span class="pieces-total" id="allprice" name="allprice">0</span>&nbsp;元</p>--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div id="show">--%>

            <%--<div style="width: 1100px;" id="address">--%>
                <%--<br>--%>
                <%--<table class="table-address">--%>

                    <%--<c:forEach items="${address}" var="a">--%>
                        <%--<tr>--%>
                            <%--<td style="width: 120px;"><input class="CheckBoxShop check" type="radio" num="all"--%>
                                                             <%--name="select-address" value="${a.id}"></td>--%>
                            <%--<td style="width: 220px;">${a.address}</td>--%>
                            <%--<td style="width: 100px;">${a.receiver}</td>--%>
                            <%--<td style="width: 300px;">${a.tel}</td>--%>
                            <%--<td style="width: 120px;">--%>
                                <%--<input class="layui-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>to-upAddress.do?id=${a.id}',500,400)"--%>
                                       <%--style="width: 100px;background-color: #1481ff;"  value="修改地址" >--%>
                            <%--</td>--%>
                            <%--<td style="width: 120px;">--%>
                                <%--<input class="layui-btn" value="删除" onclick="deleteAddress(${a.id})" style="width: 100px;background-color: #ff5320">--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<br>--%>
                    <%--</c:forEach>--%>
                <%--</table>--%>
                <%--<br>--%>
                <%--<button  class="address-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>add-Address.do',500,400)">--%>
                    <%--<i class="iconfont">&#xe6b9;</i>新增收获地址--%>
                <%--</button>--%>

                <%--<br>--%>

                <%--<button style="width: 160px;height: 84px;background-color: #ff5500;border: 0px;color: white;font-size: 20px"onclick="pay()">生成订单</button>--%>

            <%--</div>--%>
            <%--&lt;%&ndash;<div style="width: 495px;">&ndash;%&gt;--%>
            <%--&lt;%&ndash;&ndash;%&gt;--%>

            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
        <%--</div>--%>
    <%--</div>--%>

    <div class="cart w1200">
        <div class="OrderList">
            <div class="order-content" id="list-cont">
                <ul class="item-content layui-clear" style="border: 0px;">
                    <li class="th th-chk">
                        <div class="select-all">
                            <span style="display: none;" id="ono" name="ono">${detail.ono}</span>
                        </div>
                    </li>
                    <li class="th th-item" style="left: -22px;">
                        <div class="item-cont">
                            <a href="<%=basePath%>proInfo.do?pno=${product.pno}"><img src="/images/${product.image}" alt="" style="border-radius: 50%;"></a>
                            <div class="text" style="line-height: 50px;">
                                <div class="title">${product.pname}</div>
                                <p><span>厂家</span> <span>${product.vender}</span></p>
                            </div>
                        </div>
                    </li>
                    <li class="th th-price">
								<span class="th-su">
              	<textarea  placeholder="请在此填写评价..." name="${product.pno}" id ="${product.pno}" style="width: 600px;height: 100px;border: 2px solid #ececee;border-radius: 3px;padding: 5px;"></textarea>
              </span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="FloatBarHolder layui-clear" style="background-color: #ececee;height: 0px;">
            <div class="th batch-deletion">
                <div class="th Settlement">
                    <button class="layui-btn" style="height: 50px;line-height: 50px;" onclick="comment(${product.pno})">评价</button>
                </div>
            </div>
        </div>
    </div>
    <br>
    <br>
    <br>
    <br>
    <div class="footer" style="position: relative">
        <div class="ng-promise-box">
            <div class="ng-promise w1200">
                <p class="text">
                    <a class="icon1" href="javascript:;">7天无理由退换货</a>
                    <a class="icon2" href="javascript:;">消费满10000全场免邮</a>
                    <a class="icon3" style="margin-right: 0" href="javascript:;">100%品质保证</a>
                </p>
            </div>
        </div>
        <div class="mod_help w1200">
            <p>
                <a href="javascript:;">关于我们</a>
                <span>|</span>
                <a href="javascript:;">帮助中心</a>
                <span>|</span>
                <a href="javascript:;">售后服务</a>
                <span>|</span>
                <a href="javascript:;">健身资讯</a>
                <span>|</span>
                <a href="javascript:;">关于货源</a>
            </p>
            <p class="coty">体育器材商城版权所有 &copy; 2019-2020</p>
            <p class="coty">desgined by 庞锡秋™</p>
        </div>
    </div>

    <script type="text/javascript">
        layui.config({
            base: '../res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
        }).use(['mm', 'jquery', 'element', 'car'], function () {
            var mm = layui.mm, $ = layui.$, element = layui.element, car = layui.car;
            car.init()


        });

        function test() {
            var allprice = document.getElementById("allprice").innerText;
            if(${vip.id==2}){
                var postage = document.getElementById("postage").innerText;
                var all = Number(postage)+Number(allprice);
            }else{
                var all = allprice;
            }


            alert(postage);
            alert(allprice);
            alert(all);
        }


        function comment(pno) {
            var ono = document.getElementById("ono").innerText;
            var udesc = document.getElementById(pno).value;
            var desc = udesc.replace(/\s*/g,"");
            if(desc!=null && desc!='' && ono !=''){
                if (confirm("确认评价吗？")) {
                    alert(pno);
                    alert(udesc);
                    alert(ono);
                    $.ajax({
                        url: "<%=basePath%>user/addComments.do",
                        type: "post",
                        data: {
                            "pno":pno,
                            "udesc":desc,
                            "ono":ono
                        },
                        traditional: true,
                        async: true,
                        success: function (res) {
                            alert("评价成功")
                            console.log(res)
                            // if(res.code===0){
                            //     alert("评价成功")
                            // }else{
                            //     alert("失败")
                            // }
                        }, error: function () {
                            alert("评价提交失败")
                        }
                    })
                }else{
                    return false;
                }
            }else{
                alert("至少也要说一句吧。");
            }
        }




        function toggle() {
            var div = document.getElementById("show");
            if (div.style.display == "block") {
                div.style.display = "none";
            } else {
                div.style.display = "block";
            }
        }




    </script>



</body>
</html>