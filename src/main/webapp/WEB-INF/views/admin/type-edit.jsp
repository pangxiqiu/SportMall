<%--
  Created by IntelliJ IDEA.
  User: 庞锡秋
  Date: 2019/4/24
  Time: 23:50
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

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" id="addType" method="post">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>类别名称
            </label>
                <input type="text" id="typeno" name="typeno" value="${productType.typeno}" style="display: none">
            <div class="layui-input-inline">
                <input type="text" id="typename" name="typename" value="${productType.typename}" lay-verify="required" autocomplete="off" class="layui-input">
            </div>

        </div>

        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button  lay-submit="" class="layui-btn" lay-filter="edit_demo" >
               修改
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

        form.on('submit(edit_demo)', function(data){
            console.log(JSON.stringify(data.field));
            var typeno = $("#typeno").val();
            var typename = $("#typename").val();
            layer.confirm('确认修改吗？', function(index){
                $.ajax({
                    type : "POST",
                    url :'<%=basePath%>adminType/updateType.do',
                    data : {
                        'typeno':typeno,
                        'typename':typename
                    },
                    dataType : "text",
                    success : function(data) {

                        var index = parent.layer.getFrameIndex(window.name);
                        layer.alert('成功', {
                            icon : 1
                        });
                        setTimeout(function(){
                            parent.layer.close(index);//关闭弹出层
                            parent.location.reload();//更新父级页面（提示：如果需要跳转到其它页面见下文）
                        }, 500);

                    },error:function (data) {
                        layer.alert('失败', {
                            icon : 2
                        });
                    }
                });
            });
            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // });
            return false;
        });

    });


    
</script>
</body>

</html>