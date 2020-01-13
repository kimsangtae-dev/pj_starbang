<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../assets/inc/meta_admin.jsp"%>

<!-- css 참조 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/assets/css/ad_css/rmli.css" />

</head>

<body>
	<!-- 상단 영역 -->
	<!-- 공통된 Header 영역 처리를 위한 include 처리 -->
	<div>
		<%@ include file="../assets/inc/ad_header.jsp"%>
		<!-- 중앙 영역 -->
		<div id="content">
			<div>
				<div class="adm-header">
					<h1>방관리</h1>
					<div class="adm">
						<form method="get"
							action="${pageContext.request.contextPath}/admin/rmli.do">
							<div class="input-group">
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-search"></span>
								</span> <input type="search" class="form-control" id="keyword"
									name="keyword" placeholder="이름 종류 방번호 검색" value="${keyword}" /> <span
									class="input-group-btn">
									<button class="btn btn-default" type="submit">검색</button>
								</span>
						</form>
					</div>
					<br>

					<!-- 라디오 버튼 영역 -->
					<div class="box">
						<form method="get"
							action="${pageContext.request.contextPath}/admin/rmli.do">
							<div class="adm-radio">
								<label for="check"></label> <input type="radio"
									class="radiobutton" name='check' value="1" id="checked-item"
									<c:if test="${rememberChecked eq '1'}">checked</c:if>>확인매물
								<input type="radio" class="radiobutton" name='check' value="2"
									id="checked-fake"
									<c:if test="${rememberChecked eq '2'}">checked</c:if>>허위매물
								<input type="radio" class="radiobutton" name='check' value="3"
									id="checked-hidden"
									<c:if test="${rememberChecked eq '3'}">checked</c:if>>숨김매물
								<input type="radio" class="radiobutton" name='check' value="4"
									id="checked-done"
									<c:if test="${rememberChecked eq '4'}">checked</c:if>>거래완료
								<input type="submit" value="확인" class="btn btn-primary">
							</div>
						</form>

						<!-- 버튼 영역 -->
						<div class="adm-btn">
							<input type="button" name="" class="btn btn-success"
								id=confirm-button value="확인매물"> <input type="button"
								name="" class="btn btn-info" id=hidden-room value="방 숨기기">
							<input type="button" name="" class="btn btn-warning"
								id=delete-room value="방 삭제"> <input type="button"
								name="" class="btn btn-danger" id=fake-room value="허위매물">
						</div>
					</div>
				</div>
			</div>

			<!-- 조회 결과 목록을 보여줄 테이블 영역 -->
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th class="text-center"><input type="checkbox" id="all_check"></th>
						<%--체크박스 전체 선택을 위한--%>
						<th class="text-center">방 번호</th>
						<th class="text-center">방 종류</th>
						<th class="text-center">매물 종류</th>
						<th class="text-center">가격대</th>
						<th class="text-center">방 주인</th>
						<th class="text-center">유저번호</th>
						<th class="text-center">확인매물</th>
						<th class="text-center">허위매물신고건수</th>
						<th class="text-center">상태</th>
					</tr>
				</thead>

				<!-- 조회 결과에 따라 분기 처리하여 보여준다-->
				<c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<tr>
							<td colspan="9" align="center">조회결과가 존재 하지 않습니다.</td>
						</tr>
					</c:when>
					<%-- 조회 결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${output}" varStatus="status">
							<%-- 출력을 위해 준비한 유저이름과 위치 --%>
							<c:set var="roomno" value="${item.roomno}" />
							<c:set var="roomtype" value="${item.roomtype}" />
							<c:set var="dealingtype" value="${item.dealingtype}" />
							<c:set var="price" value="${item.price}" />
							<c:set var="name" value="${item.name}" />
							<c:set var="userno" value="${item.userno}" />
							<c:set var="confirmdate" value="${item.confirmdate}" />
							<c:set var="fakecount" value="${item.cnt}" />
							<c:set var="status" value="${item.status}" />

							<%--검색어가 있다면? --%>
							<c:if test="${keyword != ''}">
								<%-- 검색어에 <mark> 태그를 적용하여 형광펜 효과 준비 --%>
								<c:set var="mark" value="<mark>${keyword}</mark>" />
								<%-- 출력을 위해 준비한 유저이름과 위치에서 검색어와 일치하는 단어를 형광펜 효과로 변경 --%>
								<c:set var="roomtype" value="${fn:replace(roomtype, keyword, mark)}" />
								<c:set var="dealingtype" value="${fn:replace(dealingtype, keyword, mark)}" />
								<c:set var="name" value="${fn:replace(name, keyword, mark)}" />
								<c:set var="roomno" value="${fn:replace(roomno, keyword, mark)}" />
							</c:if>

							<tr id="bbbb">
								<td class="text-center"><input type="checkbox" id="aaaa"
									value="${item.roomno}" class="roomlist"></td>
								<td align="center">${roomno}</td>
								<td align="center">${roomtype}</td>
								<td align="center">${dealingtype}</td>
								<c:choose>
                                <%-- 월세인 경우 --%>
                                <c:when test="${item.dealingtype == '월세'}">
                                <fmt:formatNumber value="${item.price}" pattern="#,####" var="eok1"></fmt:formatNumber>
                                <c:set var="patternprice1" value="${fn:replace(fn:replace(eok1, ',', '억'), '0000', '')}" />
                                <td align="center">${patternprice1}만원</td>
                                </c:when>
                                <%-- 전세 혹은 매매인 경우 --%>
                                <c:otherwise>
                                <fmt:formatNumber value="${item.price}" pattern="#,####" var="eok2"></fmt:formatNumber>
                                <c:set var="patternprice2" value="${fn:replace(fn:replace(eok2, ',', '억'), '0000', '')}" />
                                <td align="center">${patternprice2}</td>
                                </c:otherwise>
                                </c:choose>
								<td align="center">${name}</td>
								<td align="center">${userno}</td>
								<td align="center" id="confirmdate">${confirmdate}</td>
								<td align="center"><a href="${pageContext.request.contextPath}/modal/adminfake.do?roomno=${roomno}" data-toggle="modal" data-target="#fakeModal">${fakecount}</a></td>
								<td align="center" id="hidden"><c:choose>
										<c:when test="${status eq '1'}">확인매물</c:when>
										<c:when test="${status eq '2'}">허위매물</c:when>
										<c:when test="${status eq '3'}">숨김매물</c:when>
										<c:when test="${status eq '4'}">거래완료</c:when>
										<c:otherwise>공개</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
	</div>

	<!-- 하단 영역 -->
	<div id="footer">
		<%-- gallery-index --%>
		<div class="gallery-footer">
			<div class="gallery-index">
				<!-- 페이지 번호 구현 -->
				<%-- 이전 그룹에 대한 링크 --%>
				<c:choose>
					<%-- 이전 그룹으로 이동 가능하다면? --%>
					<c:when test="${pageData.prevPage > 0}">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/admin/rmli.do" var="prevPageUrl">
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
						<c:url value="/admin/rmli.do" var="pageUrl">
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="${i}" />
							<c:param name="check" value="${rememberChecked}" />
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
						<c:url value="/admin/rmli.do" var="nextPageUrl">
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="${pageData.nextPage}" />
							<c:param name="check" value="${rememberChecked}" />
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
	</div>

	<!-- Javascript -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			/* 체크박스 전체선택 */
			$("#all_check").change(function() {
				$(".roomlist").prop('checked', $(this).prop('checked'));
			});
		});
		
		/* 확인 버튼 클릭시 */
		$(function() {
			$('#confirm-button').on('click',function() {
				$('#aaaa:checked').each(function() {
					var list = $(this).val(); //체크된 값을 가져오는 함수(다중선택 가능)
					$.ajax({//결과 url
					url : "${pageContext.request.contextPath}/admin/confirm_ok.do",
					data : {user_id : list},
					type : "POST",
					success : function(data) {
						location.reload();
						alert(list+"번 방 확인매물처리 되었습니다.")
					},
					error : function(error,status,request) {
					alert("Error!"+ error+ "request: "+ request+ " status: "+ status);
					},
				});
			});//checked
		})
	}); //end $.ajax;
		
		/* 숨김버튼 클릭시 */
		$(function() {$('#hidden-room').on('click',function() {
			$('#aaaa:checked').each(function() {
				var hidden = $(this).val(); //체크된 값을 가져오는 함수(다중선택 가능)
				$.ajax({//결과 url
				url : "${pageContext.request.contextPath}/admin/hidden_ok.do",
				data : {hidden_id : hidden},
				type : "POST",
				success : function(data) {
					location.reload();
					alert(hidden+"번 방 숨김매물처리 되었습니다.")
				},
				error : function(error,status,request) {
					alert("Error!"+ error+ "request: "+ request+ " status: "+ status);
					},
				});
			});//checked
		})
	}); //end $.ajax;
		
		/* 삭제버튼 클릭시 */
		$(function() {
			$('#delete-room').on('click',function() {
				$('#aaaa:checked').each(function() {
				var delete1 = $(this).val(); //delete가 예약어라서 delete1으로 받음
				$.ajax({//결과 url
				url : "${pageContext.request.contextPath}/admin/delete_ok.do",
				data : {delete_id : delete1},
				type : "POST",
				datatype : 'text',
				success : function(data) {
					location.reload();
					alert(delete1+"번 방 삭제 처리 되었습니다.")
				},
				error : function(error,status,request) {
					alert("Error!"+ error+ "request: "+ request+ " status: "+ status);
					},
				});
			});//checked
		})
	}); //end $.ajax;
	
		/* 허위매물 버튼 클릭시 */
		$(function() {
			$('#fake-room').on('click',function() {
				$('#aaaa:checked').each(function() {
					var delete1 = $(this).val();
					$.ajax({//결과 url
					url : "${pageContext.request.contextPath}/admin/fake_ok.do",
					data : {fake_id : delete1},
					type : "POST",
					success : function(data) {
						location.reload();
						alert(delete1+"번 방 허위매물처리 되었습니다.")
					},
					error : function(error,status,request) {
						alert("Error!"+ error+ "request: "+ request+ " status: "+ status);
						},
					});
				});//checked
			})
		}); //end $.ajax;
	</script>

    <!-- 허위매물용 모달 로더 -->
    <div class="modal fade" id="fakeModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content"></div>
        </div>
    </div>
</body>
</html>