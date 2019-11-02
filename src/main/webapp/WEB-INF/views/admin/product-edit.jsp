<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/24
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

    .upload {
        width: 107px;
        height: 38px;
        padding: 0px 0px;
        /*height: 20px;*/
        line-height: 40px;
        text-align: center;
        position: absolute;
        text-decoration: none;
        color: white;
        background-color: #0dc316;
        border-radius: 2px;
        border: 1px solid grey;
    }

    .change {
        width: 107px;
        height: 38px;
        position: relative;
        overflow: hidden;
        /*right: -35px;*/
        top: -41px;
        opacity: 0;
        border: 1px solid grey;
    }
    #preview{
        width: 100px;
        height: 100px;
        position: relative;
        overflow: hidden;
        top:0;
        right: -130px;
        opacity: 0.9;
        /*border: 1px dashed grey;*/
        /*display: none;*/
    }

    #preview1{
        width: 100px;
        height: 100px;
        position: relative;
        overflow: hidden;
        top:0;
        right: -130px;
        opacity: 0.9;
        /*border: 1px dashed grey;*/
        /*display: none;*/
    }

    #preview2{
        width: 100px;
        height: 100px;
        position: relative;
        overflow: hidden;
        top:0;
        right: -130px;
        opacity: 0.9;
        /*border: 1px dashed grey;*/
        /*display: none;*/
    }

</style>
<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" id="updateProduct" action="<%=basePath%>back/updateProduct.do" method="post" enctype="multipart/form-data">
        <div class="layui-form-item" style="display: none;">
            <div class="layui-input-inline">
                <input type="text" id="pno" name="pno" autocomplete="off" class="layui-input" value="${product.pno}">
            </div>
        </div>

        <div class="layui-form-item">

            <label  class="layui-form-label"><span class="x-red">*</span>产品名称</label>
            <div class="layui-input-inline">
                <input type="text" id="pname" name="pname" lay-verify="required|nikename" autocomplete="off" class="layui-input" value="${product.pname}">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>必填项
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">启用状态</label>
            <div class="layui-input-block">
                <input type="radio" name="pstate" value="1" title="启用" checked="">
                <input type="radio" name="pstate" value="2" title="停用">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">厂家</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input class="layui-input" id="vender" lay-verify="required|nikename" name="vender" placeholder="" value="${product.vender}"/>
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>必填项
                </div>
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出厂日期</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input class="layui-input" id="pubdate" name="pubdate" placeholder="yyyy-MM-dd" value="<fmt:formatDate value="${product.pubdate}" pattern="yyyy-MM-dd"/>">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input class="layui-input" id="price" lay-verify="required|price" name="price" placeholder="￥0.00" value="${product.price}"/>
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>必填项
                </div>
            </div>

        </div>

        <div class="layui-form-item" >
            <label class="layui-form-label">图片信息</label>
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <span class="upload" >选择图片
				        <input type="file" class="change" id="pic" name="pic" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"  onchange="imgPreview(this)"/>
			        </span>

                    <img id="preview" src="/images/${product.image}"/>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片详情1</label>
            <div class="layui-input-inline">
                    <span class="upload" >选择图片
				        <input type="file" class="change" id="pic1" name="pic1" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"  onchange="imgPreview1(this)"/>
			        </span>
                <img id="preview1" src="/images/${product.image1}"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">图片详情2</label>
            <div class="layui-input-inline">
                    <span class="upload" >选择图片
				        <input type="file" class="change" id="pic2" name="pic2" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"  onchange="imgPreview2(this)"/>
			        </span>

                <img id="preview2" src="/images/${product.image2}"/>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">产品描述</label>
            <div class="layui-input-block">
                <textarea id="pdesc" name="pdesc"  placeholder="请输入内容" class="layui-textarea">${product.pdesc}</textarea>
            </div>
        </div>




        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <button class="layui-btn" lay-submit="" lay-filter="edit_demo">修改</button>
            <button class="layui-btn" lay-submit="" lay-filter="exit_demo">取消</button>
            <%--<button class="layui-btn" lay-filter="add" lay-submit="">--%>
                <%--添加--%>
            <%--</button>--%>
        </div>
    </form>
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
        <%--var uploadInst = upload.render({--%>
            <%--elem: '#test1'--%>
            <%--,url: '<%=basePath%>back/addProductInfo.do'--%>
            <%--,before: function(obj){--%>
                <%--//预读本地文件示例，不支持ie8--%>
                <%--obj.preview(function(index, file, result){--%>
                    <%--$('#demo1').attr('src', result); //图片链接（base64）--%>
                <%--});--%>
            <%--}--%>
            <%--,done: function(res){--%>
                <%--//如果上传失败--%>
                <%--if(res.code > 0){--%>
                    <%--return layer.msg('上传失败');--%>
                <%--}--%>
                <%--//上传成功--%>
            <%--}--%>
            <%--,error: function(){--%>
                <%--//演示失败状态，并实现重传--%>
                <%--var demoText = $('#demoText');--%>
                <%--demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');--%>
                <%--demoText.find('.demo-reload').on('click', function(){--%>
                    <%--uploadInst.upload();--%>
                <%--});--%>
            <%--}--%>
        <%--});--%>


        //自定义验证规则
        form.verify({
            nikename: function(value) {
                if(value.length < 2) {
                    return '名称至少得2个字符啊';
                }
            },
            price:[
                /^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/  //正则表达式
                ,'金额只能为正数'  //提示信息
            ],
            count:[
                /^[+]{0,1}(\d+)$/  //正则表达式
                ,'数量只能为正整数'  //提示信息
            ]
        });

        // form.on('submit(add_demo)',function(){
        //     var pic1 = $("#pic1").val();
        //     alert(pic1);
        //     console.log(pic1);
        // })


        //监听提交
        form.on('submit(edit_demo)', function(data) {
            console.log(data.field);
            // alert(data.field);
            $.ajax({
                url:"<%=basePath%>back/updateProduct.do",
                type:"POST",
                data:data.field,
                // data: data.field,
                dataType:json,
                contentType:"application/json",
                async:true,
                // processData : false,
                // contentType : false,
                beforeSend: function () {
                    // 禁用按钮防止重复提交
                    $("#submit").attr({ disabled: "disabled" });
                },
                success:function (res) {
                    // if(res.code===200){
                        layer.alert("修改成功", {
                            icon: 6,
                            time: 1000
                        },function() {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                        // alert("添加成功");
                        // console.log(data);
                        window.close();
                    // }
                },
                complete: function () {
                    $("#submit").removeAttr("disabled");
                },
                error:function (res) {
                    layer.alert("修改失败，请稍后再试", {
                        icon: 5,
                    },function() {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                    // alert("添加成功");
                    // console.log(data);
                    // window.close();
                    // alert("添加失败")
                    console.log("error:"+data.responseText)
                }
            });
            //发异步，把数据提交给php
            // layer.alert("增加成功", {
            //     icon: 6
            // }, function() {
            //     // 获得frame索引
            //     var index = parent.layer.getFrameIndex(window.name);
            //     //关闭当前frame
            //     parent.layer.close(index);
            // });
            return false;
        });
        form.on('submit(exit_demo)', function(data) {
            // 获得frame索引
            var index = parent.layer.getFrameIndex(window.name);
            //关闭当前frame
            parent.layer.close(index);
        });


    });


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
                    alert("添加成功");
                    console.log(data);
                window.close();
            },
            complete: function () {
                $("#submit").removeAttr("disabled");
            },
            error:function (data) {
                alert("添加失败");
                console.log("error:"+data.responseText)
            }
        })
    }

    function changepic() {
        var reads= new FileReader();
        f=document.getElementById('pic1').files[0];
        reads.readAsDataURL(f);
        reads.onload=function (e) {
            document.getElementById('show').src=this.result;
        };
    }

    function changepic2() {
        var reads= new FileReader();
        f=document.getElementById('pic2').files[0];
        reads.readAsDataURL(f);
        reads.onload=function (e) {
            document.getElementById('show2').src=this.result;
        };
    }


    function imgPreview(fileDom) {
        //判断是否支持FileReader
        if(window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if(!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img = document.getElementById("preview");
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    function imgPreview1(fileDom) {
        //判断是否支持FileReader
        if(window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if(!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img = document.getElementById("preview1");
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    function imgPreview2(fileDom) {
        //判断是否支持FileReader
        if(window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if(!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读取完成
        reader.onload = function(e) {
            //获取图片dom
            var img = document.getElementById("preview2");
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
</script>
</body>

</html>