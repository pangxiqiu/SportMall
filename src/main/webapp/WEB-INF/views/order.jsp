<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/10
  Time: 13:03
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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>

<style>
    .table-order{
        width: 1200px;
        margin: auto;
    }
    .table-order th{
        height: 30px;
        background-color: #f5f5f5;
    }
    .table-order td{
        border: 1px solid #f5f5f5;
        height: 100px;
        width: 100px;
        text-align: center;

    }

    .table-order img{
        margin: 20px;
        border: 1px solid #f5f5f5;
        width: 100px;
        height: 100px;

    }

    .table-order .text {

        margin: 20px;



    }
</style>
<body>
<jsp:include page="main/TBhead.jsp"></jsp:include>
<div class="content content-nav-base shopcart-content">

    <br />
    <div class="cart w1200">
        <div class="cart-table-th">
            <div class="th th-chk">
                <div class="select-all" style="width:800px;display: flex;justify-content: space-around">

                    <label><a href="<%=basePath%>user/myOrder.do?ostate=0">所有订单</a></label>
                    <label><a href="<%=basePath%>user/myOrder.do?ostate=1">待付款</a></label>
                    <label><a href="<%=basePath%>user/myOrder.do?ostate=2">待发货</a></label>
                    <label><a href="<%=basePath%>user/myOrder.do?ostate=3">配送中</a></label>
                    <label><a href="<%=basePath%>user/myOrder.do?ostate=4">待收货</a></label>
                    <label><a href="<%=basePath%>user/myOrder.do?ostate=5">已完成</a></label>
            </div>
            </div>

        </div>
        <br />
        <c:if test="${empty orderlist}" >
            <div style="margin: auto">
                <span style="color:grey;margin-left: 520px;margin-top: 50px">暂无数据</span>
            </div>

        </c:if>
        <c:forEach var="order" items="${orderlist}">
        <table class="table-order">

            <tr>
                <th><a name="ono">订单号:${order.ono}</a></th>

                <th colspan="2">订单日期:<fmt:formatDate value="${order.odate}" pattern="yyyy-MM-dd HH:mm:ss"/></th>
                <th colspan="2">
                    <c:if test="${order.ostate==1}">
                        未支付
                    </c:if>
                    <c:if test="${order.ostate==2}">
                        待发货
                    </c:if>
                    <c:if test="${order.ostate==3}">
                        配送中
                    </c:if>
                    <c:if test="${order.ostate==4}">
                        已送达
                    </c:if>
                    <c:if test="${order.ostate==5}">
                        交易完成
                    </c:if>
                    <c:if test="${order.ostate==9}">
                        <del>已取消</del>

                    </c:if>
                        <%--${order.ostate}--%>
                </th>
            </tr>
                <c:set value="${order.detaillist}" var="detaillist"/>
                    <c:forEach items="${detaillist}" var="d">
            <tr>
                <td style="width: 300px" >
                    <a href="<%=basePath%>proInfo.do?pno=${d.pno}"><img src="/images/${d.image}" alt=""></a>
                    <!-- <div class="text">-->
                    ${d.pname}

                    <!--</div>-->

                </td>
                <td>${d.price}</td>
                <td>${d.amount}</td>
                <td>${d.price * d.amount}</td>
                <td>
                 <c:if test="${order.ostate!=5}">
                     等待送达
                 </c:if>
                <c:if test="${order.ostate==5}">
                    <c:if test="${d.iscomment==0}">
                        <a href="<%=basePath%>user/getComments.do?ono=${order.ono}&pno=${d.pno}"><input type="button" value="立即评价"></a>
                    </c:if>
                    <c:if test="${d.iscomment==1}">
                        <a href="<%=basePath%>user/getComments.do?ono=${order.ono}&pno=${d.pno}"><input type="button" value="追加评价"></a>
                    </c:if>
                </c:if>
                </td>
            </tr>
                    </c:forEach>
            <tr>
                <td colspan="5">
                    <div class="FloatBarHolder layui-clear" style="line-height: 35px">
                        <div style="width: 700px;">
                            <p>收货地址: ${order.address}&nbsp;${order.tel}&nbsp;${order.receiver}</p>
                            <p>支付日期：<fmt:formatDate value="${order.paydate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                            <p>发货日期：<fmt:formatDate value="${order.senddate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                        </div>
                        <c:if test="${order.ostate==1}">
                            <div class="th Settlement">
                                <%--<button class="layui-btn" onclick="pay('${order.ono}')">支付</button>--%>
                                <a href="<%=basePath%>user/payMoney.do?ono=${order.ono}"><button class="layui-btn">支付</button></a>
                                <button class="layui-btn" onclick="quxiao('${order.ono}')" style="position: absolute;right: 162px;top: -1px;background-color: darkgrey;">取消订单</button>
                            </div>

                        </c:if>

                        <c:if test="${order.ostate==4}">
                            <div class="th Settlement">
                                <button class="layui-btn" onclick="received('${order.ono}')">确认收货</button>
                            </div>
                        </c:if>
                        <%--<c:if test="${order.ostate==5}">--%>
                            <%--<div class="th Settlement">--%>
                                <%--<a href="<%=basePath%>user/getComments.do?ono=${order.ono}"><button class="layui-btn">评价</button></a>--%>
                            <%--</div>--%>
                        <%--</c:if>--%>

                        <div class="th total" style="">
                            <p>总计：<span class="pieces-total">${order.allprice}</span>
                            <c:if test="${vip.ispostage==1}">
                                <label style="margin-left: 20px;">含运费：</label><span style="font-size: 16px;">10</span>元
                            </c:if>
                            <c:if test="${vip.id!=2}">
                                <span style="color: orange;font-size: 16px;margin-left: 20px">会员${vip.discount*10}折</span>
                            </c:if>

                            </p>
                        </div>
                    </div>
                </td>
                <br />
            </tr>
            <br />
        </table>
        </c:forEach>

        <br />


        <div class="OrderList">
            <div class="order-content" id="list-cont">

            </div>
        </div>

    </div>

</div>
<jsp:include page="main/Footer.jsp"></jsp:include>
<script type="text/javascript">
    layui.config({
        base: '../res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
    }).use(['mm','jquery','element','car'],function(){
        var mm = layui.mm,$ = layui.$,element = layui.element,car = layui.car;

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

    function quxiao(id) {
        if (confirm("确认取消订单吗？")) {
            $.ajax({
                url:'<%=basePath%>user/upstate.do?ostate=9&ono='+id,
                type:'get',
                async:'true',
                success:function (res) {
                    alert("已取消");
                    window.location.reload();
                },
                error:function (res) {
                    alert("取消失败");
                }
            });
        }
        else {
            return false;
        }
    }

    function received(id) {
        if (confirm("确认收货吗？")) {
            $.ajax({
                url:'<%=basePath%>user/upstate.do?ostate=5&ono='+id,
                type:'get',
                async:'true',
                success:function (res) {
                    alert("已收货");
                    window.location.reload();
                },
                error:function (res) {
                    alert("收获失败");
                }
            });
        }
        else {
            return false;
        }
    }

    function pay(id) {
        if (confirm("确认支付吗？")) {
            $.ajax({
                url:'<%=basePath%>user/payMoney.do?ono='+id,
                type:'get',
                async:'true',
                success:function (res) {
                    alert("支付成功");
                    window.location.reload();
                },
                error:function (res) {
                    alert("支付失败");
                }
            });
        }
        else {
            return false;
        }
    }


</script>
</body>
</html>