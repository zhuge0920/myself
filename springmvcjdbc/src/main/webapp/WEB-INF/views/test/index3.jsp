<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>js解析返回的json数据</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript" src="${ APP_PATH }/js/juery-3.1.1.min.js"></script>

    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script
            src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>ajax接收解析后端创过来的数据</title>
</head>
<body>
<div    >
    <!-- 标题 -->
    <div>
        <div">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 两个按钮 -->
    <div>
        <div>
            <button>新增</button>
            <button>删除</button>
        </div>
    </div>
    <!-- 显示表格 -->
    <div>
        <div >
            <table width="100%" border="10">
                <tr>
                    <th>id</th>
                    <th>Name</th>
                    <th>age</th>
                    <th>操作</th>
                </tr>

            </table>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function(){
        //alert(1);
        //这是json格式，但不是json串，这是key:value，  相当于一个map。{}外面得加上一个单引号才是串，但只是个json格式的字符串，不是json数据
        var params = '{"id": 1,"name": "测试商品","price": 99.9,"detail": "测试商品描述","pic": "123456.jpg"}';

        /*$.post(url,params,function(data){//这是回调json字符串，不能发送json字符串

        },"json");*/

        $.ajax({
            url: "${ APP_PATH }/testJson.action",
            data: params,
            contentType: "application/json;charset=UTF-8", //发送数据的格式
            type: "post",
            dataType: "json", //这是返回来是json，也就是回调json
            success: function(data){
                alert(data.name);
            }
        });
    });
</script>
</html>