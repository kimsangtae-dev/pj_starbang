package project.star.b2.controllers;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.FakeRoom;
import project.star.b2.model.Gallery;
import project.star.b2.model.Price;
import project.star.b2.model.User;
import project.star.b2.service.FakeService;
import project.star.b2.service.GalleryService;
import project.star.b2.service.PriceService;
import project.star.b2.service.RoomService;
import project.star.b2.service.UserService;

@Controller
@Slf4j
public class ModalController {
    /** WebHelper 주입 */
    @Autowired
    WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired
    RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired
    UserService userService;
    @Autowired
    RoomService roomService;
    @Autowired
    FakeService fakeService;
    @Autowired
    GalleryService galleryService;
    @Autowired
    PriceService priceService;

    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;

    /********************************************************************
     * 동의하기
     *******************************************************************/
    @RequestMapping(value = "/modal/agree.do", method = RequestMethod.GET)
    public ModelAndView agree() {

        return new ModelAndView("modal/agree");
    }

    /********************************************************************
     * 회원가입 폼
     *******************************************************************/

    @RequestMapping(value = "/modal/join.do", method = RequestMethod.GET)
    public ModelAndView join() {

        return new ModelAndView("modal/join");
    }

    /********************************************************************
     * 회원가입 폼에 대한 action
     *******************************************************************/

    @RequestMapping(value = "/modal/join_ok.do", method = RequestMethod.POST)
    public ModelAndView join_ok(Model model) {

        /** 날짜 시간 포맷 선언 */
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar time = Calendar.getInstance();

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        String name = webHelper.getString("name");
        String email = webHelper.getString("email");
        String email1 = webHelper.getString("email1");
        String passwd = webHelper.getString("passwd");
        String tel = webHelper.getString("tel");
        String tel1 = webHelper.getString("tel1");
        String tel2 = webHelper.getString("tel2");
        String format_time1 = format1.format(time.getTime());
        /* String regdate = webHelper.getString("regdate"); */
        String editdate = webHelper.getString("editdate");
        String profile_img = webHelper.getString("profile_img");
        String emailtol = email + "@" + email1;
        String teltol = tel + "-" + tel1 + "-" + tel2;

        /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        User input = new User();
        input.setName(name);
        input.setEmail(emailtol);
        input.setPasswd(passwd);
        input.setTel(teltol);
        input.setRegdate(format_time1);
        input.setEditdate(editdate);
        input.setProfile_img(profile_img);

        try {

            // 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            userService.addUser(input);

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) 결과를 확인하기 위한 페이지 이동 */
        // 저장 결과를 확인하기 위해서 데이터 저장시 생성된 PK값을 상세 페이지로 전달해야 한다.
        String redirectUrl = contextPath + "/";

        return webHelper.redirect(redirectUrl, "저장되었습니다.");
    }

    /********************************************************************
     * 로그인
     *******************************************************************/
    @RequestMapping(value = "/modal/login.do", method = RequestMethod.GET)
    public ModelAndView login(Model model, HttpServletRequest request) {

        return new ModelAndView("modal/login");
    }

    /********************************************************************
     * 로그인 action폼
     *******************************************************************/
    @RequestMapping(value = "/modal/login_ok.do", method = RequestMethod.POST)
    public ModelAndView login_ok(Model model, HttpServletRequest request) {

        // 1) 사용자가 입력한 파라미터 수신 및 필수값 검사 */
        String email = webHelper.getString("email");
        String passwd = webHelper.getString("passwd");

        // 필수 값의 존재여부 검사
        if (email == null || email.contentEquals("")) {
            return webHelper.redirect(null, "아이디를 입력하세요.");
        }

        if (passwd == null || passwd.contentEquals("")) {
            return webHelper.redirect(null, "비밀번호를 입력하세요.");
        }

        /*
         * if (email.equals("1@") && passwd.equals("1")) {
         * return webHelper.redirect("/b2/admin/login.do", "관리자로 로그인하세요."); }
         */

        // 2) 사용자가 입력한 값을 Beans에 저장
        User input = new User();
        input.setEmail(email);

        // 조회결과를 저장할 객체 선언
        User output = null;

        try {
            // 데이터 조회
            output = userService.getUserLogin(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /* request 객체를 사용해서 세션 객체 만들기 */
        HttpSession session = request.getSession();

        // 가입된 정보와 DB가 일치하는지 검사 후 세션 생성
        if (passwd.equals(output.getPasswd())) {
            session.setAttribute("loginInfo", output);
        } else {
            return webHelper.redirect(null, "비밀번호가 잘못되었습니다.");
        }

        // 로그인 이전 페이지로 보내주는 처리
        request.getHeader("REFERER");
        String referer = (String) request.getHeader("REFERER");
        return webHelper.redirect(referer, "로그인되었습니다.");
    }

    /********************************************************************
     * 로그아웃 폼
     *******************************************************************/

    @RequestMapping(value = "/modal/login_out.do", method = RequestMethod.GET)
    public ModelAndView login_out(Model model, HttpServletRequest request) {
        // request 객체를 사용해서 세션 객체 만들기
        HttpSession session = request.getSession();

        /* session 삭제 */
        session.removeAttribute("loginInfo");
        
        /* session 무효화 */
        session.invalidate();

        String redirectUrl = contextPath + "/";
        return webHelper.redirect(redirectUrl, "로그아웃 되었습니다.");
    }

    /********************************************************************
     * 중복확인
     *******************************************************************/
    @RequestMapping(value = "/modal/idCheck.do", method = RequestMethod.GET)
    @ResponseBody
    public String idCheck(HttpServletRequest request) throws Exception {

        // 사용자 입력 값 가져오기
        String email = request.getParameter("email");

        // DB에 있는 입력값과 비교하기
        int result = userService.idCheck(email);
        return Integer.toString(result);
    }

    /********************************************************************
     * 비밀번호 찾기 폼
     *******************************************************************/
    @RequestMapping(value = "/modal/pwd.do", method = RequestMethod.GET)
    public ModelAndView pwd() {

        return new ModelAndView("modal/pwd");
    }

    /********************************************************************
     * 찜한방 - 비교하기
     *******************************************************************/
    @RequestMapping(value = "/modal/compare.do", method = RequestMethod.GET)
    public ModelAndView compare() {

        return new ModelAndView("modal/compare");
    }

    /********************************************************************
     * AJAX 호출 (찜한방 - 비교하기)
     *******************************************************************/
    @RequestMapping(value = "/modal/comparelist.do", method = RequestMethod.POST)
    public ModelAndView comparelist(Model model, @RequestParam(value = "checkArray[]") List<String> arrayParams, @RequestParam(value = "userId") String userId) {

        // 파라미터로 받아온 userid 확인용
        System.out.println("=user=");
        System.out.println(userId);

        // 파라미터로 받아온 방 번호들 확인용
        System.out.println("=roomno=");
        for (String hahat : arrayParams) {
            System.out.println(hahat);
        }

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        // Gallery input = new Gallery();
        // input.setRegion_2depth_name(region);

        List<String> list = arrayParams;
        List<Gallery> output = null;
        List<Price> price = null;

        try {
            // 체크된 방번호로 조회
            output = galleryService.getCompareList(list);

            // 체크된 방번호 중 가격 조회
            price = priceService.getCompareList(list);
            log.info("성공 priceService");

        } catch (Exception e) {
            return new ModelAndView("main/wish");
        }

        /** view 화면으로 보여주기 */
        model.addAttribute("output", output);
        model.addAttribute("price", price);
        return new ModelAndView("modal/compare");
    }

    /** 허위매물 신고에 대한 action 페이지 */
    @RequestMapping(value = "/modal/fake_ok.do", method = RequestMethod.POST)
    public ModelAndView fake_ok(Model model) {
        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        int reason = webHelper.getInt("reason");
        int roomno1 = webHelper.getInt("roomno");
        int userno = webHelper.getInt("userno");
        int singo = webHelper.getInt("singo");

        /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        FakeRoom input = new FakeRoom();
        input.setReason(reason);
        input.setRoomno(roomno1);
        input.setUserno(userno);
        input.setSingo(singo);

        try {
            // 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            roomService.addFakeRoom(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) 결과를 확인하기 위한 페이지 이동 */
        // 저장 결과를 확인하기 위해서 데이터 저장시 생성된 PK값을 상세 페이지로 전달해야 한다.
        String redirectUrl = contextPath + "/main/rmdt.do?roomno=" + input.getRoomno();
        return webHelper.redirect(redirectUrl, "저장되었습니다.");
    }

    /********************************************************************
     * 관리자페이지 - 신고사유
     *******************************************************************/
    @RequestMapping(value = "/modal/adminfake.do", method = RequestMethod.GET)
    public ModelAndView fake_check(Model model, HttpServletRequest request) {

        int roomno1 = webHelper.getInt("roomno");

        /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        FakeRoom input = new FakeRoom();
        input.setRoomno(roomno1);

        List<FakeRoom> output = null;

        try {
            // 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            output = fakeService.getFakeList(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        model.addAttribute("output", output);
        return new ModelAndView("modal/adminfake");
    }
}