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
    <div class="cart w1200">
        <div class="cart-table-th">
            <div class="th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">
                        <input class="check-all check" id="allCheckked" type="checkbox" value="true">
                    </div>
                    <label>&nbsp;&nbsp;全选</label>
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
                    小计
                </div>
            </div>
            <div class="th th-op">
                <div class="th-inner">
                    操作
                </div>
            </div>
        </div>
        <div class="OrderList">
            <div class="order-content" id="list-cont">
                <c:forEach items="${list}" var="car">
                    <ul class="item-content layui-clear">
                        <li class="th th-chk">
                            <div class="select-all">
                                <div class="cart-checkbox">
                                    <input class="CheckBoxShop check" id="check" type="checkbox" num="all"
                                           name="select-all" value="${car.id}">
                                        ${car.id}
                                </div>
                            </div>
                        </li>
                        <li class="th th-item">
                            <div class="item-cont">
                                <a href="javascript:;"><img src="/images/${car.image}" alt=""></a>
                                <div class="text">
                                    <div class="title">${car.pname}</div>
                                    <p><span>厂家</span> <span>${car.vender}</span></p>
                                </div>
                            </div>
                        </li>

                        <li class="th th-price">
                            <del style="color: grey;">${car.price}</del>
                            <br/>
                            <br/>
                            <c:if test="${vip.id!=2}">
                            <span >
                                会员价:
                            </span>
                            </c:if>
                            <span class="th-su" id="price" name="price">
                                <fmt:formatNumber type="number" value="${car.price*vip.discount}" pattern="0.00" maxFractionDigits="2"/>
                            </span>
                        </li>

                        <li class="th th-amount">
                            <div class="box-btn layui-clear">
                                <div class="less layui-btn" onclick="reduce(${car.id})">-</div>
                                <input class="Quantity-input" type="" id="pcount" name="pcount" value="${car.pcount}"
                                       disabled="disabled">
                                <div class="add layui-btn" onclick="insert(${car.id})">+</div>
                            </div>
                        </li>
                        <li class="th th-sum">
                            <span class="sum">
                                <fmt:formatNumber type="number" value="${car.price*vip.discount*car.pcount}" pattern="0.00" maxFractionDigits="2"/>
                            </span>
                        </li>
                        <li class="th th-op">
                            <span  onclick="javjavascript:return deleteCar(${car.id});">删除</span>
                        </li>
                    </ul>
                </c:forEach>
            </div>
        </div>
        <div class="FloatBarHolder layui-clear">
            <div class="th th-chk">
                <div class="select-all">
                    <div class="cart-checkbox">
                        <input class="check-all check" name="selectall" type="checkbox" value="true">
                    </div>
                    <label>&nbsp;&nbsp;已选<span class="Selected-pieces">0</span>件</label>
                    <%--<span >${vip.discount}</span>--%>
                </div>
            </div>
            <div class="th batch-deletion">
                <%--<span class="batch-dele-btn">批量删除</span>--%>
            </div>
            <div class="th Settlement">
                <button class="layui-btn" onclick="toggle()">选择地址</button>
            </div>
            <c:if test="${vip.ispostage==1}">
                快递：<span  id="postage" name="postage" style="color:#ee0000;font-size: 24px">10</span>&nbsp;元
            </c:if>

            <div class="th total">

                <p>总计：<span class="pieces-total" id="allprice" name="allprice">0</span>&nbsp;元</p>
            </div>
        </div>

        <div id="show">

            <div style="width: 1100px;" id="address">
                <br>
                <table class="table-address">

                    <c:forEach items="${address}" var="a">
                        <tr>
                            <td style="width: 120px;"><input class="CheckBoxShop check" type="radio" num="all"
                                                             name="select-address" value="${a.id}"></td>
                            <td style="width: 220px;">${a.address}</td>
                            <td style="width: 100px;">${a.receiver}</td>
                            <td style="width: 300px;">${a.tel}</td>
                            <td style="width: 120px;">
                                <input class="layui-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>to-upAddress.do?id=${a.id}',500,400)"
                                       style="width: 100px;background-color: #1481ff;"  value="修改地址" >
                            </td>
                            <td style="width: 120px;">
                                <input class="layui-btn" value="删除" onclick="deleteAddress(${a.id})" style="width: 100px;background-color: #ff5320">
                            </td>
                        </tr>
                        <br>
                    </c:forEach>
                </table>
                <br>
                <button  class="address-btn" onclick="x_admin_show('新增收货地址','<%=basePath%>add-Address.do',500,400)">
                        <i class="iconfont">&#xe6b9;</i>新增收获地址
                </button>

                <br>

                    <button style="width: 160px;height: 84px;background-color: #ff5500;border: 0px;color: white;font-size: 20px"onclick="pay()">生成订单</button>

            </div>
            <%--<div style="width: 495px;">--%>
                <%----%>

            <%--</div>--%>
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



            function pay() {
                var address = $("input[name='select-address']:checked").val();

                var id = document.getElementsByName("select-all");
                var values = new Array();
                for (var i = 0; i < id.length; i++) {
                    if (id[i].checked)
                        values.push(id[i].value);
                }
                var allprice = document.getElementById("allprice").innerText;
                if(${vip.ispostage==1}){
                    var postage = document.getElementById("postage").innerText;
                    var all = Number(postage)+Number(allprice);
                }else{
                    var all = allprice;
                }
                if(address!=null && values!=null && values.length>0 && id!=null){
                    if (confirm("确认生成订单吗？")) {
                        $.ajax({
                            url: "<%=basePath%>user/order.do",
                            type: "post",
                            data: {
                                "list": values,
                                "allprice": all,
                                "address":address
                            },
                            traditional: true,
                            async: true,
                            success: function () {
                                alert("订单生成成功，请前往我的订单进行支付操作")
                            }, error: function () {
                                alert("订单生成失败，请联系管理员")
                            }
                        })
                    }else {
                        return false;
                    }
                }else{
                    alert("请正确选择信息");
                }



                // alert(values);
                // alert(allprice);
                // alert(address);
            }


            function reduce(id) {
                $.ajax({
                    url: "<%=basePath%>user/reduceCount.do",
                    type: "post",
                    data: {"id": id},

                    async: true,
                    success: function (res) {
                        if (res.code === 0) {
                            alert("-1");
                            console.log(res.msg);
                            window.close();
                        }
                    },
                    error: function (data) {
                        alert("-1 faile")
                        console.log("error:" + data.responseText)

                    }
                })


            }

            function insert(id) {
                $.ajax({
                    url: "<%=basePath%>user/insertCount.do",
                    type: "post",
                    data: {"id": id},
                    async: true,
                    success: function (res) {
                        if (res.code === 0) {
                            alert("+1");
                            console.log(res.msg);
                            window.close();
                        }
                    },
                    error: function (data) {
                        alert("+1 faile")
                        console.log("error:" + data.responseText)

                    }
                })
            }

            function deleteCar(id) {
                var msg = "确定要删除吗？";
                if (confirm(msg)==true) {
                    $.ajax({
                        url:'<%=basePath%>user/delete-car.do',
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
                }else {
                    return false;
                }
            }






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


            function toggle() {
                var div = document.getElementById("show");
                if (div.style.display == "block") {
                    div.style.display = "none";
                } else {
                    div.style.display = "block";
                }
            }

            function money(){

                var add = $("input[name='select-address']:checked").val();
                alert(add);
                // var address = document.getElementsByName("address");
                // for(var i = 0;i<address.length;i++){
                //     if(address[i].checked){
                //         alert(address[i].value);
                //     }
                // }

            }


        </script>



</body>
</html>