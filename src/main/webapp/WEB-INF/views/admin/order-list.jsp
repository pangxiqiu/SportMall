<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/12
  Time: 23:51
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
    <title>订单列表</title>
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
                <label class="layui-form-label">订单编号</label>
                <input type="text" id="ono" name="ono"  placeholder="订单编号" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户id</label>
                <input type="text" id="uid" name="uid"  placeholder="用户id" autocomplete="off" class="layui-input">
            </div>

            <div class="layui-inline">
                <label class="layui-form-label" style="width: 80px;">订单状态</label>
                <div class="layui-input-inline">
                    <select id="ostate" name="ostate" style="display: inline-block;width: 150px;height:38px;">
                        <option value="0">请选择</option>
                        <option value="1">未支付-待支付</option>
                        <option value="2">已支付-代发货</option>
                        <option value="3">已发货-配送中</option>
                        <option value="4">已送达-待收货</option>
                        <option value="5">已签收-已完成</option>
                    </select>
                </div>
            </div>

            <button id="do_search" class="layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
        </div>

    </div>

    <%--<xblock>--%>
        <%--<button class="layui-btn" onclick="x_admin_show('添加产品','<%=basePath%>back/productAdd.do',700,500)"><i class="layui-icon"></i>添加产品</button>--%>

    <%--</xblock>--%>

    <table class="layui-table" id="table-order" lay-filter="table-order">

    </table>


</div>
<script type="text/html" id="barDemo">
    {{# if(d.ostate==1) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="down" style="visibility: hidden">下架</a>
    {{# } else if(d.ostate==2) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="up">发货</a>
    {{# } else if(d.ostate==3) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" lay-event="sended">送达</a>
    {{# } else if(d.ostate==4) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" style="visibility: hidden">送达</a>
    {{# } else if(d.ostate==5) { }}
    <a class="layui-btn layui-btn-sm layui-btn-primary" style="visibility: hidden">送达</a>
    {{# } }}
    <a class="layui-btn layui-btn-xs" lay-event="detail">详细信息</a>
</script>

<script type="text/html" id="state">
    {{#  if(d.ostate==1){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm layui-btn-disabled">待支付</span>
    {{#  } else if(d.ostate==2){ }}
    <span class="layui-btn layui-btn-normal layui-btn-sm">已支付</span>
    {{#  } else if(d.ostate==3){ }}
    <span class="layui-btn layui-btn-warm layui-btn-sm">配送中</span>
    {{#  } else if(d.ostate==4){ }}
    <span class="layui-btn layui-btn-primary layui-btn-sm ">待收货</span>
    {{#  } else if(d.ostate==5){ }}
    <span class="layui-btn layui-btn-primary layui-btn-sm ">已完成</span>
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
            elem:'#table-order',
            url:'<%=basePath%>Order/getAllOrders.do',
            width: 1270,
            height: 470,
            cols:[[
                {checkbox:true,fixed:true},
                {field:'ono',title:'订单号', width:220,fixed:true,sort:true},
                {field:'uid',title:'用户id',width:80},
                {field:'address',title:'收货地址',width:245},
                {field:'tel',title:'联系方式',width:130},
                {field:'receiver',title:'收件人',width:90},
                {field:'allprice',title:'总计/￥',width:80},
                {field:'odate',title:'订单日期',sort:true,width:170,templet : "<div>{{layui.util.toDateString(d.odate, 'yyyy-MM-dd HH:mm:ss')}}</div>"},
                {field:'cname',title:'快递公司',width:100},
                {field:'ostate',title:'状态',templet:'#state',width:100,fixed:'right'},
                {fixed:'right',align:'center',title:'操作',width:200,toolbar: '#barDemo'}
            ]],
            page:true
            // id:'contenttable',
            // toolbar:'#toolbardemo',
        });

        table.on('checkbox(table-order)', function(obj){
            console.log(obj)
        });

        //监听工具条
        table.on('tool(table-order)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                // layer.msg('ID：'+ data.ono + ' 的查看操作');
                x_admin_show('详细信息','<%=basePath%>Order/orderDetail.do?ono='+data.ono,900,500)
            } else if(obj.event === 'up') {
                x_admin_show('请选择快递公司','<%=basePath%>com/send-company.do?ono='+data.ono,500,500)

            } else if(obj.event === 'down'){
                layer.confirm('确认要下架吗？', function(index){
                    $.ajax({
                        url:'<%=basePath%>back/product-down.do?pstate=2&pno='+data.pno,
                        type:'get',
                        async:'true',
                        success:function (res) {
                            alert("下架成功");

                            window.location.reload();
                        },
                        error:function (res) {
                            alert("下架失败");
                        }
                    })

                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,title: '修改 ID 为 ['+ data.ono +'] 的产品信息'
                    ,value: data.pname
                }, function(value, index){
                    //这里一般是发送修改的Ajax请求
                    alert(value);
                    alert(index);
                });
                layer.alert('编辑行：<br>'+ JSON.stringify(data))
            } else if(obj.event === 'sended'){
                layer.confirm('是否已送达？', function(index){
                    $.ajax({
                        url:'<%=basePath%>Order/sendedOstate.do?ostate=4&ono='+data.ono,
                        type:'get',
                        async:'true',
                        dataType:'json',
                        success:function (res) {
                            layer.alert('已送达', {
                                icon : 1
                            });

                            window.location.reload();
                        },
                        error:function (res) {

                            layer.alert('送达失败', {
                                icon : 2
                            });
                        }
                    })

                });
            }
        });



        $('#do_search').on('click', function(){
            var ono = $("#ono").val();
            var ostate=$("#ostate").val();
            var uid = $("#uid").val();
            table.reload('table-order',{
                where:{
                    ono:ono,
                    ostate:ostate,
                    uid:uid
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