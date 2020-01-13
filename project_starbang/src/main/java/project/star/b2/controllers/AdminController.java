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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import project.star.b2.helper.PageData;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.Room;
import project.star.b2.model.User;
import project.star.b2.service.RoomService;
import project.star.b2.service.UserService;

@Controller
public class AdminController {
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

	/** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;

	/********************************************************************
	 * 글쓰기 수정
	 *******************************************************************/
	@RequestMapping(value = "/admin/edit.do", method = RequestMethod.GET)
	public ModelAndView edit(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }

		return new ModelAndView("admin/edit");
	}

	/********************************************************************
	 * 관리자 자주묻는질문
	 *******************************************************************/
	@RequestMapping(value = "/admin/faq.do", method = RequestMethod.GET)
	public ModelAndView faq(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }

		return new ModelAndView("admin/faq");
	}

	/********************************************************************
	 * 관리자 메인
	 *******************************************************************/
	@RequestMapping(value = "/admin/main.do", method = RequestMethod.GET)
	public ModelAndView main(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        
        /* 로그인이 여부 확인 */
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "관리자로그인 후 접근이 가능합니다.");
        } 
        
        /* 관리자 아이디로 로그인 여부 확인*/
        String id = loginInfo.getEmail();
        String pw = loginInfo.getPasswd();
        
        if (!id.equals("admin") && !pw.equals("admin")) {
        	return webHelper.redirect("/b2/admin/lg.do", "관리자로그인 후 접근이 가능합니다.");
        }
		return new ModelAndView("admin/main");
	}

	/********************************************************************
	 * 관리자 공지사항
	 *******************************************************************/
	@RequestMapping(value = "/admin/notice.do", method = RequestMethod.GET)
	public ModelAndView notice(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }

		return new ModelAndView("admin/notice");
	}

	/********************************************************************
	 * 방 관리(b2/admin/rmli.do)
	 *******************************************************************/
	@RequestMapping(value = "/admin/rmli.do", method = RequestMethod.GET)
	public ModelAndView rmli(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }
        
		/** 1) 필요한 변수값 생성 */
		String keyword = webHelper.getString("keyword", ""); // 검색어를 위한 변수 처리
		int key_int = webHelper.getInt("keyword");
		int raval = webHelper.getInt("check"); // 체크박스를 통한 값 조회를 위한 변수 생성, submit을 통해 파라미터로 받는다.
		int nowPage = webHelper.getInt("page", 1); // 페이지 번호(기본값 1)
		int totalCount = 0; // 전체 게시글 수
		int listCount = 10; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Room input = new Room();
		input.setStatus(raval); //Status 컬럼을 조회하기 위해서 setStatus에 input에서 전달받은 raval값을 넣는다.
		input.setRoomtype(keyword);
		input.setName(keyword);
		input.setDealingtype(keyword);
		input.setRoomno(key_int);

		List<Room> output = null; // 조회결과가 저장될 객체
		PageData pageData = null; // 페이지 번호를 계산할 결과가 저장될 객체
		String rememberChecked = ""; //체크박스 값을 담기 위한 변수 생성

		try {
			// 전체 게시글 수 조회
			totalCount = roomService.getRoomCount(input);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Room.setOffset(pageData.getOffset());
			Room.setListCount(pageData.getListCount());
			// 데이터 조회하기
			output = roomService.getRoomList(input);

			/** 데이터 조회시 input 조건에 따른 다른 결과값을 받기 위한 처리*/
			if (raval == 1) { // 확인매물
				output = roomService.getRoomCheckList(input);
				rememberChecked = "1"; //체크박스 유지를 위한 값 처리
				totalCount = roomService.getRoomCount(input);
				pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			} else if (raval == 2) { // 허위매물
				output = roomService.getRoomCheckList(input);
				rememberChecked = "2"; 
				totalCount = roomService.getRoomCount(input);
				pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			} else if (raval == 3) { // 숨김매물
				output = roomService.getRoomCheckList(input);
				rememberChecked = "3"; 
				totalCount = roomService.getRoomCount(input);
				pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			} else if (raval == 4) { // 숨김매물
				output = roomService.getRoomCheckList(input);
				rememberChecked = "4"; 
				totalCount = roomService.getRoomCount(input);
				pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			} else {
				output = roomService.getRoomList(input); //전체 매물
			}
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		/** 3)View 처리 */
		model.addAttribute("keyword", keyword); //검색어
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData); //페이지 번호
		model.addAttribute("rememberChecked", rememberChecked); //체크박스를 유지하기 위한 변수, View페이지에서 처리 할 수 있게 한다.
		
		String viewPath = "admin/rmli";
		return new ModelAndView(viewPath);
	}
	
	/********************************************************************
	 * 삭제 버튼 클릭을 통한 방 삭제 기능
	 *******************************************************************/
	
	@RequestMapping(value = "/admin/delete_ok.do", method = RequestMethod.POST)
	public ModelAndView room_delete_ok(Model model, HttpServletRequest request) {
		/** 1) 필요한 변수값 생성 */
		// 삭제할 대상에 대한 PK값
		String delete = request.getParameter("delete_id");
		int roomno = Integer.valueOf(delete); //String 으로 전달 받기 때문에 int형으로 변환하여 전달한다.

		// 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (roomno == 0) {
			return webHelper.redirect(null, "삭제될 방이 존재하지 않습니다.");
		}

		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
		Room input = new Room();
		input.setRoomno(roomno);

		try {
			roomService.deleteRoom(input); //input 값을 받아서 삭제 처리 할수 있게 한다.
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		String viewPath = "admin/rmli";
		return webHelper.redirect(viewPath, null);
	}

	/********************************************************************
	 * 확인매물 클릭을 통한 확인 매물 설정 기능
	 *******************************************************************/
	
	@RequestMapping(value = "/admin/confirm_ok.do", method = RequestMethod.POST)
	public ModelAndView room_edit_ok(Model model, HttpServletRequest request) {

		/** 데이터 받기 */
		String userno = request.getParameter("user_id"); //버튼 클릭을 통해 클릭값을 받는다.
		int roomno = Integer.valueOf(userno);

		/** 2) 데이터 수정하기 */
		// 저장할 값들을 Beans에 담는다.
		Room input = new Room();
		input.setRoomno(roomno); //조회 할 방번호를 input에 넣는다.

		try {
			// 확인 하고자 하는 방에 넣어 처리할 수 있게 한다.
			roomService.editConfirmRoom(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		String viewPath = "/admin/rmli.do";
		return webHelper.redirect(contextPath + viewPath, null);
	}
	
	/********************************************************************
	 * 숨김매물 버튼 클릭을 통한 숨김 매물 설정 기능
	 *******************************************************************/
	
	@RequestMapping(value = "/admin/hidden_ok.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView room_hidden_ok(Model model, HttpServletRequest request) {

		/** 데이터 받기 */
		String hidden = request.getParameter("hidden_id"); //버튼클릭을 통해 클릭값을 받는다.
		int roomno = Integer.valueOf(hidden);

		/** 2) 데이터 수정하기 */
		// 저장할 값들을 Beans에 담는다.
		Room input = new Room();
		input.setRoomno(roomno); //조회 할 방번호를 input에 넣는다.

		try {
			// 숨김 처리 하고자 하는 방에 넣어 처리할 수 있게 한다.
			roomService.editHiddenRoom(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		String viewPath = "/admin/rmli.do";
		return webHelper.redirect(contextPath + viewPath, null);
	}
	
	/********************************************************************
	 * 허위매물 버튼 클릭을 통한 허위 매물 설정 기능
	 *******************************************************************/
	
	@RequestMapping(value = "/admin/fake_ok.do", method = RequestMethod.POST)
	public ModelAndView room_fake_ok(Model model, HttpServletRequest request) {

		/** 데이터 받기 */
		String fake = request.getParameter("fake_id"); //버튼클릭을 통해 클릭값을 받는다.
		int roomno = Integer.valueOf(fake);

		/** 2) 데이터 수정하기 */
		// 저장할 값들을 Beans에 담는다.
		Room input = new Room();
		input.setRoomno(roomno); //조회 할 방번호를 input에 넣는다.

		try {
			// 허위 매물 처리 하고자 하는 방에 넣어 처리할 수 있게 한다.
			roomService.editFakeRoom(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		String viewPath = "/admin/rmli.do";
		return webHelper.redirect(contextPath + viewPath, null);
	}
	
	
	/********************************************************************
	 * 회원 관리
	 *******************************************************************/

	/****** 목록 페이지 ******/
	@RequestMapping(value = "/admin/userli.do", method = RequestMethod.GET)
	public ModelAndView userli(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }

		/** 1) 필요한 변수값 생성 (페이징처리 변수) */
		String keyword = webHelper.getString("keyword", ""); // 검색어
		int keywordno = webHelper.getInt("keyword");
		int nowPage = webHelper.getInt("page", 1); // 페이지 번호(기본값 1)
		int totalCount = 0; // 전체 게시글 수
		int listCount = 10; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		User input = new User();
		input.setName(keyword);
		input.setUserno(keywordno);
		
		
		List<User> output = null; // 조회결과가 저장될 객체
		PageData pageData = null; // 페이지 번호를 계산할 결과가 저장될 객체

		
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
		
		
		/** 3)View 처리 */
		model.addAttribute("keyword", keyword);
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);

		String viewPath = "/admin/userli";
		return new ModelAndView(viewPath);
	}


	
	/****** 상세페이지 ******/
	@RequestMapping(value = "/admin/userlist/view.do", method = RequestMethod.GET)
	public ModelAndView view(Model model) {
		
		/** 1) 필요한 변수값 생성 */
		// 조회할 대상에 대한 PK값
		int userno = webHelper.getInt("userno");

		// 필수값 유효성검사.
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

		return new ModelAndView("/admin/userlist/view");
	}


	/****** 회원 삭제 페이지 ******/
	@RequestMapping(value = "/admin/userlist/delete_ok.do", method = RequestMethod.POST)
	public ModelAndView delete_ok(Model model, HttpServletRequest request) {
		/** 1) 필요한 변수값 생성 */
		// 삭제할 대상에 대한 PK값
		String delete = request.getParameter("delete_id");
		int userno = Integer.valueOf(delete);

		// 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (userno == 0) {
			return webHelper.redirect(null, "회원번호가 없습니다.");
		}

		
		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
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
		return webHelper.redirect(contextPath + "/admin/userli.do", "삭제되었습니다."); 
	}


	/****** 회원 수정 폼 페이지 ******/
	@RequestMapping(value = "/admin/userlist/edit.do", method = RequestMethod.GET)
	public ModelAndView edit(Model model) {
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
			output = userService.getUserItem(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		
		/** 3) View 처리 */
		model.addAttribute("output", output);
		return new ModelAndView("admin/userlist/edit");
	}


	/****** 회원 수정 폼에 대한 action 페이지 ******/
	@RequestMapping(value = "/admin/userlist/edit_ok.do", method = RequestMethod.POST)
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

		if (userno == 0) {
			return webHelper.redirect(null, "회원번호가 없습니다.");
		}

		if (name == null) {
			return webHelper.redirect(null, "회원이름을 입력하세요.");
		}

		
		/** 2) 데이터 수정하기 */
		// 수정할 값들을 Beans에 담는다.
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
			userService.editUser(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}

		
		/** 3) 결과를 확인하기 위한 페이지 이동 */
		// 수정한 대상을 상세페이지에 알려주기 위해서 PK값을 전달해야 한다.
		String redirectUrl = contextPath + "/admin/userli.do";
		return webHelper.redirect(redirectUrl, "수정되었습니다.");
	}

	/********************************************************************
	 * 글쓰기
	 *******************************************************************/
	@RequestMapping(value = "/admin/write.do", method = RequestMethod.GET)
	public ModelAndView write(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		
        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
        	return webHelper.redirect("/b2/admin/lg.do", "로그인 후 접근이 가능합니다.");
        }

		return new ModelAndView("admin/write");
	}

	/********************************************************************
	 * 관리자 로그인
	 *******************************************************************/
	@RequestMapping(value = "/admin/lg.do", method = RequestMethod.GET)
	public ModelAndView ad_login() {

		return new ModelAndView("admin/lg");
	}
	
	/********************************************************************
	 * 관리자 로그인 action폼
	 *******************************************************************/
	@RequestMapping(value = "/admin/login_ok.do", method = RequestMethod.POST)
	public ModelAndView login_ok(Model model, HttpServletRequest request) {

		// 1) 사용자가 입력한 파라미터 수신 및 필수값 검사 */
		String email = webHelper.getString("email"); 
		String passwd = webHelper.getString("passwd");
			
		// 필수 값의 존재여부 검사 
		if (email == null || email.contentEquals("")) { 
			return webHelper.redirect(null, "이메일을 입력하세요."); }
		
		if (passwd == null || passwd.contentEquals("")) { 
			return webHelper.redirect(null, "비밀번호를 입력하세요."); }
	 
		if (!email.equals("admin") && !passwd.equals("admin")) { 
			return webHelper.redirect(null, "관리자가 아닙니다."); }
			
		
		// 2) 사용자가 입력한 값을 Beans에 저장
		User input = new User();
		input.setEmail(email);
		input.setPasswd(passwd);
			
			
		// 조회결과를 저장할 객체 선언 
		User output = null;
			
		
		try { 
			//데이터 조회 
			output = userService.getUserLogin(input); 
		} catch (Exception e) { 
			return webHelper.redirect(null, e.getLocalizedMessage()); }
			
		/* request 객체를 사용해서 세션 객체 만들기 */
		HttpSession session = request.getSession();
		
		// 가입된 정보와 DB가 일치하는지 검사 후 세션 생성   
		if (email.equals(output.getEmail()) || passwd.equals(output.getPasswd())) {
			session.setAttribute("loginInfo", output);
		} 
		
		String redirectUrl = contextPath + "/admin/main.do";
		return webHelper.redirect(redirectUrl, "관리자페이지로 이동합니다.");

		/*return new ModelAndView("admin/main");*/
	}
}
