<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../assets/inc/meta.jsp"%>

<!-- css 참조 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/etc/reset.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ma_css/repwd.css" />
</head>

<body>
<%@ include file="../assets/inc/ma_top.jsp"%>
<div id="root">
    <div class="larUdW">
        <form method="post" action="${pageContext.request.contextPath}/main/repwd_ok.do" id="repwd_form" class="repwd">
            <h1>비밀번호 재설정</h1>
            <div class="repwd_div">
                <input autocomplete="off" class="re_input" type="password" name="passwd" placeholder="새로운 비밀번호" value="">
            </div>
            <div class="repwd_div">
                 <input autocomplete="off" class="re_input" type="password" name="passwd" placeholder="비밀번호 재입력" value="">
            </div>
            <div class="repwd_div" style="display:none">
                <input autocomplete="off" class="re_input" type="email" name="email" placeholder="이메일주소" value="${fullemail}">
            </div>
                 <button type="submit" class="re_btn">설정완료</button>
        </form>
    </div>
</div>	

<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
<script	src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
</body>
</html>