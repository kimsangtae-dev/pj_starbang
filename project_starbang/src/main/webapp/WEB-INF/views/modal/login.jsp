<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/modal_css/login.css">
</head>
<div class="modal-content love">
    <!-- 닫기버튼 -->
    <button class="btnclose" data-dismiss="modal">
        <svg width="30" height="30" viewbox="0 0 32 32">
            <g fill="none" fill-rule="evenodd" transform="translate(1 1)">
                <circle class="Circle" cx="15" cy="15" r="15"></circle>
                <g class="Close" stroke-linecap="round" stroke-width="2">
                    <path d="M19.243 19.243l-8.486-8.486M19.243 10.757l-8.486 8.486"></path>
                </g>
            </g>
        </svg>
    </button>
    <!-- 상단 전체박스 시작 -->
    <div class="topbox-div">
        <!-- 제목 -->
        <h3 class="login-h3">
            <b>로그인</b>
        </h3>
        <!-- 로그인윗부분 -->
        <div class="login" id="">
            <form method="post" action="${pageContext.request.contextPath}/modal/login_ok.do">
                <!-- 아이디 / 패스워드 -->
                <input autocomplete="off" class="idpass" type="text" placeholder="아이디" name="email" id="loginid" value="" /> <input autocomplete="off" class="idpass" type="password" placeholder="비밀번호" name="passwd" value="" />
                <div class="checkbox-d">
                    <!-- 아이디저장 - 체크박스 -->
                    <label class="checkbox-l clearfix" size="22"> <input type="checkbox" class="checkbox-i" name="isSaved" id="isSaved" value=""> <span class="checkbox-s"></span>
                        <p class="checkbox-p">아이디 저장</p>
                    </label>
                    <!-- 비밀번호 찾기 -->
                    <a href="<%=request.getContextPath()%>/modal/pwd.do" data-dismiss="modal" data-toggle="modal" data-target="#passwdModal" class="findpw-a">비밀번호 찾기</a>
                </div>
                <button class="login-button" type="submit" id="loginbtn">
                    <span class="login-span">로그인</span>
                </button>
            </form>
            <div class="joinus-div">
                <p>
                    아직 회원이 아니세요? <a href="<%=request.getContextPath()%>/modal/agree.do" id="join" data-dismiss="modal" data-toggle="modal" data-target="#agreeModal">이메일로 회원가입</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/jquery.cookie.js"></script>

<!-- ID저장하기 쿠키 -->
<script type="text/javascript">
    $(function() {
        //최초 쿠키에 login_id라는 쿠키값이 존재하면
        var login_id = $.cookie('loginid');
        if (login_id != undefined) {
            //아이디에 쿠키값을 담는다
            $("#loginid").val(login_id);
            //아이디저장 체크박스 체크를 해놓는다
            $("#isSaved").prop("checked", true);
        }

        //로그인 버튼 클릭시
        $("#loginbtn").click(function() {
            //아이디 미입력시
            if ($.trim($("#loginid").val()) == "") {
                alert("아이디를 입력하세요");
                return;
                //아이디 입력시
            } else {
                //아이디저장 체크되어있으면 쿠키저장
                if ($("#isSaved").prop("checked")) {
                    $.cookie('loginid', $("#loginid").val());
                    //아이디저장 미체크면 쿠키에 정보가 있던간에 삭제
                } else {
                    $.removeCookie("loginid");
                }
            }
        })
    })
</script>
<!-- ID저장하기 끝 -->
<!-- shift+enter 새창 뜨는 것 막기 -->
<script>
    $(document).on('keypress', function(event) {
        if (event.which === 13 && event.shiftKey) {
            alert('SHIFT키가 눌렸습니다.');
            return false;
        }
    });
</script>
<!-- 끝 -->