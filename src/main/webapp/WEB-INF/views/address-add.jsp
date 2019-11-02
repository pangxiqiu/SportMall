<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/5/11
  Time: 11:54
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
    <title>添加收货地址</title>
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
    <form class="layui-form" id="addAddress"  method="post" >
        <div class="layui-form-item">
            <label  class="layui-form-label"><span class="x-red">*</span>收货地址</label>
            <div class="layui-input-inline">
                <input type="text" id="address" name="address" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">收件人</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input class="layui-input" id="receiver" name="receiver" placeholder="姓名" />
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input class="layui-input" id="tel" name="tel" placeholder="电话" />
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <input  class="layui-btn" value="添加" id="submit" onclick="add()"/>

            <%--<button class="layui-btn" lay-filter="add" lay-submit="">--%>
            <%--添加--%>
            <%--</button>--%>
            <span>${msg}</span>
        </div>
    </form>
</div>
<script>
    layui.use(['laydate','form', 'layer','upload'], function() {

        var laydate = layui.laydate;

        laydate.render({
            elem: '#pubdate'
        });

        var $ = layui.jquery;
        var upload = layui.upload;
        var form = layui.form;
        var layer = layui.layer;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#pic2'
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
        var address = $('#address').val();
        var receiver = $('#receiver').val();
        var tel = $('#tel').val();
        console.log(address);
        console.log(receiver);console.log(tel);

        if(address!=''&&receiver!=''&&tel!=''){
            $.ajax({
                url:"<%=basePath%>address-add.do",
                type:"POST",
                data: $("#addAddress").serialize(),
                async:true,
                beforeSend: function () {
                    // 禁用按钮防止重复提交
                    $("#submit").attr({ disabled: "disabled" });
                },
                success:function (data) {

                    alert("添加成功");
                    console.log(data);
                    var index = parent.layer.getFrameIndex(window.name);
                    setTimeout(function(){
                        parent.layer.close(index);//关闭弹出层
                        parent.location.reload();//更新父级页面（提示：如果需要跳转到其它页面见下文）
                    }, 100);
                    // window.parent.location.replace(location.href)//刷新父级页面

                },
                complete: function () {
                    $("#submit").removeAttr("disabled");
                },
                error:function (data) {
                    alert("添加失败")
                    console.log("error:"+data.responseText)

                }
            })
        }else{
            alert("请准确填写信息");

        }






    }

</script>
</body>

</html>