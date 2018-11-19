<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.github.pagehelper.PageInfo"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>员工信息</title>
        <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
        <script type="text/javascript" src="${ APP_PATH }/js/juery-3.1.1.min.js"></script>
        <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-16">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 两个按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <a href="/admin/users/add" type="button" class="btn btn-primary" >新增</a>
        </div>
    </div>
    <!-- 显示表格 -->
    <div class="row">
        <div class="col-md-12">
            <table id="user_table" class="table table-hover">
               <thead>
                  <tr>
                   <th>#</th>
                   <th>Name</th>
                   <th>age</th>
                   <th>操作</th>
                  </tr>
               </thead>

                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div  class="row">
        <!-- 分页信息 -->
        <div class="col-md-6" id="page_info_area"></div>


        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_pagination_info"></div>
    </div>
</div>
</body>
<script type="text/javascript">
    //1、页面加载完成后，直接发送一个ajax请求，要到分页数据
    $(function() {
        //直接去第一页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url : "${APP_PATH}/admin/users",
            data : "pn=" + pn,
            type : "GET",
            dataType:"JSON",
            contentType:"application/json;charset=utf-8",

            success : function(result) {
                //把获取到的信息输出到控制台上
                console.log(result);
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                build_page_nav(result);
            }
        });
    };

    function build_emps_table(result) {
        $("#user_table tbody").empty();
        //此处要对照JSON数据，获取到员工的list
        var user = result.extend.pageInfo.list;
        //jquery的遍历，user为要遍历的参数，后面的为每次遍历返回的内容；index为下标，item为当前的数据
        $.each(user, function(index, item) {
            //创建列表
            var empId = $("<td></td>").append(item.id);
            var empName = $("<td></td>").append(item.name);
            var age = $("<td></td>").append(item.age);
            //编辑按钮，利用jquery添加bootstrap所依赖的class
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm")
                .click(user,function () {
                    window.location.href="/admin/users/show/"+item.id;
                })
                .append($("<span></span>"))
                .append("编辑");
            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm")
                .click(function () {
                   // window.location.href="/admin/users/delete/"+item.id;
                    var r=confirm("确认删除？");
                    if(r){
                    $.ajax({
                        url: "/admin/user/delete/"+item.id,
                        type: "DELETE",
                        success: function (data) {      //成功，回调函数
                            if (data && data.code== '200') {
                                window.location.href= "/";
                            } else {
                                alert(data.msg);
                            }
                        },
                        error: function (er) {          //失败，回调函数
                            alert();
                        }

                    });
                    }
                })
                .append($("<span></span>"))
                .append("删除");
            //把两个按钮写在一起，并且在其中添加一个空格
            var btnTd = $("<td></td>").append(editBtn).append("  ").append(delBtn);

            //append方法执行完成后，还是返回原来的元素，所以可以不停使用append方法添加内容
            $("<tr></tr>").append(empId)
                          .append(empName)
                          .append(age)
                          .append(btnTd)
                          .appendTo("#user_table");
        });
    }
    function build_page_info(result) {
        $("#page_info_area").empty();
        //找到id=page_info_area的div块 进行操作
        $("#page_info_area").append(
            "当前" + result.extend.pageInfo.pageNum + "页，总共"
            + result.extend.pageInfo.pages + "页，总共"
            + result.extend.pageInfo.total + "记录");
      }
    function build_page_nav(result) {
        $("#nav_pagination_info").empty();
        var nav = $("<nav></nav>");
        var ul = $("<tr></tr>").addClass("pagination");
        //首页、上一页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断能不能点击前一页或者首页
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页的事件
            firstPageLi.click(function() {
                to_page(1);
            });
            prePageLi.click(function() {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        //末页、下一页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        //判断能不能点击下一页或者末页
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function() {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function() {
                to_page(result.extend.pageInfo.pages);
            })
        }

        ul.append(firstPageLi).append(prePageLi);

        //1,2,3,4,5页码显示
        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //让当前页面高亮
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            //添加单击事件
            numLi.click(function() {
                to_page(item);
            })
            ul.append(numLi);
        })

        ul.append(nextPageLi).append(lastPageLi);
        nav.append(ul);
        $("#nav_pagination_info").append(nav);
    }

</script>
</html>