<%@page import="Login.mvc.model.LoginCase"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
   if(${rCode} == <%=LoginCase.SIGN_UP%>){
	   alert("๐๐!!ํ์ ๊ฐ์ ์ฑ๊ณตํ์จ์ต๋๋ค!!๐งก๐");
   }else {
	   alert("ํ์๊ฐ์  ์คํจ");
   }
   
   location.href="../../";
</script>