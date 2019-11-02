<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/13
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
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
    <script type="text/javascript" src="<%=basePath%>lib/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form"  action="">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>公司名称
            </label>
            <div class="layui-input-inline">

                <input style="width: 220px;" type="text" id="cname" name="cname" lay-verify="required|cname" autocomplete="off" class="layui-input" >
            </div>

        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>联系方式
            </label>
            <div class="layui-input-inline">
                <input lay-verify="required|phone" style="width: 220px;" type="text" id="ctel" name="ctel" autocomplete="off" class="layui-input">
            </div>

        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>网址
            </label>
            <div class="layui-input-inline">
                <input lay-verify="required|url" style="width: 220px;" type="text" id="cweb" name="cweb"  autocomplete="off" class="layui-input" >
            </div>

        </div>



        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button class="layui-btn" lay-submit="" lay-filter="edit_demo">
                添加
            </button>
        </div>
    </form>


</div>
<script>
    layui.use(['form', 'layer','laypage'], function() {


        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //将一段数组分页展示



        //自定义验证规则
        form.verify({
            cname: function(value) {
                if(value.length < 4) {
                    return '昵称至少得4个字符啊';
                }
            },
            ctel: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']
        });

        //创建一个编辑器
        //layedit.build('LAY_demo_editor');

        form.on('submit(edit_demo)', function(data){
            console.log(JSON.stringify(data.field));
            var cname = $("#cname").val();
            var ctel = $("#ctel").val();
            var cweb = $("#cweb").val();

            layer.confirm('确认添加吗？', function(index){

                $.ajax({
                    type : "POST",
                    url :'<%=basePath%>com/insertCompany.do',
                    data : {
                        "cname":cname,
                        "ctel":ctel,
                        "cweb":cweb
                    },
                    dataType : "text",
                    success : function(data) {

                        var index = parent.layer.getFrameIndex(window.name);
                        layer.alert('添加成功', {
                            icon : 1
                        });
                        setTimeout(function(){
                            parent.layer.close(index);//关闭弹出层
                            parent.location.reload();//更新父级页面（提示：如果需要跳转到其它页面见下文）
                        }, 500);

                    },error:function (data) {
                        var index = parent.layer.getFrameIndex(window.name);
                        layer.alert('添加失败', {
                            icon : 2
                        });
                        setTimeout(function(){
                            parent.layer.close(index);//关闭弹出层
                            // parent.location.reload();//更新父级页面（提示：如果需要跳转到其它页面见下文）
                        }, 500);

                    }
                });
            });
            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // });
            return false;
        });
        // form.render(); // 更新全部

    });

    //监听提交
    // form.on('submit(add)', function(data) {
    //     console.log(data);
    //
    //     //发异步，把数据提交给php
    //     layer.alert("增加成功", {
    //         icon: 6
    //     }, function() {
    //         // 获得frame索引
    //         var index = parent.layer.getFrameIndex(window.name);
    //         //关闭当前frame
    //         parent.layer.close(index);
    //     });
    //     return false;
    // });


    <%--function add() {--%>
    <%--$.ajax({--%>
    <%--url:"<%=basePath%>adminType/addTyped.do",--%>
    <%--type:"POST",--%>
    <%--data: $("#addType").serialize(),--%>
    <%--async:true,--%>
    <%--beforeSend: function () {--%>
    <%--// 禁用按钮防止重复提交--%>
    <%--$("#submit").attr({ disabled: "disabled" });--%>
    <%--},--%>
    <%--success:function (data) {--%>

    <%--alert("添加成功")--%>
    <%--console.log(data)--%>

    <%--window.close();--%>

    <%--},--%>
    <%--complete: function () {--%>
    <%--$("#submit").removeAttr("disabled");--%>
    <%--},--%>
    <%--error:function (data) {--%>
    <%--alert("添加失败")--%>
    <%--console.log("error:"+data.responseText)--%>
    <%--}--%>
    <%--})--%>
    <%--}--%>

</script>
</body>

</html>