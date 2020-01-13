<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../assets/inc/meta.jsp"%>

<!-- css 참조 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/etc/reset.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ma_css/rtrm.css">
</head>

<body>
    <!-- 상단 헤더 -->
    <%@ include file="../assets/inc/ma_top.jsp"%>
    <!-- 중앙 영역 -->
    <!-- 페이지의 전체 폭을 결정하기 위한 영역 -->
    <div class="root">
        <div id="content">
            <!-- 최근본방/찜한 방 -->
            <div id="recent" class="recent">
                <h1 class="interest">관심목록</h1>
                <div class="tab-menu">
                    <a class="st-bang active" href="#">최근 본 방</a>
                    <c:choose>
                        <%-- 컨트롤러에서 식별한 세션 없을 때 --%>
                        <c:when test="${loginInfo == null }">
                            <a href="${pageContext.request.contextPath}/modal/login.do" class="st-bang padding-l" data-toggle="modal" data-target="#loginModal">찜한 방</a>
                        </c:when>
                        <%-- 컨트롤러에서 식별한 세션 있을 때 --%>
                        <c:otherwise>
                            <a class="st-bang" href="${pageContext.request.contextPath}/main/wish.do">찜한 방</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="tab-text">
                    <div class="re-div1">
                        <p>
                            총 <span class="room-count">0000</span><span>개</span>의 최근 본 방이 있습니다
                        </p>
                    </div>
                    <div class="re-div2">
                        <p>최근 본 방은 최대 50개까지 저장됩니다</p>
                    </div>
                </div>
                <div class="gallery-container">
                    <!-- 갤러리 내용 영역 -->
                    <div class="gallery-content clearfix">
                        <ul id="gallery-list">
                            <c:choose>
                                <%-- 조회 결과가 없는 경우 --%>
                                <c:when test="${output == null || fn:length(output) == 0}">
                                    <div class="noresultbox">
                                        <p class="noresulticon">
                                            <i class="glyphicon glyphicon-home noresulticon"></i>
                                        </p>
                                        <p class="noresult">최근 본 방이 없습니다.</p>
                                        <p class="noresult">별방에서 살고 싶은 방을 찾아보세요.</p>
                                    </div>
                                </c:when>
                                <%-- 갤러리 시작 --%>
                                <c:otherwise>
                                    <c:forEach var="item" items="${output}" varStatus="status">
                                        <li>
                                            <div class="recent-div5">
                                                <div class="recent-div6">
                                                    <input type="hidden" value="${item.roomno}">
                                                    <c:choose>
                                                        <%-- 컨트롤러에서 식별한 세션 없을 때 --%>
                                                        <c:when test="${loginInfo == null }">
                                                            <%-- 좋아요 버튼 클릭 시 로그인 모달 띄우기 --%>
                                                            <a href="${pageContext.request.contextPath}/modal/login.do" class="st-bang padding-l" data-toggle="modal" data-target="#loginModal"> <%-- 좋아요 버튼 --%>
                                                                <div class="recent-div7">
                                                                    <div class="recent-div8 offff"></div>
                                                                </div> <%-- 좋아요 끝 --%>
                                                            </a>
                                                        </c:when>
                                                        <%-- 컨트롤러에서 식별한 세션 있을 때 --%>
                                                        <c:otherwise>
                                                            <c:set var="count" value="0" />
                                                            <c:forEach var="h" items="${heart}" varStatus="status">
                                                                <c:if test="${h.roomno==item.roomno}">
                                                                    <c:set var="count" value="${count + 1}" />
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${count == 0}">
                                                                    <div class="recent-div7">
                                                                        <div class="recent-div8 off" data-value="on"></div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="recent-div7">
                                                                        <div class="recent-div8 on" data-value="off"></div>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>


                                                    <%-- 전체 링크화 --%>
                                                    <a target="_blank" rel="" class="recent-a" href="${pageContext.request.contextPath}/main/rmdt.do?roomno=${item.roomno}"> <!-- 이미지 -->
                                                        <div class="recent-a-div">
                                                            <c:url value="/upload/download.do" var="thumbnail_url">
                                                                <c:param name="file" value="${item.filename}" />
                                                            </c:url>
                                                            <img src="${thumbnail_url}" />
                                                        </div> <c:if test="${item.confirmdate != null}">
                                                            <%-- 확인매물 div --%>
                                                            <div class="recent-a-confirm">
                                                                <div class="recent-a-confirm-div">
                                                                    <span class="bold">확인매물</span> <span>${item.confirmdate}</span>
                                                                </div>
                                                            </div>
                                                            <%-- 확인매물 끝 --%>
                                                        </c:if>
                                                        <p class="recent-a-p1">${item.roomtype}</p>
                                                        <p class="recent-a-p2">
                                                            <c:choose>
                                                                <c:when test="${item.dealingtype == '월세'}">
                                                                    <span>${item.dealingtype}&nbsp;<!-- -->
                                                                        <fmt:formatNumber value="${item.deposit}" pattern="#,####" var="eok1"></fmt:formatNumber> <c:set var="patternprice1"
                                                                            value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" /> <!--
                                                        	 -->${patternprice1}/${item.price}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${item.dealingtype}&nbsp;<!-- -->
                                                                        <fmt:formatNumber value="${item.price}" pattern="#,####" var="eok2"></fmt:formatNumber> <c:set var="patternprice2"
                                                                            value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" /> <!--
                                                        	 -->${patternprice2}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="recent-a-p34">${item.floor}층, ${item.area}m², 
                                                        <c:choose>
			                                            	<c:when test="${item.fee == 0}">관리비 없음</c:when>
			                                                <c:otherwise>관리비 ${item.fee}만</c:otherwise>
                                            			</c:choose>
                                                        </p>
                                                        <p class="recent-a-p34">${item.title}</p>
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                                <%-- 각 갤러리 끝 --%>
                            </c:choose>
                        </ul>
                    </div>
                    <!-- 갤러리 내용 영역 -->
                </div>
                <!-- 최근본방/찜한 방 끝-->
            </div>
            <!-- content 끝 -->
        </div>
    </div>
    <!-- root 끝 -->


    <!-- 하단 영역 -->
    <%@ include file="../assets/inc/ma_bottom.jsp"%>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

    <script type="text/javascript">
                    function delectstar(x) {
                        $.ajax({
                            url : "delectstar.do",
                            method : "get",
                            data : {
                                "x" : x
                            },
                            success : function(req) {
                                console.log(x + "delectstar");
                            },
                            error : function() {
                                console.log("delectstar발송에러 발생");
                            }
                        });
                    }

                    function insertstar(x) {
                        $.ajax({
                            url : "insertstar.do",
                            method : "get",
                            data : {
                                "x" : x
                            },
                            success : function(req) {
                                console.log(x + "insertstar");
                            },
                            error : function() {
                                console.log("insertstar발송에러 발생");
                            }
                        });
                    }
                </script>

    <%-- ---------------하얀색 헤더의 좋아요 시작------------------- --%>
    <script type="text/javascript">
                    /* 로그인 세션 있을 때 좋아요 클릭 -> 하트 색 변경 */
                    $(function() {
                        $(".recent-div8").click(function(e) {
                            var loginInfouser = "${loginInfo.userno}";
                            if (loginInfouser != "") {
                                $(this).toggleClass('on off');
                                var onoff = $(this).hasClass("on");
                                console.log(onoff);
                                var a = $(this).parent().prev().val();
                                console.log(a);
                                if (onoff == true) {
                                    insertstar(a);
                                } else {
                                    delectstar(a);
                                }
                            }
                        })
                        /* if (${loginInfo != null}) {
                        	$(".recent-div8").click(function(e) {
                        		$(this).toggleClass('off on');
                        })};// end if */
                    });
                </script>
    <%-- ---------------하얀색 헤더의 좋아요 끝------------------- --%>

    <script type="text/javascript">
                    /* 조건에 맞는 방 개수 */
                    $(function() {
                        var n = $(".recent-div5").length;
                        $(".room-count").html(n);
                    });
                </script>
</body>
</html>
