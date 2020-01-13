<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../assets/inc/meta_admin.jsp"%>

<!-- css 참조 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ad_css/userli.css" />

</head>

<body>
    <%@ include file="../assets/inc/ad_header.jsp"%>

<!-- 중앙 영역 -->
<div id="content">
    <div class="container">
        <div class="adm-header">
            <h1>회원관리</h1>
                <div class="search_form">
                    <form method="get"
                        action="${pageContext.request.contextPath}/admin/userli.do">
                    <div class="input-group">
                        <span class="input-group-addon"> 
                            <span class="glyphicon glyphicon-search"></span></span> 
                        <input type="search" class="form-control" name="keyword"
                                id="keyword" placeholder="이름 or회원번호 검색" value="${keyword}" /> 
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="submit">검색</button>
                            </span>
                    </div>
                    </form>
                    </div>
                    <br>
                    <div class="box">
                        <div class="adm-btn">
                            <input type="button" name="" class="btn btn-default" id="edit-user" value="회원수정"> 
                            <input type="button"
                                name="" class="btn btn-default" id="delete-user" value="회원탈퇴">
                        </div>
                    </div>
            
            </div>

    <!-- <hr /> -->
    
    <!-- 조회 결과 목록 -->
    <table class="table table-striped" border="1">
        <thead>
            <tr>
                <th class="text-center"><input type="checkbox"
                                id="all_check"></th>
                <th width="100" class="text-center">회원번호</th>
                <th class="text-center">이름</th>
                <th class="text-center">이메일</th>
                <th class="text-center">비밀번호</th>
                <th class="text-center">전화번호</th>
                <th class="text-center">등록날짜</th>
                <th class="text-center">수정날짜</th>
                <!-- <th class="text-center">프로필경로</th> -->
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <%-- 조회결과가 없는 경우 --%>
                <c:when test="${output == null || fn:length(output) == 0}">
                    <tr>
                        <td colspan="3" align="center">조회결과가 없습니다.</td>
                    </tr>
                </c:when>
                <%-- 조회 결과가 있는 경우 --%>
                <c:otherwise>
                    <%-- 조회 결과에 따른 반복 처리 --%>
                    <c:forEach var="item" items="${output}" varStatus="status">
                        <%-- 출력을 위해 준비한 유저이름과 위치 --%>
                        <c:set var="name" value="${item.name}" />
                        <c:set var="email" value="${item.email}" />
                        <c:set var="passwd" value="${fn:replace(item.passwd, item.passwd, '****')}" />
                        <c:set var="userno" value="${item.userno}" />
                        <c:set var="tel" value="${item.tel}" />
                        <c:set var="regdate" value="${item.regdate}" />
                        <c:set var="editdate" value="${item.editdate}" />
                        <%-- <c:set var="profile_img" value="${item.profile_img}" /> --%>
                        

                        <%--검색어가 있다면? --%>
                        <c:if test="${keyword != ''}">
                            <%-- 검색어에 <mark> 태그를 적용하여 형광펜 효과 준비 --%>
                            <c:set var="mark" value="<mark>${keyword}</mark>" />
                            <%-- 출력을 위해 준비한 유저이름과 위치에서 검색어와 일치하는 단어를 형광펜 효과로 변경 --%>
                            <c:set var="name" value="${fn:replace(name, keyword, mark)}" />
                            <c:set var="userno" value="${fn:replace(userno, keyword, mark)}" />
                        </c:if>

                        <tr>
                            <td class="text-center"><input type="checkbox" id="aaaa" value="${userno}" class="userlist"></td>
                            <td align="center">${userno}</td>
                            <%-- <td align="center"><a href="${viewUrl}">${name}</a></td> --%>
                            <td align="center">${name}</td>
                            <td align="center">${email}</td>
                            <td align="center">${passwd}</td>
                            <td align="center">${tel}</td>
                            <td align="center">${regdate}</td>
                            <td align="center">${editdate}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    </div>
    
    <%-- gallery-index --%>
    <div class="gallery-footer">
        <div class="gallery-index">
            <!-- 페이지 번호 구현 -->
            <%-- 이전 그룹에 대한 링크 --%>
            <c:choose>
                <%-- 이전 그룹으로 이동 가능하다면? --%>
                <c:when test="${pageData.prevPage > 0}">
                    <%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/userli.do" var="prevPageUrl">
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="page" value="${pageData.prevPage}" />
                    </c:url>
                    <a href="${prevPageUrl}" id="temp">
                        <button class="prev-btn">
                            <span>&lt;</span>
                        </button>
                    </a>
                </c:when>
                <c:otherwise>
                    <button class="prev-btn" id="temp">
                        <span>&lt;</span>
                    </button>
                </c:otherwise>
            </c:choose>

            <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
            <ul class="index-list">
                <c:forEach var="i" begin="${pageData.startPage}"
                    end="${pageData.endPage}" varStatus="status">
                    <%-- 이동할 URL 생성 --%>
                    <c:url value="/admin/userli.do" var="pageUrl">
                        <c:param name="keyword" value="${keyword}" />
                        <c:param name="page" value="${i}" />
                    </c:url>

                    <%-- 페이지 번호 출력 --%>
                    <c:choose>
                        <%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
                        <c:when test="${pageData.nowPage == i}">
                            <li><a class="index-indiv index-active">${i}</a></li>
                        </c:when>
                        <%-- 나머지 페이지의 경우 링크 적용함 --%>
                        <c:otherwise>
                            <li><a class="index-indiv" href="${pageUrl}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                        </c:forEach>
                    </ul>

                    <%-- 다음 그룹에 대한 링크 --%>
                    <c:choose>
                        <%-- 다음 그룹으로 이동 가능하다면? --%>
                        <c:when test="${pageData.nextPage > 0}">
                            <%-- 이동할 URL 생성 --%>
                            <c:url value="/admin/userli.do" var="nextPageUrl">
                                <c:param name="keyword" value="${keyword}" />
                                <c:param name="page" value="${pageData.nextPage}" />
                            </c:url>
                            <a href="${nextPageUrl}">
                                <button class="next-btn">
                                    <span>&gt;</span>
                                </button>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button class="next-btn">
                                <span>&gt;</span>
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <%-- gallery-index --%>
        <!-- 하단 영역 -->
        <div id="footer"></div>
    </div>
    
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function() {
            /* 체크박스 전체선택 */
            $("#all_check").change(function() {
                $(".userlist").prop('checked', $(this).prop('checked'));
            });
        });
    </script>
    <script>
    $(function () {
        $('#delete-user').on('click', function () {
            if ($('#aaaa:checked').val() == null) {
                alert("회원을 선택하세요.");
            } 
            $('#aaaa:checked').each(function () {
                var delete1 = $(this).val();
                
                $.ajax({
                    // 결과 url
                    url: "${pageContext.request.contextPath}/admin/userlist/delete_ok.do",
                    data: {
                        delete_id: delete1
                    },
                    type: "POST",
                    datatype: 'text',
                    success: function (data) {
                       location.reload();
                    },
                    error: function (error, status, request) {
                        alert("Error!" + error + "request: " + request + " status: " + status);
                    }
                });
            }); // checked
           if($('#aaaa:checked').val() != null) {
            alert("회원이 삭제되었습니다."); 
           }
        })
        
    }); // end $.ajax;
    </script>

    <script>
        $('#edit-user').on('click', function () { 
            if ($('#aaaa:checked').val() == null) {
                alert("회원을 선택하세요.");
            }
            $('#aaaa:checked').each(function () {
                var edit = $('#aaaa:checked').val(); 
                location.href="${pageContext.request.contextPath}/admin/userlist/edit.do?userno=" + edit;
        });

    });
    </script>
</body>
</html>