<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../assets/inc/meta.jsp"%>
    <!-- css 참조 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ma_css/search.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugin/ion.rangeSlider.css">

</head>

<body>
    <!-- 브라우저에 보여질 부분 -->
    <!-- 페이지의 전체 폭을 결정하기 위한 영역 -->
    <div>
        <!-- 상단 헤더 -->
        <%@ include file="../assets/inc/ma_top.jsp"%>
        <!-- 중앙 영역 -->
        <div id="content">
            <div id="search" class="clearfix">
                <div class="searchtab">
                    <form id="search-form" method="get" action="${pageContext.request.contextPath}/main/search.do">
                        <input type="search" placeholder="검색바" name="search" id="keyword"
                            value="${keyword}" /> <i class="glyphicon glyphicon-search"></i>
                        <button type="submit">검색</button>
                    </form>
                </div>
                <!-- 전체 필터 -->
                <div class="filters clearfix">
                    <!-- 개별 필터 -->
                    <div class="btn-group filter">
                        <button type="button" class="btn dropdown-toggle btn-rt" data-toggle="dropdown">
                            원룸,투·쓰리룸,오피스텔<span class="caret"></span>
                        </button>
                        <div class="dropdown-menu width1" role="menu">
                            <form id="room-type">
                                <h1>방종류</h1>
                                <p>중복 선택이 가능합니다.</p>
                                <ul>
                                    <li><label class="room-typech">
                                        <input type="checkbox" name="room-type" value="oneroom" id="roomtype1" />
                                        <span class="checkBox"></span>
                                        <span class="checkText">원룸</span>
                                    </label></li>
                                    <li><label class="room-typech">
                                        <input type="checkbox" name="room-type" value="tworoom" id="roomtype2" />
                                        <span class="checkBox"></span>
                                        <span class="checkText">투·쓰리룸</span>
                                    </label></li>
                                    <li><label class="room-typech">
                                        <input type="checkbox" name="room-type" value="officetel" id="roomtype3" />
                                        <span class="checkBox"></span>
                                        <span class="checkText">오피스텔</span>
                                    </label></li>
                                </ul>
                            </form>
                        </div>
                    </div>
                    <!-- 개별 필터 끝 -->
                    <!-- 개별 필터 -->
                    <div class="btn-group filter">
                        <button type="button" class="btn dropdown-toggle btn-st" data-toggle="dropdown">
                            월세,전세,매매 <span class="caret"></span>
                        </button>
                        <div class="dropdown-menu width1" role="menu">
                            <h1>매물종류</h1>
                            <p>중복 선택이 가능합니다.</p>
                            <ul>
                                <li><label class="dealing-typech">
                                    <input type="checkbox" name="sale-type" value="monthly" id="dealingtype1" />
                                    <span class="checkBox"></span>
                                    <span class="checkText">월세</span>
                                </label></li>
                                <li><label class="dealing-typech">
                                    <input type="checkbox" name="sale-type" value="charter" id="dealingtype2" />
                                    <span class="checkBox"></span>
                                    <span class="checkText">전세</span>
                                </label></li>
                                <li><label class="dealing-typech">
                                    <input type="checkbox" name="sale-type" value="buying" id="dealingtype3" />
                                    <span class="checkBox"></span>
                                    <span class="checkText">매매</span>
                                </label></li>
                            </ul>
                        </div>
                    </div>
                    <!-- 개별 필터 끝 -->
                    <!-- 개별 필터 -->
                    <div class="btn-group filter">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
                            가격대 <span class="caret"></span>
                        </button>
                        <div class="dropdown-menu width2" role="menu">
                            <div class="filter-slide">
                                <h1>보증금/전세가
                                    <p class="inf" id="filter1-value">무제한</p>
                                </h1>
                                <input type="text" id="slide-price1" name="">
                                <ul>
                                    <li>0</li>
                                    <li>1억 2000만원</li>
                                    <li>무제한</li>
                                </ul>
                            </div>
                            <div class="filter-slide mar-top">
                                <h1>월세
                                    <p class="inf" id="filter2-value">무제한</p>
                                </h1>
                                <input type="text" id="slide-price2" name="">
                                <ul>
                                    <li>0</li>
                                    <li>60만원</li>
                                    <li>무제한</li>
                                </ul>
                            </div>
                            <div class="filter-slide mar-top">
                                <h1>매매가
                                    <p class="inf" id="filter3-value">무제한</p>
                                </h1>
                                <input type="text" id="slide-price3" name="">
                                <ul>
                                    <li>0</li>
                                    <li>5억원</li>
                                    <li>무제한</li>
                                </ul>
                            </div>
                            <button type="button" id="filter-reset1" class="filter-reset">
                                <i class="glyphicon glyphicon-refresh"></i>조건삭제
                            </button>
                        </div>
                    </div>
                    <!-- 개별 필터 끝 -->
                    <!-- 개별 필터 -->
                    <div class="btn-group filter">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
                            관리비 <span class="caret"></span>
                        </button>
                        <div class="dropdown-menu width2" role="menu">
                            <div class="filter-slide">
                                <h1>관리비
                                    <p class="inf" id="filter4-value">무제한</p>
                                </h1>
                                <input type="text" id="slide-price4" name="">
                                <ul>
                                    <li>0</li>
                                    <li>20만원</li>
                                    <li>무제한</li>
                                </ul>
                            </div>
                            <button type="button" id="filter-reset2" class="filter-reset">
                                <i class="glyphicon glyphicon-refresh"></i>조건삭제
                            </button>
                        </div>
                    </div>
                    <!-- 개별 필터 끝 -->
                    <!-- 개별 필터 -->
                    <div class="btn-group filter">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
                             방크기 <span class="caret"></span>
                        </button>
                        <div class="dropdown-menu pull-right width2" role="menu">
                            <div class="filter-slide">
                                <h1>방크기
                                    <p class="inf" id="filter5-value">무제한</p>
                                </h1>
                                <input type="text" id="slide-size" name="">
                                <ul>
                                    <li>0㎡(0평)</li>
                                    <li>33㎡(10평)</li>
                                    <li>무제한</li>
                                </ul>
                            </div>
                            <button type="button" id="filter-reset3" class="filter-reset">
                                <i class="glyphicon glyphicon-refresh"></i>조건삭제
                            </button>
                        </div>
                    </div>
                    <!-- 개별 필터 끝 -->
                </div>
                <!-- 전체 필터 끝 -->
                <!-- 초기화 버튼 -->
                <div id="filters-reset" class="filters-reset">
                    <i class="glyphicon glyphicon-refresh"></i>초기화
                </div>
            </div>
            <div id="contentbox" class="clearfix">
                <div class="gallery">
                    <!-- 갤러리 상단 영역 -->
                    <div class="gallery-header">
                        <span>조건에 맞는 방 </span> <span class="room-count" id="room-count">${totalCount}</span><span>개</span>
                    </div>
                    <!-- 갤러리 상단 영역 끝 -->
                    <!-- 갤러리 내용 + 하단 영역 -->
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
                                            <p class="noresult">조건에 맞는 방이 없습니다.</p>
                                            <p class="noresult">맞춤필터를 해제해보세요.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                    <%-- 갤러리 시작 --%>
                                        <c:forEach var="item" items="${output}" varStatus="status">
                                            <li>
                                                <div class="recent-div5">
                                                    <div class="recent-div6">
                                                        <%-- 좋아요 버튼 --%>
                                                        <input type="hidden" value="${item.roomno}">
                                                        <c:choose>
                                                            <%-- 세션 없을 때 --%>
                                                            <c:when test="${loginInfo == null}">
                                                            <a href="${pageContext.request.contextPath}/modal/login.do"
                                                                data-toggle="modal" data-target="#loginModal">
                                                            <div class="recent-div7">
                                                               <div class="recent-div8 off"></div>
                                                            </div>
                                                            </a>
                                                            </c:when>
                                                            <%-- 세션 있을 때 --%>
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
                                                        <%-- 좋아요 끝 --%>
                                                        <%-- 전체 링크화 --%>
                                                        <%-- -------------------쿠키 굽기---------------------- --%>

                                                        <%-- 파라미터 GET으로 보내기 작업 --%>
                                                        <a target="_blank" rel="" class="recent-a"
                                                            href="${pageContext.request.contextPath}/main/rmdt.do?roomno=${item.roomno}">

                                                            <%-- -------------------쿠키 굽기---------------------- --%>
                                                            <!-- 이미지 -->
                                                            <div class="recent-a-div">
                                                                <c:url value="/upload/download.do" var="thumbnail_url">
                                                                    <c:param name="file" value="${item.thumbnail}" />
                                                                </c:url>
                                                                <img src="${thumbnail_url}" />
                                                            </div>
                                                            <c:if test="${item.confirmdate != null}">
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
                                                                    <%-- 월세인 경우 --%>
                                                                    <c:when test="${item.dealingtype == '월세'}">
                                                                        <span>${item.dealingtype}&nbsp;<!--
                                                        --><fmt:formatNumber value="${item.deposit}" pattern="#,####" var="eok1"></fmt:formatNumber>
                                                        <c:set var="patternprice1" value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" /> <!--
                                                        -->${patternprice1}/${item.price}</span>
                                                                    </c:when>
                                                                    <%-- 전세 혹은 매매인 경우 --%>
                                                                    <c:otherwise>
                                                                        <span>${item.dealingtype}&nbsp;<!--
                                                        --><fmt:formatNumber value="${item.price}" pattern="#,####" var="eok2"></fmt:formatNumber>
                                                        <c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" /> <!--
                                                        -->${patternprice2}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <p class="recent-a-p34">
                                                            	${item.floor}층,
                                                                ${item.area}m², 
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
                                        <%-- 각 갤러리 끝 --%>
                                    </c:otherwise>
                                </c:choose>
                                    </ul>
                        </div>
                        <!-- 갤러리 내용 영역 -->
                        <!-- 갤러리 하단 영역 -->
                        <c:if test="${output != null && fn:length(output) != 0}">
                            <div class="gallery-footer">
                                <%-- gallery-index --%>
                                <div class="gallery-index">
                                    <!-- 페이지 번호 구현 -->
                                    <%-- 이전 그룹에 대한 링크 --%>
                                    <button class="prev-btn" id="temp">
                                        <span>&lt;</span>
                                    </button>

                                    <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
                                    <ul class="index-list" id="index-list">
                                        <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">

                                            <%-- 페이지 번호 출력 --%>
                                            <c:choose>
                                                <%-- 현재 머물고 있는 페이지 번호를 출력 --%>
                                                <c:when test="${pageData.nowPage == i}">
                                                    <li><a class="index-indiv index-active">${i}</a></li>
                                                </c:when>
                                                <%-- 나머지 페이지 --%>
                                                <c:otherwise>
                                                    <li><a class="index-indiv">${i}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </ul>

                                    <%-- 다음 그룹에 대한 링크 --%>
                                    <button class="next-btn">
                                        <span>&gt;</span>
                                    </button>
                                </div>
                                <%-- gallery-index --%>
                            </div>
                        </c:if>
                        <!-- 갤러리 하단 영역 끝 -->
                    </div>
                    <!-- 갤러리 내용 + 하단 영역 끝 -->
                </div>
                <!-- 지도 -->
                <div class="map-container">
                    <div id="map"></div>
                    <div class="zoom">
                        <button class="zoom-in">+</button>
                        <button class="zoom-out">-</button>
                    </div>
                </div>
                <!-- 지도 끝 -->
            </div>
        </div>
        <!-- 하단 영역 -->
        <div id="footer"></div>
    </div>
    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49ad4eb7ef14b56eb0eca723e4dd1eaa&libraries=clusterer,services"></script>
    <script src="${pageContext.request.contextPath}/assets/plugin/ion.rangeSlider.js"></script>

    <script type="text/javascript">
        function delectstar(x) {
            $.ajax({
                url: "delectstar.do",
                method: "get",
                data: {"x" : x},
                success: function(req){
                    console.log(x + "delectstar");
                },
                error : function() {
                    console.log("delectstar발송에러 발생");
                }
            });
        }

        function insertstar(x) {
            $.ajax({
                url: "insertstar.do",
                method: "get",
                data: {"x" : x},
                success: function(req){
                    console.log( x + "insertstar");
                },
                error : function() {
                    console.log("insertstar발송에러 발생");
                }
            });
        }
    </script>

    <script type="text/javascript">
        /* 브라우저 크기에 따라 갤러리와 지도영역 높이 변경 */
        function contentSize() {
            var wHeight = $(window).height();
            var gHeight = wHeight - 206;
            var mHeight = wHeight - 136;
            $(".gallery-container").css("height", gHeight);
            $(".map-container").css("height", mHeight);

            // 조회 결과가 없는 경우를 위한 크기 조정
            $(".noresultbox").css("height", gHeight-60);
        }
        $(function() {
            contentSize();
            $(window).resize(function(e) {
                contentSize();
            });

            /** 좋아요 */
            $(".recent-div8").click(function(e) {
                var loginInfouser = "${loginInfo.userno}";
                if(loginInfouser != "") {
                    $(this).toggleClass('on off');
                    var onoff = $(this).hasClass("on");
                    console.log(onoff);
                    var a = $(this).parent().prev().val();
                    console.log(a);
                    if(onoff == true) {
                        insertstar(a);
                    }else {
                        delectstar(a);
                    }
                }
            });
        });
    </script>

    <!-- Ajax로 읽어온 내용을 출력하는데 사용될 템플릿 -->
    <script src="${pageContext.request.contextPath}/assets/plugin/ajax/ajax_helper.js"></script>
   <script src="${pageContext.request.contextPath}/assets/plugin/handlebars-v4.0.11.js"></script>
   <script id="gallery-data" type="text/x-handlebars-template">
    {{#each output}}
    <li>
        <div class="recent-div5">
        <div class="recent-div6">
            {{!-- 좋아요 버튼 --}}
            <input type="hidden" value="{{roomno}}" class="room_num">
            {{#session roomno}}
            {{else}}
            {{/session}}
            {{!-- 좋아요 끝 --}}
            {{!-- 전체 링크화 --}}
            <a target="_blank" rel="" class="recent-a" href="${pageContext.request.contextPath}/main/rmdt.do?roomno={{roomno}}">
            {{!-- 이미지 --}}
            <div class="recent-a-div">
                <img src="${pageContext.request.contextPath}/upload/download.do?file={{thumbnail}}" />
            </div>
            {{!-- 확인매물 div --}}
            {{#if confirmdate}}
            <div class="recent-a-confirm">
                <div class="recent-a-confirm-div">
                <span class="bold">확인매물</span> <span class="confirm-date">{{confirmdate}}</span>
                </div>
            </div>
            {{/if}}
            {{!-- 확인매물 끝 --}}
            <p class="recent-a-p1">{{roomtype}}</p>
            <p class="recent-a-p2">
                {{#isMonth dealingtype}}
                <span>{{dealingtype}} {{isOver2 deposit}}/{{isOver price}}</span>
                {{else}}
                <span>{{dealingtype}} {{isOver price}}</span>
                {{/isMonth}}
            </p>
            <p class="recent-a-p34">{{floor}}층, {{area}}m², 관리비 {{fee fee}}</p>
            <p class="recent-a-p34">{{title}}</p>
            </a>
        </div>
        </div>
    </li>
    {{/each}}
   </script>

    <!-- 지도 api -->
    <script type="text/javascript">
    var mapDefaultInfo = {
        lat: 37.5880618964351,
        lng: 126.987409633377,
        level: 5
    };

    /** ajax전송을 위한 파라미터 가져오기 **/
    var roomtype = "${param.roomtype}";
    var dealingtype = "${param.dealingtype}";
    var deposit_from = ${param.depositFrom};
    var deposit_to = ${param.depositTo};
    var month_from = ${param.monthFrom};
    var month_to= ${param.monthTo};
    var buying_from = ${param.buyingFrom};
    var buying_to = ${param.buyingTo};
    var fee_from = ${param.feeFrom};
    var fee_to = ${param.feeTo};
    var size_from = ${param.sizeFrom};
    var size_to = ${param.sizeTo};
    
    var centerLat = ${filter.centerLat};
    var centerLng = ${filter.centerLng};
    var level =${filter.level};

    var west = ${filter.west};
    var east = ${filter.east};
    var south = ${filter.south};
    var north = ${filter.north};

    var startPage;
    var endPage;
    var groupCount;
    var totalPage;
    var nowPage;
    var nextPage;
    var prevPage;

    var session = "${loginInfo}";
    var heart = "${heart}";

    var null_div;

    /** ajax 전송 메서드 **/
    function getMapPosition(west,east,south,north,page) {
        var params = {
        		"roomtype": roomtype,
                "dealingtype": dealingtype,
                "depositFrom": deposit_from,
                "depositTo": deposit_to,
                "monthFrom": month_from,
                "monthTo": month_to,
                "buyingFrom": buying_from,
                "buyingTo": buying_to,
                "feeFrom": fee_from,
                "feeTo": fee_to,
                "sizeFrom": size_from,
                "sizeTo": size_to,
                "east": east,
                "west": west,
                "north": north,
                "south": south,
                "page": page
            };

        console.log(params);

        $.ajax({
            url: "${pageContext.request.contextPath}/main/search",
            method: "get",
            data: params,
            success: function(req){
                if (req.output.length == 0) {
                    null_div = '<div class="noresultbox">';
                    null_div += '<p class="noresulticon">';
                    null_div += '<i class="glyphicon glyphicon-home noresulticon"></i>';
                    null_div += '</p>';
                    null_div += '<p class="noresult">조건에 맞는 방이 없습니다.</p>';
                    null_div += '<p class="noresult">맞춤필터를 해제해보세요.</p>';
                    null_div += '</div>';

                    $("#gallery-list").html(null_div);
                } else {
                    /** 월세인지 전세/매매인지 구분 **/
                    Handlebars.registerHelper('isMonth', function(dealingtype, options) {
                      if (dealingtype == '월세') { return options.fn(this); }
                      else { return options.inverse(this); }
                    });
                    /** 억 단위 표현하기 price **/
                    Handlebars.registerHelper('isOver', function(price, options) {
                        if (price >= 10000 && price%10000 != 0) {
                            return Math.floor(price/10000) +"억" + price%10000;
                        } else if (price >= 10000 && price%10000 == 0) {
                            return price/10000 + "억";
                        } else { return price; }
                    });
                    /** 억 단위 표현하기 deposit **/
                    Handlebars.registerHelper('isOver2', function(deposit, options) {
                        if (deposit >= 10000 && deposit%10000 != 0) {
                            return Math.floor(deposit/10000) +"억" + deposit%10000;
                        } else if (deposit >= 10000 && deposit%10000 == 0) {
                            return deposit/10000 + "억";
                        } else { return deposit; }
                    });
                    /** 관리비 유료/무료 fee **/
                    Handlebars.registerHelper('fee', function(fee, options) {
                        if (fee == 0) {
                            return "없음";
                        } else { 
                        	return fee+"만"; }
                    });
    
                    /** 세션 식별하기 **/
                    Handlebars.registerHelper('session', function(roomno, options) {
                        if (session == null || session == "") {
                            var heart_div  = '<a href="${pageContext.request.contextPath}/modal/login.do" data-toggle="modal" data-target="#loginModal">'
                                heart_div += '<div class="recent-div7">'
                                heart_div += '<div class="recent-div8 offff"></div>'
                                heart_div += '</div>'
                                heart_div += '</a>'
                            return heart_div;
                        }
                        else {
                            for (var i=0; i<req.heart.length; i++) {
                                if (req.heart[i].roomno == roomno) {
                                    var heart_div = '<div class="recent-div7">'
                                        heart_div += '<div class="recent-div8 on" data-value="off"></div>'
                                        heart_div += '</div>'
                                    return heart_div;
                                }
                            }
                            for (var i=0; i<req.heart.length; i++) {
                                if (req.heart[i].roomno != roomno) {
                                    var heart_div = '<div class="recent-div7">'
                                        heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                                        heart_div += '</div>'
                                    return heart_div;
                                }
                            }
                            if (req.heart.length == 0) {
                                var heart_div = '<div class="recent-div7">'
                                    heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                                    heart_div += '</div>'
                                return heart_div;
                            }
                        }
                    });
    
                    var template = Handlebars.compile($("#gallery-data").html());
                    var html = template(req);
                    $("#gallery-list").html(html);
                }
                
                $("#room-count").html(req.totalCount);
                /** 페이징을 위한 정보 가져오기 **/
                startPage = req.pageData.startPage;
                endPage = req.pageData.endPage;
                groupCount = req.pageData.groupCount;
                totalPage = req.pageData.totalPage;
                nowPage = req.pageData.nowPage;
                nextPage = req.pageData.nextPage;
                prevPage = req.pageData.prevPage;
                /** 페이지 번호 출력 **/
                var index_list = new Array();
                for (var i=startPage; i<=endPage; i++) {
                    var indexno = i;
                    if (nowPage == indexno) {
                        index_list[i] = '<li><a class="index-indiv index-active">'+indexno+'</a></li> ';
                    } else {
                        index_list[i] = '<li><a class="index-indiv">'+indexno+'</a></li> ';
                    }
                }
                $("#index-list").html(index_list);
                /** 좋아요 하트 토글 **/
                $(".recent-div8").click(function(e) {
                    var loginInfouser = "${loginInfo.userno}";
                    if(loginInfouser != "") {
                        $(this).toggleClass('on off');
                        var onoff = $(this).hasClass("on");
                        console.log(onoff);
                        var a = $(this).parent().prev().val();
                        console.log("a = " + a);
                        if(onoff == true) {
                            insertstar(a);
                        }else {
                            delectstar(a);
                        }
                    }
                });
            }
        });
    }

        /* kakao map API */
        $(function() {
            /** 지도 생성하기 */
            var container = document.getElementById('map');
            var options = {
                center : new kakao.maps.LatLng(centerLat, centerLng), // 지도의 중심 좌표
                level : level,
                maxLevel : 9    // 지도 확대 레벨
            };
            console.log("centerLat=%s, centerLng=%s", centerLat, centerLng);
            var map = new kakao.maps.Map(container, options);


            /** 마커 클러스터러 생성하기 **/
            var clusterer = new kakao.maps.MarkerClusterer({
                map : map,                  // 마커들을 클러스터로 관리하고 표시할 지도 객체
                averageCenter : false,      // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
                minLevel : 1,               // 클러스터 할 최소 지도 레벨
                disableClickZoom : true,    // 클릭 시 확대기능 해제
                styles : [ {                // calculator에 적용될 스타일
                    minWidth : '40px',
                    height : '40px',
                    padding : '5px 11px',
                    background : 'rgb(20, 118, 252)',
                    borderRadius : '40px',
                    border : '3px solid rgb(20, 118, 252)',
                    color : '#fff',
                    fontSize : '13px',
                    textAlign : 'center',
                    fontWeight : 'bold',
                    lineHeight : '24px'
                } ]
            });


            /** 매물 데이터 가져오기 **/
            var params = {
                    roomtype: "${param.roomtype}",
                    dealingtype: "${param.dealingtype}",
                    depositFrom: "${param.depositFrom}",
                    depositTo: "${param.depositTo}",
                    monthFrom: "${param.monthFrom}",
                    monthTo: "${param.monthTo}",
                    buyingFrom: "${param.buyingFrom}",
                    buyingTo: "${param.buyingTo}",
                    feeFrom: "${param.feeFrom}",
                    feeTo: "${param.feeTo}",
                    sizeFrom: "${param.sizeFrom}",
                    sizeTo: "${param.sizeTo}",
                    east: 0,
                    west: 0,
                    north: 0,
                    south: 0,
                    pagelist: 1
                };

            console.log(params);

            $.get('${pageContext.request.contextPath}/main/search', params, function(data) {
                    var markers = $(data.output).map(function(i, position) {
                        return new kakao.maps.Marker({
                            position : new kakao.maps.LatLng(position.latitude, position.longitude)
                        });
                    });

                    clusterer.setMinClusterSize(1);

                    // 지도 레벨에 따라 마커 생성/제거
                    var changeMarker = function() {
                        var level = map.getLevel();

                        if (1 <= level && level <= 7) {
                            clusterer.addMarkers(markers);
                        } else if (8 <= level && level <= 10) {
                            clusterer.removeMarkers(markers);
                        }
                    };

                    kakao.maps.event.addListener(map, 'zoom_changed', changeMarker);
                    changeMarker();

                    /** 마커를 클릭하면 실행되는 기능 -> 리스트에 보이는 매물 변경 **/
                    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
                        var southwest = cluster.getBounds().getSouthWest();
                        var northeast = cluster.getBounds().getNorthEast();
                        east = northeast.getLat();
                        west = southwest.getLat();
                        north = northeast.getLng();
                        south = southwest.getLng();

                        getMapPosition(west,east,south,north,1);

                        centerLat = map.getCenter().getLat();
                        centerLng = map.getCenter().getLng();
                        level = map.getLevel();
                    });

                    centerLat = map.getCenter().getLat();
                    centerLng = map.getCenter().getLng();
                    level = map.getLevel();




                    /** 서울시 구 별로 마커 생성하기 **/
                    $.get("${pageContext.request.contextPath}/assets/guposition", {},
                        function(data) {
                            var guPosition = data.guPositions;
                            var gumark;
                            for (var i = 0; i < guPosition.length; i++) {
                                gumark = '<div class="gu-marker" id="gu-marker' + i + '">';
                                gumark += '<div class="gu-count">' + guPosition[i].guCount + '</div>';
                                gumark += '<div class="gu-name">' + guPosition[i].guName + '</div>';
                                gumark += '<span id="lat" style="display:none;">' + guPosition[i].guLat + '</span>'; // 해당 구의 위도 저장
                                gumark += '<span id="lng" style="display:none;">' + guPosition[i].guLng + '</span>'; // 해당 구의 경도 저장
                                gumark += '</div>';
                                var customOverlay = new kakao.maps.CustomOverlay({
                                    position : new kakao.maps.LatLng(guPosition[i].guLat, guPosition[i].guLng),
                                    clickable : false,
                                    content : gumark,
                                    zIndex : 3
                                });

                                customOverlay.setMap(map);

                                // 마커 클릭 시 마커를 중심으로 지도 확대 이벤트
                                $("#gu-marker" + i).click(function() {
                                    var poslat = $(this).children("#lat").html();
                                    var poslng = $(this).children("#lng").html();
                                    map.setCenter(new kakao.maps.LatLng(poslat,poslng));
                                    map.setLevel(map.getLevel() - 2,{animate : true});
                                });

                            } // end for

                            $("#map > div > div > div > div").hover(
                                function() {$(this).css("z-index", "100");},
                                function() {$(this).css("z-index", "0");}
                            ); // end hover()
                        });

            }); // end $.get(address.json)


            /** 검색값 가져와서 지도 위치 변경하기 **/
            $("#search-form").submit(function(e) {
                e.preventDefault();

                var ps = new kakao.maps.services.Places();  // 장소 검색 객체 생성
                var value = $('input[name=search]').val();  // input값 가져오기

                ps.keywordSearch(value, placesSearchCB);    // 키워드로 장소 검색
                // 키워드 검색 완료 시 호출되는 콜백함수
                function placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {

                        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표 추가
                        var bounds = new kakao.maps.LatLngBounds();

                        for (var i = 0; i < data.length; i++) {
                            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                        }

                        map.setBounds(bounds);  // 검색된 장소 위치를 기준으로 지도 범위 재설정
                    }
                }; // end placesSearchCB()
            }); // end submit()

            var key = "${keyword}";
            if (key) {
                var ps = new kakao.maps.services.Places();  // 장소 검색 객체 생성
                ps.keywordSearch(key, placesSearchCB);  // 키워드로 장소 검색
                // 키워드 검색 완료 시 호출되는 콜백함수
                function placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {

                        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표 추가
                        var bounds = new kakao.maps.LatLngBounds();

                        for (var i = 0; i < data.length; i++) {
                            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                        }

                        map.setBounds(bounds);  // 검색된 장소 위치를 기준으로 지도 범위 재설정
                    }
                }; // end placesSearchCB()
            }


            /** 지도 확대/축소 변경 버튼 **/
            function zoomIn() { map.setLevel(map.getLevel() - 1); }     // 지도 확대 메서드
            function zoomOut() { map.setLevel(map.getLevel() + 1); }    // 지도 축소 메서드

            // 버튼 클릭과 기능 연결
            $(".zoom-in").click(function() { zoomIn(); });
            $(".zoom-out").click(function() { zoomOut(); });


            /** 지도 범위 이동이 이루어지면 실행 -> 리스트에 보이는 매물 변경 **/
            kakao.maps.event.addListener(map, 'dragend', function() {
                var bounds = map.getBounds();
                var southwest = bounds.getSouthWest();
                var northeast = bounds.getNorthEast();
                east = northeast.getLat();
                west = southwest.getLat();
                north = northeast.getLng();
                south = southwest.getLng();

                getMapPosition(west,east,south,north,1);
                console.log("west=%s south=%s", west, south);

                centerLat = map.getCenter().getLat();
                centerLng = map.getCenter().getLng();
                level = map.getLevel();
            });


            /** 지도 확대/축소가 이루어지면 실행 -> 리스트에 보이는 매물 변경 **/
            kakao.maps.event.addListener(map, 'zoom_changed', function() {
                var bounds = map.getBounds();
                var southwest = bounds.getSouthWest();
                var northeast = bounds.getNorthEast();
                east = northeast.getLat();
                west = southwest.getLat();
                north = northeast.getLng();
                south = southwest.getLng();

                getMapPosition(west,east,south,north,1);

                centerLat = map.getCenter().getLat();
                centerLng = map.getCenter().getLng();
                level = map.getLevel();
            });


            /** 페이징 처리 **/
            // 페이지 번호 클릭
            $(document).on('click', ".index-indiv", function(e){
                var index_no = $(this).html();
                getMapPosition(west,east,south,north,index_no);
            });
            // 다음 그룹으로 가기 버튼 클릭
            $(document).on('click', ".next-btn", function(e){
                if (nextPage == undefined) { nextPage = ${pageData.nextPage}; }

                if (nextPage > 0) {
                    getMapPosition(west,east,south,north,nextPage);
                    return;
                } else { return false; }
            });
            // 이전 그룹으로 가기 버튼 클릭
            $(document).on('click', ".prev-btn", function(e){
                if (prevPage > 0) {
                    getMapPosition(west,east,south,north,prevPage);
                    return;
                } else { return false; }
            });

        });

        /* 필터 -드롭다운 - 자동 toggle 해제 */
        $('.dropdown-menu').click(function(e) { e.stopPropagation(); })

        /** 원룸, 투쓰리룸, 오피스텔 체크박스 */
        var roomtypeto = "${param.roomtype}";
        var to = [];
        to = roomtypeto.split(",");
        var roomtype1 = document.getElementById('roomtype1');
        var roomtype2 = document.getElementById('roomtype2');
        var roomtype3 = document.getElementById('roomtype3');
        for (var room in to) {
            if (to[room] == "원룸") {
                $roomtype1 = $('#roomtype1').attr('checked', true);
            }
            if (to[room] == "투룸") {
                $roomtype1 = $('#roomtype2').attr('checked', true);
            }
            if (to[room] == "쓰리룸") {
                $roomtype1 = $('#roomtype2').attr('checked', true);
            }
            if (to[room] == "오피스텔") {
                $roomtype1 = $('#roomtype3').attr('checked', true);
            }
        }

        $('.room-typech').click(function() {
            var rt = "";

            if ($("input:checkbox[id='roomtype1']").is(":checked") == true) {
                rt += "원룸";
            }
            if ($("input:checkbox[id='roomtype2']").is(":checked") == true) {
                rt += ",투룸,쓰리룸";
            }
            if ($("input:checkbox[id='roomtype3']").is(":checked") == true) {
                rt += ",오피스텔";
            }

            if(rt == "") {
                return false;
            }

            var roomtypehref = '${pageContext.request.contextPath}/main/search.do?roomtype='+ rt +'&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
            location.replace(roomtypehref);

        });
        /** 원룸, 투쓰리룸, 오피스텔 체크박스 끝 */

        /** 월세, 전세, 매매 체크박스 */
        var dealingtypeto = "${param.dealingtype}";
        var to = [];
        to = dealingtypeto.split(",");
        var dealingtype1 = document.getElementById('dealingtype1');
        var dealingtype2 = document.getElementById('dealingtype2');
        var dealingtype3 = document.getElementById('dealingtype3');
        for (var dealing in to) {
            if (to[dealing] == "월세") {
                $dealingtype1 = $('#dealingtype1').attr('checked', true);
            }
            if (to[dealing] == "전세") {
                $dealingtype2 = $('#dealingtype2').attr('checked', true);
            }
            if (to[dealing] == "매매") {
                $dealingtype3 = $('#dealingtype3').attr('checked', true);
            }
        }


        $('.dealing-typech').click(function() {
            var dt = "";

            if ($("input:checkbox[id='dealingtype1']").is(":checked") == true) {
                dt += "월세";
            }
            if ($("input:checkbox[id='dealingtype2']").is(":checked") == true) {
                dt += ",전세";
            }
            if ($("input:checkbox[id='dealingtype3']").is(":checked") == true) {
                dt += ",매매";
            }

            if(dt == "") {
                return false;
            }

            var dealingtypehref = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=' + dt + '&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
            location.replace(dealingtypehref);

        });
        /** 월세, 전세, 매매 체크박스 끝 */

        // 금액별로 단위 표시(만/억)를 위한 메서드
        function fix(val) {
            if (val < 10000) {
                var won = val + "만 원";
            } else if (val % 10000 == 0) {
                var won = val / 10000 + "억 원";
            } else {
                var mil = Math.floor(val / 10000);
                var won = mil + "억 " + (val - mil * 10000) + "만 원";
            }
            return won;
        } // end fix()

        /* 필터 - Range plugin(ion.rangeSlider) */
        // 보증금/전세가
        var price1_value = [ 0, 100, 200, 300, 400, 500, 1000, 1500, 2000,
        2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000,
        7500, 8000, 8500, 9000, 9500, 10000, 11000, 12000, 13000,
        14000, 15000, 16000, 17000, 18000, 19000, 20000, 25000, 30000,
        35000, 40000, 45000, 50000, 55000, 60000, 65000, 70000, 75000,
        80000, 85000, 90000, 999999 ];
        var deposit_from = ${param.depositFrom};
        var deposit_to = ${param.depositTo};
        var price1_from = price1_value.indexOf(deposit_from);
        var price1_to = price1_value.indexOf(deposit_to);
        $("#slide-price1").ionRangeSlider(
        {
            type : "double",
            from : price1_from,
            to : price1_to,
            values : price1_value,
            to_min : price1_value.indexOf(100),
            from_max : price1_value.indexOf(90000),
            skin : "round",
            onStart : function(data) {
                if (deposit_from == 0 && deposit_to == 999999) {
                    $("#filter1-value").html("무제한");
                } else if (deposit_from != 0 && deposit_to == 999999) {
                    $("#filter1-value").html(
                        fix(deposit_from) + " ~ 무제한");
                } else {
                    $("#filter1-value").html(
                        fix(deposit_from) + " ~ " + fix(deposit_to));
                }
            },
            onChange : function(data) {
                if (data.from_value == 0 && data.to_value == 999999) {
                    $("#filter1-value").html("무제한");
                } else if (data.to_value == 999999) {
                    $("#filter1-value").html(fix(data.from_value) + " ~ 무제한");
                } else {
                    $("#filter1-value").html(fix(data.from_value) + " ~ " + fix(data.to_value));
                }
            },
            onFinish: function(data) {
                var low = data.from_value;
                var high = data.to_value;

                var href = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom='+low+'&depositTo='+high+'&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(href);
            },
            hide_from_to : true,
            hide_min_max : true
        });
        var slide1_value = $("#slide-price1").data("ionRangeSlider");

        // 월세
        var price2_value = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60,
        65, 70, 80, 90, 100, 110, 120, 130, 140, 150, 999999 ];
        var month_from = ${param.monthFrom};
        var month_to = ${param.monthTo};
        var price2_from = price2_value.indexOf(month_from);
        var price2_to = price2_value.indexOf(month_to);
        $("#slide-price2").ionRangeSlider(
        {
            type : "double",
            from : price2_from,
            to : price2_to,
            values : price2_value,
            to_min : price2_value.indexOf(5),
            from_max : price2_value.indexOf(150),
            skin : "round",
            onStart : function(data) {
                if (month_from == 0 && month_to == 999999) {
                    $("#filter2-value").html("무제한");
                } else if (month_from != 0 && month_to == 999999) {
                    $("#filter2-value").html(month_from + "만 원 ~ 무제한");
                } else {
                    $("#filter2-value").html(month_from + "만 원 ~" + month_to + "만 원");
                }
            },
            onChange : function(data) {
                if (data.from_value == 0 && data.to_value == 999999) {
                    $("#filter2-value").html("무제한");
                } else if (data.from_value != 0 && data.to_value == 999999) {
                    $("#filter2-value").html(data.from_value + "만 원 ~ 무제한");
                } else {
                    $("#filter2-value").html(data.from_value + "만 원 ~" + data.to_value + "만 원");
                }
            },
            onFinish: function(data) {
                var low = data.from_value;
                var high = data.to_value;

                var href = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom='+low+'&monthTo='+high+'&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(href);
            },
            hide_from_to : true,
            hide_min_max : true
        });
        var slide2_value = $("#slide-price2").data("ionRangeSlider");

        // 매매가
        var price3_value = [ 0, 3000, 5000, 10000, 15000, 20000, 25000, 30000,
        35000, 40000, 45000, 50000, 60000, 70000, 80000, 90000, 100000,
        110000, 120000, 130000, 140000, 150000, 999999 ];
        var buying_from = ${param.buyingFrom};
        var buying_to = ${param.buyingTo};
        var price3_from = price3_value.indexOf(buying_from);
        var price3_to = price3_value.indexOf(buying_to);
        $("#slide-price3").ionRangeSlider(
        {
            type : "double",
            from : price3_from,
            to : price3_to,
            values : price3_value,
            to_min : price3_value.indexOf(3000),
            from_max : price3_value.indexOf(150000),
            skin : "round",
            onStart : function(data) {
                if (buying_from == 0 && buying_to == 999999) {
                    $("#filter3-value").html("무제한");
                } else if (buying_from != 0 && buying_to == 999999) {
                    $("#filter3-value").html(
                        fix(buying_from) + " ~ 무제한");
                } else {
                    $("#filter3-value").html(
                        fix(buying_from) + " ~ " + fix(buying_to));
                }
            },
            onChange : function(data) {
                if (data.from_value == 0 && data.to_value == 999999) {
                    $("#filter3-value").html("무제한");
                } else if (data.from_value != 0 && data.to_value == 999999) {
                    $("#filter3-value").html(
                        fix(data.from_value) + " ~ 무제한");
                } else {
                    $("#filter3-value").html(
                        fix(data.from_value) + " ~ " + fix(data.to_value));
                }
            },
            onFinish: function(data) {
                var low = data.from_value;
                var high = data.to_value;

                var href = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom='+low+'&buyingTo='+high+'&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(href);
            },
            hide_from_to : true,
            hide_min_max : true
        });
        var slide3_value = $("#slide-price3").data("ionRangeSlider");

        // 관리비
        var price4_value = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
        31, 32, 33, 34, 35, 36, 38, 40, 42, 44, 46, 48, 50, 999999 ];
        var fee_from = ${param.feeFrom};
        var fee_to = ${param.feeTo};
        var price4_from = price4_value.indexOf(fee_from);
        var price4_to = price4_value.indexOf(fee_to);
        $("#slide-price4").ionRangeSlider(
        {
            type : "double",
            from : price4_from,
            to : price4_to,
            values : price4_value,
            to_min : price4_value.indexOf(1),
            from_max : price4_value.indexOf(50),
            skin : "round",
            onStart : function(data) {
                if (fee_from == 0 && fee_to == 999999) {
                    $("#filter4-value").html("무제한");
                } else if (fee_from != 0 && fee_to == 999999) {
                    $("#filter4-value").html(fee_from + "만 원 ~ 무제한");
                } else {
                    $("#filter4-value").html(fee_from + "만 원 ~" + fee_to + "만 원");
                }
            },
            onChange : function(data) {
                if (data.from_value == 0 && data.to_value == 999999) {
                    $("#filter4-value").html("무제한");
                } else if (data.from_value != 0 && data.to_value == 999999) {
                    $("#filter4-value").html(data.from_value + "만 원 ~ 무제한");
                } else {
                    $("#filter4-value").html(data.from_value + "만 원 ~" + data.to_value + "만 원");
                }
            },
            onFinish: function(data) {
                var low = data.from_value;
                var high = data.to_value;

                var href = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom='+low+'&feeTo='+high + '&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(href);
            },
            hide_from_to : true,
            hide_min_max : true
        });

        // 방크기
        var size_from = ${param.sizeFrom};
        var size_to = ${param.sizeTo};
        $("#slide-size").ionRangeSlider(
        {
            type : "double",
            min : 0,
            max : 115,
            step : 1,
            from : size_from,
            to : size_to,
            to_min : 1,
            from_max : 114,
            skin : "round",
            onStart : function(data) {
                var from_p = size_from / 3.3;
                var to_p = size_to / 3.3;
                if (size_from == 0 && size_to == 999999) {
                    $("#filter5-value").html("무제한");
                } else if (size_from != 0 && size_to == 999999) {
                    $("#filter5-value").html(
                        size_from + "㎡(" + Math.floor(from_p) + "평) ~ 무제한");
                } else {
                    $("#filter5-value").html(
                        size_from + "㎡(" + Math.floor(from_p) + "평) ~ " + size_to + "㎡(" + Math.floor(to_p) + "평)");
                }
            },
            onChange : function(data) {
                var from_p = data.from / 3.3;
                var to_p = data.to / 3.3;
                if (data.from == 0 && data.to == 115) {
                    $("#filter5-value").html("무제한");
                } else if (data.from_value != 0 && data.to == 115) {
                    $("#filter5-value").html(
                        data.from + "㎡(" + Math.floor(from_p) + "평) ~ 무제한");
                } else {
                    $("#filter5-value").html(
                        data.from + "㎡(" + Math.floor(from_p) + "평) ~ " + data.to + "㎡(" + Math.floor(to_p) + "평)");
                }
            },
            onFinish: function(data) {
                var low = data.from;
                var high = data.to;

                if(high == 115) {
                    high = 999999;
                }

                var href = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom='+low+'&sizeTo='+high+'&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(href);
            },
            hide_from_to : true,
            hide_min_max : true
        });
        var slide5_value = $("#slide-size").data("ionRangeSlider");


        // 필터 초기화
        $(function() {
            // 가격대 조건삭제
            $("#filter-reset1").click(function(e) {
                e.preventDefault();
                var pricehref = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(pricehref);
            })

            // 관리비 조건삭제
            $("#filter-reset2").click(function(e) {
                e.preventDefault();
                /* slide4_value.reset();
                $("#filter4-value").html("무제한"); */
                var feehref = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=0&feeTo=999999&sizeFrom=${param.sizeFrom}&sizeTo=${param.sizeTo}&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(feehref);
            })

            // 방크기 조건삭제
            $("#filter-reset3").click(function(e) {
                e.preventDefault();
                var sizehref = '${pageContext.request.contextPath}/main/search.do?roomtype=${param.roomtype}&dealingtype=${param.dealingtype}&depositFrom=${param.depositFrom}&depositTo=${param.depositTo}&monthFrom=${param.monthFrom}&monthTo=${param.monthTo}&buyingFrom=${param.buyingFrom}&buyingTo=${param.buyingTo}&feeFrom=${param.feeFrom}&feeTo=${param.feeTo}&sizeFrom=0&sizeTo=999999&map='+centerLat+','+centerLng+','+level+"&news="+west+","+east+","+south+","+north;
                location.replace(sizehref);
            })

            // 전체 필터 초기화
            $("#filters-reset").click(function(e) {
                e.preventDefault();
                $("input[type='checkbox']").prop('checked', true);
                var resetUrl = "${pageContext.request.contextPath}/main/search.do?roomtype=원룸,투룸,쓰리룸,오피스텔&dealingtype=월세,전세,매매&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map="+centerLat+","+centerLng+","+level+"&news="+west+","+east+","+south+","+north;
                location.replace(resetUrl);
            });

        })
    </script>
</body>
</html>
