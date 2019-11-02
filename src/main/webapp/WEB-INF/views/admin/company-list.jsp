<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/13
  Time: 16:23
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
    <title>快递公司列表</title>
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



            <input type="text" id="cname" name="cname"  placeholder="快递公司名称" autocomplete="off" class="layui-input">
            <%--<input type="text" id="vender" name="vender"  placeholder="厂家" autocomplete="off" class="layui-input" >--%>
            <input type="text" id="ctel" name="ctel"  placeholder="联系方式" autocomplete="off" class="layui-input" >
            <input type="text" id="cweb" name="cweb"  placeholder="网址" autocomplete="off" class="layui-input" >
            <%--<button class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>--%>
            <div class="layui-input-inline">
                <select id="cstate" name="cstate" style="display: inline-block;width: 150px;height:38px;">
                    <option value="0">状态</option>
                    <option value="1">正常</option>
                    <option value="9">禁用</option>
                </select>
            </div>
            <button id="do_search" class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
        </div>

    </div>

    <xblock>
    <button class="layui-btn" onclick="x_admin_show('添加快递公司','<%=basePath%>com/toAddCompany.do',500,400)"><i class="layui-icon"></i>添加快递公司</button>
    </xblock>

    <table class="layui-table" id="table-company" lay-filter="table-company">

    </table>


</div>
<script type="text/html" id="barDemo">
    {{# if(d.cstate!=9) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="down">停用</a>
    {{# } else if(d.cstate==9) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="up">启用</a>
    {{# } }}
    <%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>

</script>

<script type="text/html" id="state">
    {{#  if(d.cstate!=9){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm">正常</span>
    {{#  } else if(d.cstate==9){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm layui-btn-disabled">禁用</span>
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
            elem:'#table-company',
            url:'<%=basePath%>com/getCompanys.do',
            width: 1270,
            height: 470,
            cols:[[
                {checkbox:true,fixed:true},
                {field:'cid',title:'公司编号',fixed:true,sort:true},
                {field:'cname',title:'公司名称'},
                {field:'ctel',title:'联系方式'},
                {field:'cweb',title:'网址',width:220},
                {field:'cstate',title:'状态',templet:'#state'},
                {fixed:'right',align:'center',title:'操作',width:200,toolbar: '#barDemo'}
            ]],
            page:true
            // id:'contenttable',
            // toolbar:'#toolbardemo',
        });

        table.on('checkbox(table-company)', function(obj){
            console.log(obj)
        });

        //监听工具条
        table.on('tool(table-company)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                // layer.prompt({
                //     formType: 2
                //     ,title: '修改 ID 为 ['+ data.cid +'] 的产品信息'
                //     ,value: data.cname
                // }, function(value, index){
                //     //这里一般是发送修改的Ajax请求
                //     alert(value);
                //     alert(index);
                // });
                // layer.alert('编辑行：<br>'+ JSON.stringify(data))


                // layer.msg('ID：'+ data.cid + ' 的查看操作');
                x_admin_show('编辑','<%=basePath%>com/editCompany.do?cid='+data.cid,500,400)


            } else if(obj.event === 'up') {
                layer.confirm('确认要启用吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>com/upstate.do?cstate=1&cid='+data.cid,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            alert("启用成功");

                            window.location.reload();
                        },
                        error:function (res) {
                            alert("启用失败");
                        }
                    })

                });
            } else if(obj.event === 'down'){
                layer.confirm('确认要停用吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>com/upstate.do?cstate=9&cid='+data.cid,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            alert("停用成功");

                            window.location.reload();
                        },
                        error:function (res) {
                            alert("停用失败");
                        }
                    })

                });
            }
        });



        $('#do_search').on('click', function(){
            var cname = $("#cname").val();
            var ctel=$("#ctel").val();
            var cweb=$("#cweb").val();
            var cstate=$("#cstate").val();
            table.reload('table-company',{
                where:{
                    cname:cname,
                    ctel:ctel,
                    cweb:cweb,
                    cstate:cstate
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
