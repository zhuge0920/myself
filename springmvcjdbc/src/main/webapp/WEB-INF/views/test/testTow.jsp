<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: zhuge0920
  Date: 2018/10/26
  Time: 上午10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--jsp指令-->
<html>
<head>
    <title>根据当前时间打印不同的问候语</title>
</head>
<body>
      <h6>可以编写任意的java代码</h6>
      <%
          Calendar now= Calendar.getInstance();
          int hour=now.get(Calendar.HOUR_OF_DAY);
          SimpleDateFormat sdf=new SimpleDateFormat("HH:mm:ss");
          System.out.print("当前时间是："+sdf.format(now.getTime())+"</br>");
          if(hour<12){
              %>
           早上好！
      <%
          }else if (hour<18){
              %>
           下午好！
      <%
          }else {
              %>
           晚上好！
      <%
          }
      %>
</body>
</html>
