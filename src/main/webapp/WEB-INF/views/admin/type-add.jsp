<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/24
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" id="addType" method="post">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>类别名称
            </label>
            <div class="layui-input-inline">
                <input type="text" id="typename" name="typename" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>必填项
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">启用状态</label>
            <div class="layui-input-block">
                <input type="radio" name="typestate" value="1" title="启用" checked="">
                <input type="radio" name="typestate" value="2" title="停用">
            </div>
        </div>
        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button id="submit" class="layui-btn" lay-filter="add" onclick="add()">
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
            nikename: function(value) {
                if(value.length < 5) {
                    return '昵称至少得5个字符啊';
                }
            }
        });

    });

    //监听提交
    form.on('submit(add)', function(data) {
        console.log(data);

        //发异步，把数据提交给php
        layer.alert("增加成功", {
            icon: 6
        }, function() {
            // 获得frame索引
            var index = parent.layer.getFrameIndex(window.name);
            //关闭当前frame
            parent.layer.close(index);
        });
        return false;
    });


    function add() {
        $.ajax({
            url:"<%=basePath%>adminType/addTyped.do",
            type:"POST",
            data: $("#addType").serialize(),
            async:true,
            beforeSend: function () {
                // 禁用按钮防止重复提交
                $("#submit").attr({ disabled: "disabled" });
            },
            success:function (data) {

                    alert("添加成功")
                    console.log(data)

                window.close();

            },
            complete: function () {
                $("#submit").removeAttr("disabled");
            },
            error:function (data) {
                alert("添加失败")
                console.log("error:"+data.responseText)
            }
        })
    }
    
</script>
</body>

</html>