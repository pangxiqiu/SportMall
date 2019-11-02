<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/1
  Time: 0:09
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
    <title>产品列表</title>
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
            <div class="layui-input-inline">
                <select id="typeno" name="typeno" style="display: inline-block;width: 150px;height:38px;">
                    <option value="0">请选产品类别</option>
                    <c:forEach var="v" items="${list}">
                        <option value=${v.typeno}>${v.typename}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-inline">
                <input type="text" id="pname" name="pname"  placeholder="产品名称" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-inline">
                <input type="text" id="vender" name="vender"  placeholder="厂家" autocomplete="off" class="layui-input" >
            </div>
            <div class="layui-input-inline">
                <select id="pstate" name="pstate" style="display: inline-block;width: 150px;height:38px;">
                    <option value="0">上架状态</option>
                    <option value="1">上架</option>
                    <option value="2">下架</option>
                </select>
            </div>

            <%--<button class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>--%>
            <button id="do_search" class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
        </div>

    </div>

    <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加产品','<%=basePath%>back/productAdd.do',700,500)"><i class="layui-icon"></i>添加产品</button>

    </xblock>

    <table class="layui-table" id="table-product" lay-filter="table-product">

    </table>


</div>
<script type="text/html" id="barDemo">
    {{# if(d.pstate==1) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="down">下架</a>
    {{# } else if(d.pstate==2) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="up">上架</a>
    {{# } }}
    <a class="layui-btn layui-btn-xs" lay-event="add">补充库存</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail">其他信息</a>
</script>

<script type="text/html" id="state">
    {{#  if(d.pstate==1){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm">已上架</span>
    {{#  } else if(d.pstate==2){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm layui-btn-disabled">已下架</span>
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
            elem:'#table-product',
            url:'<%=basePath%>back/getProducts.do',
            width: 1270,
            height: 470,
            cols:[[
                {checkbox:true,fixed:true},
                {field:'pno',title:'编号', width:80,fixed:true,sort:true},
                // {field:'pic',title:'图片'},
                {field:'pname',title:'产品名称'},
                {field:'vender',title:'厂家'},
                {field:'pubdate',title:'生产日期',sort:true,width:170,templet : "<div>{{layui.util.toDateString(d.pubdate, 'yyyy-MM-dd HH:mm:ss')}}</div>"},
                {field:'price',title:'价格',sort:true},
                {field:'count',title:'库存',sort:true},
                {field:'pstate',title:'状态',templet:'#state'},
                {fixed:'right',align:'center',title:'操作',width:320,toolbar: '#barDemo'}
            ]],
            page:true
            // id:'contenttable',
            // toolbar:'#toolbardemo',
        });

        table.on('checkbox(table-product)', function(obj){
            console.log(obj)
        });

        //监听工具条
        table.on('tool(table-product)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.msg('ID：'+ data.pno + ' 的查看操作');
                x_admin_show('详细信息','<%=basePath%>back/product-image.do?pno='+data.pno,700,500)
            } else if(obj.event === 'up') {
                layer.confirm('确认要上架吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>back/product-down.do?pstate=1&pno='+data.pno,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            layer.alert('上架成功', {
                                icon : 1
                            });

                            window.location.reload();
                        },
                        error:function (res) {
                            layer.alert('上架失败', {
                                icon : 1
                            });
                        }
                    })

                });
            } else if(obj.event === 'down'){
                layer.confirm('确认要下架吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>back/product-down.do?pstate=2&pno='+data.pno,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            layer.alert('下架成功', {
                                icon : 1
                            });

                            window.location.reload();
                        },
                        error:function (res) {
                            layer.alert('下架失败', {
                                icon : 1
                            });

                        }
                    })

                });
            } else if(obj.event === 'edit'){
                // layer.prompt({
                //     formType: 2
                //     ,title: '修改 ID 为 ['+ data.pno +'] 的产品信息'
                //     ,value: data.pname
                // }, function(value, index){
                //     //这里一般是发送修改的Ajax请求
                //    // alert(value);
                //    // alert(index);
                // });
                // layer.alert('编辑行：<br>'+ JSON.stringify(data))
                x_admin_show('编辑','<%=basePath%>back/editProduct.do?pno='+data.pno,700,500)
            } else if(obj.event === 'add'){
                layer.prompt({
                    formType: 2
                    ,title: '补充产品 ['+ data.pno +':'+data.pname+'] 的库存'
                    ,value: data.amount
                }, function(value, index){
                    // alert(value); //得到value
                    if (isNaN(value)) {
                        layer.alert("请输入数字", {
                            icon: 5,
                            time: 1000
                        });
                    } else {
                        //这里一般是发送修改的Ajax请求
                        $.ajax({
                            url:'<%=basePath%>back/addProductCount.do?pno='+data.pno+'&count='+value,
                            type:'get',
                            async:'true',
                            success:function (res) {
                                layer.close(index);

                                obj.update({
                                    count: Number(data.count)+Number(value)
                                });
                                layer.alert("补充成功", {
                                    icon: 6,
                                    time: 1000
                                });
                                // layer.alert("补充成功", {
                                //     icon: 6,
                                //     time: 1000
                                // });
                                // window.location.reload();
                            },
                            error:function (res) {
                                layer.alert("补充失败", {
                                    icon: 5,
                                    time: 1000
                                });
                            }
                        })
                    }

                    // alert(value)



                });
            }
        });



        $('#do_search').on('click', function(){
            var typeno = $("#typeno").val();
            var pname=$("#pname").val();
            var vender=$("#vender").val();
            var pstate=$("#pstate").val();
            table.reload('table-product',{
                where:{
                    typeno:typeno,
                    pname:pname,
                    vender:vender,
                    pstate:pstate
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