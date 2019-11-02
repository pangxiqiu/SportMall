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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/static/css/main.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
	<script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/regist.css" />
</head>
<body>
<jsp:include page="main/TBhead.jsp"></jsp:include>
<div class="content content-nav-base commodity-content">

    <div class="commod-cont-wrap">
        <div class="commod-cont w1200 layui-clear">
            <div class="left-nav">
                <div class="title">所有分类</div>
                <div class="list-box">
                    <dl>
                       <c:forEach items="${typelist}" var="type">
                        <dd><a href="<%=basePath%>home.do?typeno=${type.typeno}">${type.typename}</a></dd>
                       </c:forEach>
                    </dl>

                </div>
            </div>
            <div class="right-cont-wrap">
                <div class="right-cont">

                    <div class="prod-number">
                        <span>共查到${count}个匹配项</span>
                    </div>
                    <div class="cont-list layui-clear" id="list-cont">

                        <c:forEach var="pd" items="${list}">
                        <div class="item">
                            <a href="<%=basePath%>proInfo.do?pno=${pd.pno}">
                            <div class="img">
                                <img width="280px" height="280px" src="/images/${pd.image}">
                            </div>
                            <div class="text">
                                <p class="title">${pd.pname}</p>
                                <p class="price">
                                    <span class="pri">￥${pd.price}</span>
                                    <span class="nub">剩余${pd.count}</span>
                                </p>
                            </div>
                            </a>
                        </div>
                        </c:forEach>

                    </div>
                    <!-- 模版引擎导入 -->
                    <!-- <script type="text/html" id="demo">
                      {{# layui.each(d.menu.milk.content,function(index,item){}}
                        <div class="item">
                          <div class="img">
                            <a href="javascript:;"><img src="{{item.img}}"></a>
                          </div>
                          <div class="text">
                            <p class="title"></p>
                            <p class="price">
                              <span class="pri">{{item.pri}}</span>
                              <span class="nub">{{item.nub}}</span>
                            </p>
                          </div>
                        </div>
                      {{# }); }}
                    </script> -->
                    <div id="demo0" style="text-align: center;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
	<%--<table class="TAB-register" cellspacing="0 ">--%>

		<%--<tr>--%>
			<%--<table border="1" width=100%>--%>
				<%--<c:forEach var="pd" items="${list}" >--%>
					<%--<tr>--%>
						<%--<td rowspan=3><img width=100 height=100 src="/images/${pd.image}"/></td>--%>
						<%--<td colspan=2 align=center style="color:red">--%>
							<%--<a href="<%=basePath%>proInfo.do?pno=${pd.pno}">${pd.pname}</a>--%>
						<%--</td></tr>--%>
					<%--<tr><td>商品价格</td><td>${pd.price}</td></tr>--%>
					<%--<tr><td>品牌</td><td>${pd.vender}</td></tr>--%>
				<%--</c:forEach>--%>
			<%--</table>--%>
		<%--</tr>--%>
	<%--</table>--%>

<jsp:include page="main/Footer.jsp"></jsp:include>
</body>
</html>
