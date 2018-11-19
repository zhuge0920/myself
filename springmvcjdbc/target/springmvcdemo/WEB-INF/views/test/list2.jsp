<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.String"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>分页查询员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript"
            src="${ APP_PATH }/js/juery-3.1.1.min.js"></script>

    <link rel="stylesheet"
          href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script
            src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>ajax接收解析后端创过来的数据</title>
</head>
<body>
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 两个按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>age</th>
                    <th>操作</th>
                </tr>

            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!-- 分页信息 -->
        <div class="col-md-6">当前 页，总共 页， 总共 记录</div>


        <!-- 分页条信息 -->
        <div class="col-md-6"></div>
    </div>
</div>
<script type="text/javascript">
    //1、页面加载完成后，直接发送一个ajax请求，要到分页数据
    $(function() {
        $.ajax({
            url : "${APP_PATH}/admin/users",
            data : "pn=1",
            type : "GET",
            success : function(result) {
                //把获取到的信息输出到控制台上
                //console.log(result);
                build_emps_table(result);
            }
        });
    });
    //用于解析员工数据
    function build_emps_table(result) {
        //此处要对照JSON数据，获取到员工的list
        var user = result.extend.pageInfo.list;
        //jquery的遍历，user为要遍历的参数，后面的为每次遍历返回的内容；index为下标，item为当前的数据
        $.each(user, function(index, item) {
            //创建列表
            var userId = $("<td></td>").append(item.id);
            var userName = $("<td></td>").append(item.name);
            var userAge=$("<td></td>").append(item.name);
            //编辑按钮，利用jquery添加bootstrap所依赖的class
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //把两个按钮写在一起，并且在其中添加一个空格
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成后，还是返回原来的元素，所以可以不停使用append方法添加内容
            $("<tr></tr>").append(userId)
                          .append(userId)
                          .append(userName)
                          .append(userAge)
                          .append(btnTd)
                          .appendTo("#user_table tbody");
        });
    }

    //用于解析分页信息，等下写

</script>

</body>
