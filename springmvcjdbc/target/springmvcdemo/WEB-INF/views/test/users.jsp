<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">

    <title>数据查询列表</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container">
    <h1>SpringMVC 博客系统-用户管理</h1>
    <hr/>

    <h3>所有用户 <a href="/admin/users/add" type="button" class="btn btn-primary btn-sm">添加</a></h3>

    <!-- 如果用户列表为空 -->
    <c:if test="${empty userList}">
        <div class="alert alert-warning" role="alert">
            <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>User表为空，请<a href="/admin/users/add" type="button" class="btn btn-primary btn-sm">添加</a>
        </div>
    </c:if>

</div>
<form action=${pageContext.request.contextPath }"/admin/users" method="get">
    数据查询：
    <table width="10%" border="1">
        <tr>
            <td><input type="submit" value="查询"/></td>
        </tr>
    </table>
    <!-- 如果用户列表非空 -->
    <c:if test="${!empty requestScope.userList}">
        <table width="100%" border="10">
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>年龄</th>
                <th>操作</th>
            </tr>

            <c:forEach items="${requestScope.userList}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.age}</td>
                    <td>
                        <a href="/admin/users/show/${user.id}" type="button" >详情</a>
                        <a href="/admin/users/update/${user.id}" type="button">修改</a>
                        <a href="/admin/users/delete/${user.id}" type="button">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</form>
</body>
</html></html>