<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.String"%>

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
    <div>
        <div>
            <button >新增</button>
            <button >删除</button>
        </div>
    </div>
    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>name</th>
                    <th>age</th>
                    <th>操作</th>
                </tr>
                <!-- items是要遍历的对象，在HomeController中已经传值给 “pageInfo”了，所以要取出其中的list值然后var为此次引用的变量名 -->
                <c:forEach items="${pageInfo.list}" var="user">
                    <!--//items要被循环的信息//var 代表当前条目的变量名称-->
                    <tr>
                        <th>${user.id}</th>
                        <th>${user.name}</th>
                        <th>${user.age}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <!-- 分页信息 -->
        <div class="col-md-6">当前${ pageInfo.pageNum }页，总共${ pageInfo.pages }页,总共${pageInfo.total }记录</div>

        <!-- 分页条信息 -->
          <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <!-- 首页和上一页的图标 -->
                    <li><a href="${ APP_PATH}/admin/users?pn=1">首页</a></li>
                    <!-- 写个判断，如果当前页在第一页，则无法点击首页和上一页 -->
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li><a href="${ APP_PATH}/admin/users?pn=${pageInfo.pageNum-1 }"
                               aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
                        </a></li>
                    </c:if>



                    <!-- 当前页遍历 -->
                    <c:forEach items="${ pageInfo.navigatepageNums }" var="page_Num">
                        <!-- 判断是否为当前页，如果是，就利用bootstrap让它比其他的页面亮一点 -->
                        <c:if test="${page_Num==pageInfo.pageNum }">
                            <li class="active"><a href="#">${page_Num }</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum }">
                            <!-- 跳转到第二页时候，href的写法，这样就实现了分页跳转 -->
                            <li><a href="${ APP_PATH}/admin/users?pn=${page_Num }">${page_Num }</a></li>
                        </c:if>
                    </c:forEach>

                    <!-- 末页和下一页图标 -->
                    <c:if test="${pageInfo.hasNextPage}">
                        <li><a href="${ APP_PATH}/admin/users?pn=${pageInfo.pageNum+1 }"
                               aria-label="Next"> <span aria-hidden="true">&raquo;</span>
                        </a></li>
                    </c:if>

                    <li><a href="${ APP_PATH}/admin/users?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
          </div>
    </div>

<!-- 显示分页信息 -->
</div>

</body>
</html>
