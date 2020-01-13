<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<style>
/*---------------------------------
|   header * css
----------------------------------*/
        /* 브라우저 최소 넓이 지정 */
        #header {
             min-width: 1366px;
        }
        /* 메뉴바 크기, 여백, 테두리 */
        #header .navbar {
            height: 70px;
            min-height: 70px;
            padding-right: 30px;
            border: 0;
            border-bottom: 1px solid #eee;
            margin: 0;
        }
        /* 로고 이미지 크기, 위치 설정 */
        #header > .navbar > a > img {
            height: 50px;
            margin: 8px 0 12px 30px;
        }
        /* 방주인사이트 여백 설정 */
        #header .menu-left {
            display: inline-block;
            margin-left: 20px;
        }
        /* 방주인사이트, 회원가입로그인 글씨 크기 및 색상 설정 */
        .small-font > a {
            display: inline-block;
            font-size: 14px;
            color: #777;
            /* font-weight: 700; */
        }
        .pull-right > div.pages > a {
            line-height: 70px;
            height: 70px;
            display: inline-block;
            font-size: 14px;
            color: #222;
        }
        /* 메뉴에 마우스오버 시 색 변경 설정 */
        #header a:hover {
            color: rgb(21, 100, 249);
        }
        /* 각 메뉴들 간 여백 설정 */
        .padding-l {
            margin-left: 40px;
        }
        /* 메뉴 우측 정렬 */
        #header .pull-right div {
            display: inline-block;
        }
        /******* 로그인 시 변경  ***/
        /* 로그인 프로필 이미지 크기 */
        .pull-right .small-font1 img {
            width: 35px;
            height: 35px;
        }
        /* 회원가입 , 로그인 창 전체*/
        .small-font1 {
            min-width: 70px;
            height: 70px;
            margin-left: 57px;
            cursor: pointer;
        }
        /* 이름 상자 */
        a.atag > button {
            height: 30px;
            cursor: pointer;
            background-color: white;
            border-width: 0;
            color: rgb(34, 34, 34);
            outline: none;
        }
        /* 드랍다운 상자 구분 선 */
        .small .divider {
            width: 100%;
            height: 1px;
            /* margin: 9px 0; */
            overflow: hidden;
            background-color: #e5e5e5;
        }
        /* 프로필 이미지 크기 */
        #header .navbar .small-font1.img {
            height: 25px;
            width: 25px;
        }
        /* 드랍다운 상자 */
        ul.small {
            width: 150px;
            box-shadow: rgba(0, 0, 0, 0.25) 0 15px 18px -10px;
            background-color: rgb(255, 255, 255);
            position: absolute;
            left: -30px !important;
            top: 39px;
            z-index: 11;
            border: 1px solid rgb(212, 212, 212) !important;
            border-radius: 4px;
        }
        
        .dropdown-menu > li {
        	padding : 1px;
        }
        
        .small > li > .atag1 {
            width: 100%;
            height: 50px;
            line-height: 50px;
            color: rgb(102, 102, 102);
            font-size: 14px;
            cursor: pointer;
            /* padding: 0px 20px; */
            text-align: left;
        }

        #loginprofile {
        	height: 30px;
		    width: 30px;
    		border-radius: 50%;
        }
        
        #header .menu-left > span{    	
		    font-size: 14px;
		    font-weight: 200;
		    color: #777777;
        }

    </style>
</head>
<!---------------------------------
|   header * body
---------------------------------->
<!-- 상단 헤더 -->
<div id="header">
    <div class="navbar" role="navigation">
        <a href="${pageContext.request.contextPath}">
            <img src="${pageContext.request.contextPath}/assets/ico/logo_blue.png"></a>
<c:choose>
<c:when test="${loginInfo.email != 'admin'}">
<div class="menu-left small-font">
<a href="${pageContext.request.contextPath}/host/main.do">방주인 사이트</a>
</div>
</c:when>
<c:otherwise>
<div class="menu-left small-font">
    <a href="${pageContext.request.contextPath}/host/main.do">방주인 사이트</a>
         <span>&nbsp | &nbsp</span>
    <a href="${pageContext.request.contextPath}/admin/main.do">관리자 사이트</a>
</div>
</c:otherwise>
</c:choose>
            <!-- 메뉴 항목 -->
            <div class="pull-right">
                <div class="pages">
                    <a href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸,투룸,쓰리룸,오피스텔&dealingtype=월세,전세,매매&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9&news=0,0,0,0">방찾기</a>
                    <a href="${pageContext.request.contextPath}/main/rtrm.do" class="padding-l">관심목록</a>
                    <a href="${pageContext.request.contextPath}/main/faq.do" class="padding-l">문의하기</a>
                    <a href="${pageContext.request.contextPath}/main/pprm.do" class="padding-l">인기매물</a>
                </div>
                <%-- 로그인 시 바뀌는 로그인창 --%>
                <c:choose>
                    <c:when test="${loginInfo == null}">
                        <div class="small-font">
                            <a href="${pageContext.request.contextPath}/modal/login.do" class="padding-l" data-toggle="modal" data-target="#loginModal">회원가입·로그인</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown small-font1">
                        <!-- ********************************************************************************************** -->
                            <c:choose>
                                <c:when test="${loginInfo.profile_img == null}">
                                    <img src="${pageContext.request.contextPath}/assets/img/ma_img/basic.svg"/>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/upload/download.do" var="thumbnail_url">
                                        <c:param name="file" value="${loginInfo.profile_img}" />
                                    </c:url>
                                    <img src="${thumbnail_url}" id="loginprofile"/>
                                </c:otherwise>
                            </c:choose>
                         <!-- ********************************************************************************************** -->
                            <a id="dLabel" data-target="#" data-toggle="dropdown" aria-haspopup="true" role="button" class="atag" aria-expanded="false" data-target="#loginModal">
                                <button>
                                    <span>${loginInfo.name} 님<span class="caret"></span></span>
                                </button>
                            </a>
                            <ul class="dropdown-menu small" role="menu" aria-labelledby="dLabel">
                                <li>
                                    <a href="${pageContext.request.contextPath}/main/mypage.do" class="atag1">
                                        <span>마이페이지</span>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/modal/login_out.do" class="atag1">로그아웃</a>
                                </li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- 로그인용 모달 로더 -->
    <div class="modal fade" id="loginModal" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content"></div>
        </div>
    </div>
    <!-- 비밀번호 찾기용 모달 로더 -->
    <div class="modal fade" id="passwdModal" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content"></div>
        </div>
    </div>
    <!-- 동의하기용 모달 로더 -->
    <div class="modal fade" id="agreeModal" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content"></div>
        </div>
    </div>
    <!-- 회원가입용 모달 로더 -->
    <div class="modal fade" id="joinModal" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content"></div>
        </div>
    </div>
