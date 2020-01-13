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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/etc/reset.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/ma_css/pprm.css">
</head>

<body>
	<!-- 브라우저에 보여질 부분 -->
	<!-- 페이지의 전체 폭을 결정하기 위한 영역 -->
	<!-- <div> -->
		<!-- 상단 헤더 -->
		<%@ include file="../assets/inc/ma_top.jsp"%>

		<!-- 중앙 영역 -->
		<div id="content">
			<!-- 최근본방/찜한 방 -->
			<div id="hit" class="hit_bang">
				<h1 class="hit_title">인기매물</h1>
				<div class="tab-text">
					<div class="re-div1">
						<p>
							인기매물은 최대 <span>50개</span>까지 보여집니다
						</p>
					</div>
				</div>
				<!-- 갤러리 전체 박스 -->
				<div class="hit-div4">
					<ul id="gallery-list">
						<c:choose>
							<%-- 조회 결과가 없는 경우 --%>
							<c:when test="${output == null || fn:length(output) == 0}">
								<p>조회 결과가 없습니다.</p>
							</c:when>
							<%-- 갤러리 시작 --%>
							<c:otherwise>
								<c:forEach var="item" items="${output}" varStatus="status">
									<li>
										<div class="hit-div5">
											<div class="hit-div6">
												<%-- 좋아요 버튼 --%>
												<input type="hidden" value="${item.roomno}">
                                                        <c:choose>
                                                        	<%-- 세션 없을 때 --%>
                                                        	<c:when test="${loginInfo == null}">
                                                        	<a href="${pageContext.request.contextPath}/modal/login.do"
																data-toggle="modal" data-target="#loginModal">
                                                        	<div class="hit-div7">
                                                               <div class="hit-div8 offff"></div>
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
                                                                    <div class="hit-div7">
                                                                        <div class="hit-div8 off" data-value="on"></div>
                                                                    </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                    	<c:forEach var="h" items="${heart}" varStatus="status">
                                                                        	<c:if test="${item.roomno==h.roomno}">
                                                                        	<div class="hit-div7">
                                                                        	    <div class="hit-div8 on" data-value="off"></div>
                                                                        	</div>
                                                                        	</c:if>
                                                                    	</c:forEach>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                        	</c:otherwise>
                                                        </c:choose>
												<!-- <div class="hit-div7">
													<div class="hit-div8 off" data-value="on"></div>
												</div> -->
												<%-- 좋아요 끝 --%>
												<%-- 전체 링크화 --%>
												<a target="_blank" rel="" class="hit-a"
													href="${pageContext.request.contextPath}/main/rmdt.do?roomno=${item.roomno}">
													<%-- -------------------쿠키 굽기---------------------- --%>
													<!-- 이미지 -->
													<div class="hit-a-div">
							                            <c:url value="/upload/download.do" var="thumbnail_url">
							                              <c:param name="file" value="${item.filename}" />
							                            </c:url>
                            							<img src="${thumbnail_url}"/>
                            						</div>
														<c:if test="${item.confirmdate != null}">
														<%-- 확인매물 div --%>
														<div class="hit-a-confirm">
															<div class="hit-a-confirm-div">
																<span class="bold">확인매물</span> <span>${item.confirmdate}</span>
															</div>
														</div>
														<%-- 확인매물 끝 --%>
													</c:if>
													<p class="hit-a-p1">${item.roomtype}</p>
													<p class="hit-a-p2">
														<c:choose>
			                                                <c:when test="${item.dealingtype == '월세'}">
			                                                    <span>${item.dealingtype}&nbsp;<!--
			                                                    	--><fmt:formatNumber value="${item.deposit}" pattern="#,####" var="eok1" />
			                                                        <c:set var="patternprice1" value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" />
			                                                        ${patternprice1}/${item.price}
			                                                    </span>
			                                                </c:when>
			                                                <c:otherwise>
			                                                    <span>${item.dealingtype}&nbsp;<!--
			                                                    --><fmt:formatNumber value="${item.price}" pattern="#,####" var="eok2" /> 
                                                        			<c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" />
                                                        			${patternprice2}</span>
                                                			</c:otherwise>
                                            			</c:choose>
													</p>
													<p class="hit-a-p34">${item.floor}층, ${item.area}m²,
			                                        	<c:choose>
			                                            	<c:when test="${item.fee == 0}">관리비 없음</c:when>
			                                                <c:otherwise>관리비 ${item.fee}만</c:otherwise>
			                                            </c:choose>
			                                        </p>
													<p class="hit-a-p34">${item.title}</p>
												</a>
											</div>
										</div>
									</li>
								</c:forEach>
							</c:otherwise>
							<%-- 갤러리 끝 --%>
						</c:choose>
					</ul>
				</div>
				<!-- 갤러리 전체 끝 -->
			</div>
			<!-- 최근본방/찜한 방 끝-->
		</div>
		<!-- content 끝 -->

		<!-- 하단 영역 -->
		<%@ include file="../assets/inc/ma_bottom.jsp"%>

		<!-- Javascript -->
		<script
			src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

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
			/* 좋아요 클릭 -> 하트 색 변경 */
			$(function() {
				$(".hit-div8").click(function(e) {
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
			});
		</script>

</body>
</html>
