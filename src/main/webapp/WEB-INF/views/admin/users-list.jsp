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
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8" />
    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>lib/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>
<body class="layui-anim layui-anim-up">

<div class="x-body">
        <div class="layui-row">
            <div class="layui-form layui-col-md12 x-so">
                <div class="layui-inline">
                    <select id="rolee" name="role"  style="display: inline-block;width: 150px;height:38px;">
                        <option value="0">请选择用户级别</option>
                        <c:forEach var="v" items="${viplist}">
                            <option value=${v.id}>${v.vipname}</option>
                        </c:forEach>
                    </select>
                </div>
                <input type="text" id="uname" name="uname"  placeholder="请输入用户名" autocomplete="off" class="layui-input">
                <input type="text" id="tel" name="tel"  placeholder="手机号" autocomplete="off" class="layui-input" >
                <%--<button class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>--%>
                <button id="do_search" class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
            </div>

        </div>

    <table class="layui-table" id="table-user" lay-filter="table-user">

    </table>


</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="upPwd">重置密码</a>
</script>

<script type="text/html" id="role">
    {{#  if(d.role === 2){ }}
    <span>普通用户</span>
    {{#  } else if(d.role === 3){ }}
    <span style="color: #aaf51d;">VIP1</span>
    {{#  } else if(d.role === 4){ }}
    <span style="color: #f5f21c;">VIP2</span>
    {{#  } else if(d.role === 5){ }}
    <span style="color: #f5f21c;">VIP3</span>
    {{#  } }}
</script>

<script>
    layui.use(['laydate','table'], function(){
        var laydate = layui.laydate;
        var table = layui.table;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });



        table.render({
            elem:'#table-user',
            url:'<%=basePath%>back/getUser.do',
            width: 1270,
            height: 480,
            cols:[[
                {checkbox:true,fixed:true},
                {field:'uid',title:'编号', width:80,fixed:true,sort:true},
                {field:'uname',title:'用户名'},
                {field:'pwd',title:'密码'},
                {field:'tel',title:'联系方式'},
                {field:'rname',title:'真实姓名',width:86},
                {field:'sex',title:'性别',width:80},
                {field:'cost',title:'消费额',width:80,sort:true},
                {field:'regdate',title:'注册日期',width:170,sort:true,templet : "<div>{{layui.util.toDateString(d.regdate, 'yyyy-MM-dd HH:mm:ss')}}</div>"},
                {field:'role',title:'级别',sort:true,templet:'#role'},
                {fixed:'right',align:'center',title:'操作',toolbar: '#barDemo'}

            ]],
            page:true
            // id:'contenttable',
            // toolbar:'#toolbardemo',
        });

        //监听表格复选框选择
        table.on('checkbox(table-user)', function(obj){
            console.log(obj)
        });

        table.on('tool(table-user)',function (obj) {
            var data = obj.data;
            if(obj.event === "upPwd"){
                layer.confirm('确定要重置密码？',function (index) {
                    console.log(data);
                    $.ajax({
                        url:'<%=basePath%>back/repwd.do',
                        type:'post',
                        data:{
                            "uid":data.uid
                        },
                        dataType:'json',
                        success:function (data) {
                            if(data.state===true){
                                layer.close(index);
                                layer.msg("重置密码成功", {icon: 6});
                            }else{
                                layer.msg("重置密码失败", {icon: 5});
                            }
                        }
                    });
                });
            }
        })

        $('#do_search').on('click', function(){
            var role = $("#rolee").val();
            var uname=$("#uname").val();
            var tel=$("#tel").val();
            table.reload('table-user',{
                where:{
                    role:role,
                    uname:uname,
                    tel:tel
                },
                page:{
                    curr:1
                }
            });
        });

        // var $ = layui.$,active = {
        //     reload:function () {
        //         var uname=$("#uname").val();
        //         var tel=$("#tel").val();
        //         table.reload('table-user',{
        //             where:{
        //                 uname:uname,
        //                 tel:tel
        //             },
        //             page:{
        //                 page:1
        //             }
        //         });
        //     }
        // };
    });

    // $('#do_search').on('click', function(){
    //     var uname=$("#uname").val();
    //     var tel=$("#tel").val();
    //     table.reload('table-user',{
    //         where:{
    //             uname:uname,
    //             tel:tel
    //         },
    //         page:{
    //             page:1
    //         }
    //     });
    // });

    // //时间戳的处理
    // layui.laytpl.toDateString = function(d, format){
    //     var date = new Date(d || new Date())
    //         ,ymd = [
    //         this.digit(date.getFullYear(), 4)
    //         ,this.digit(date.getMonth() + 1)
    //         ,this.digit(date.getDate())
    //     ]
    //         ,hms = [
    //         this.digit(date.getHours())
    //         ,this.digit(date.getMinutes())
    //         ,this.digit(date.getSeconds())
    //     ];
    //
    //     format = format || 'yyyy-MM-dd HH:mm:ss';
    //
    //     return format.replace(/yyyy/g, ymd[0])
    //         .replace(/MM/g, ymd[1])
    //         .replace(/dd/g, ymd[2])
    //         .replace(/HH/g, hms[0])
    //         .replace(/mm/g, hms[1])
    //         .replace(/ss/g, hms[2]);
    // };
    //
    // //数字前置补零
    // layui.laytpl.digit = function(num, length, end){
    //     var str = '';
    //     num = String(num);
    //     length = length || 2;
    //     for(var i = num.length; i < length; i++){
    //         str += '0';
    //     }
    //     return num < Math.pow(10, length) ? str + (num|0) : num;
    // };
    //
    //
    //
    //
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
