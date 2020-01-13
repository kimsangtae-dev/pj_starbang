<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<%@ include file="assets/inc/meta.jsp"%>

<!-- css 적용 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ma_css/main.css">

<!--  slider css -->

<%--쓰지 않을 css --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugin/slick/slick.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugin/slick/slick-theme.css">


</head>
<body>
    <input type="hidden" id="oksession" value="${loginInfo}">
    <input type="hidden" id="oksessionno" value="${loginInfo.userno}">
    <input type="hidden" id="inputheart" value="${heart}">

    <!----------------------------------------
    -   header                         -
    ----------------------------------------->
    <%@ include file="assets/inc/ma_top.jsp"%>


    <!---------------------------------------\
    /    content                          /
    ----------------------------------------->
    <!-- 중앙 영역 시작 -->
    <div id="content">

        <!---------------------------------------\
    /    검색창                             /
    ----------------------------------------->
        <div id="search">
            <div class="text-center">
                <p class="text-center">
                    <span class="text-center">어떤 동네, 어떤 방</span>에서
                </p>
                <p>살고 싶으신가요?</p>
            </div>
            <form method="get" action="${pageContext.request.contextPath}/main/search.do">
                <div>
                    <input type="hidden" class="input-hidden" name="roomtype" value="원룸,투룸,쓰리룸,오피스텔"> <input type="hidden" class="input-hidden" name="dealingtype" value="월세,전세,매매"> <input type="hidden" class="input-hidden"
                        name="depositFrom" value="0"> <input type="hidden" class="input-hidden" name="monthFrom" value="0"> <input type="hidden" class="input-hidden" name="buyingFrom" value="0"> <input type="hidden"
                        class="input-hidden" name="feeFrom" value="0"> <input type="hidden" class="input-hidden" name="sizeFrom" value="0"> <input type="hidden" class="input-hidden" name="depositTo" value="999999"> <input
                        type="hidden" class="input-hidden" name="monthTo" value="999999"> <input type="hidden" class="input-hidden" name="buyingTo" value="999999"> <input type="hidden" class="input-hidden" name="feeTo"
                        value="999999"> <input type="hidden" class="input-hidden" name="sizeTo" value="999999"> <input type="hidden" class="input-hidden" name="map" value="37.5642135,126.9743207,9"> <input
                        type="search" name="keyword" id="searching-for" value="${keyword}" placeholder="지역으로 검색하세요"> <i class="glyphicon glyphicon-search"></i>
                    <button type="submit" class="btn btn-primary">방 찾기</button>
                </div>
            </form>
        </div>
        <!-- 검색창 끝 -->


        <!---------------------------------------\
    /    쉬운 방 찾기 시작                  /
    ----------------------------------------->
        <div id="easyfind">
            <div class="text-center easy-box1">
                <span>쉬운 방찾기</span>
                <p>방 찾기 초보를 위한 초간단 솔루션!</p>
            </div>
            <div class="slide-div1">
                <div class="slide-div2">
                    <div class="slide-div3 slider regular" style="right: 0px;">

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸&dealingtype=월세&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=50&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up1"></div>
                                    <div class="slide-a-div1-down">
                                        <p>부담없는 월세</p>
                                        <p>50이하 원룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸&dealingtype=월세&depositFrom=0&depositTo=500&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up2"></div>
                                    <div class="slide-a-div1-down">
                                        <p>믿음직한 보증금</p>
                                        <p>500이하 원룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸&dealingtype=월세,전세,매매&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&region=송파구&map=37.5048534,127.1144822,5">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up3"></div>
                                    <div class="slide-a-div1-down">
                                        <p>살기좋은</p>
                                        <p>송파구 원룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=투룸,쓰리룸&dealingtype=전세&depositFrom=0&depositTo=20000&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up4"></div>
                                    <div class="slide-a-div1-down">
                                        <p>2억이하</p>
                                        <p>전세 투쓰리룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸,투룸,쓰리룸,오피스텔&dealingtype=전세&depositFrom=0&depositTo=30000&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up5"></div>
                                    <div class="slide-a-div1-down">
                                        <p>중산층을 위한</p>
                                        <p>3억 이하 전세</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=오피스텔&dealingtype=월세,전세,매매&depositFrom=0&depositTo=10000&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up6"></div>
                                    <div class="slide-a-div1-down">
                                        <p>보증금1억이하</p>
                                        <p>오피스텔</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸,투룸,쓰리룸,오피스텔&dealingtype=매매&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=20000&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up7"></div>
                                    <div class="slide-a-div1-down">
                                        <p>신혼부부를 위한</p>
                                        <p>2억이하 매매</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸&dealingtype=월세,전세,매매&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=999999&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&region=강남구&map=37.4959854,127.0664091,5">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up8"></div>
                                    <div class="slide-a-div1-down">
                                        <p>놀기 좋은 접근성 좋은</p>
                                        <p>강남구 원룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div>
                            <a class="slide-a"
                                href="${pageContext.request.contextPath}/main/search.do?roomtype=원룸&dealingtype=월세&depositFrom=0&depositTo=999999&monthFrom=0&monthTo=50&buyingFrom=0&buyingTo=999999&feeFrom=0&feeTo=999999&sizeFrom=0&sizeTo=999999&map=37.5642135,126.9743207,9">
                                <div class="slide-a-div1">
                                    <div class="slide-a-div1-up9"></div>
                                    <div class="slide-a-div1-down">
                                        <p>부담없는 월세</p>
                                        <p>50이하 원룸</p>
                                    </div>
                                </div>
                            </a>
                        </div>

                    </div>
                </div>

                <!-- 
         다방 버전 오른쪽 화살표 
         <div class="">
         <button class="slide-button">
           <svg width="10" height="16" viewBox="0 0 10 16">
             <path fill="none" fill-rule="evenodd" stroke="#666" d="M2 14l6-6-6-6"></path>
           </svg>
         </button>
         </div> -->

                <!-- 
        다방 버전 페이징
        
        <div class="slidepage-div">
         <p class="slidepage-p1">01</p>
         <p class="slidepage-p2">02</p>
        </div>
       -->
            </div>
        </div>
        <!-- 쉬운방찾기 끝 -->


        <!---------------------------------------\
    /    최근본방/찜한 방                    /
    ----------------------------------------->
        <div class="recent">
            <div class="recent-div0">
                <!--         <div class="recent-div1">
           </div>
           <div class="recent-div2">
           </div> -->

                <ul class="tabs" id="tabs">
                    <li id="tab1"><c:choose>
                            <c:when test="${loginInfo == null }">최근 본 방
           			</c:when>
                            <%-- 컨트롤러에서 식별한 세션 있을 때 --%>
                            <c:otherwise>
                      ${loginInfo.name}님의 최근 본 방
                   </c:otherwise>
                        </c:choose></li>
                    <li id="tab2"><c:choose>
                            <%-- 컨트롤러에서 식별한 세션 없을 때 --%>
                            <c:when test="${loginInfo == null }">
                                <a href="${pageContext.request.contextPath}/modal/login.do" data-toggle="modal" data-target="#loginModal">찜한 방</a>
                            </c:when>
                            <%-- 컨트롤러에서 식별한 세션 있을 때 --%>
                            <c:otherwise>
                   ${loginInfo.name}님의 찜한방
                   </c:otherwise>
                        </c:choose></li>
                </ul>
                <div class="recent-div3">
                    <span>최근에 본 방과 찜한방을 볼 수 있어요</span>
                </div>

                <div class="tab_container" id="tab_con">
                    <div class="recent-div4">
                        <%-- 조회 결과가 없는 경우 --%>
                        <c:if test="${output3 == null || fn:length(output) == 0}">
                            <div class="recent-div5-vacant margin">
                                <p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>
                            </div>
                            <div class="recent-div5-vacant margin">
                                <p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>
                            </div>
                            <div class="recent-div5-vacant margin">
                                <p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>
                            </div>
                            <div class="recent-div5-vacant margin">
                                <p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- div0 끝 -->
        </div>
        <!-- 최근본방 / 찜한방 끝  -->

        <!---------------------------------------\
    /    인기있는 방 시작                    /
    ----------------------------------------->
        <div class="pop-entire">
            <div class="pop-entire-d2">
                <div class="pop-title1">
                    <a href="main/pprm.do">인기 있는 방</a>
                </div>
                <div class="pop-title2">많은 사람들이 찾아본 이곳, 궁금하지 않으세요?</div>
                <div class="fame_container">
                    <!-- 갤러리 전체 박스 -->
                    <div class="popular-div4">
                        <ul id="gallery-list">
                        </ul>
                    </div>
                </div>
                <!-- 인기 있는 방 끝  -->

                <!-- 방 찾기 버튼  -->
                <button class="btn-searchrm" style="bottom: 30px;">
                    <svg width="20" height="20" viewBox="0 0 20 20">
         <g fill="none" fill-rule="evenodd" stroke="#FFF" stroke-width="2">
            <circle cx="8.5" cy="8.5" r="6.5"></circle>
            <path d="M13 13l5 5"></path>
         </g>
       </svg>
                    <span>방 찾기</span>
                </button>
            </div>
        </div>
    </div>
    <!-- content 끝 -->

    <!----------------------------------------
-   footer                      -
----------------------------------------->
    <%@ include file="assets/inc/ma_bottom.jsp"%>

    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugin/slick/slick.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
                    function delectstar(x) {
                        $.ajax({
                            url : "${pageContext.request.contextPath}/main/delectstar.do",
                            method : "get",
                            data : {
                                "x" : x
                            },
                            success : function(req) {
                                console.log(x + "delectstar");
                                popularityroom();
                                recentroom();
                            },
                            error : function() {
                                console.log("delectstar발송에러 발생");
                            }
                        });
                    }

                    function delect3(x) {
                        $.ajax({
                            url : "${pageContext.request.contextPath}/main/delectstar.do",
                            method : "get",
                            data : {
                                "x" : x
                            },
                            success : function(req) {
                                console.log(x + "delectstar");
                                popularityroom();
                                wishsh();
                                $("#tab2").click();
                            },
                            error : function() {
                                console.log("delectstar발송에러 발생");
                            }
                        });
                    }

                    function insertstar(x) {
                        $.ajax({
                            url : "${pageContext.request.contextPath}/main/insertstar.do",
                            method : "get",
                            data : {
                                "x" : x
                            },
                            success : function(req) {
                                console.log(x + "insertstar");
                                popularityroom();
                                recentroom();
                            },
                            error : function() {
                                console.log("insertstar발송에러 발생");
                            }
                        });
                    }
                </script>

    <script>
        /* 슬라이더 세팅 */
        $(".regular").slick({
            dots : true,
            infinite : true,
            slidesToShow : 6,
            slidesToScroll : 5
        });

        /* 스크롤 내렸을 때 방찾기 버튼 나타내기 */
        $(function() {
            $(window).scroll(function() {

                if ($(window).scrollTop() > 370) {
                    $(".btn-searchrm").fadeIn(1).css("display", "block").css("bottom", "30px");
                } else {
                    $(".btn-searchrm").fadeOut(1);
                }

                if ($(document).height() < $(window).scrollTop() + $(window).height() + 250) {
                    var control = 0;
                    control = 280 - ($(document).height() - $(window).scrollTop() - $(window).height());
                    $(".btn-searchrm").css("bottom", control + "px");
                }
            });

            $(".btn-searchrm").click(function() {
                $("#searching-for").focus();
            });
        });
    </script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js">
                    $(document).ready(function() {
                        $("#tabs").tabs();
                    });
                </script>
    <!-- Handlebar 템플릿 코드 -->
    <script id="prof-list-tmpl" type="text/x-handlebars-template">
    {{#each item}}
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
                <img src="${pageContext.request.contextPath}/upload/download.do?crop=true&size=285x186&file={{filename}}" />
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
    <!-- 값이 없을때 -->
    <script id="no-list-tmpl" type="text/x-handlebars-template">   
    <div class="recent-div5-vacant margin">
        <p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>
    </div>
    </script>
    <!-- user code -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugin/handlebars-v4.0.11.js"></script>
    <script>
        var session = $("#oksession").val(); //세션 식별을 위한 값
        var sessionuserno = $("#oksessionno").val(); //세션 식별을 위한 값
        var heartlist = $("#inputheart").val(); //세션 식별을 위한 값
        
        $(function() {
            /** 최근본방 **/
            $(document).ready(function() {
                recentroom();
            });
            
            /** 찜한방 **/
            $("#tab2").click(function() {
                wishsh();
            });
            
            /** 최근본방 **/
            $("#tab1").click(function() {
                recentroom();
            });
            
            $(document).ready(function() { //인기있는 방 AJAX
                popularityroom();
            });
            
        });

        function wishsh() {
            $.get("${pageContext.request.contextPath}/professor", {
                    "userno" : sessionuserno
                }, function(json) {
                    Handlebars.registerHelper('isMonth', function(dealingtype, options) {
                        if (dealingtype == '월세') {
                            return options.fn(this);
                        } else {
                            return options.inverse(this);
                        }
                    });
                    
                    Handlebars.registerHelper('isOver', function(price, options) {
                        if (price >= 10000 && price % 10000 != 0) {
                            return Math.floor(price / 10000) + "억" + price % 10000;
                        } else if (price >= 10000 && price%10000 == 0) {
                            return price/10000 + "억";
                        } else { return price; }
                    });
                    
                    Handlebars.registerHelper('isOver2', function(deposit, options) {
                        if (deposit >= 10000 && deposit % 10000 != 0) {
                            return Math.floor(deposit / 10000) + "억" + deposit % 10000;
                        } else if (deposit >= 10000 && deposit%10000 == 0) {
                            return deposit/10000 + "억";
                        } else { return deposit; }
                    });
                    
                    Handlebars.registerHelper('fee', function(fee, options) {
                        if (fee == 0) {
                            return "없음";
                        } else { 
                            return fee+"만"; }
                    });
                    
                    /** 세션 식별하기 **/
                    Handlebars.registerHelper('session', function(roomno, options) {
                        for (var i = 0; i < json.heart_size; i++) {
                            var heart_div = '<div class="wish-div7">'
                            heart_div += '<div class="wish-div8 on" data-value="off"></div>'
                            heart_div += '</div>'
                            return heart_div;
                        }
                        if (json.heart_size == 0) {
                            var heart_div = '<div class="recent-div7">'
                            heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                            heart_div += '</div>'
                            return heart_div;
                        }
                    });
                    var source = $("#prof-list-tmpl").html()//템플릿코드
                    var template = Handlebars.compile(source);// 템플릿 컴파일
                    var result = template(json);
                    var a = Object.keys({
                        item : []
                    });
                    console.log(a); //json 데이터 알아보기
                    $(".tabs > li:nth-child(2)").css("color", "black");
                    $(".tabs > li:nth-child(1)").css("color", "gray");
                    
                    if (a == "item") {
                        var source2 = $("#no-list-tmpl").html()
                        var template = Handlebars.compile(source2);// 템플릿 컴파일
                        $(".recent-div4").append(template);
                    }
                    
                    var empty_div = "";
                    if (json.item.length < 4) {
                        for (var k = 0; k < 4 - json.item.length; k++) {
                            empty_div += '<li><div class="recent-div5-vacant margin">';
                            empty_div += '<p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>';
                            empty_div += '</div></li>';
                        }
                    }
                    
                    $(".recent-div4").empty();
                    $(".recent-div4").append(result);
                    $(".recent-div4").append(empty_div);
                    
                    /* 좋아요 클릭 -> 하트 색 변경 */
                    $(function() {
                        $(".wish-div8").click(function(e) {
                            $(this).toggleClass('on off');
                            var onoff = $(this).hasClass("on");
                            var a = $(this).parent().prev().val();
                            delect3(a);
                        });
                    });
                });
        } // function wishsh() {

        /** 최근본방 ajax처리 함수 */
        function recentroom() {
            $.get("${pageContext.request.contextPath}/professor2", {}, function(json) {
                Handlebars.registerHelper('isMonth', function(dealingtype, options) {
                    if (dealingtype == '월세') {
                        return options.fn(this);
                    } else {
                        return options.inverse(this);
                    }
                });
                
                Handlebars.registerHelper('isOver', function(price, options) {
                    if (price >= 10000 && price % 10000 != 0) {
                        return Math.floor(price / 10000) + "억" + price % 10000;
                    } else if (price >= 10000 && price%10000 == 0) {
                        return price/10000 + "억";
                    } else { return price; }
                });
                
                Handlebars.registerHelper('isOver2', function(deposit, options) {
                    if (deposit >= 10000 && deposit % 10000 != 0) {
                        return Math.floor(deposit / 10000) + "억" + deposit % 10000;
                    } else if (deposit >= 10000 && deposit%10000 == 0) {
                        return deposit/10000 + "억";
                    } else { return deposit; }
                });
                
                Handlebars.registerHelper('fee', function(fee, options) {
                    if (fee == 0) {
                        return "없음";
                    } else { 
                    	return fee+"만"; }
                });
                
                /** 세션 식별하기 **/
                Handlebars.registerHelper('session', function(roomno, options) {
                    if (session == null || session == "") {
                        var heart_div = '<a href="${pageContext.request.contextPath}/modal/login.do" data-toggle="modal" data-target="#loginModal">'
                        heart_div += '<div class="recent-div7">'
                        heart_div += '<div class="recent-div8 off"></div>'
                        heart_div += '</div>'
                        heart_div += '</a>'
                        return heart_div;
                    } else if (json.heart_size == 0) {
                        var heart_div = '<div class="recent-div7">'
                        heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                        heart_div += '</div>'
                        return heart_div;
                    } else {
                        for (var i = 0; i < json.heart_size; i++) {
                            if (json.heart[i].roomno == roomno) {
                                var heart_div = '<div class="recent-div7">'
                                heart_div += '<div class="recent-div8 on" data-value="off"></div>'
                                heart_div += '</div>'
                                return heart_div;
                            }
                        }
                        for (var i = 0; i < json.heart_size; i++) {
                            if (json.heart[i].roomno != roomno) {
                                var heart_div = '<div class="recent-div7">'
                                heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                                heart_div += '</div>'
                                return heart_div;
                            }
                        }
                        if (json.heart_size == 0) {
                            var heart_div = '<div class="recent-div7">'
                            heart_div += '<div class="recent-div8 off" data-value="on"></div>'
                            heart_div += '</div>'
                            return heart_div;
                        }
                    }
                    
                });
                
                var empty_div = "";
                if (json.cookie_size < 4) {
                    for (var k = 0; k < 4 - json.cookie_size; k++) {
                        empty_div += '<li><div class="recent-div5-vacant margin">';
                        empty_div += '<p class="recent-div5-vacant-p">아직 못 본 더 많은 방이 있어요.</p>';
                        empty_div += '</div></li>';
                    }
                }
                
                var source = $("#prof-list-tmpl").html()//템플릿코드
                var template = Handlebars.compile(source);// 템플릿 컴파일
                var result = template(json);
                
                $(".tabs > li:nth-child(1)").css("color", "black");
                $(".tabs > li:nth-child(2)").css("color", "gray");
                $(".recent-div4").empty();
                $(".recent-div4").append(result);
                $(".recent-div4").append(empty_div);
                
                /* 좋아요 클릭 -> 하트 색 변경 */
                $(function() {
                    $(".recent-div8").click(function(e) {
                        var loginInfo = "${loginInfo}";
                        if (loginInfo != "") {
                            $(this).toggleClass('on off');
                            var onoff = $(this).hasClass("on");
                            var a = $(this).parent().prev().val();
                            if (onoff == true) {
                                insertstar(a);
                            } else {
                                delectstar(a);
                            }
                        }
                    });
                });
            });
        }
        
        /** 인기있는 방 ajax처리 함수 */
        function popularityroom() {
            $.get("${pageContext.request.contextPath}/famous", {}, function(json) {
                Handlebars.registerHelper('isMonth', function(dealingtype, options) {
                    if (dealingtype == '월세') {
                        return options.fn(this);
                    } else {
                        return options.inverse(this);
                    }
                });
                
                Handlebars.registerHelper('isOver', function(price, options) {
                    if (price >= 10000 && price % 10000 != 0) {
                        return Math.floor(price / 10000) + "억" + price % 10000;
                    } else if (price >= 10000 && price%10000 == 0) {
                        return price/10000 + "억";
                    } else { return price; }
                });
                
                Handlebars.registerHelper('isOver2', function(deposit, options) {
                    if (deposit >= 10000 && deposit % 10000 != 0) {
                        return Math.floor(deposit / 10000) + "억" + deposit % 10000;
                    } else if (deposit >= 10000 && deposit%10000 == 0) {
                        return deposit/10000 + "억";
                    } else { return deposit; }
                });
                
                Handlebars.registerHelper('fee', function(fee, options) {
                    if (fee == 0) {
                        return "없음";
                    } else { 
                    	return fee+"만"; }
                });
                
                /** 세션 식별하기 **/
                Handlebars.registerHelper('session', function(roomno, options) {
                    if (session == null || session == "") {
                        var heart_div = '<a href="${pageContext.request.contextPath}/modal/login.do" data-toggle="modal" data-target="#loginModal">'
                        heart_div += '<div class="hit-div7">'
                        heart_div += '<div class="hit-div8 off"></div>'
                        heart_div += '</div>'
                        heart_div += '</a>'
                        return heart_div;
                    } else {
                        for (var i = 0; i < json.heart_size; i++) {
                            if (json.heart[i].roomno == roomno) {
                                var heart_div = '<div class="hit-div7">'
                                heart_div += '<div class="hit-div8 on" data-value="off"></div>'
                                heart_div += '</div>'
                                return heart_div;
                            }
                        }
                        for (var i = 0; i < json.heart_size; i++) {
                            if (json.heart[i].roomno != roomno) {
                                var heart_div = '<div class="hit-div7">'
                                heart_div += '<div class="hit-div8 off" data-value="on"></div>'
                                heart_div += '</div>'
                                return heart_div;
                            }
                        }
                        if (json.heart_size == 0) {
                            var heart_div = '<div class="hit-div7">'
                            heart_div += '<div class="hit-div8 off" data-value="on"></div>'
                            heart_div += '</div>'
                            return heart_div;
                        }
                    }
                });
                
                var source = $("#prof-list-tmpl").html()//템플릿코드
                var template = Handlebars.compile(source);// 템플릿 컴파일
                var result = template(json);
                
                $(".tabs > li:nth-child(1)").css("color", "black");
                $(".tabs > li:nth-child(2)").css("color", "gray");
                $(".popular-div4").empty();
                $(".popular-div4").append(result);
                
                /* 좋아요 클릭 -> 하트 색 변경 */
                $(function() {
                    $(".hit-div8").click(function(e) {
                        var loginInfo = "${loginInfo}";
                        if (loginInfo != "") {
                            $(this).toggleClass('on off');
                            var onoff = $(this).hasClass("on");
                            var a = $(this).parent().prev().val();
                            if (onoff == true) {
                                insertstar(a);
                            } else {
                                delectstar(a);
                            }
                        }
                    });
                });
            });
        }// popularityroom()끝
    </script>
</body>
</html>