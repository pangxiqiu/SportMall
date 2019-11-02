    <%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/28
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"  isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/regist.css" />
    <script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
</head>
<body>

<jsp:include page="main/TBhead.jsp"></jsp:include>

<div class="content content-nav-base datails-content">
    <%--<div class="main-nav">--%>
        <%--<div class="inner-cont0">--%>
            <%--<div class="inner-cont1 w1200">--%>
                <%--<div class="inner-cont2">--%>
                    <%--<a href="commodity.html" class="active">所有商品</a>--%>
                    <%--<a href="buytoday.html">今日团购</a>--%>
                    <%--<a href="information.html">母婴资讯</a>--%>
                    <%--<a href="about.html">关于我们</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="data-cont-wrap w1200">
        <div class="crumb">
            <a href="javascript:;">首页</a>
            <span>></span>
            <a href="javascript:;">所有商品</a>
            <span>></span>
            <a href="javascript:;">产品详情</a>
        </div>
        <div class="product-intro layui-clear">
            <div class="preview-wrap">
                <a href="javascript:;"><img src="/images/${product.image}" width="402px" height="402px"></a>
            </div>
            <div class="itemInfo-wrap">
                <div class="itemInfo">
                    <div class="title">
                        <h4>${product.pname}</h4>
                        <span><i class="layui-icon layui-icon-rate-solid"></i>${product.pno}</span>
                    </div>
                    <div class="summary" style="height: 180px;">
                        <p class="reference"><span>参考价</span> <del>￥${product.price}</del></p>
                        <p class="activity"><span>活动价</span><strong class="price"><i>￥</i>${product.price}</strong></p>
                        <p class="address-box"><span>发货地址</span><strong class="address">北京市&nbsp;&nbsp;海淀区&nbsp;&nbsp;</strong></p>
                        <p class="address-box"><span>剩余</span><strong class="address">${product.count}</strong></p>
                    </div>
                    <div class="choose-attrs">
                        <!--<div class="color layui-clear"><span class="title">颜&nbsp;&nbsp;&nbsp;&nbsp;色</span> <div class="color-cont"><span class="btn">白色</span> <span class="btn active">粉丝</span></div></div>-->
                        <div class="number layui-clear"><span class="title">数&nbsp;&nbsp;&nbsp;&nbsp;量</span><div class="number-cont"><span class="cut btn">-</span><input id="pcount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" maxlength="4" type="" name="" value="1"><span class="add btn">+</span></div></div>
                    </div>
                    <div class="choose-btns">
                        <a href="<%=basePath%>user/justOrder.do?pno=${product.pno}"><button class="layui-btn layui-btn-primary purchase-btn">立即购买</button></a>
                        <button class="layui-btn  layui-btn-danger car-btn"  onclick="addShopCar()"><i class="layui-icon layui-icon-cart-simple"></i>加入购物车</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-clear">
            <div class="aside" style="width: 400px">
                <h4>评价</h4>
                <div class="item-list">
                    <c:forEach var="c" items="${comments}">
                    <div class="item">
                        <p><span>${c.uname}</span><span class="pric">${c.udesc}</span></p>
                            <fmt:formatDate value="${c.tdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </div>
                    </c:forEach>
                </div>
            </div>
            <div class="detail" style="width: 750px">
                <h4>详情</h4>
                <div class="item">
                    <!--<img src="../res/static/img/details_imgbig.jpg">-->
                    <img src="/images/${product.image}" style="margin: 40px;width: 400px"/>
                    <img src="/images/${product.image1}" style="margin: 40px;width: 400px"/>
                    <h4>商品描述</h4>
                    <p style="font-size: 20px;color:grey;margin: 20px">${product.pdesc}</p>

                    <img src="/images/${product.image2}" style="margin: 40px;width: 400px"/>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="main/Footer.jsp"></jsp:include>
<script type="text/javascript">
    layui.config({
        base: '<%=basePath%>res/static/js/util/' //你存放新模块的目录，注意，不是layui的模块目录
    }).use(['mm','jquery'],function(){
        var mm = layui.mm,$ = layui.$;
        var cur = $('.number-cont input').val();
        $('.number-cont .btn').on('click',function(){
            if($(this).hasClass('add')){
                cur++;

            }else{
                if(cur > 1){
                    cur--;
                }
            }
            $('.number-cont input').val(cur)
        })

    });
</script>
    <script type="text/javascript">
        function addShopCar(){
            var pcount = $('#pcount');
            $.ajax({
                type: "POST",
                url: "<%=basePath%>user/addCar.do",
                data:{
                    'pno':${product.pno},
                    'pcount':pcount.val()
                },
                success: function(){
                   alert("添加成功")
                },
                error:function () {
                    alert("添加失败")
                }
            });
        }
    </script>


</body>
</html>
