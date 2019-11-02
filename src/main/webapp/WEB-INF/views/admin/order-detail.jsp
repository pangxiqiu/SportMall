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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%--<jsp:useBean id="timer" class="java.util.Date"/>--%>
<%--<fmt:formatDate value="${timer}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
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
        width: 800px;
        margin: 20px;
    }
    .table-order th{
        height: 30px;
        background-color: #f5f5f5;
    }
    .table-order td{
        border: 1px solid #f5f5f5;
        /*height: 100px;*/
        /*width: 100px;*/
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
<div class="content content-nav-base shopcart-content">
    <div class="cart w1200" style="width: 880px;">
            <table class="table-order">
                <tr>
                    <th ><p name="ono">商品</p></th>
                    <th >单价</th>
                    <th>数量</th>
                    <th>数量</th>
                </tr>
                <c:forEach items="${list}" var="d">
                    <tr>
                        <td style="width: 300px" >

                            <img src="/images/${d.image}" alt="">
                            <!-- <div class="text">-->
                                ${d.pname}

                            <!--</div>-->

                        </td>
                        <td>${d.price}</td>
                        <td>${d.amount}</td>
                        <td>${d.price * d.amount}</td>

                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4">
                        <div class="FloatBarHolder layui-clear">
                            <div class="th th-chk" style="width: 200px;">
                                订单日期:<fmt:formatDate value="${order.odate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </div>
                            <div class="th th-chk" style="width: 200px;">
                                支付时间:<fmt:formatDate value="${order.paydate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </div>
                            <div class="th th-chk" style="width: 200px;">
                                发货时间:<fmt:formatDate value="${order.senddate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </div>

                            <%--<div style="width: 700px; line-height: 30px" >--%>
                                <%--&lt;%&ndash;收货地址: ${order.address}&nbsp;${order.tel}&nbsp;${order.receiver}&ndash;%&gt;--%>
                                <%--<p>订单号:${order.ono}</p>--%>

                                <%--<p>订单日期:<fmt:formatDate value="${order.odate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>--%>

                                <%--<p>支付时间:<fmt:formatDate value="${order.paydate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>--%>

                                <%--<p>发货时间:<fmt:formatDate value="${order.senddate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>--%>

                            <%--</div>--%>

                        </div>
                    </td>

                </tr>


            </table>



        <!-- 模版导入数据 -->
        <!-- <script type="text/html" id="demo">
          {{# layui.each(d.infoList,function(index,item){}}
            <ul class="item-content layui-clear">
              <li class="th th-chk">
                <div class="select-all">
                  <div class="cart-checkbox">
                    <input class="CheckBoxShop check" id="" type="checkbox" num="all" name="select-all" value="true">
                  </div>
                </div>
              </li>
              <li class="th th-item">
                <div class="item-cont">
                  <a href="javascript:;"><img src="../res/static/img/paging_img1.jpg" alt=""></a>
                  <div class="text">
                    <div class="title">宝宝T恤棉质小衫</div>
                    <p><span>粉色</span>  <span>130</span>cm</p>
                  </div>
                </div>
              </li>
              <li class="th th-price">
                <span class="th-su">189.00</span>
              </li>
              <li class="th th-amount">
                <div class="box-btn layui-clear">
                  <div class="less layui-btn">-</div>
                  <input class="Quantity-input" type="" name="" value="1" disabled="disabled">
                  <div class="add layui-btn">+</div>
                </div>
              </li>
              <li class="th th-sum">
                <span class="sum">189.00</span>
              </li>
              <li class="th th-op">
                <span class="dele-btn">删除</span>
              </li>
            </ul>
          {{# });}}
        </script> -->





    </div>

</div>

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
</script>
</body>
</html>