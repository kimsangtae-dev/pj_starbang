<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/modal_css/compare.css" />
</head>

<!-- .modal -->
<!-- <div id="myModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!-- .modal-dialog -->
<!-- 여백잡아주는박스  -->
<!-- <div class="modal-dialog marginbox"> -->
<!-- .modal-content -->
<!-- 여기가 나오는부분 -->
<div class="modal-content mainbox">
    <div id="header_compare" class="height">
        <h1>방 비교하기</h1>
    </div>
    <div class="content">
        <table class="tableconfig">
            <colgroup>
                <col width="33.3%">
                <col width="33.3%">
                <col width="33.3%">
            </colgroup>

            <c:choose>
                <%-- 조회 결과가 없는 경우 --%>
                <c:when test="${output == null || fn:length(output) == 0}">
                    <p>조회 결과가 없습니다.</p>
                </c:when>
                <%-- 갤러리 시작 --%>
                <c:otherwise>

                    <!-- table 1번째 시작 -->
                    <tbody>
                        <tr>
                            <c:forEach var="item" items="${output}" varStatus="status">
                                <td><a target="_blank" href="${pageContext.request.contextPath}/main/rmdt.do?roomno=${item.roomno}">
                                        <p class="tbody-top-p" id="${item.roomno}">매물번호 ${item.roomno}</p>
                                </a></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var="item" items="${output}" varStatus="status">
                                <c:url value="/upload/download.do" var="thumbnail_url">
                                    <c:param name="file" value="${item.filename}" />
                                </c:url>
                                <td><div class="compare-img1">
                                        <img src="${thumbnail_url}" />
                                    </div></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var="item" items="${output}" varStatus="status">
                                <td><p class="room-num">${item.roomtype}</p></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <c:forEach var="item" items="${output}" varStatus="status">
                                <td><p class="room-price">
                                        <c:choose>
                                            <c:when test="${item.dealingtype == '월세'}">
                                                <span>${item.dealingtype}&nbsp;<!--
                                             -->
                                                    <fmt:formatNumber value="${item.deposit}" pattern="#,####" var="eok1"></fmt:formatNumber> <c:set var="patternprice1" value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" /> <!--
                                             -->${patternprice1}/${item.price}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${item.dealingtype}&nbsp;<!--
                                             -->
                                                    <fmt:formatNumber value="${item.price}" pattern="#,####" var="eok2"></fmt:formatNumber> <c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" /> <!--
                                             -->${patternprice2}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p></td>
                            </c:forEach>
                        </tr>
                    </tbody>
                    <!-- 테이블 1번째 끝 -->

                    <!-- 테이블 2번째 시작 -->
                    <table class="tableconfig">
                        <colgroup>
                            <col width="33.3%">
                            <col width="33.3%">
                            <col width="33.3%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>가격대</th>
                                <th>가격대</th>
                                <th>가격대</th>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table2-margin">
                                        <p class="table2-price-lp">가격</p>
                                        <p class="table2-price-rp">
                                            <c:forEach var="p" items="${price}" varStatus="status">
                                                <c:if test="${item.roomno==p.roomno}">
                                                    <c:choose>
                                                        <c:when test="${p.dealingtype == '월세'}">
                                                            <span>${p.dealingtype}&nbsp;<!--
                                                        -->
                                                                <fmt:formatNumber value="${p.deposit}" pattern="#,####" var="eok1"></fmt:formatNumber> <c:set var="patternprice1" value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" />
                                                                <!--
                                                        -->${patternprice1}/${p.price}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>${p.dealingtype}&nbsp;<!--
                                                        -->
                                                                <fmt:formatNumber value="${p.price}" pattern="#,####" var="eok2"></fmt:formatNumber> <c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" />
                                                                <!--
                                                        -->${patternprice2}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                        </p>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table2-margin" style="padding-bottom: 20px;">
                                        <p class="table2-price-lp">관리비</p>
                                        <p class="table2-price-rp">
                                            <c:choose>
                                                <c:when test="${room.fee =='0'}">없음</c:when>
                                                <c:otherwise>
                                                ${item.fee}만 원
                                            </c:otherwise>
                                            </c:choose>
                                            <input type="hidden" name="getfeeitem" value="${item.feeitem}" class="fee" />
                                        </p>
                                    </td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 테이블 2번째 끝 -->

                    <!-- 테이블 3번째 -->
                    <table class="tableconfig">
                        <colgroup>
                            <col width="33.3%">
                            <col width="33.3%">
                            <col width="33.3%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>상세정보</th>
                                <th>상세정보</th>
                                <th>상세정보</th>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table3-padding">
                                        <p class="table3-detail-lp">주소</p>
                                        <p class="table3-detail-rp">${item.address}</p>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table3-padding">
                                        <p class="table3-detail-lp">면적</p>
                                        <p class="table3-detail-rp">${item.area}㎡(${item.supplyarea}㎡)</p>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table3-padding">
                                        <p class="table3-detail-lp">층수</p>
                                        <p class="table3-detail-rp">${item.floor}층</p>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table3-padding" style="padding-bottom: 20px;">
                                        <p class="table3-detail-lp">주차</p>
                                        <p class="table3-detail-rp">
                                            <c:choose>
                                                <c:when test="${item.parking =='-1'}">불가</c:when>
                                                <c:when test="${item.parking =='0'}">가능(무료)</c:when>
                                                <c:otherwise>${info.parking}만 원</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 테이블 3번째 끝 -->

                    <!-- 테이블 4번째 -->
                    <table class="tableconfig">
                        <colgroup>
                            <col width="33.3%">
                            <col width="33.3%">
                            <col width="33.3%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>옵션</th>
                                <th>옵션</th>
                                <th>옵션</th>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table4-padding"><input type="hidden" value="${item.optionitem}" name="getoption" class="option" />
                                        <p class="dDctva table5-option-p"></p></td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 테이블 4번째 -->
                    <!-- 테이블 5번째 -->
                    <table class="tableconfig">
                        <colgroup>
                            <col width="33.3%">
                            <col width="33.3%">
                            <col width="33.3%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>기타</th>
                                <th>기타</th>
                                <th>기타</th>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="table5-padding">
                                        <p class="table5-option-p">
                                            <c:if test="${item.heater == '1'}">중앙난방</c:if>
                                            <c:if test="${item.heater == '2'}">개별난방</c:if>
                                            <c:if test="${item.heater == '3'}">지역난방</c:if>
                                        </p>
                                        <p class="table5-option-p">
                                            <c:if test="${item.builtin == '0'}">빌트인 아님</c:if>
                                            <c:if test="${item.builtin == '1'}">빌트인 주방</c:if>
                                        </p>
                                        <p class="table5-option-p">
                                            <c:if test="${item.elevator == '0'}">엘리베이터 없음</c:if>
                                            <c:if test="${item.elevator == '1'}">엘리베이터 있음</c:if>
                                        </p>
                                        <p class="table5-option-p">
                                            <c:if test="${item.pet == '0'}">반려동물 불가능</c:if>
                                            <c:if test="${item.pet == '1'}">반려동물 가능</c:if>
                                        </p>
                                        <p class="table5-option-p">
                                            <c:if test="${item.veranda == '0'}">베란다/발코니 없음</c:if>
                                            <c:if test="${item.veranda == '1'}">베란다/발코니 있음</c:if>
                                        </p>
                                        <p class="table5-option-p">
                                            <c:if test="${item.loan == '0'}">전세자금대출 불가능</c:if>
                                            <c:if test="${item.loan == '1'}">전세자금대출 가능</c:if>
                                        </p>
                                        <p class="table5-option-p">${item.commingday}</p>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="item" items="${output}" varStatus="status">
                                    <td class="last-contact-td">
                                        <div class="last-contact-div">
                                            <div>
                                                <div>
                                                    <p>${item.name}</p>
                                                    <p>${item.email}</p>
                                                </div>
                                            </div>
                                            <button>문의하기</button>
                                        </div>
                                    </td>
                                </c:forEach>
                            </tr>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </table>
    </div>
</div>

<!-- /.modal-content -->

<script>
    $(function() {
        $(".last-contact-div").click(function() {
            $(this).toggleClass("last-contact-div last-contact-div-open");
        });
    });
</script>
<script>
    function binary() {

        /* 뿌려줄 String을 배열에 저장 */
        var option = ["에어컨", "세탁기", "옷장", "TV", "신발장", "냉장고", "가스레인지", "인덕션", "전자레인지", "전자도어락", "비데", "침대", "책상"];

        /* 받아온 값을 관리비 항목에 넣는다 */
        var num1 = new Array;
        for (var j = 0; j < $(".option").length; j++) {
            num1[j] = $(".option").eq(j).val();
            var sum = new Array;
            for (var i = 13; i >= 0; i--) {
                if (num1[j] >= Math.pow(2, i - 1)) {
                    num1[j] = num1[j] - Math.pow(2, i - 1);
                    sum += option[13 - i];
                    if (num1[j] == 0 || i == 1) {
                        break;
                    }
                    sum += ", ";
                } // if문
            } // for문
            $(".dDctva").eq(j).append("<span>" + sum + "</span>");
        }

        //alert(num);

    } // binary함수
    binary(); //return

    function binary2() {

        /* 뿌려줄 String을 배열에 저장 */
        var option2 = ["인터넷", "유선TV", "청소비", "수도세", "도시가스", "전기세", "기타"];

        /* 받아온 값을 관리비 항목에 넣는다 */
        var num2 = new Array;
        for (var j = 0; j < $(".fee").length; j++) {
            num2[j] = $(".fee").eq(j).val();

            var sum = new Array;

            for (var i = 7; i >= 1; i--) {
                if (num2[j] >= Math.pow(2, i - 1)) {
                    num2[j] = num2[j] - Math.pow(2, i - 1);
                    sum += option2[7 - i];

                    if (num2[j] == 0 || i == 1) {
                        break;
                    }
                    sum += ", ";
                } // if문
            } // for문
            if (sum == "") {
                sum = "없음";
            }
            ;
            sum = "(" + sum + ")";
            $(".fee").eq(j).parent().append(sum);
        }
    } // binary함수

    binary2();
</script>
