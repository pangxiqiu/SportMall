<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/21
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="utf-8"  isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>
<body class="layui-anim layui-anim-up">

<div class="x-body">

    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>vip级别</th>
            <th>特权：折扣</th>
            <th>特权：邮费</th>
            <th>最小额度</th>
            <th>最大额度</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="vip">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
                </td>
                <%--<td>${vip.id}</td>--%>
                <td>${vip.vipname}</td>
                <td>${vip.discount*10}折</td>
                <td>
                    <c:if test="${vip.ispostage==1}">
                        不包邮
                    </c:if>
                    <c:if test="${vip.ispostage==2}">
                        包邮
                    </c:if>
                </td>
                <td>${vip.cost}</td>
                <td>${vip.maxcost}</td>
                <%--<td class="td-status">--%>
                    <%--<span class="layui-btn layui-btn-normal layui-btn-sm">--%>
                        <%--正常--%>
                    <%--<c:if test="${vip.state}==1">--%>
                        <%--禁用--%>
                    <%--</c:if>--%>
                <%--</span></td>--%>
                <td class="td-manage">
                    <%--<a onclick="member_stop(this,'10001')" class="layui-btn layui-btn-sm layui-btn-primary" href="javascript:;"  title="启用">--%>
                        <%--启用--%>
                    <%--</a>--%>
                    <a  class="layui-btn layui-btn-sm layui-btn-warm" onclick="edit(${vip.id})" title="编辑" href="javascript:;">
                        编辑
                    </a>

                </td>
            </tr>
        </c:forEach>
        <span>${msg}</span>>
        </tbody>
    </table>

</div>
<script>

    function edit(id) {
        x_admin_show('重置密码','<%=basePath%>back/editVip.do?id='+id,600,400)
    }
    // layui.use('laydate', function(){
    //     var laydate = layui.laydate;
    //
    //     //执行一个laydate实例
    //     laydate.render({
    //         elem: '#start' //指定元素
    //     });
    //
    //     //执行一个laydate实例
    //     laydate.render({
    //         elem: '#end' //指定元素
    //     });
    // });
    //
    // /*用户-停用*/
    // function member_stop(obj,id){
    //     layer.confirm('确认要停用吗？',function(index){
    //
    //         if($(obj).attr('title')=='启用'){
    //
    //             //发异步把用户状态进行更改
    //             $(obj).attr('title','停用')
    //             $(obj).find('i').html('&#xe62f;');
    //
    //             $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
    //             layer.msg('已停用!',{icon: 5,time:1000});
    //
    //         }else{
    //             $(obj).attr('title','启用')
    //             $(obj).find('i').html('&#xe601;');
    //
    //             $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
    //             layer.msg('已启用!',{icon: 5,time:1000});
    //         }
    //
    //     });
    // }
    //
    // /*用户-删除*/
    // function member_del(obj,id){
    //     layer.confirm('确认要删除吗？',function(index){
    //         //发异步删除数据
    //         $(obj).parents("tr").remove();
    //         layer.msg('已删除!',{icon:1,time:1000});
    //     });
    // }



</script>
</body>
</html>
