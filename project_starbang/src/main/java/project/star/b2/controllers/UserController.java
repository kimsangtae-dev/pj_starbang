package project.star.b2.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import project.star.b2.helper.PageData;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.User;
import project.star.b2.service.UserService;

@Controller
public class UserController {
    /** WebHelper 주입 */
    @Autowired
    WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired
    RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired
    UserService userService;

    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;

    /**
     * 목록페이지
     */
    @RequestMapping(value = "/user/list.do", method = RequestMethod.GET)
    public ModelAndView list(Model model) {
        /** 1) 필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", ""); // 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 10; // 한 페이지당 표시할 목록 수
        int pageCount = 10; // 한 그룹당 표시할 페이지 번호 수

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        User input = new User();
        input.setName(keyword);
        input.setEmail(keyword);
        input.setPasswd(keyword);
        input.setTel(keyword);
        input.setRegdate(keyword);
        input.setEditdate(keyword);

        List<User> output = null; // 조회결과가 저장될 객체
        PageData pageData = null;

        try {
            // 전체 게시글 수 조회
            totalCount = userService.getUserCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            User.setOffset(pageData.getOffset());
            User.setListCount(pageData.getListCount());

            // 데이터 조회하기
            output = userService.getUserList(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) View 처리 */
        model.addAttribute("keyword", keyword);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);

        String viewPath = "user/list";
        return new ModelAndView(viewPath);
    }

    /**
     * 상세 페이지
     */
    @RequestMapping(value = "/user/view.do", method = RequestMethod.GET)
    public ModelAndView view(Model model) {
        /** 1) 필요한 변수값 생성 */
        // 조회할 대상에 대한 PK값
        int userno = webHelper.getInt("userno");

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "회원번호가 없습니다.");
        }

        /** 2) 데이터 조회하기 */
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        User input = new User();
        input.setUserno(userno);

        // 조회결과를 저장할 객체 선언
        User output = null;

        try {
            // 데이터 조회
            output = userService.getUserItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) View 처리 */
        model.addAttribute("output", output);

        return new ModelAndView("user/view");
    }

    /**
     * 작성 폼 페이지
     */
    @RequestMapping(value = "/user/add.do", method = RequestMethod.GET)
    public ModelAndView add(Model model) {

        return new ModelAndView("user/add");
    }

    /**
     * 작성 폼에 대한 action 페이지
     */
    @RequestMapping(value = "/user/add_ok.do", method = RequestMethod.POST)
    public ModelAndView add_ok(Model model) {

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        String name = webHelper.getString("name");
        String email = webHelper.getString("email");
        String passwd = webHelper.getString("passwd");
        String tel = webHelper.getString("tel");
        String regdate = webHelper.getString("regdate");
        String editdate = webHelper.getString("editdate");
        String profile_img = webHelper.getString("profile_img");

        // 학과 이름은 필수 항목이므로 입력여부를 검사
        // 위치는 미필수(null허용)이므로 입력 여부를 검사하지 않는다.
        if (name == null) {
            return webHelper.redirect(null, "회원이름을 입력하세요.");
        }

        if (!regexHelper.isKor(name)) {
            return webHelper.redirect(null, "회원이름은 한글만 가능합니다.");
        }

        /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        User input = new User();
        input.setName(name);
        input.setEmail(email);
        input.setPasswd(passwd);
        input.setTel(tel);
        input.setRegdate(regdate);
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
        String redirectUrl = contextPath + "/user/view.do?no=" + input.getUserno();

        return webHelper.redirect(redirectUrl, "저장되었습니다.");
    }

    /**
     * 수정 폼 페이지
     */
    @RequestMapping(value = "/user/edit.do", method = RequestMethod.GET)
    public ModelAndView edit(Model model) {

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        int userno = webHelper.getInt("userno");

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "학과번호가 없습니다.");
        }

        /** 2) 데이터 조회하기 */
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        User input = new User();
        input.setUserno(userno);

        // 조회결과를 저장할 객체 선언
        User output = null;

        try {
            output = userService.getUserItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) View 처리 */
        model.addAttribute("output", output);
        return new ModelAndView("user/edit");
    }

    /**
     * 수정 폼에 대한 action 페이지
     */
    @RequestMapping(value = "/user/edit_ok.do", method = RequestMethod.POST)
    public ModelAndView edit_ok(Model model) {

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        int userno = webHelper.getInt("userno");
        String name = webHelper.getString("name");
        String email = webHelper.getString("email");
        String passwd = webHelper.getString("passwd");
        String tel = webHelper.getString("tel");
        String regdate = webHelper.getString("regdate");
        String editdate = webHelper.getString("editdate");
        String profile_img = webHelper.getString("profile_img");

        // 학과 이름은 필수 항목이므로 입력여부를 검사
        // 위치는 미필수(null허용)이므로 입력 여부를 검사하지 않는다.
        if (userno == 0) {
            return webHelper.redirect(null, "회원번호가 없습니다.");
        }

        if (name == null) {
            return webHelper.redirect(null, "회원이름을 입력하세요.");
        }

        /** 2) 데이터 수정하기 */
        // 저장할 값들을 Beans에 담는다.
        User input = new User();
        input.setUserno(userno);
        input.setName(name);
        input.setEmail(email);
        input.setPasswd(passwd);
        input.setTel(tel);
        input.setRegdate(regdate);
        input.setEditdate(editdate);
        input.setProfile_img(profile_img);

        try {
            // 데이터 수정
            // --> 데이터 수정에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            userService.editUser(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) 결과를 확인하기 위한 페이지 이동 */
        // 저장 결과를 확인하기 위해서 데이터 저장시 생성된 PK값을 상세 페이지로 전달해야 한다.
        String redirectUrl = contextPath + "/user/view.do?no=" + input.getUserno();
        return webHelper.redirect(redirectUrl, "수정되었습니다.");

    }

    /**
     * 데이터 삭제 기능
     */
    @RequestMapping(value = "/user/delete_ok.do", method = RequestMethod.GET)
    public ModelAndView delete(Model model) {

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        int userno = webHelper.getInt("userno");

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "회원번호가 없습니다.");
        }

        /** 2) 데이터 삭제하기 */
        // 데이터 조회에 필요한 조건값을 Beans에 저장하기
        User input = new User();
        input.setUserno(userno);

        try {
            // 데이터 삭제
            userService.deleteUser(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) 페이지 이동 */
        // 확인할 대상이 삭제된 상태이므로 목록 페이지로 이동
        return webHelper.redirect(contextPath + "/user/list.do", "삭제되었습니다.");
    }

    /********************************************************************
     * 마이페이지 회원정보 수정하기
     *******************************************************************/
    @RequestMapping(value = "/main/mypageedit.do", method = RequestMethod.POST)
    public ModelAndView mypage(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        /** 1)필요한 변수값 생성 */
        int userno = webHelper.getInt("userno"); // 회원 번호
        String nowmyname = webHelper.getString("nowmyname"); //
        String nowemail = webHelper.getString("nowemail"); //
        String nowallpon = webHelper.getString("nowallpon"); //
        String pwd = webHelper.getString("pwd"); //

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "회원정보 번호가 없습니다.");
        }

//		Calendar c = Calendar.getInstance();
//		String editDate = String.format("%04d-%02d-%02d", c.get(Calendar.YEAR), c.get(Calendar.MONTH) + 1,
//				c.get(Calendar.DAY_OF_MONTH)); // 변경일자

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        User input = new User();
        input.setName(nowmyname);
        input.setEmail(nowemail);
        input.setTel(nowallpon);
        input.setPasswd(pwd);
        input.setUserno(userno);

        try {
            // 현재 로그인 되어있는 회원번호를 사용해 정보를 추출한다
            userService.editUserMyPage(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        loginInfo.setName(nowmyname);
        loginInfo.setEmail(nowemail);
        loginInfo.setTel(nowallpon);
        loginInfo.setPasswd(pwd);

        session.setAttribute("loginInfo", loginInfo);

        /** 3) 업로드 결과를 View에게 전달한다 */
        model.addAttribute("fileList", input);

        /** 3)View 처리 */
//		String redirectUrl = contextPath + "/main/mypage.do?roomno=" + input.getRoomno();
//		return webHelper.redirect(redirectUrl, "수정되었습니다.");

        // return new ModelAndView("main/mypage");
        String redirectUrl = contextPath + "/main/mypage.do";
        return webHelper.redirect(redirectUrl, "저장완료");
    }

    /********************************************************************
     * 마이페이지 회원정보 삭제하기
     *******************************************************************/
    @RequestMapping(value = "/main/mypagedelect.do", method = RequestMethod.POST)
    public ModelAndView mypagedelect(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        /** 1)필요한 변수값 생성 */
        int userno = loginInfo.getUserno(); // 회원 번호
        String outtextarea = webHelper.getString("outtextarea");
        //String Regdate = loginInfo.getRegdate(); // 회원 가입 날짜

        /* session 삭제 */
        session.removeAttribute("loginInfo");

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "회원정보 번호가 없습니다.");
        }

//		Calendar c = Calendar.getInstance();
//		String editDate = String.format("%04d-%02d-%02d", c.get(Calendar.YEAR), c.get(Calendar.MONTH) + 1,
//				c.get(Calendar.DAY_OF_MONTH)); // 변경일자

        /** 2 - 1) user 삭제 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        User input = new User();
        input.setUserno(userno);

        try {
            // 현재 로그인 되어있는 회원번호를 사용해 정보를 추출한다
            userService.deleteUser(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 2 - 2) 삭제 이유 저장 */
        User outinput = new User();
        outinput.setUserno(userno);
        outinput.setReason(outtextarea);

        try {
            // 현재 로그인 되어있는 회원번호를 사용해 정보를 추출한다
            userService.outUserinsert(outinput);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3)View 처리 */
//		String redirectUrl = contextPath + "/main/mypage.do?roomno=" + input.getRoomno();
//		return webHelper.redirect(redirectUrl, "수정되었습니다.");

        // return new ModelAndView("main/mypage");
        String redirectUrl = contextPath + "/";
        return webHelper.redirect(redirectUrl, "탈퇴되었습니다");
    }

}