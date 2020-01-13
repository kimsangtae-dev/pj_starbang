<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<!-- css 참조 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/modal_css/adminfake.css" />

</head>
<div class="modal-content">
    <!-- 닫기버튼 -->
    <button class="btnclose" data-dismiss="modal">
        <svg width="30" height="30" viewbox="0 0 32 32">
            <g fill="none" fill-rule="evenodd" transform="translate(1 1)">
                <circle class="Circle" cx="15" cy="15" r="15"></circle>
                <g class="Close" stroke-linecap="round" stroke-width="2">
                    <path d="M19.243 19.243l-8.486-8.486M19.243 10.757l-8.486 8.486"></path>
                </g>
            </g>
        </svg>
    </button>
    <div class="fake_box">
        <div class="fake-header">
            <img src="${pageContext.request.contextPath}/assets/ico/logo_blue.png" />
            <p>허위매물 상세보기</p>
        </div>

        <!-- <hr /> -->

        <!-- 조회 결과 목록 -->
        <table class="table table-striped" border="1">
            <thead>
                <tr>
                    <th width="80" class="text-center">신고번호</th>
                    <th width="80" class="text-center">신고날짜</th>
                    <th width="200" class="text-center">신고된 이유</th>
                    <th width="100" class="text-center">방번호</th>
                    <th width="100" class="text-center">유저번호</th>
                    <th width="100" class="text-center">신고자</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <%-- 조회결과가 없는 경우 --%>
                    <c:when test="${output == null || fn:length(output) == 0}">
                        <tr>
                            <td colspan="5" align="center">조회결과가 없습니다.</td>
                        </tr>
                    </c:when>
                    <%-- 조회 결과가 있는 경우 --%>
                    <c:otherwise>
                        <%-- 조회 결과에 따른 반복 처리 --%>
                        <c:forEach var="item" items="${output}" varStatus="status">
                            <%-- 출력을 위해 준비한 유저이름과 위치 --%>
                            <c:set var="fakeno" value="${item.fakeno}" />
                            <c:set var="regdate" value="${item.regdate}" />
                            <c:set var="reason" value="${item.reason}" />
                            <c:set var="roomno" value="${item.roomno}" />
                            <c:set var="userno" value="${item.userno}" />
                            <c:set var="singo" value="${item.singo}" />

                            <tr>
                                <td align="center">${fakeno}</td>
                                <td align="center">${regdate}</td>
                                <td align="center"><c:choose>
                                        <c:when test="${reason eq '1'}">거래가 완료된 매물</c:when>
                                        <c:when test="${reason eq '2'}">가격이 다른 매물</c:when>
                                        <c:when test="${reason eq '3'}">사진이 다른 매물</c:when>
                                        <c:when test="${reason eq '4'}">위치가 다른 매물</c:when>
                                        <c:when test="${reason eq '5'}">옵션이 다른 매물</c:when>
                                    </c:choose></td>
                                <td align="center">${roomno}</td>
                                <td align="center">${userno}</td>
                                <td align="center">${singo}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
    // 새로고침
    $('.btnclose').click(function() {
        location.reload()
    });
</script>
