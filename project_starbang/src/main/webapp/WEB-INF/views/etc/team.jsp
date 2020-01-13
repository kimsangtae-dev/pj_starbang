<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon"
   href="${pageContext.request.contextPath}/assets/ico/logo_bb.png" />
<link rel="apple-touch-icon-precomposed"
   href="${pageContext.request.contextPath}/assets/ico/logo_bb.png" />
<style>
a > img {
   height: 100px;
   margin: 8px 0 12px 40px;
}
        
/* 갤러리 박스 시작 */
/*박스전체*/
.recent-div4 {
   margin: auto;
   width: fit-content;
}

.recent-div5 {
   float: left;
   width: 280px;
   height: 321px;
   background-color: rgb(255, 255, 255);
   position: relative;
   border-radius: 5px;
   margin: 10px;
}

/* 두번째부터 마진추가 */
.margin {
   margin-left: 20px;
}

/* 좋아요를 위한 엄마박스 -relative */
.recent-div6 {
   height: 280px;
   position: relative;
}

/* <div>좋아요 자식박스 -absolute */
.recent-div7 {
   width: 36px;
   position: absolute;
   top: 3px;
   right: 7px;
   z-index: 1;
   cursor: pointer;
}
/* <div>좋아요 - <div> */
.recent-div8 {
   width: 32px;
   height: 30px;
   margin: 0px auto;
}

.recent-div8.on{ background: url(../assets/img/ma_img/like-on.svg) center center / cover; }

/* 부트스트랩에 마진이 들어가있어서 <a> 부분만 초기화시켜주기 */
.recent-div4 p {
   margin: 0px;
}

/* <a> 태그 - <div>이미지 */
.recent-a-div {
   width: 100%;
   height: 186px;
   margin-bottom: 12px;
   background-color: rgb(239, 240, 242);
   position: relative;
   border-radius: 3px;
   overflow: hidden;
}

/* body태그에 이미지가 따로들어가있음 주의 @@*/
.recent-a-div:before {
   content: "";
   height: 100%;
   position: absolute;
   top: 0px;
   right: 0px;
   left: 0px;
}

.recent-a-div:after {
   content: "";
   height: 100%;
   position: absolute;
   top: 0px;
   left: 0px;
   right: 0px;
}

/* <a>태그 - <div>생년월일 박스 */
.recent-a-confirm {
   height: 21px;
   margin-bottom: 3px;
}

.recent-a-confirm span {
   display: inline-block;
   color: rgb(50, 108, 249);
   font-size: 11px;
   white-space: nowrap;
   position: relative;
   bottom: 2px;
}

.bold {
   font-weight: 700;
}

/* <a>태그 - <div>생년월일 박스 - <div>인박스 */
.recent-a-confirm-div {
   display: inline-block;
   height: 21px;
   line-height: 19px;
   vertical-align: top;
   padding: 0px 5px;
   border-width: 1px;
   border-style: solid;
   border-color: rgb(168, 193, 252);
   border-image: initial;
   border-radius: 2px;
}

/* <a>태그 - <p>방 종류 */
.recent-a-p1 {
   width: 100%;
   color: rgb(102, 102, 102);
   font-size: 12px;
   font-weight: 300;
   line-height: 20px;
   white-space: nowrap;
   text-overflow: ellipsis;
   overflow: hidden;
}

/* <a>태그 - <p>lent방식 / 금액 */
.recent-a-p2 {
   color: rgb(34, 34, 34);
   font-size: 20px;
   font-weight: 700;
   line-height: 25px;
   margin: 3px 0px 6px !important;
}

/* <a>태그 - <p>lent방식 / 금액 - <span> */
.recent-a-p2 span {
   vertical-align: middle;
}

/* <a>태그 - 3th, 4th <p> */
.recent-a-p34 {
   width: 100%;
   color: rgb(102, 102, 102);
   font-size: 14px;
   font-weight: 300;
   line-height: 20px;
   white-space: nowrap;
   text-overflow: ellipsis;
   overflow: hidden;
}

.intro {
   display: inline-block;
   font-size: 40px;
   line-height: 100px;
   position: absolute;
   top: 18px;
   left: 200px;
}

.recent-a-div img {
	width: 280px;
    height: 186px;
}
</style>
<title>팀소개</title>
</head>

<body>
<a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/assets/ico/logo_blue.png"></a>
<span class="intro">팀원소개</span>

   <!-- 갤러리 전체 박스 -->
   <div class="recent-div4">
   
      <!-- 각각 갤러리 시작 -->
      <!-- 1번째 갤러리 시작 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/4.jpg"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>최근본방 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀장</p>
            <p class="recent-a-p2">
               <span>조수민</span>
            </p>
            <p class="recent-a-p34">닉네임</p>
            <p class="recent-a-p34">07.25</p>
            <p class="recent-a-p34">gju031@gmail.com</p>
         </div>
      </div>
      <!-- 1번째 갤러리 끝 -->

      <!-- 2번째 갤러리 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/3.PNG"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>공실등록 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀원</p>
            <p class="recent-a-p2">
               <span>김기홍</span>
            </p>
            <p class="recent-a-p34">닉네임</p>
            <p class="recent-a-p34">07.30</p>
            <p class="recent-a-p34">frozenof@gmail.com</p>
         </div>
      </div>
      <!-- 두번째 갤러리 끝 -->

      <!-- 3번째 갤러리 시작 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/2.PNG"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>DB 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀원</p>
            <p class="recent-a-p2">
               <span>이명섭</span>
            </p>
            <p class="recent-a-p34">닉네임</p>
            <p class="recent-a-p34">10.09</p>
            <p class="recent-a-p34">narabyeol@gmail.com</p>
         </div>
      </div>
      <!-- 4번째 갤러리 끝 -->

      <!-- 4번째 갤러리 시작 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/6.png"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>세션 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀원</p>
            <p class="recent-a-p2">
               <span>김상태</span>
            </p>
            <p class="recent-a-p34">닉네임</p>
            <p class="recent-a-p34">07.15</p>
            <p class="recent-a-p34">kst1330@gmail.com</p>
         </div>
      </div>
      <!-- 4번째 갤러리 끝 -->
      
      <!-- 5번째 갤러리 시작 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/5.jpg"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>방찾기 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀원</p>
            <p class="recent-a-p2">
               <span>박지원</span>
            </p>
            <p class="recent-a-p34">닉네임</p>
            <p class="recent-a-p34">02.17</p>
            <p class="recent-a-p34">gwonp217@gmail.com</p>
         </div>
      </div>
      <!-- 5번째 갤러리 끝 -->
      
      <!-- 6번째 갤러리 시작 -->
      <div class="recent-div5">
         <div class="recent-div6">
            <!-- 좋아요 버튼 -->
            <div class="recent-div7">
               <div class="recent-div8 on"></div>
            </div>
            <!-- 좋아요 끝 -->
            <!-- 이미지 -->
            <div class="recent-a-div"><img src="${pageContext.request.contextPath}/assets/ico/1.PNG"></div> 
            <!-- 생년월일 div -->
            <div class="recent-a-confirm">
               <div class="recent-a-confirm-div">
                  <span class="bold">주요기능</span> <span>하트 마스터</span>
               </div>
            </div> <!-- 생년월일 끝 -->
            <p class="recent-a-p1">팀원</p>
            <p class="recent-a-p2">
               <span>김수진</span>
            </p>
            <p class="recent-a-p34">만두</p>
            <p class="recent-a-p34">01.29</p>
            <p class="recent-a-p34">wkqk89@gmail.com</p>
         </div>
      </div>
      <!-- 6번째 갤러리 끝 -->

   </div>
   <!--  갤러리 전체박스 끝 -->

</body>
</html>