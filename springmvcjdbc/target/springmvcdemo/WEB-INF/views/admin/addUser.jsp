<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <script type="text/javascript" src="/js/juery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
    <h1>SpringMVC 添加用户</h1>
    <hr/>
    <div class="row">
        <form id="formDemo" >
            <!--“user”说明form内的内容都保存在这个user实例中，然后将整个user实例传递给controller处理。-->
            <tr>
                <td><input type="text" id="name"  name="name" value="" placeholder="Enter Nickname:"/></td>
                <td><input type="text" id="age" name="age"  value=""  placeholder="Enter age"/></td>
                <td align="right"><input id="commit" type="button"  value="提交"/></td>
            </tr>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
        $(function () {
          $("#commit").click(function () {


              var user_name=$("#name").val();
              var user_age=$("#age").val();
              $.ajax({
                  url: "/admin/users/addP",        //后台url
                  data:JSON.stringify({"name":user_name,"age":parseInt(user_age)}),
                  type: "POST",                   //类型，POST或者GET
                  dataType: "JSON",              //数据返回类型，可以是xml、json等
                  contentType:'application/json;charset=utf-8',
                  success: function (data) {      //成功，回调函数
                      if (data && data.code== '200') {
                          window.location = "/";
                      } else {
                              alert(data.msg);
                      }
                  },
                  error: function (er) {          //失败，回调函数
                      alert(er);
                  }
              });
          })
      });
</script>
</html>

