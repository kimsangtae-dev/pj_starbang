<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../assets/inc/meta.jsp"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/etc/reset.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/ma_css/ma_mypager.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.css">

<!-- Javascript -->
   <script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
   <script src="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.all.min.js"></script>
   <!-- 모달창 -->
   <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
$(function () {
			$("#ex_file").change(function(e) {
				$("#inputsubmit").click();
			});
		});
</script>

</head>
<body>
   <!-- 상단 영역 -->
   <%@ include file="../assets/inc/ma_top.jsp"%>

    <!-- 중앙 영역 -->
         <div id="content" class="container box">
            <div class="h">
               <h1 class="h1">MY별방</h1>
            </div>
            <div class="div2">
                        <!-- 아직 프로필 수정은 새로고침과 window에서 설정을 해주어야 실행된다 -->
              <div class="imgs_wrap imgupload" id="imgupload" >
        		<c:choose>
					<c:when test="${loginInfo.profile_img == null}">
						<img src="${pageContext.request.contextPath}/assets/img/ma_img/mypa.png" id="proflie">
					</c:when>
					<c:when test="${loginInfo.profile_img != null}">
                        <c:url value="/upload/download.do" var="thumbnail_url">
                            <c:param name="file" value="${loginInfo.profile_img}" />
                        </c:url>
						<img src="${thumbnail_url}" id="proflie" />
						<!-- "${pageContext.request.contextPath}/${fn:substring(output.profile_img ,63, fn:length(output.profile_img))}" -->
					</c:when>
				</c:choose>
       		</div>

       		<form method="post" action="${pageContext.request.contextPath}/main/Profileupload_ok.do" enctype="multipart/form-data">
	       		<div class="div2">
	    			<div class="filebox">
	                	<label for="ex_file">프로필 사진 변경
	               		<input type="file" id="ex_file" name="profile_img" >  <!-- onchange="handleFiles(this.files)" -->
	               		<input type="submit" value="보내기" id="inputsubmit" style="display:none;" ></label>
	            	</div>
	            </div>
            </form>
            </div>
            <br/>
            <div id="textcontent">
               <h3 class="h31">본인 성명</h3>
	               <input type="hidden" value="${loginInfo.userno}" id="userno" >
	               <input type="hidden" id="nowmyname" value="${loginInfo.name}">
	               <input type="text" id="myname" name="myname" value="${loginInfo.name}" class="input" >
               <h3 class="h32">이메일주소</h3>
					<input type="hidden" id="nowemail" value="${loginInfo.email}">
					<input type="text" name="email" id="email" disabled value="${loginInfo.email}" class="emailmypage">
					<button type="button" class="btn btn-default focse ponbutton" id="reemail">변경</button>
               <button type="button" class="btn btn-default focse ponbutton reemailaut" id="reemailaut">인증</button>
               <div id="emailinumberdiv">
                  <input type="number" name="emailinumber" id="emailinumber" class="emailinumber emailmypage">
                  <button type="button" class="btn btn-default focse reemailinumber" id="reemailinumber">인증번호확인</button>
               </div>
               <h3 class="h33">휴대폰 번호</h3>
               <input type="hidden" id="nowallpon" value="${loginInfo.tel}" >
                <select class="pon input" name="pont1" id="pon1" value="${fn:substring(loginInfo.tel,0,3)}" disabled >
					<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="017" >017</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select> -
               <input type="number" name="pont2" id="pon2" value="${fn:substring(loginInfo.tel,4,8)}" disabled class="pon input" onkeydown="javascript: return event.keyCode == 69  ? false : true"> -
               <input type="number" name="pont3" id="pon3" value="${fn:substring(loginInfo.tel,9,13)}" disabled class="pon input" onkeydown="javascript: return event.keyCode == 69 ? false : true">
               <button type="button" class="btn btn-default focse ponbutton" id="repon">변경</button>
               <h3 class="h34">비밀번호</h3>
               <input type="hidden" value="${loginInfo.passwd}" id="pwd" >
               <input type="passwd" name="pwd1" id="pwd1" class="pwd input" placeholder="현재비밀번호를 입력하세요">
               <br/>
               <input type="passwd" name="pwd2" id="pwd2" class="pwd input" placeholder="변경될 비밀번호를 입력하세요" >
               <br/>
               <input type="passwd" name="pwd3" id="pwd3" class="pwd2 input" placeholder="변경될 비밀번호를 한 번 더 입력하세요" >
               <br/>
            </div>
            <hr class="hr" />
            <button type="reset" id="resert" class="btn btn-default focse" onclick="location='${pageContext.request.contextPath}/'">취소</button>
            <button type="submit" id="submitedit" class="btn btn-default focse hwmyp">확인</button>
            <p class="rhdrks"></p>
            <button id="out" class="btn btn-link bot outall" data-toggle="modal" data-target="#outall">회원탈퇴</button>
            <p class="rhdrks2"></p>
         </div>

         <!-- 하단 영역 -->
   <%@ include file="../assets/inc/ma_bottom.jsp"%>

   <!-- 모달창 -->
   <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>
   <script type="text/javascript">
   $(function() {
       /** 변경 버튼 */
      $('#reemail').one("click", function() {
         var reemail = document.getElementById('reemail');
         var email = document.getElementById('email');
         var reemailinumber = document.getElementById("reemailinumber");
         var emailinumber = document.getElementById("emailinumber");
         var emailinumberdiv = document.getElementById("emailinumberdiv");
         var reemailaut = document.getElementById("reemailaut");
         /**email.readonly = true; */

         $reemail = $('#email').attr('disabled', false);
         reemailinumber.style.display = 'block';
         emailinumber.style.display = 'block';
         emailinumberdiv.style.height = '60px';
         $reemail = $('#reemail').css("display", "none");
         $reemailaut = $('#reemailaut').css('display', "inline-block");
      });

      /** 랜덤값 함수 */
		function random() {
			var num = Math.floor(Math.random() * 10);
			return num;
		}

		var auth = "";

		for (var i = 0; i < 6; i++) {
			auth += random();
		}

		/** 이메일인증확인창 */
		$("#reemailinumber").click(function() {
			var user = $('#emailinumber').val();
			if (auth == user) {
				alert("인증되었습니다");
			} else {
				alert("인증번호를 다시 확인해 주세요");

			}
		});

       $('#reemailaut').on("click", function() {
    	   var email = $("#email").val();
    	   if (!regex.email('#email', '이메일 형식에 맞춰서 입력해주세요.')) {return false;}
			alert("새로운 이메일에 인증번호를 발송했습니다");
			$.ajax({
				url : "mypageema.do",
				type : 'POST',
				data : {
					"email" : email,
					"auth" : auth
				},
				success : function(data) {
					alert(allemail + "으로 메일이 발송되었습니다");
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log("이메일발송에러 발생~~ \n" + textStatus + " : " + errorThrown);
					self.close();
				}
			});
      });

       /** 휴대폰 번호 바꿈 */
      $("#repon").click(function(e) {
         var repon = document.getElementById('repon');
         var pon1 = document.getElementById('pon1');
         var pon2 = document.getElementById('pon2');
         var pon3 = document.getElementById('pon3');

         $repon = $('#pon1').attr('disabled', true);
         $repon = $('#pon1').attr('disabled', false);

         $repon = $('#pon2').attr('disabled', true);
         $repon = $('#pon2').attr('disabled', false);

         $repon = $('#pon3').attr('disabled', true);
         $repon = $('#pon3').attr('disabled', false);

      });



      $('#modal').modal("hide"); //닫기

      var myname = document.getElementById('myname');
      var mynamevalue = $('#myname').val();

      /** 회원  수정하기 */
		$("#submitedit").click(function() {
			/** 이름 검사 */
			var nowmyname = $('#nowmyname').val(); // 유저 이름
			var myname = $('#myname').val(); // 유저 이름
			if(nowmyname != myname) {
				if (!regex.value('#myname','이름을 입력하세요.')) {return false;}
				if (!regex.kor('#myname','이름은 한글만 입력 가능합니다.')) {return false;}
				if (!regex.min_length('#myname', 2, '이름은 최소 2자 이상 입력 가능합니다.')) {return false;}
			}
			/** 이메일 검사 */
			var nowemail = $('#nowemail').val(); // 유저 이메일
			var email = $('#email').val(); // 유저 이메일
			var user = $('#emailinumber').val(); // 유저 이메일인증번호
			if (nowemail != email) {
				if (!regex.value('#email','이메일을 입력하세요.')) {return false;}
				if (!regex.email('#email', '이메일 형식에 맞춰서 입력해주세요.')) {return false;}
				if (!regex.value('#emailinumber', '인증번호를 입력하세요.')) { return false; }
			        if (user != auth) {
			        	alert("인증번호를 다시 입력해주세요.");
						return false;
					}
			}
			/** 휴대폰 검사 */
			var nowallpon = $('#nowallpon').val();
			var pon1 = $('#pon1').val(); // 유저 휴대폰1pon1
			var pon2 = $('#pon2').val(); // 유저 휴대폰2
			var pon3 = $('#pon3').val(); // 유저 휴대폰3
			var allpon = pon1 + "-" + pon2 + "-" + pon3; // 유저 all휴대폰
			if (nowallpon != allpon) {
				if (!regex.value('#pon1', '휴대폰번호를 입력하세요.')) {return false;}
				if (!regex.value('#pon2', '휴대폰번호를 입력하세요.')) {return false;}
				if (!regex.value('#pon3', '휴대폰번호를 입력하세요.')) {return false;}
				if (!regex.max_length('#pon2', 4, '휴대폰번호는 최소 4자 이상 입력 가능합니다.')) {return false;}
				if (!regex.max_length('#pon3', 4, '휴대폰번호는 최소 4자 이상 입력 가능합니다.')) {return false;}
				
			}
			/** 비밀번호 검사 */
			var pwd = $('#pwd').val();
			var pwd1 = $('#pwd1').val(); // 유저 구비밀번호
			var pwd2 = $('#pwd2').val(); // 유저 신비밀번호
			var pwd3 = $('#pwd3').val(); // 유저 신비밀번호확인
			if ($('#pwd1').val() != "") {
				if ($('#pwd').val() != $('#pwd1').val()) {
					alert("변경전 비밀번호를 다시 입력해주세요.");
					return false;
				}
				if (!regex.value('#pwd2','새로운 비밀번호를 입력하세요.')) {return false;}
				if (!regex.value('#pwd3','새로운 비밀번호를 다시 입력하세요.')) {return false;}
				if (!regex.min_length('#pwd2', 4, '비밀번호는 최소 4자 이상 입력 가능합니다.')) {return false;}
				if (!regex.compare_to('#pwd2', '#pwd3', '비밀번호 확인이 잘못되었습니다.')) {return false;}
				pwd = pwd2;
			}
			


			if ($('#nowmyname').val() == $('#myname').val() && $('#nowemail').val() == $('#email').val() && nowallpon == allpon && $('#pwd1').val() == "") {
				alert("바뀐 정보가 없습니다.")
				return false;
			}else {
				nowmyname = myname;
				nowemail = email;
				nowallpon = allpon;
			}


		var userno = $('#userno').val(); // 유저넘버
		var d = new Date();
		var noweditdate = d.getFullYear() + "-" + d.getMonth() + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
			$.ajax({
				url:"mypageedit.do",
				type:'POST',
		    	data: {"userno" : userno,
		    		"nowmyname" : nowmyname,
		    		"nowemail" : nowemail,
		    		"nowallpon" : nowallpon,
		    		"pwd" : pwd},
				success:function(data){
					alert("정보가 수정되었습니다.");
					console.log(userno + myname + proflie + email + allpon + "비밀번호 수정" + pwd + "데이터 수정완료");
		        	var http = "${pageContext.request.contextPath}/main/mypage.do"
						location.replace(http);
		    	},
		    	error:function(jqXHR, textStatus, errorThrown){
		    		console.log("mypagesubmit회원수정 에러 발생~~ \n" + textStatus + " : " + errorThrown);
		    		self.close();
	        	}
	    	});
		}); //$("#mypagesubmit").click(function() {

   });

	</script>
	
	<!-- 1. 전화번호 4자리 남기기 로직 -->
<script>
    $(function() {
        function substring(target) {
            $(target).keyup(function() {
                var value = $(this).val(); // 입력값을 가져온다.
                if (value.length >= 4) { // 글자수가 4자 이상이 되면?
                    var input = value.substring(0, 4); // 4자만 남겨놓고 자른다.
                    $(this).val(input); // 잘라낸 값을 다시 설정한다.
                    $(target).focus(); // 포커스 이동
                } // end if
            }); // end keyup event
        }

        substring($('#pon2'));
        substring($('#pon3'));

    });
</script>
<!-- 끝 -->

   <script type="text/javascript">
   $(function() {
	   $("#modalsubmit").click(function() {
			var outtextarea = $('#outtextarea').val();
			//alert(outtextarea);
			if (!regex.value('#outtextarea', '탈퇴 이유를 입력하세요.')) {return false;}
			if (outtextarea.trim() == "") {
				alert("탈퇴 이유를 입력하세요.");
				return false;
			}
			if ($("input:checkbox[id='outokinput']").is(":checked") == false) {
				alert("안내사항에 대해 동의해주세요.");
				return false;
           }
   	  	$.ajax({
				url:"mypagedelect.do",
				type:'POST',
				data: {"outtextarea" : outtextarea},
   	  		success:function(data){
   	  				console.log(outtextarea + "데이터 삭제");
					var http = "${pageContext.request.contextPath}/"
					location.replace(http);
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log("mypagedelect회원수정 에러 발생~~ \n" + textStatus + " : " + errorThrown);
					self.close();
				}
	        });
		});
   });
   </script>

      <!-- 탈퇴 -->
      <div class="modal fade modalwit" id="outall">
         <div class="modal-content modal-contentwit">
            <div class="modal-header">
                   <h4>회원탈퇴</h4>
                </div>
            <div class="modal-body modalbody modalcont" id="modaloutcheck">
               <h4 class="modal-title">회원탈퇴를 신청하기전에 아래 안내 사항을 한번 더 확인해주세요.</h4>
               <br/>
               <pre class="mypageoutpre">
1. 회원 탈퇴 시, 현재 로그인된 아이디는 즉시 탈퇴 처리됩니다.
2. 회원 탈퇴 시, 회원 전용 웹 서비스 이용이 불가합니다.
3. 탈퇴 시 회원 정보 및 찜 서비스, 등록한 게시물 이용 기록이 모두 삭제됩니다.
4. 회원 정보 및 서비스 이용 기록은 모두 삭제되며, 삭제된 데이터는복구되지 않습니다.
5. 광고를 위한 매물이 등록되어 있을 경우, 탈퇴 시 모든 정보는 삭제 처리됩니다.
               </pre>
               <textarea rows="10" cols="64" placeholder="탈퇴사유를 써주세요" class="outtextarea" id="outtextarea"></textarea>
               <input type="hidden" id="hiddentext">
               <!-- <button onClick="action();" class="actionbutton"><img src="ma_assets/ma_img/eede.png" width="16px" id="modelcheck" class="buttonimg"></button> -->
               <label>
               		<input type="checkbox" name="room-type" value="oneroom" id="outokinput" />
               		<span class="checkBox"></span> <span class="checkText checkTextspan">안내사항을 모두 확인하였으며, 이에 동의합니다.</span>
				</label>
               <!-- <p class="modelpp" >안내사항을 모두 확인하였으며, 이에 동의합니다.</p> -->
            </div>
            <div class="modal-footer modal-footerhw ">
               <button type="button" id="modalsubmit" class="btn btn-default btnmodaloutsubmit" >확인</button>
               <!-- data-dismiss="modal" -->
            </div>
         </div>
      </div>

</body>


</html>

