<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <style>
		/*------------------
		|	header * css
		-------------------*/
        /* 브라우저 최소 넓이 지정 */
        #header {
            min-width: 1366px;
        }
        /* 메뉴바 크기, 여백, 테두리 */
        #header .navbar {
            height: 70px;
            min-height: 70px;
            padding: 0 50px 0 30px;
            border: 0;
            border-bottom: 1px solid #eee;
            margin: 0;
            background-color: rgb(81, 136, 244);
        }
        /* 로고 이미지 크기, 위치 설정 */
        #header > .navbar > a > img {
            height: 50px;
            margin: 8px 0 12px 50px;
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
            color: white;
            font-weight: 700;
        }
        .pull-right > div > a {
            line-height: 70px;
            height: 70px;
            display: inline-block;
            font-size: 14px;
            color: white;
            font-weight: 700;
        }
        /* 메뉴에 마우스오버 시 색 변경 설정 */
        /* #header a:hover {
            color: rgb(21, 100, 249);
        } */
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
            border-radius: 50%;
        }
        /* 회원가입 , 로그인 창 전체*/
        .small-font1 {
            min-width: 70px;
            height: 70px;
            margin-left: 40px;
            cursor: pointer;
        }
        /* 이름 상자 */
        a.atag > button {
            height: 30px;
            cursor: pointer;
            background-color: rgb(81, 136, 244);
            border-width: 0;
            color: white;
            outline: none;
            font-weight: 700;
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
            /* right: 50px; */
            top: 55px;
            z-index: 11;
            border: 1px solid rgb(212, 212, 212);
            border-radius: 4px;
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
        .navbar > .pull-right {
            width: 450px;
        }
        /*#header a:hover {
            color: #666666;
        }*/
        
    </style>
</head>
<!---------------------------------
|	header * body
---------------------------------->
<!-- 상단 헤더 -->
<div id="header">
    <div class="navbar" role="navigation">
        <a href="${pageContext.request.contextPath}/host/main.do">
            <img src="${pageContext.request.contextPath}/assets/ico/logo_white.png"></a>
            <div class="menu-left small-font">
                <a href="${pageContext.request.contextPath}">메인 사이트</a>
            </div>
            <!-- 메뉴 항목 -->
            <div class="pull-right">
                <div>
                    <a href="${pageContext.request.contextPath}/host/rm_add.do" class="padding-l">공실 등록하기</a>
                    <a href="${pageContext.request.contextPath}/host/rmli.do" class="padding-l">공실관리</a>
                </div>
                <%-- 로그인 시 바뀌는 로그인창 --%>
                <c:choose>
                    <c:when test="${loginInfo == null}">
                        <div class="small-font">
                            <a href="${pageContext.request.contextPath}/modal/login.do" class="padding-l" data-toggle="modal" data-target="#loginModal">로그인</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown small-font1">
                            <c:choose>
                                <c:when test="${loginInfo.profile_img == null}">
                                    <img src="${pageContext.request.contextPath}/assets/img/ma_img/basic.svg"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/upload/download.do?file=${loginInfo.profile_img}" id="loginprofile"/>
                                </c:otherwise>
                            </c:choose>
                            <a id="dLabel" data-target="#" data-toggle="dropdown" aria-haspopup="true" role="button" class="atag" aria-expanded="false" data-target="#loginModal">
                                <button>
                                    <span>${loginInfo.name} 님<span class="caret"></span>
                                    </span>
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

