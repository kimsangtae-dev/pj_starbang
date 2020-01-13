<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../assets/inc/meta.jsp" />
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/assets/plugin/billboard.min.css" />
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/assets/css/ma_css/rmdt.css" />
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.css" />

</head>

<body>
<!--<script language="JavaScript">
javascript:alert(document.cookie);//요건 쿠키가 잘 됐는지 확인해 보는 자바스크립트
</script>-->
	<!-- 상단 헤더 -->
	<jsp:include page="../assets/inc/ma_top.jsp" />
	<!-- 중앙 영역 -->
	<div id="content">
		<!-- 전체 면적 설정 -->
		<div id="summury">
			<!--상단 내용 시작-->
			<ul id="box1">
				<li class="pull-left abc"><span class="greyfont1">${room.roomtype}</span>
					<h1 class="monthman">
						<!-- 월세일때 전세, 매매일때 if문시작 -->
						<c:choose>
						    <c:when test="${price[0].dealingtype == '월세'}">
							    <fmt:formatNumber value="${price[0].deposit}" pattern="#,####" var="eok1"/>
						    	<c:set var="patternprice1" value="${fn:replace(eok1, ',', '억')}" />
							    	${price[0].dealingtype}&nbsp;${patternprice1}/${price[0].price}
							    	<span class="greyfontwon1"> 만원</span>
						    </c:when>
						    <c:otherwise>
						    	<!-- if문 시작 -->
                                <c:choose>
                                	<c:when test="${fn:contains(price[0].price,'0000')}">
                                		<fmt:formatNumber value="${price[0].price}" pattern="#,####" var="eok2" />
                                		<c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" />
                                		${price[0].dealingtype}&nbsp;${patternprice2}
                                		<span class="greyfontwon1"> 원</span>
                                	</c:when>
                                	<c:otherwise>
                                	<fmt:formatNumber value="${price[0].price}" pattern="#,####" var="eok2" />
                                	<c:set var="patternprice2" value="${fn:replace(eok2, ',', '억')}" />
                                	${price[0].dealingtype}&nbsp;${patternprice2}
                                	<span class="greyfontwon1"> 만원</span>
                                	</c:otherwise>
                                </c:choose>
						    </c:otherwise>
						</c:choose>

					</h1></li>
				<li class="pull-left abc" id="month"><span class="greyfont1">전용면적</span>
					<h1 id="chnum">
						${room.area}<span>㎡</span>
					</h1>
					<button type="button" class="chbt">
						<span class="glyphicon glyphicon-refresh">평</span>
					</button></li>
				<li class="pull-right">
					<!--방주인 이메일보기-->
					<p class="honame">방주인 ${user.name}님</p>
					<button type="button" class="btn btn-primary grml">
						<img src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/mail.png" class="mailsize"> <span
							class="que">문의하기</span>
					</button>
				</li>
			</ul>
		</div>
		<!--상단 내용 끝-->
		<div id="iconlist">
			<!--찜,이메일,공유,허위매물신고 시작-->
			<input type="hidden" value="${newRoomno}">
            <c:choose>
            	<%-- 세션 없을 때 --%>
            	<c:when test="${loginInfo == null}">
						<a href="${pageContext.request.contextPath}/modal/login.do"
							class="st-bang" data-toggle="modal"
							data-target="#loginModal">
        					<div class="recent-div9 off"></div>
						</a>
					</c:when>
                	<%-- 세션 있을 때 --%>
                	<c:otherwise>
                        <c:choose>
                        	<c:when test="${heartox == 0}">
                        		<div class="recent-div9 off" data-value="on"></div>
							</c:when>
                        	<c:otherwise>
 	                    		<div class="recent-div9 on" data-value="off"></div>
                        	</c:otherwise>
                        </c:choose>
				</c:otherwise>
			</c:choose>
			<span id="lkct">${heartint}</span>
			<!-- 도트 -->
			<img src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/blackdot.png" class="dotsize">
			<!-- 링크 -->
			<button class="linkimg">
				<img src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/link.png" class="linksize">
			</button>
			<!-- url 복사 -->
			<input type="hidden" id="link-area" class="link-area" value="<%=request.getRequestURL()%>?<%=request.getQueryString()%>">
			<!-- 도트 -->
			<img src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/blackdot.png" class="dotsize">
			<!-- 사이렌 -->
			<c:choose>
				<%-- 컨트롤러에서 식별한 세션 없을 때 --%>
				<c:when test="${loginInfo == null }">
				<a href="${pageContext.request.contextPath}/modal/login.do"
						class="st-bang" data-toggle="modal" data-target="#loginModal">
					<button class="notce"  id="falsehood" class="btn btn-link bot outall">
					<img class="siren" src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/siren.png"
						onmouseover='this.src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/redsiren.png"'
						onmouseout='this.src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/siren.png"'>
						<span class="greyfontnm1">허위매물신고</span>
					</button>
				</a>
				</c:when>
				<%-- 컨트롤러에서 식별한 세션 있을 때 --%>
				<c:otherwise>
				<button class="notce" id="falsehood" class="btn btn-link bot outall" data-toggle="modal" data-target="#falsehoodmo">
					<img class="siren" src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/siren.png"
						onmouseover='this.src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/redsiren.png"'
						onmouseout='this.src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/siren.png"'>
					<span class="greyfontnm1">허위매물신고</span>
				</button>
				</c:otherwise>
			</c:choose>
		</div>
		<!--찜,이메일,공유,허위매물신고 끝-->
		<c:choose>
			<c:when test="${room.confirmdate == null }">
			</c:when>
			<c:when test="${room.confirmdate != null }">
				<div id="confirm room">
					<!--확인매물 푸른색바 시작-->
					<div class="eTgAil confirm">
						<p class="gknGpv onfirm">
							확인매물<span>
							<c:set var="confirmdate" value="${fn:replace(room.confirmdate, ' 00:00:00', '')}" />
							${confirmdate}
							</span>
						</p>
						<p class="cETKtB">
							<span class="confirmsm">방주인과 공인중개사가 거래정보를 확인한 매물입니다.</span>
							<button class="mola">
								<img src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/confirmq.png">
							</button>
						</p>
					</div>
				</div>
			</c:when>
		</c:choose>


		<!--확인매물 푸른색바 끝-->
		<div id="summury-option">
			<!--방등록시 상세 옵션값들 시작-->
			<ul class="iuNQqL clearfix" id="list">
				<li class="gWdVQs">
					<p class=" gPsGgb">해당층/건물층</p>
					<div class="gbAeEp">${room.floor} / ${info.maxfloor}</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">전용/공급면적</p>
					<div class="gbAeEp"></div><span id="toggleArea">${room.area} / ${info.supplyarea}㎡</span>
					<button type="button" class="bHPFKV">
						<span class="glyphicon glyphicon-refresh">평</span>
					</button>
				<li class="gWdVQs">
					<p class=" gPsGgb">난방종류</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.heater == '1'}">
								중앙난방
							</c:when>
							<c:when test="${info.heater == '2'}">
								개별난방
							</c:when>
							<c:when test="${info.heater == '3'}">
								개별난방
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">빌트인</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.builtin == '0'}">
								아님
							</c:when>
							<c:when test="${info.builtin == '1'}">
								빌트인주방
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">엘리베이터</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.elevator == '0'}">
								없음
							</c:when>
							<c:when test="${info.elevator == '1'}">
								있음
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">반려동물</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.pet == '0'}">
								불가능
							</c:when>
							<c:when test="${info.pet == '1'}">
								가능
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">베란다/발코니</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.veranda == '0'}">
								없음
							</c:when>
							<c:when test="${info.veranda == '1'}">
								있음
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">전세자금대출</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.loan == '0'}">
								불가능
							</c:when>
							<c:when test="${info.loan == '1'}">
								가능
							</c:when>
						</c:choose>
					</div>
				</li>
				<li class="gWdVQs">
					<p class=" gPsGgb">입주가능일</p>
					<div class="gbAeEp">
						<c:choose>
							<c:when test="${info.commingday == '0'}">
								<span>즉시 입주</span>
							</c:when>
							<c:when test="${info.commingday == '1'}">
								<span>날짜 협의</span>
							</c:when>
							<c:otherwise>
								<span>${info.commingday}</span>
							</c:otherwise>
						</c:choose>
					</div>
				</li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
		</div>
		<!--방등록시 상세 옵션값들 끝 (원본)-->
		<div id="bigview">
			<!-- 매물 이미지 시작  -->
			<ul class="bigviewul">
				<li class="bigviewigli">
				<div class="room_num"><p>매물번호 ${room.roomno}</p></div>
					<a href="#">
						<c:url value="/upload/download.do" var="thumbnail_url">
                            <c:param name="file" value="${img[0].thumbnail}" />
                        </c:url>
						<img src="${thumbnail_url}" /></a></li>
				<c:forEach var="i" begin="1" end="4" step="1">
					<c:choose>
						<c:when test="${img[i].thumbnail != null}">
							<li class="bigviewiglism">
							<!-- null값이 아니고 4번재 사진에 덧씌어질 이미지 -->
							<c:if test="${img[i].thumbnail != null && i == 4}">
							<div class="roomnum"><div class="line1"></div><div class="line2"></div><p>전체보기</p></div>
							</c:if>
								<a href="#">
									<c:url value="/upload/download.do" var="thumbnail_url">
					                    <c:param name="file" value="${img[i].thumbnail}" />
					                </c:url>
									<img src="${thumbnail_url}" /></a></li>
						</c:when>
						<c:otherwise>
							<li class="bigviewiglism">
								<a href="#">
									<c:url value="/upload/download.do" var="thumbnail_url">
					                    <c:param name="file" value="nophoto.png" />
					                </c:url>
									<img src="${thumbnail_url}" /></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>

		<div id="explanall">
			<!--사용자 매물 설명 시작-->
			<div id="bigexplan">
				<div class="explan1">${room.title}</div>
			</div>
			<!--매물 설명 큰 폰트-->
			<div id="smallexplan">
				<div class="explan-off" data-value="explan-on">
					<div>
						<span class="smexp">${info.content}</span>
					</div>
				</div>
				<button class="jQYbpN more">상세설명 더보기</button>
			</div>
			<!--매물 설명 작은 폰트-->
		</div>
		<!--
		---------------------
		파란색 바 스크롤 위치 고정작업
		---------------------
		 -->
		<div id="fxed">
			<div id="bbblue">
				<div id="lol">
					<!--스크롤 발생 시 움직이는 파란색바 시작-->
					<h1 class="textht pull-left texthth1">
						<c:choose>
						    <c:when test="${price[0].dealingtype == '월세'}">
						    <fmt:formatNumber value="${price[0].deposit}" pattern="#,####" var="eok1"/>
					    	<c:set var="patternprice1" value="${fn:replace(eok1, ',', '억')}" />
						    	${price[0].dealingtype}&nbsp;${patternprice1}/${price[0].price}
						    </c:when>

					    	<c:otherwise>
					    	<fmt:formatNumber value="${price[0].price}" pattern="#,####" var="eok2" />
					    	<c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" />
					    		${price[0].dealingtype}&nbsp;${patternprice2}
					    	</c:otherwise>
						</c:choose>
					</h1>
					<input type="hidden" value="${newRoomno}">
                  <c:choose>
                        <%-- 세션 없을 때 --%>
                     <c:when test="${loginInfo == null}">
                     <a href="${pageContext.request.contextPath}/modal/login.do"
                        class="st-bang" data-toggle="modal"
                        data-target="#loginModal">
                          <div class="recent-div8 off"></div>
                     </a>
                  </c:when>
                      <%-- 세션 있을 때 --%>
                      <c:otherwise>
                           <c:choose>
                              <c:when test="${heartox == 0}">
                                 <div class="recent-div8 off" data-value="on"></div>
                        </c:when>
                              <c:otherwise>
                                 <div class="recent-div8 on" data-value="off"></div>
                              </c:otherwise>
                           </c:choose>
                  </c:otherwise>
               </c:choose>
               <span class="cntlk" id="blueh">${heartint}</span>
					<button class="icngbl ulcp">
						<img class="upup" src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/whlink.png">
					</button>
					<!-- 신고하기 -->
					<c:choose>
						<%-- 컨트롤러에서 식별한 세션 없을 때 --%>
						<c:when test="${loginInfo == null }">
						<a href="${pageContext.request.contextPath}/modal/login.do"
								class="st-bang" data-toggle="modal" data-target="#loginModal">
							<button class="icngbl">
								<img class="siren notce" src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/whsiren.png">
							</button>
						</a>
						</c:when>
						<%-- 컨트롤러에서 식별한 세션 있을 때 --%>
						<c:otherwise>
						<button class="icngbl" data-toggle="modal" data-target="#falsehoodmo">
							<img class="siren notce" src="${pageContext.request.contextPath}/assets/img/ma_img/rmdt/whsiren.png">
						</button>
						</c:otherwise>
					</c:choose>

					<div id="plrt">
						<span class="texthtlvc">방주인</span> <span
							class="textht skyblue lvc">${user.name}님</span>
						<button type="submit" class="textht inbl">
							<span class="quest grml">문의하기</span>
						</button>
					</div>
				</div>
				<!--스크롤 발생 시 움직이는 파란색바 끝-->
			</div>
			<!--사용자 매물 설명 끝-->
			<div id="smhead">
				<div class="xOEdU">
					<a class="eYDrrB move1">다방면 스코어</a>
					<a class="eYDrrB move2">가격정보</a>
					<a class="eYDrrB move3">옵션</a>
					<a class="eYDrrB move4">위치</a>
				</div>
			</div>
		</div>
		<!--
		----------------------
		파란색 바 스크롤 위치 고정작업
		----------------------
		 -->
		<div id="simsim">
			<div class="xOEdU">
				<a id="move1" class="eYDrrB">다방면 스코어</a>
				<a id="move2" class="eYDrrB">가격정보</a>
				<a id="move3" class="eYDrrB">옵션</a>
				<a id="move4" class="eYDrrB">위치</a>
				<!-- <a class="eYDrrB">인기매물</a> -->
			</div>
		</div>
		<!-- 파란색 헤더바 여기서 부터 시작 -->
		<div id="radar">
			<!-- 다방면 스코어 시작-->
			<div id="location1" class="jFMhNO kBQneM">
				<h1 class="dbrfvk kBQneM">다방면 스코어</h1>
				<div class="fCword">
					<h1>
						75.5<span>점</span>
					</h1>
					<p>가격대비 괜찮은 방!</p>
				</div>
				<div id="radarChart"></div>
			</div>
		</div>

		<!--다방면스코어 끝-->
		<div id="location2" class="jFMhNO kBQneM">
			<!--가격정보 시작-->
			<h1 class="GYLAC">가격정보</h1>
			<div class="taln">
				<!-- 표 영역 -->
				<table class="tabdln">
					<!-- 제목 영역 -->
					<thead class="bdlnthd">
						<tr class="bdlntr">
							<th class="bdlnth">월세</th>
							<th class="bdlnth">전세</th>
							<th class="bdlnth">관리비</th>
							<th class="bdlnth">주차비</th>
							<th class="bdlnth">단기임대</th>
						</tr>
					</thead>
					<!-- 본문 영역 -->
					<tbody class="bdlntdy">
						<tr class="bdlnbtr">
							<td class="bdlntd">
								<c:forEach var="k" items="${price}" varStatus="status">
									<c:choose>
									    <c:when test="${k.dealingtype == '월세'}">
										   	<fmt:formatNumber value="${k.deposit}" pattern="#,####" var="eok1"/>
									    	<c:set var="patternprice1" value="${fn:replace(eok1, ',', '억')}" />
										   	<h6>${patternprice1}/${k.price}만 원</h6>	
									    </c:when>
								    	<c:otherwise>
									    	-
								    	</c:otherwise>
									</c:choose>
								</c:forEach>
							</td>
							<td class="bdlntd">
								<c:choose>
								    <c:when test="${price[0].dealingtype == '전세'}">
									   	<fmt:formatNumber value="${price[0].price}" pattern="#,####" var="eok1"/>
							    		<c:set var="patternprice1" value="${fn:replace(eok1, ',', '억 ')}" />
								    	${patternprice1}만 원
								    </c:when>
							    	<c:otherwise>
								    	-
							    	</c:otherwise>
								</c:choose>
							</td>
							<td class="bdlntd">
								<c:choose>
									<c:when test="${room.fee =='0'}">
										관리비 없음
									</c:when>
									<c:otherwise>
									${room.fee}만 원
									</c:otherwise>
								</c:choose>
								<br>
								<span id="apeend_feeitem"></span>
							</td>
							<td class="bdlntd">
								<c:choose>
									<c:when test="${info.parking =='-1'}">
										불가
									</c:when>
									<c:when test="${info.parking =='0'}">
										가능(무료)
									</c:when>
									<c:otherwise>
									${info.parking}만 원
									</c:otherwise>
								</c:choose>
							</td>
							<td class="bdlntd">
								<c:choose>
									<c:when test="${price[0].short_room =='1'}">
										가능
									</c:when>
									<c:otherwise>
										불가능
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!--가격정보 끝 -->
		<div id="location3" class="jFMhNO kBQneM">
			<!--상세 옵션들 아이콘으로 보여줌 시작-->
			<h1 class="GYLAC">옵션</h1>

			<input type="hidden" id="nice" value="${info.optionitem}" />

			<div class="dDctva">

			</div>
		</div>
		<!--상세 옵션들 아이콘으로 보여줌 끝-->
		<!-- 지도 시작 -->
		<div id="location4" class="jFMhNO kBQneM">
			<h1 class="fIqmuM">위치</h1>
			<p class="hwnvlX">${room.address}</p>

			<!-- 맵 api 시작-->

			<div class="map-container">
				<div id="map"></div>
			</div>

			<!-- 맵 api 끝-->
			<!--위치 30미터 반경만 표시-->
		</div>
		<!-- 지도 끝 -->
		<!--매물 이미지 끝-->

	</div>
	<!-- 하단 영역 -->
	<jsp:include page="../assets/inc/ma_bottom.jsp" />









	<div class="portal" id="">
    <div class="background_layer"> <!-- VPfux -->
        <button class="img_close"> <!-- jmTKvK -->
            <svg width="27" height="28" viewBox="0 0 27 28">
                <g fill="#FFF" fill-rule="evenodd">
                    <path d="M.67.774l26.366 26.365-.707.707L-.036 1.481z"></path>
                    <path d="M26.33.774L-.037 27.139l.707.707L27.036 1.481z"></path>
                </g>
            </svg>
        </button>
        <div class="fkdkpL">   <!-- fkdkpL -->
            <div class="xDUcp">   <!-- xDUcp -->
                <button class="railBtn_left">  <!-- Huuqk -->
                    <svg width="10" height="16" viewBox="0 0 10 16">
                        <path fill="none" fill-rule="evenodd" stroke="#FFF" d="M2 14l6-6-6-6"></path>
                    </svg>
                </button>

                <ul width="860" class="thumnail_rail" style="transform: translateX(0px);">  <!-- tHjGe -->
                <c:forEach var="i" items="${img}" varStatus="status">
					<c:choose>
						<c:when test="${i.thumbnail != null}">
							<c:url value="/upload/download.do" var="thumbnail_url">
								<c:param name="file" value="${i.thumbnail}" />
							</c:url>
							<li class="list"><div class="sm_thumnail index${status.index}" style="background-image:url(${thumbnail_url})";></div></li>
						</c:when>
					</c:choose>
				</c:forEach>

                </ul>

                <button class="railBtn_right">  <!-- TcMUB * 2-->
                    <svg width="10" height="16" viewBox="0 0 10 16">
                        <path fill="none" fill-rule="evenodd" stroke="#FFF" d="M2 14l6-6-6-6"></path>
                    </svg>
                </button>
            </div>

			<c:url value="/upload/download.do" var="thumbnail_url">
				<c:param name="file" value="${img[0].thumbnail}" />
			</c:url>
            <div class="giantView" id="target" style="background: url(${thumbnail_url}) center center / contain no-repeat;">  <!-- esRNDG -->
                <button class="giantBtn_left">  <!-- gmzACw *2 -->
                    <svg width="15" height="24" viewBox="0 0 10 16">
                        <path fill="none" fill-rule="evenodd" stroke="#FFF" d="M2 14l6-6-6-6"></path></svg></button>
                <div class="eKXjJb"></div>   <!-- eKXjJb -->
                <button class="giantBtn_right">  <!-- hgppiM *2 -->
                    <svg width="15" height="24" viewBox="0 0 10 16">
                        <path fill="none" fill-rule="evenodd" stroke="#FFF" d="M2 14l6-6-6-6"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>



<!-- 허위매물 신고 -->
      <div class="modal fade modalwit" id="falsehoodmo">
         <div class="modal-content modal-contentwit">
            <div class="modal-header">
                   <h4 class="falhooh4">허위매물 신고</h4>
                   <!-- 닫기버튼 -->
              <button class="btnclose"  data-dismiss="modal">
                 <svg width="30" height="30" viewBox="0 0 32 32">
                    <g fill="none" fill-rule="evenodd" transform="translate(1 1)">
                       <circle class="Circle" cx="15" cy="15" r="15"></circle>
                       <g class="Close" stroke-linecap="round" stroke-width="2">
                          <path d="M19.243 19.243l-8.486-8.486M19.243 10.757l-8.486 8.486"></path>
                       </g>
                    </g>
                 </svg>
              </button>
                </div>
            <div class="modal-body modalbody modalcont" id="modaloutcheck">
			   <img class="sirenmodal" src="/b2/assets/img/ma_img/rmdt/siren.png" >
			   <h4 class="modal-title modal-titlecolor">허위매물을 신고해주세요!</h4>
               <h4 class="modal-title">허위매물 신고를 접수해주시면, 매물 검증 단계를 거친 후</h4>
               <h4 class="modal-title">허위매물 여부를 판정하여 목록에서 삭제등의 조치가 진행됩니다.</h4>
               <br/>
               <pre class="mypageoutpre">
               </pre>
               <div>
            	   <label class="labelss">
            	   		<input type="radio" name="fakeReason" value="1" />
            	   		<span class="checkBox"></span> <span class="checkText checkTextspan checkTextspanma">거래가 완료된 매물</span>
					</label>
					<label class="labelss">
            	   		<input type="radio" name="fakeReason" value="2" />
            	   		<span class="checkBox"></span> <span class="checkText checkTextspan checkTextspanma">가격이 다른 매물</span>
					</label>
					<label class="labelss">
            	   		<input type="radio" name="fakeReason" value="3" />
            	   		<span class="checkBox"></span> <span class="checkText checkTextspan checkTextspanma">사진이 다른 매물</span>
					</label>
					<label class="labelss">
               			<input type="radio" name="fakeReason" value="4" />
               			<span class="checkBox"></span> <span class="checkText checkTextspan checkTextspanma">위치가 다른 매물</span>
					</label>
					<label class="labelss">
               			<input type="radio" name="fakeReason" value="5" />
               			<span class="checkBox"></span> <span class="checkText checkTextspan checkTextspanma">옵션이 다른 매물</span>
					</label>
				</div>

				<h4 class="modal-titlef modal-dd">별방은 상시 검수를 통해 허위매물 근절을 위해 노력중입니다</h4>
               	<h4 class="modal-titlef">이 매물이 허위매물로 판정된 경우 별방 기프티콘을 선물로 드려요</h4>
               	<h4 class="modal-titlef">허위 신고일 경우 서비스 이용이 제한이 될 수 있습니다</h4>
            </div>
            <input type="hidden" name="roomno" value="${room.roomno}">
			<input type="hidden" name="userno" value="${user.userno}">
            <div class="modal-footer modal-footerhw ">
               <button type="submit" id="modalsubmit" class="btn btn-default falsehoodsubmit" data-dismiss="modal">확인</button>
            </div>
         </div>
      </div>



	<!-- Javascript -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.min.js"></script>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49ad4eb7ef14b56eb0eca723e4dd1eaa"></script>

	<script type="text/javascript">
	var count_heart = ${heartint};

		function delectstar(x) {
			$.ajax({
				url: "delectstar.do",
            	method: "get",
            	data: {"x" : x},
            	success: function(req){
            		console.log(x + "delectstar");
            		console.log(count_heart);
					count_heart -= 1;
					$("#lkct").html(count_heart);
					$("#blueh").html(count_heart);
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
            		count_heart += 1;
        	    	$("#lkct").html(count_heart);
        	    	$("#blueh").html(count_heart);
            	},
            	error : function() {
            		console.log("insertstar발송에러 발생");
				}
			});
		}
	</script>

	<script type="text/javascript">
		/* kakao map API */
		$(function() {
			var lat = ${room.latitude};
			var lng = ${room.longitude};
			var container = document.getElementById('map');
			var options = {
				center : new kakao.maps.LatLng(lat, lng), // 지도의 중심 좌표
				level : 2
			// 지도 확대 레벨
			};

			var map = new kakao.maps.Map(container, options);

			var circle = new kakao.maps.Circle({
				center : new kakao.maps.LatLng(lat, lng), // 원의 중심좌표 입니다
				radius : 30, // 미터 단위의 원의 반지름입니다
				strokeWeight : 2, // 선의 두께입니다
				strokeColor : '#1564f9', // 선의 색깔입니다
				strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle : 'solid', // 선의 스타일 입니다
				fillColor : '#1564f9', // 채우기 색깔입니다
				fillOpacity : 0.3
			// 채우기 불투명도 입니다
			});

			// 지도에 원을 표시합니다
			circle.setMap(map);
		})
	</script>

	<script>
		$(function() {
			/*문의하기 클릭*/
			$(".grml").click(function() {
				// 메시지 내용만 적용하여 확인창 표시
				swal("${user.name}님의 이메일입니다.<br/><br/>${user.email}<br/><br/>*문의에티켓을 지켜주세요.");
				});
			/*확인매물 바의 물음표 클릭*/
			$(".mola").click(function() {
				swal(
					'확인매물이란?<br/>',
					'확인매물은 절차를 모두 통과한 가장 믿을 수 있는 매물정보입니다.<hr /> 방주인 확인 -<br><br>방주인이 직접 거래가격, 위치, 중개사무소까지 확인했어요! <hr /> 인증날짜 확인 - <br><br>인증날짜를 확인하세요.<br>최근에 인증된 방이 더욱 믿을 수 있어요!',
					'question');
			});
		});
	</script>

	<script src="https://d3js.org/d3.v5.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/plugin/billboard.min.js"></script>
	<script type="text/javascript">
		var chart = bb.generate({
			data : {
				x : "x",
				columns : [ [ "x", "가격", "관리비", "옵션", "편의시설", "교통" ],
						[ "data1", 70, 50, 50, 80, 70 ]
				// ["data2", 130, 100, 30, 200, 80],
				// ["data3", 230, 153, 85, 300, 250]
				],
				type : "radar",
				labels : true
			},
			radar : {
				axis : {
					max : 100
				},
				level : {
					depth : 1
				},
				direction : {
					clockwise : true
				},
				line : {
					connectNull : true,
					classes : [ "line-class1", "line-class2" ]
				},

			},
			bindto : "#radarChart"
		});

		chart.data.colors({
			data1 : "#0040FF",
		});
	</script>

	<script type="text/javascript">
		$(function() {
			$(".more").click(
				function(e) {
					$("#smallexplan > div").toggleClass('explan-on explan-off', 400);
				});
		});
	</script>

	<script>
      /* 좋아요 클릭 -> 하트 색 변경 */
      $(function() {
         $(".recent-div9").click(function(e) {
            var loginInfouser = "${loginInfo.userno}";
               if(loginInfouser != "") {
                  $(this).toggleClass('on off');
                  var onoff = $(this).hasClass("on");
                  console.log(onoff);
                  $(".recent-div8").toggleClass('on off');
                  var onoffh = $(".recent-div8").hasClass("on");
                  if (onoffh == true) {
                     $('.recent-div8').css('background', 'url(../../img/ma_img/rmdt/like.svg) center center/cover;');
                  }else {
                     $('.recent-div8').css('background', 'url(../../img/ma_img/rmdt/like-on.svg) center center/cover;');
                  }
                  console.log(onoffh);
                  var a = $(this).prev().val();
                  console.log(a);
                   if(onoff == true) {
                      insertstar(a);
               }else {
                  delectstar(a);
                  }
               }
         })
      });
   </script>

   <script>
      /* 파란색 헤더바 좋아요 클릭 -> 하트 색 변경 */
      $(function() {
         $(".recent-div8").click(function(e) {
            var loginInfouser = "${loginInfo.userno}";
            if(loginInfouser != "") {
                  $(this).toggleClass('on off');
                  var onoff = $(this).hasClass("on");
                  console.log(onoff);
                  $(".recent-div9").toggleClass('on off');
                  var onoffh = $(".recent-div9").hasClass("on");
                  if (onoffh == true) {
                     $('.recent-div9').css('background', 'url(../../img/ma_img/rmdt/like.svg) center center/cover;');
                  }else {
                     $('.recent-div9').css('background', 'url(../../img/ma_img/rmdt/like-on.svg) center center/cover;');
                  }
                  var a = $(this).prev().val();
                  console.log(a);
                   if(onoff == true) {
                      insertstar(a);
               }else {
                  delectstar(a);
                  }
               }
         })
      });
   </script>

	<!-- 평수 바꾸기 -->
	<script type="text/javascript">
		$(function() {
			v1 = ${room.area};
			result = v1;

			$(".chbt").click(function(e) {

				if (result == v1) {
					result = v1 / 3.3;
					$('#chnum').html("<span>" + result.toFixed(1) + "평</span>");
					$('.chbt>span').html("㎡");

				} else {
					result = v1;
					$('#chnum').html("<span>" + result.toFixed(1) + "㎡</span>");
					$('.chbt>span').html("평");
				}
			});
		});
	</script>

		<!-- 평수 미터제곱 같이 바꾸기2 -->
	<script type="text/javascript">
		$(function() {
			var v1 = ${room.area};
			var v2 = ${info.supplyarea}
			var result = v1;
			var result1 = 0;
			var result2 = 0;

			$(".bHPFKV").click(function(e) {

				if (result == v1) {
					result1 = v1 / 3.3;
					result2 = v2 / 3.3;
					result = v1 / 3.3;
					$('#toggleArea').html("<span>" + result1.toFixed(1) + " / " + result2.toFixed(1) + "평</span>");
					$('.bHPFKV>span').html("㎡");

				} else {
					result = v1
					result1 = v1;
					result2 = v2;
					$('#toggleArea').html("<span>" + result1.toFixed(1) + " / " + result2.toFixed(1) + "㎡</span>");
					$('.bHPFKV>span').html("평");

				}
			});
		});
	</script>

	<!-- 파란색 헤더의 url 복사 -->
	<script>
		$(".ulcp").click(function() {
			$("#link-area").attr("type", "text");
			$("#link-area").select();
			var success = document.execCommand("copy");
			$("#link-area").attr("type", "hidden");
			if (success) {
				swal("링크가 복사되었습니다.");
			}
		});
	</script>

	<!-- 하얀색 헤더의 url 복사 -->
	<script>
		$(".linkimg").click(function() {
			$("#link-area").attr("type", "text");
			$("#link-area").select();
			var success = document.execCommand("copy");
			$("#link-area").attr("type", "hidden");
			if (success) {
				swal("링크가 복사되었습니다.");
			}
		});
	</script>

	<script>
	$(function() {
		/** 브라우저에 대한 스크롤 감지 이벤트 정의 */
		$(window).scroll(
			function() {
				// 스크롤이 맨 끝에 도달했음을 감지하는 조건문
				if ($(window).scrollTop() > 1060) {
					$("#fxed").css("display", "block");
					$("#simsim").css("display", "none");
				} else {
					$("#fxed").css("display", "none");
					$("#simsim").css("display", "block", "min-height", "100px");
				}
		}); // end scroll
	});

	/* 이동하기 기능 */
	$(function() {

		/* 위에 있는 바 */
		function up_fnMove(seq){
	        var offset = $("#location" + seq).offset();
	        $('html, body').animate({scrollTop : offset.top-150}, 300);
	    }

		$("#move1").click(function(){ up_fnMove(1) });
		$("#move2").click(function(){ up_fnMove(2) });
		$("#move3").click(function(){ up_fnMove(3) });
		$("#move4").click(function(){ up_fnMove(4) });

		/* 밑에 있는 바 */
		function dn_fnMove(seq){
	        var offset = $("#location" + seq).offset();
	        $('html, body').animate({scrollTop : offset.top-80}, 300);
	    }

		$(".move1").click(function(){ dn_fnMove(1) });
		$(".move2").click(function(){ dn_fnMove(2) });
		$(".move3").click(function(){ dn_fnMove(3) });
		$(".move4").click(function(){ dn_fnMove(4) });

	});


	</script>

	<script>
	function binary() {

        /* 뿌려줄 String을 배열에 저장 */
        var option = [
        	"<div class='gqtsIc'><div class='dNeTFF'></div><p>에어컨</p></div>",
        	"<div class='gqtsIc'><div class='bisIQz'></div><p>세탁기</p></div>",
        	"<div class='gqtsIc'><div class='ecqNej'></div><p>옷장</p></div>",
        	"<div class='gqtsIc'><div class='gdTorF'></div><p>TV</p></div>",
        	"<div class='gqtsIc'><div class='fuJjGK'></div><p>신발장</p></div>",
        	"<div class='gqtsIc'><div class='gdMhEY'></div><p>냉장고</p></div>",
        	"<div class='gqtsIc'><div class='dQLnLP'></div><p>가스레인지</p></div>",
        	"<div class='gqtsIc'><div class='krFgu'></div><p>인덕션</p></div>",
        	"<div class='gqtsIc'><div class='cnLAIn'></div><p>전자레인지</p></div>",
        	"<div class='gqtsIc'><div class='fkeEgq'></div><p>전자도어락</p></div>",
        	"<div class='gqtsIc'><div class='iAeGhw'></div><p>비데</p></div>",
        	"<div class='gqtsIc'><div class='mCsgX'></div><p>침대</p></div>",
        	"<div class='gqtsIc'><div class='gaOEWf'></div><p>책상</p></div>"
        	];


        /* 받아온 값을 관리비 항목에 넣는다 */
        var num = $("#nice").val();
        var num = ${info.optionitem};

        for (var i=13; i>=0 ; i--) {
            if(num >= Math.pow(2, i-1)){
            	num = num - Math.pow(2, i-1);
                $(".dDctva").append(option[13-i]);
            } // if문
        } // for문
    } // binary함수
    binary();

function binary2() {

            /* 뿌려줄 String을 배열에 저장 */
            var option2 = ["인터넷", "유선TV", "청소비", "수도세", "도시가스", "전기세", "기타"];

            /* 받아온 값을 관리비 항목에 넣는다 */
            //var num2 = ${info.feeitem};
            var num2 = ${info.feeitem};
			var sum = new Array;

            for (var i=7; i>=1 ; i--) {
                if(num2 >= Math.pow(2, i-1)){
                	num2 = num2 - Math.pow(2, i-1);
                	sum += option2[7-i];

                    if(num2 == 0 || i == 1){ break; }
                    sum += ", ";
                } // if문
            } // for문
            sum = "(" + sum + ")";
            $("#apeend_feeitem").append(sum);
        } // binary함수
        binary2();

	</script>


	<script>

	$(function() {
	    /** 링크를 클릭한 경우 */
	    $("#bigview").click(function(e) {
	        e.preventDefault();             // 페이지 이동 방지
	        $(".background_layer").fadeIn(0);   // 배경 레이어를 화면에 표시한다.
	    });

		/** (화면에 표시된) 배경 레이어를 클릭한 경우 */
		$(".img_close").click(function() {
		     $(".background_layer").fadeOut(0);       // 배경 레이어의 숨김
		});
	});

	/* 썸네일 슬라이드 */
	$(function() {
		var len = $(".list").length * 140 + ($(".list").length - 1) * 4;
	    $(".thumnail_rail").css('width',len + "px");

	    var location = 0;

	    $(".railBtn_left").click(function() {
	    	location = location + 288;
	    	if ( location > 0){
	    		location = 0;
	    	}
	    	$(".thumnail_rail").css('transform',"translateX(" + location + "px)");
	    });

	    $(".railBtn_right").click(function() {

	    	location = location - 288;
	    	if (location < -len + 932) {
	    		location = -len + 932;
	    	}
	    	$(".thumnail_rail").css('transform',"translateX(" + location + "px)");

	    });

	    if( $(".list").length < 7 ){
	    	$(".railBtn_right").attr('disabled', true);
	    }

	});


	/* 큰 이미지 띄워주기 */
	$(function() {

		// 가장 처음 선택하지 않았을 때
		var img = $(".sm_thumnail:eq(0)").parents('li');

		var pass = "";

        $(".sm_thumnail").click(function(e) {
        	img = $(this).parents('li'); // 클릭한 요소의 src 속성값 가져오기
        	pass = img;

            $("#target").css('background-image', img.children("div").css('background-image'));
        });

        $(".giantBtn_left").click(function(e) {
        	// img = 해당 div의 부모 요소가 들어가있다
            if (pass == "") {
            	pass = img;
            }
        	if (pass != null){
            	pass2 = $(".list:first-child").children("div").css('background');
            	if( pass.children("div").css('background') == pass2 ) {
            		pass = $(".sm_thumnail:eq(0)").parents('li');
                } else {
                	pass = pass.prev();
                }
            }

            var val = pass.children("div").css("background-image");
            $("#target").css('background-image', val);
        });


        $(".giantBtn_right").click(function(e) {

        	// img = 해당 div의 부모 요소가 들어가있다
            if (pass == "") {
            	pass = img;
            }

            if (pass != null){
            	pass2 = $(".list:last-child").children("div").css('background');
            	if( pass.children("div").css('background') == pass2 ) {
            		pass = $(".list:last-child");
                } else {
                	pass = pass.next();
                }
            }

            console.log(pass);

            var val = pass.children("div").css("background-image");
            $("#target").css('background-image', val);
        });
	});
 	$(document).ready(function(){ //인기있는 방 AJAX
 		var chart_roomno = ${room.roomno};
 		$.ajax({
 			url:"${pageContext.request.contextPath}/chart",
 			data:{"chartdata": chart_roomno},
 			type: "GET",
 			success:function(data){
 				var chart = bb.generate({
 					data : {
 						x : "x",
 						columns : [ [ "x", "가격", "관리비", "옵션", "편의시설", "교통" ],
 								[ "data1", data.item.chart1, data.item.chart2, data.item.chart3, data.item.chart4, data.item.chart5 ]
 						// ["data2", 130, 100, 30, 200, 80],
 						// ["data3", 230, 153, 85, 300, 250]
 						],
 						type : "radar",
 						labels : true
 					},
 					radar : {
 						axis : {
 							max : 100
 						},
 						level : {
 							depth : 1
 						},
 						direction : {
 							clockwise : true
 						},
 						line : {
 							connectNull : true,
 							classes : [ "line-class1", "line-class2" ]
 						},

 					},
 					bindto : "#radarChart"
 				});

 				chart.data.colors({
 					data1 : "#0040FF",
 				});
		    },
		    error: function(data) {
		        console.log(data);
		    }
 		});
 	});
	</script>

	<!-- 허위매물 신고하기 -->
	<script type="text/javascript">
	$(function() {
        $("#modalsubmit").click(function(e) {
            e.preventDefault;
            var userno = ${user.userno};    // 방주인의 회원번호
            var roomno = ${room.roomno};    // 방 번호
            var reason = $("input[name=fakeReason]:checked").val(); // 신고 사유
            var singo;                      // 신고한 회원번호 (현재 로그인중인 회원)
            var loginInfo = "${loginInfo.userno}";
            if (loginInfo == "") { singo = 0; }
            else { singo = "${loginInfo.userno}"; }

            var fake_singo = "${fake.singo}";    // 이미 신고한 회원인지 구별하기

            if (!reason) {
                alert("신고 사유를 선택해주세요.");
            } else if (fake_singo == singo) {
                alert("같은 매물은 한 번만 신고할 수 있습니다.");
            } else{
                $.ajax({
                    type: "POST",
                    data: {"userno": userno, "roomno": roomno, "reason": reason, "singo": singo},
                    url: "${pageContext.request.contextPath}/modal/fake_ok.do",
                    success: function(data){
                          alert("신고가 완료되었습니다.");
                          window.location.reload();
                    },
                    error: function(data) {
                        console.log(data);
                    }
                });
            }
        });
    });
	</script>

</body>
</html>
