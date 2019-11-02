<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/12
  Time: 12:41
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
    #show {
        display: block;
        /*background-color:blue;*/
        width: 1198px;
        /*height:200px;*/
        border: 1px solid #f5f5f5;
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

    <div class="cart-table-th" style="width: 1200px;margin: auto;">
        <div class="th th-item">
            <div class="th-inner">
                <a href="javascript:;"><span style="color: orange;"> < 请选择收获地址！</span></a>
            </div>
        </div>

    </div>
    <div id="show" style="margin: auto">

        <div style="width: 1100px;" id="address">
            <br>
            <table class="table-address" style="margin-left: 100px">

                <c:forEach items="${address}" var="a">
                    <tr>
                        <td style="width: 120px;"><input class="CheckBoxShop check" type="radio" num="all"
                                                         name="select-address" value="${a.id}"></td>
                        <td style="width: 300px;">${a.address}</td>
                        <td style="width: 120px;">${a.receiver}</td>
                        <td style="width: 200px;">${a.tel}</td>
                        <td style="width: 120px;">
                            <input class="layui-btn"
                                   onclick="x_admin_show('新增收货地址','<%=basePath%>to-upAddress.do?id=${a.id}',500,400)"
                                   style="width: 100px;background-color: #1481ff;" value="修改地址">
                        </td>
                        <td style="width: 120px;">
                            <input class="layui-btn" value="删除" onclick="deleteAddress(${a.id})"
                                   style="width: 100px;background-color: #ff5320">
                        </td>
                    </tr>
                    <br>
                </c:forEach>
            </table>
            <br>
            <button class="address-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>add-Address.do',500,400)">
                <i class="iconfont">&#xe6b9;</i>新增收获地址
            </button>

            <br>

            <!--<button style="width: 160px;height: 84px;background-color: #ff5500;border: 0px;color: white;font-size: 20px"onclick="pay()">生成订单</button>-->

        </div>
        <br>
    </div>

    <div class="cart w1200">
        <div class="cart-table-th">
            <div class="th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">
                        <input class="check-all check" id="allCheckked" type="checkbox" value="true" hidden="hidden">
                    </div>
                </div>
            </div>
            <div class="th th-item">
                <div class="th-inner">
                    商品
                </div>
            </div>
            <div class="th th-price">
                <div class="th-inner">
                    单价
                </div>
            </div>
            <div class="th th-amount">
                <div class="th-inner">
                    数量
                </div>
            </div>
            <div class="th th-sum">
                <div class="th-inner">
                    总计
                </div>
            </div>

        </div>
        <div class="OrderList">
            <div class="order-content" id="list-cont">
                <ul class="item-content layui-clear">
                    <li class="th th-chk">
                        <div class="select-all">

                        </div>
                    </li>
                    <li class="th th-item">
                        <div class="item-cont">
                            <a href="javascript:;"><img src="/images/${product.image}" alt="${product.pno}"></a>
                            <div class="text">
                                <div class="title">${product.pname}</div>
                                <p><span>厂家</span> <span>${product.vender}</span></p>
                            </div>
                        </div>
                    </li>
                    <li class="th th-price">
                        <del style="color: grey;">${product.price}</del>
                        <br/>
                        <br/>
                        <c:if test="${vip.id!=2}">
                            <span>
                                会员价:
                            </span>
                        </c:if>
                        <span class="th-su" id="price" name="price">
                                <fmt:formatNumber type="number" value="${product.price*vip.discount}" pattern="0.00"
                                                  maxFractionDigits="2"/>
                            </span>
                    </li>
                    <li class="th th-amount">
                        <div class="box-btn layui-clear">
                            <div class="less layui-btn">-</div>
                            <input class="Quantity-input" type="" id="amount" name="amount" value="1"
                                   disabled="disabled">
                            <div class="add layui-btn">+</div>
                        </div>
                    </li>
                    <li class="th th-sum">
                            <span class="sum" id="allprice" name="allprice">
                                <fmt:formatNumber type="number" value="${product.price*vip.discount}" pattern="0.00"
                                                  maxFractionDigits="2"/>
                            </span>
                    </li>
                </ul>

            </div>
        </div>
        <div class="FloatBarHolder layui-clear">
            <div class="th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">

                    </div>

                </div>
            </div>
            <div class="th batch-deletion">
                <c:if test="${vip.ispostage==1}">
                    含运费<span id="postage" name="postage">10</span>元
                </c:if>
            </div>
            <div class="th Settlement">
                <button class="layui-btn" onclick="pay(${product.pno})">生成订单</button>
                <button class="layui-btn" style="position: absolute;right: 162px;top: -1px;background-color: darkgrey;"
                        onclick="javascript:history.go(-1);">返回
                </button>
            </div>
            <div class="th total">
                <span></span>
            </div>
        </div>
    </div>
</div>
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

            // 模版导入数据
            // var html = demo.innerHTML,
            // listCont = document.getElementById('list-cont');
            // mm.request({
            //   url: '../json/shopcart.json',
            //   success : function(res){
            //     listCont.innerHTML = mm.renderHtml(html,res)
            //     element.render();
            //     car.init()
            //   },
            //   error: function(res){
            //     console.log(res);
            //   }
            // })
            //
            car.init()


        });

        function pay(pno) {
            var address = $("input[name='select-address']:checked").val();
            var amount = $("#amount").val();
            var allprice = $("#allprice").text();
            if (${vip.ispostage==1}) {
                var postage = document.getElementById("postage").innerText;
                var all = Number(allprice) + Number(postage);
            } else {
                var all = allprice;
            }
            if (address != null && amount != null && allprice != null && pno != null) {
                if (confirm("确认生成订单吗？")) {
                    $.ajax({
                        url: "<%=basePath%>user/justOrder.do",
                        type: "post",
                        data: {
                            "pno": pno,
                            "amount": amount,
                            "allprice": all,
                            "address": address
                        },
                        traditional: true,
                        async: true,
                        success: function () {
                            alert("订单生成成功，请前往我的订单进行支付操作")
                        }, error: function () {
                            alert("订单生成失败，请联系管理员")
                        }
                    })
                } else {
                    return false;
                }

            } else {
                alert("请正确选择信息");
            }
        }


        function show() {
            var div = document.getElementById("show");
            if (div.style.display == "block") {
                div.style.display = "none";
            } else {
                div.style.display = "block";
            }
        }


        function deleteAddress(id) {
            var msg = "确定要删除吗？\n\n请确认！";
            if (confirm(msg) == true) {
                $.ajax({
                    url: '<%=basePath%>deleteAddress.do',
                    type: 'get',
                    data: {"id": id},
                    async: 'true',
                    success: function (res) {
                        alert("删除成功");
                        window.location.reload();
                    },
                    error: function (res) {
                        alert("删除失败");
                    }
                })
            } else {
                return false;
            }

        }
    </script>
</body>
</html>