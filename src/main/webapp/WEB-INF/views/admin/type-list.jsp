<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/24
  Time: 23:26
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
    <meta charset="UTF-8">
    <title>欢迎页面-L-admin1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <%--<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />--%>
    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>

<body class="layui-anim layui-anim-up">

<div class="x-body">
    <div class="layui-row">
        <div class="layui-form layui-col-md12 x-so">
            <div class="layui-inline">
                <label class="layui-form-label">类别名称</label>
                <input type="text" id="typename" name="typename" placeholder="请输入类别名称" autocomplete="off" class="layui-input">
            </div>

            <div class="layui-inline">
                <label class="layui-form-label" style="width: 50px;">状态</label>
                <div class="layui-input-inline">
                    <select id="typestate" name="typestate">
                        <option value="0">请选择</option>
                        <option value="1">已启用</option>
                        <option value="2">未启用</option>
                    </select>
                </div>
            </div>

            <button id="do_search" class="layui-btn" lay-submit="" lay-filter="sreach" style="margin-left:20px ;"><i class="layui-icon">&#xe615;</i></button>
        </div>
    </div>
    <xblock>
<%--<button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>--%>
<button class="layui-btn" onclick="x_admin_show('添加类别','<%=basePath%>adminType/addType.do',600,400)"><i class="layui-icon"></i>添加</button>

</xblock>

    <table class="layui-table" id="table-type" lay-filter="table-type">

    </table>

</div>

<script type="text/html" id="barDemo">
    {{# if(d.typestate==1) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="down">禁用</a>
    {{# } else if(d.typestate==2) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="up">启用</a>
    {{# } }}

    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
</script>

<script type="text/html" id="type-state">
    {{#  if(d.typestate === 1){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm">已启用</span>
    {{#  } else if(d.typestate === 2){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm layui-btn-disabled">未启用</span>
    {{#  } }}
</script>


<script>
    layui.use(['laydate','layer','laypage','table'], function() {
        var laypage = layui.laypage
        var laydate = layui.laydate;
        var table = layui.table;
        layer = layui.layer;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });

        table.render({
            elem:'#table-type',
            url:'<%=basePath%>adminType/getTypes.do',
            height: 470,
            cols:[[
                // {checkbox:true,fixed:true},
                {field:'typeno',title:'类别编号', fixed:true,sort:true},
                {field:'typename',title:'类别名称'},
                {field:'typestate',title:'状态',templet:'#type-state'},
                {fixed:'right',align:'center',title:'操作',toolbar: '#barDemo'}
            ]],
            page:true
            // id:'contenttable',
            // toolbar:'#toolbardemo',
        });

        $('#do_search').on('click', function(){
            var typename = $("#typename").val();
            var typestate=$("#typestate").val();

            table.reload('table-type',{
                where:{
                    typename:typename,
                    typestate:typestate,

                },
                page:{
                    curr:1
                }
            });
        });


        //监听工具条
        table.on('tool(table-type)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                x_admin_show('编辑','<%=basePath%>adminType/editType.do?typeno='+data.typeno,500,400)
            } else if(obj.event === 'up') {
                layer.confirm('确认要启用吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>adminType/typestate.do?typestate=1&typeno='+data.typeno,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            layer.alert('启用成功', {
                                icon : 1,
                                time: 1000
                            });
                            window.location.reload();
                        },
                        error:function (res) {
                            layer.alert('启用失败', {
                                icon : 2,
                                time: 1000
                            });
                        }
                    })

                });
            } else if(obj.event === 'down'){
                layer.confirm('确认要停用吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>adminType/typestate.do?typestate=2&typeno='+data.typeno,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            layer.alert('停用成功', {
                                icon : 1,
                                time: 1000
                            });

                            window.location.reload();
                        },
                        error:function (res) {
                            layer.alert('停用失败', {
                                icon : 1,
                                time: 1000
                            });

                        }
                    })

                });
            }
        });


    });

    /*用户-停用*/
    // function member_stop(obj, id) {
    //     layer.confirm('确认要停用吗？', function(index) {
    //
    //         if($(obj).attr('title') == '启用') {
    //
    //             //发异步把用户状态进行更改
    //             $(obj).attr('title', '停用')
    //             $(obj).find('i').html('&#xe62f;');
    //
    //             $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
    //             layer.msg('已停用!', {
    //                 icon: 5,
    //                 time: 1000
    //             });
    //
    //         } else {
    //             $(obj).attr('title', '启用')
    //             $(obj).find('i').html('&#xe601;');
    //
    //             $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
    //             layer.msg('已启用!', {
    //                 icon: 5,
    //                 time: 1000
    //             });
    //         }
    //     });
    // }
</script>
</body>

</html>