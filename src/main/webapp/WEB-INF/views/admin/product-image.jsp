<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/12
  Time: 20:52
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
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js"></script>
</head>
<style>

    .file-box{

        display: inline-block;

        position: relative;

        padding: 3px 5px;

        overflow: hidden;

        color:#fff;

        background-color: #ccc;

    }

    .file-btn{

        position: absolute;

        width: 100%;

        height: 100%;

        top: 0;

        left: 0;

        outline: none;

        background-color: transparent;

        filter:alpha(opacity=0);

        -moz-opacity:0;

        -khtml-opacity: 0;

        opacity: 0;

    }

</style>
<body>
<div class="x-body layui-anim layui-anim-up">



        <%--<div class="layui-form-item">--%>
            <%--<label class="layui-form-label">图片信息</label>--%>
            <%--<div class="layui-upload">--%>
                <%--&lt;%&ndash;<div class="file-box">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<input  id="pic1" name="pic1" type="file" class="file-btn" />上传图片&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<input type="file" class="layui-btn" id="test1">上传图片</input>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div class="layui-upload-list">&ndash;%&gt;--%>
                <%--<img class="layui-upload-img"  src="/images/${pd.image}">--%>
                <%--&lt;%&ndash;<p id="demoText"></p>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="layui-form-item">
            <label class="layui-form-label">图片详情1</label>
            <div class="layui-upload">
                <%--<div class="file-box">--%>
                    <%--<input  id="pic2" name="pic2" type="file" class="file-btn" />上传图片--%>
                <%--</div>--%>
                <%--<button type="button" class="layui-btn" name="pic2" id="pic2">上传图片</button>--%>
                <%--<div class="layui-upload-list">--%>
                <%--<img class="layui-upload-img" id="demo2">--%>
                <%--<p id="demoText2"></p>--%>
                <%--</div>--%>
                    <img class="layui-upload-img"  src="/images/${product.image}" width="150px" height="150px">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片详情2</label>
            <div class="layui-upload">
                <%--<div class="file-box">--%>
                    <%--<input  id="pic3" name="pic3" type="file" class="file-btn" />上传图片--%>
                <%--</div>--%>
                <%--<button type="button" class="layui-btn" name="pic3" id="pic3">上传图片</button>--%>
                <%--<div class="layui-upload-list">--%>
                <%--<img class="layui-upload-img" id="demo3">--%>
                <%--<p id="demoText3"></p>--%>
                <%--</div>--%>
                    <img class="layui-upload-img"  src="/images/${product.image1}"  width="150px" height="150px">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片详情3</label>
            <div class="layui-upload">
                <%--<button type="button" class="layui-btn" id="test1">上传图片</button>--%>
                <%--<div class="layui-upload-list">--%>
                    <%--<img class="layui-upload-img" id="demo1">--%>
                    <%--<p id="demoText"></p>--%>
                <%--</div>--%>
                <img class="layui-upload-img"  src="/images/${product.image2}"  width="150px" height="150px">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">产品描述</label>
            <div class="layui-input-block">

                <span>${product.pdesc}</span>
            </div>
        </div>


</div>
<script>
    layui.use(['laydate','form', 'layer','upload'], function() {

        var laydate = layui.laydate;

        laydate.render({
            elem: '#pubdate'
        });

        var $ = layui.jquery,
            upload = layui.upload;
        var form = layui.form;
        var layer = layui.layer;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '<%=basePath%>back/addProductInfo.do'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });


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


    function add() {
        $.ajax({
            url:"<%=basePath%>back/addProductInfo.do",
            type:"POST",
            data: $("#addProduct").serialize(),
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
