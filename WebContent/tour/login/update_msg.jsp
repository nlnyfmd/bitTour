<%@page import="Login.mvc.model.LoginCase"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
   if(${rCode} == <%=LoginCase.SIGN_UP%>){
	   alert("๐๐!!ํ์์ ๋ณด์์  ์ฑ๊ณตํ์จ์ต๋๋ค๐งก๐");
   }else {
	   alert("ํ์์ ๋ณด์์   ์คํจ");
   }
   
   location.href="../../";
</script>