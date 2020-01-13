<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ho_css/rmli.css" />
<head>

<%@ include file="../assets/inc/meta.jsp"%>

<title>공실관리</title>
 
<!-- header, footer, ho_rmli css 참조 -->
<link rel="stylesheet" type="text/css" href="" />

<style>
</style>
</head>

<body>
<div id="root">
    <div class="box">
        <!-- 헤더 -->
        <%@ include file="../assets/inc/ho_header2.jsp"%>

        <!-- content -->
        <!-- 공실관리 -->
        <div class="content-box">
            <div class="title-box">
                <h1 class="title-h1">공실관리</h1>
            </div>
            <form id="form" action="${pageContext.request.contextPath}/host/rmli.do">
            <!--  -->
            <div class="isroom-div">
                <p class="isroom-p1">
                    <span>${fn:length(output)}</span>건의 공실이 있습니다.
                </p>
                <p class="isroom-p2">공실상태</p>
                <ul width="135" id="dropdown" class="dropdown-closed dropdn">
                    <li name="status" value="0" class="dropdown-li"><a href="${pageContext.request.contextPath}/host/rmli.do?status=0" onclick="return false;">
                    <span><c:choose><c:when test="${rememberChecked eq '1'}">공개</c:when><c:when test="${rememberChecked eq '2'}">비공개</c:when><c:otherwise>전체</c:otherwise></c:choose></span>
                        <svg width="10px" height="5px" viewBox="0 0 10 5" version="1.1">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1235.000000, -281.000000)" fill="#444444">
                                    <g transform="translate(180.000000, 263.000000)">
                                        <g transform="translate(945.000000, 0.000000)">
                                            <path d="M119.297,18 L114.9935,21.755 L114.5345,21.3545455 L114.537,21.3568182 L110.7135,18.0204545 L110,18.6427273 C111.0565,19.565 114.007,22.1395455 114.9935,23 C115.7265,22.3609091 115.012,22.9840909 120,18.6318182 L119.297,18 Z" id="arrow_down-[#339]"></path></g></g></g></g></svg>
                   	</a></li>
                    <li name="status" value="1" class="dropdown-li2"><a href="${pageContext.request.contextPath}/host/rmli.do?status=0" >전체보기</a></li>
                    <li name="status" value="1" class="dropdown-li2"><a href="${pageContext.request.contextPath}/host/rmli.do?status=1" >공개</a></li>
                    <li name="status" value="2" class="dropdown-li2"><a href="${pageContext.request.contextPath}/host/rmli.do?status=2" >비공개</a></li>
                </ul>
            </div>
		</form>
        <div class="contain">
            <div class="table-responsive">
                <table class="table table-hover margin-bottom">
                    <colgroup>
                        <col width="10%">
                        <col width="50%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="text-center">공실번호</th>
                            <th class="text-center">공실정보</th>
                            <th class="text-center">공실현황</th>
                            <th class="text-center">공실관리</th>
                            <th class="text-center">상태변경</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<%-- 한행 씩 for문 --%>
                        <c:forEach var="item" items="${output}" varStatus="status">
                        		<%-- 출력을 위해 준비한 요소 --%>
	                    		<c:set var="roomno" value="${item.roomno}" />
								<c:set var="roomtype" value="${item.roomtype}" />
								<c:set var="dealingtype" value="${item.dealingtype}" />
								<c:set var="price" value="${item.price}" />
								<c:set var="name" value="${item.name}" />
								<c:set var="confirmdate" value="${item.confirmdate}" />
								<c:set var="status" value="${item.status}" />
								<c:set var="deposit" value="${item.deposit}" />
								<c:set var="address" value="${item.address}" />      
	                        
	                        <tr>
	                        	<%-- roomno 열 --%>
	                       		<td class="text-center">${roomno}</td>
	                       		
	                       		<%-- 공실정보열 --%>
	                           	<td class="select-td">
	                                <div class="table-div">
	                                    <span class="table-span1">${roomtype}</span>
	                                    <b class="table-span1-1">
		                                    <c:choose>
											    <c:when test="${dealingtype == '월세'}">
												    <fmt:formatNumber value="${deposit}" pattern="#,####" var="eok1"/> 
											    	<c:set var="patternprice1" value="${fn:replace(eok1, ',', '억')}" />
												    	${dealingtype}&nbsp;${patternprice1}/${price}만 원
											    </c:when>
										    	<c:otherwise>
											    	<fmt:formatNumber value="${price}" pattern="#,####" var="eok2" /> 
											    	<c:set var="patternprice2" value="${fn:replace(eok2, ',', '억')}" />
											    		${dealingtype}&nbsp;${patternprice2}만 원
										    	</c:otherwise>
											</c:choose>
	                                    </b><br>
	                                    <span class="table-span2">${address}</span><br>
	                                    <span>${fn:substringBefore(confirmdate," ")}</span>
	                                </div>
	                            </td>
	                            <%-- 공실현황 열 --%>
	                            <td class="text-center">
		                            <c:choose>
										<c:when test="${status == 0 || status == 1}">
											<span class="label label-primary">&nbsp;공개&nbsp;</span>
										</c:when>
										
										<c:when test="${status == 2}">
											<span class="label label-danger">&nbsp;허위매물&nbsp;</span>
										</c:when>
										
										<c:when test="${status == 3}">
											<span class="label label-info">&nbsp;비공개&nbsp;</span>
										</c:when>
										
										<c:when test="${status == 4}">
											<span class="label complete">&nbsp;거래완료&nbsp;</span>
										</c:when>
										
										<c:otherwise>
											<span class="label label-info">소유자 확인중</span>
										</c:otherwise>
									</c:choose>
	                            </td>
	                            <%-- 공실관리 열 --%>
	                            <td class="text-center">
	                            
                                	<c:url value="${contextPath}/host/rm_edit.do" var="update">
										<c:param name="roomno" value="${roomno}"></c:param>
									</c:url>
									
									<c:url value="${contextPath}/host/rmli_delete.do" var="delete">
									      <c:param name="roomno" value="${roomno}"></c:param>
									</c:url>
									<a href="${update}" class="btn btn-default">수정</a>
									<a href="${delete}" class="btn btn-default">삭제</a>
	                            </td>
	                            <td class="text-center">
	                                <a href="#chmodeModal" data-toggle="modal" class="changemode">
	                                    <button class="btn btn-default">공실상태전환</button>
	                                </a>
	                            </td>
	                        </tr>
						</c:forEach>
						
                    </tbody>
                </table>

            </div>
            <!--/ .table-responsive -->
        </div>
        <!-- / .table contain -->
    </div>
    <!-- / content -->
    
    	<%-- gallery-index --%>
	<div class="gallery-footer">
		<div class="gallery-index">
			<!-- 페이지 번호 구현 -->
			<%-- 이전 그룹에 대한 링크 --%>
			<c:choose>
				<%-- 이전 그룹으로 이동 가능하다면? --%>
				<c:when test="${pageData.prevPage > 0}">
					<%-- 이동할 URL 생성 --%>
					<c:url value="/host/rmli.do" var="prevPageUrl">
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
					<c:url value="/host/rmli.do" var="pageUrl">
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
							<c:url value="/host/rmli.do" var="nextPageUrl">
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
			
    <!-- footer -->
    <%@ include file="../assets/inc/ho_footer.jsp"%>
    
    </div>
    <!--/ .box -->
</div>
<!--/ #root -->


<!-- 로그인용 모달 로더 -->
<div class="modal fade" id="chmodeModal">
    <div class="modal-dialog">
        <div class="modal-content modal-whole-chmode">
            <p class="chmode-title">공실 상태를 변경합니다.</p>
            <div class="chmode-div clearfix">
                <a class="status" id="1">
                    <span>공개</span>
                    <p>게시글을 공개상태로 전환합니다.</p>
                </a>
            </div>
            <div class="chmode-div clearfix">
                <a class="status" id="3">
                    <span>비공개</span>
                    <p>게시글을 비공개 상태로 전환합니다.</p>
                </a>
            </div>
            <div class="chmode-div clearfix">
                <a class="status" id="4">
                    <span>거래완료</span>
                    <p>거래를 완료했습니다.</p>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Javascript -->
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$("#dropdown").click(function() {
		
		if ( $("#dropdown").hasClass("dropdown-closed") ) {
			
			$(this).addClass('dropdown-opened');
	        $(this).removeClass('dropdown-closed');
	        $(".dropdown-li > span").html("전체");
		
		} else {
			
			$(this).addClass('dropdown-closed');
	        $(this).removeClass('dropdown-opened');

		/* 바꾸기 */
		$(".dropdn > li").click(function(){
			var copy = $(this).html();
			$(".dropdown-li > span").html(copy);
		});
			
	        
		}
	});
</script>

<script>
	/* 페이지 이동 막은걸 풀어주고, 값 보내주기 */
	$("#dropdown").click(function(){
	   if ( $("#dropdown").hasClass("dropdown-opened") ) {   
		   $(".dropdown-li > a").prop("onclick", null);
	   }
	});
</script>

<script type="text/javascript">
	/* 공실상태 전환하기 */
	$(function() {
		var roomno;
		var status;
		var select;
		$(".changemode").click(function(e) {
			e.preventDefault();
			roomno = $(this).parents("tr").children().eq(0).html();
			select = $(this).parents("td").prev().prev().find("span");
			
		});
		
		$(".status").click(function(e) {
			e.preventDefault();
			status = $(this).attr('id');
			$.ajax({
	            type: "GET",
	            data: {"roomno": roomno, "status": status},
	            url: "${pageContext.request.contextPath}/host/rmli_status.do",
	            success: function(data){
	            	alert("공실상태가 변경되었습니다.");
	            	if (status==1){
	            		select.html("&nbsp;공개&nbsp;");
	            		select.removeClass().addClass("label").addClass("label-primary");
	            	} else if (status == 3) {
	            		select.html("&nbsp;비공개&nbsp;");
	            		select.removeClass().addClass("label").addClass("label-info");
	            	} else if (status == 4) {
	            		select.html("거래완료");
	            		select.removeClass().addClass("label").addClass("complete");
	            	}
	            },
	            error: function(data) {
	                console.log(data);
	            }
	        });
		});
	})
</script>

<script>
// 새창띄워서 룸 디테일 들어가기 
$(".select-td").click(function(){
	
	var url = "${pageContext.request.contextPath}/main/rmdt.do?roomno=";
	var roomno = $(this).prev().html();
	
	window.open(url + roomno, "_blank");
	
	
});

</script>

</body>
</html>