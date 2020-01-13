package project.star.b2.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.helper.CookieUtils;
import project.star.b2.helper.PageData;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.FakeRoom;
import project.star.b2.model.Filter;
import project.star.b2.model.Gallery;
import project.star.b2.model.Heart;
import project.star.b2.model.Info;
import project.star.b2.model.Popular;
import project.star.b2.model.Price;
import project.star.b2.model.Room;
import project.star.b2.model.UploadItem;
import project.star.b2.model.User;
import project.star.b2.service.GalleryService;
import project.star.b2.service.HeartService;
import project.star.b2.service.InfoService;
import project.star.b2.service.PriceService;
import project.star.b2.service.RoomService;
import project.star.b2.service.UploadService;
import project.star.b2.service.UserService;

@Slf4j
@Controller
public class MainController {
    /** WebHelper 주입 */
    @Autowired
    WebHelper webHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired
    RoomService roomService;
    @Autowired
    InfoService infoService;
    @Autowired
    PriceService priceService;
    @Autowired
    UploadService uploadService;
    @Autowired
    UserService userService;
    @Autowired
    GalleryService galleryService;
    @Autowired
    GalleryService gallerypopularService;
    @Autowired
    HeartService heartService;

    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;

    /********************************************************************
     * 메인
     *******************************************************************/
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView main(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /** 1)필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", ""); // 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 4; // 한 페이지당 표시할 목록 수
        int pageCount = 1; // 한 그룹당 표시할 페이지 번호 수

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Popular input = new Popular();

        List<String> list = null;
        List<Popular> output = null; // 조회결과가 저장될 객체
        PageData pageData = null;
        List<Gallery> output3 = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        try {
            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount2(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            // 쿠키 불러오기
            list = CookieUtils.getValueList("cookieName", request);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Popular.setOffset(pageData.getOffset());
            Popular.setListCount(pageData.getListCount());
            // 데이터 조회하기
            output = galleryService.getPopularGalleryList(input); // 인기있는 방
            Collections.reverse(list);
            output3 = galleryService.getCookieList(list); // 최근본방

            if (userno != 0) {
                heartlist = heartService.getHeartList(input_heart);
            }

        } catch (Exception e) {
            /* return webHelper.redirect(null, e.getLocalizedMessage()); */
            return new ModelAndView("index");
        }

        /** 3)View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("output3", output3);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pageData", pageData);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("logininfo", loginInfo);
        model.addAttribute("heart", heartlist);

        return new ModelAndView("index");
    }

    /********************************************************************
     * 자주묻는질문
     *******************************************************************/
    @RequestMapping(value = "/main/faq.do", method = RequestMethod.GET)
    public ModelAndView faq() {

        return new ModelAndView("main/faq");
    }

    /********************************************************************
     * 마이페이지
     *******************************************************************/
    @RequestMapping(value = "/main/mypage.do", method = RequestMethod.GET)
    public ModelAndView mypage(Model model, HttpServletRequest request) {

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        /** 1)필요한 변수값 생성 */
        int userno = loginInfo.getUserno(); // 회원 이메일기저오기

        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (userno == 0) {
            return webHelper.redirect(null, "방정보 번호가 없습니다.");
        }

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        User input = new User();
        input.setUserno(userno);

        User output = null; // 조회결과가 저장될 객체

        try {
            // 현재 로그인 되어있는 회원번호를 사용해 정보를 추출한다
            output = userService.getUserItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3)View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("logininfo", loginInfo);

        return new ModelAndView("main/mypage");
    }

    /********************************************************************
     * 공지사항
     *******************************************************************/
    @RequestMapping(value = "/main/notice.do", method = RequestMethod.GET)
    public ModelAndView notice() {

        return new ModelAndView("main/notice");
    }

    /********************************************************************
     * 인기매물
     *******************************************************************/
    @RequestMapping(value = "/main/pprm.do", method = RequestMethod.GET)
    public ModelAndView pprm(Model model, HttpServletRequest request) {

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /** 1)필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", ""); // 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 50; // 한 페이지당 표시할 목록 수
        int pageCount = 1; // 한 그룹당 표시할 페이지 번호 수

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Popular input = new Popular();

        List<Popular> output = null; // 조회결과가 저장될 객체
        PageData pageData = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        try {
            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount2(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Popular.setOffset(pageData.getOffset());
            Popular.setListCount(pageData.getListCount());
            // 데이터 조회하기
            output = galleryService.getPopularGalleryList(input);

            if (userno != 0) {
                heartlist = heartService.getHeartList(input_heart);
            }

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3)View 처리 */
        model.addAttribute("output", output);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pageData", pageData);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("logininfo", loginInfo);
        model.addAttribute("heart", heartlist);

        return new ModelAndView("main/pprm");
    }

    /********************************************************************
     * 상세페이지 (rmdt 파라미터 읽기)
     *******************************************************************/
    @RequestMapping(value = "/main/rmdt.do", method = RequestMethod.GET)
    public ModelAndView rmdt(Model model, HttpServletResponse response, HttpServletRequest request, @RequestParam(value = "roomno", defaultValue = "") String roomno) {

        int newRoomno = Integer.parseInt(roomno);

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        Room input_room = new Room();
        input_room.setRoomno(newRoomno);

        Info input_info = new Info();
        input_info.setRoomno(newRoomno);

        Price input_price = new Price();
        input_price.setRoomno(newRoomno);

        UploadItem input_image = new UploadItem();
        input_image.setRoomno(newRoomno);

        User input_user = new User();

        FakeRoom input_fake = new FakeRoom();
        input_fake.setRoomno(newRoomno);
        input_fake.setSingo(userno);

        Room output_room = null;
        Info output_info = null;
        List<Price> output_price = null;
        List<UploadItem> output_image = null;
        User output_user = null;
        FakeRoom output_fake = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        input_heart.setRoomno(newRoomno);
        int heartox = 0;

        Heart heartint = new Heart();
        heartint.setRoomno(newRoomno);
        int fheartint = 0;

        try {

            output_room = roomService.getRoomItem(input_room);
            log.info("성공 roomService");

            output_info = infoService.getInfoItem(input_info);
            log.info("성공 infoService");

            output_price = priceService.getPriceList_by_roomno(input_price);
            log.info("성공 priceService");

            output_image = uploadService.getImageList_by_roomno(input_image);
            log.info("성공 uploadService");

            if (userno != 0) {
                output_fake = roomService.getFakeRoomItem(input_fake);
            }

            input_user.setUserno(output_room.getUserno());
            output_user = userService.getUserItem(input_user);

            fheartint = heartService.numberHeart(heartint);

            if (userno != 0) {
                heartox = heartService.getHeartitemox(input_heart);
                if (heartox != 0) {
                    heartox = 1;
                }
            }

        } catch (Exception e) {

            log.debug("방 조회에 실패하였습니다.");
            log.error(e.getLocalizedMessage());
            return webHelper.redirect(null, e.getLocalizedMessage());

        }

        // -----------------------------------
        // 쿠키 다중저장 시작
        // -----------------------------------
        if (!roomno.equals("")) {
            try {
                roomno = URLEncoder.encode(roomno, "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        try {
            CookieUtils.setYummy("cookieName", roomno, 1, request, response);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // -----------------------------------
        // 쿠키 다중저장 끝
        // -----------------------------------

        /** view 화면으로 보여주기 */
        model.addAttribute("room", output_room);
        model.addAttribute("info", output_info);
        model.addAttribute("price", output_price);
        model.addAttribute("img", output_image);
        model.addAttribute("user", output_user);
        model.addAttribute("fake", output_fake);
        model.addAttribute("heartox", heartox);
        model.addAttribute("heartint", fheartint);
        model.addAttribute("newRoomno", newRoomno);

        return new ModelAndView("main/rmdt");
    }

    /********************************************************************
     * 최근 본 방 (쿠키불러와서 view로 보여줌)
     *******************************************************************/
    @RequestMapping(value = "/main/rtrm.do", method = RequestMethod.GET)
    public ModelAndView rtrm(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        List<String> list = null;

        try {
            list = CookieUtils.getValueList("cookieName", request);
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        List<Gallery> output = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        try {
            // 쿠키로 저장된 방번호로 조회
            output = galleryService.getCookieList(list);
            Collections.reverse(output);

            if (userno != 0) {
                heartlist = heartService.getHeartList(input_heart);
            }

        } catch (Exception e) {
            return new ModelAndView("main/rtrm");
        }

        /** view 화면으로 보여주기 */
        model.addAttribute("output", output);
        model.addAttribute("loginInfo", loginInfo);
        model.addAttribute("heart", heartlist);

        return new ModelAndView("main/rtrm");
    }

    /********************************************************************
     * 방찾기
     *******************************************************************/
    @RequestMapping(value = "/main/search.do", method = RequestMethod.GET)
    public ModelAndView search(Model model) {
        /** 1) 필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", "");// 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 24; // 한 페이지당 표시할 목록 수
        int pageCount = 7; // 한 그룹당 표시할 페이지 번호 수

        /*---세션 불러오기 ----*/
        HttpSession session = webHelper.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /** 지도 상태유지를 위한 중심좌표와 레벨 */
        String mapTemp = webHelper.getString("map", "37.5642135,126.9743207,9");
        String[] map = mapTemp.split(",");
        double lat = Double.parseDouble(map[0]);
        double lng = Double.parseDouble(map[1]);
        int level = Integer.parseInt(map[2]);

        /** 쉬운방찾기-지역 */
        String region = webHelper.getString("region");

        /******** 필터 ********/
        /** 방 종류(roomtype) */
        String room = webHelper.getString("roomtype", "원룸,투룸,쓰리룸,오피스텔");
        /** 매물 종류(dealingtype) */
        String dealingtype = webHelper.getString("dealingtype", "월세,전세,매매");
        /** 보증금/전세가(deposit/price) */
        int depositFrom = webHelper.getInt("depositFrom");
        int depositTo = webHelper.getInt("depositTo", 999999);
        /** 월세(price) */
        int monthFrom = webHelper.getInt("monthFrom");
        int monthTo = webHelper.getInt("monthTo", 999999);
        /** 매매 (price) */
        int buyingFrom = webHelper.getInt("buyingFrom");
        int buyingTo = webHelper.getInt("buyingTo", 999999);
        /** 관리비(fee) */
        int feeFrom = webHelper.getInt("feeFrom");
        int feeTo = webHelper.getInt("feeTo", 999999);
        /** 방 크기(area) */
        int sizeFrom = webHelper.getInt("sizeFrom");
        int sizeTo = webHelper.getInt("sizeTo", 999999);
        /** 좌표 **/
        String newsTemp = webHelper.getString("news", "0,0,0,0");
        String[] news = newsTemp.split(",");
        double west = Double.parseDouble(news[0]);
        double east = Double.parseDouble(news[1]);
        double south = Double.parseDouble(news[2]);
        double north = Double.parseDouble(news[3]);

        /** 방 종류(roomtype) list */
        List<String> roomtypepate = new ArrayList<String>();
        String[] roomto = room.split(",");
        for (int i = 0; i < roomto.length; i++) {
            roomtypepate.add(roomto[i]);
        }

        /** 거래 종류(dealingtype) list */
        List<String> dealingtypepate = new ArrayList<String>();
        String[] dealingtypeto = dealingtype.split(",");
        for (int i = 0; i < dealingtypeto.length; i++) {
            dealingtypepate.add(dealingtypeto[i]);
        }

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        Filter filter = new Filter();
        // 좌표
        filter.setWest(west);
        filter.setEast(east);
        filter.setSouth(south);
        filter.setNorth(north);
        // 지도 중심
        filter.setCenterLat(lat);
        filter.setCenterLng(lng);
        filter.setLevel(level);

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Gallery input = new Gallery();
        input.setRegion_2depth_name(region);

        List<Gallery> output = null;
        PageData pageData = null;

        try {
            /** 조회할 조건값 */
            // 원룸,투룸,쓰리룸,오피스텔
            Gallery.setRoomTypePate(roomtypepate);
            // 월세,전세,매매
            Gallery.setDealingTypePate(dealingtypepate);
            // 보증금/전세가
            Gallery.setDepositFrom(depositFrom);
            Gallery.setDepositTo(depositTo);
            // 월세
            Gallery.setMonthFrom(monthFrom);
            Gallery.setMonthTo(monthTo);
            // 매매
            Gallery.setBuyingFrom(buyingFrom);
            Gallery.setBuyingTo(buyingTo);
            // 관리비
            Gallery.setFeeFrom(feeFrom);
            Gallery.setFeeTo(feeTo);
            // 방 크기
            Gallery.setSizeFrom(sizeFrom);
            Gallery.setSizeTo(sizeTo);
            // 지도
            Gallery.setWest(west);
            Gallery.setEast(east);
            Gallery.setSouth(south);
            Gallery.setNorth(north);

            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Gallery.setOffset(pageData.getOffset());
            Gallery.setListCount(pageData.getListCount());

            if (userno != 0) {
                heartlist = galleryService.getHeartList(input_heart);
            }
            output = galleryService.getGalleryList(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** View 처리 */
        model.addAttribute("keyword", keyword);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("heart", heartlist);
        model.addAttribute("loginInfo", loginInfo);
        model.addAttribute("filter", filter);

        return new ModelAndView("main/search");
    }

    /********************************************************************
     * 찜한방
     *******************************************************************/
    @RequestMapping(value = "/main/wish.do", method = RequestMethod.GET)
    public ModelAndView wish(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");

        /** 1) 필요한 변수값 생성 */
        int userno = loginInfo.getUserno();
        int keyword = webHelper.getInt("roomno");// 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 24; // 한 페이지당 표시할 목록 수
        int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Heart input = new Heart();
        /* Gallery input2 = new Gallery(); */
        input.setUserno(userno);

        List<Heart> output = null;
        PageData pageData = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        try {
            // 전체 게시글 수 조회
            totalCount = heartService.getHeartGalleryCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Heart.setOffset(pageData.getOffset());
            Heart.setListCount(pageData.getListCount());

            heartlist = heartService.getHeartList(input_heart);

            output = heartService.getHeartGalleryList(input);

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** View 처리 */
        model.addAttribute("keyword", keyword);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("heart", heartlist);

        return new ModelAndView("main/wish");
    }

    /********************************************************************
     * 쉬운방찾기
     *******************************************************************/
    @RequestMapping(value = "/main/search2.do", method = RequestMethod.GET)
    public ModelAndView search2(Model model, HttpServletRequest request) {
        /** 1) 필요한 변수값 생성 */
        int keyword = webHelper.getInt("roomno");// 검색어
        String keyword2 = webHelper.getString("roomtype");// 검색어
        int keyword3 = webHelper.getInt("price");// 검색어
        int keyword4 = webHelper.getInt("deposit");// 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 10; // 한 페이지당 표시할 목록 수
        int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Gallery input = new Gallery();
        input.setRoomno(keyword);
        input.setRoomtype(keyword2);
        input.setPrice(keyword3);
        input.setDeposit(keyword4);

        List<Gallery> output = null;
        PageData pageData = null;

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;

        try {
            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Room.setOffset(pageData.getOffset());
            Room.setListCount(pageData.getListCount());

            if (userno != 0) {
                heartlist = heartService.getHeartList(input_heart);
            }

            output = galleryService.getGalleryList(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** View 처리 */
        model.addAttribute("keyword", keyword);
        model.addAttribute("output", output);
        model.addAttribute("pageData", pageData);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("heart", heartlist);
        model.addAttribute("loginInfo", loginInfo);

        return new ModelAndView("main/search");
    }

    /********************************************************************
     * 비밀번호 찾기
     *******************************************************************/
    @RequestMapping(value = "main/repwd.do")
    public String repwd(Model model, HttpServletRequest request) {

        /** pwd에서 입력한 이메일 세션 생성 */
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("fullemail");

        model.addAttribute("fullemail", email);
        session.invalidate();

        return "main/repwd";
    }

    /********************************************************************
     * 비밀번호 찾기 ok
     *******************************************************************/

    /** 수정 폼에 대한 action 페이지 */
    @RequestMapping(value = "main/repwd_ok.do", method = RequestMethod.POST)
    public ModelAndView edit(Model model) {

        /** 1) 사용자가 입력한 파라미터 수신 및 유효성 검사 */
        String passwd = webHelper.getString("passwd");
        String email = webHelper.getString("email");

        if (passwd == null) {
            return webHelper.redirect(null, "비밀번호를 입력하세요.");
        }

        /** 2) 데이터 수정하기 */
        // 수정할 값들을 Beans에 담는다.
        User input = new User();
        input.setPasswd(passwd);
        input.setEmail(email);

        try {
            try {
                // 회원 pwd 데이터 수정
                userService.getPassword(input);
                /** 3) 결과를 확인하기 위한 페이지 이동 */
                return webHelper.redirect("/b2", "수정되었습니다.");
            } catch (Exception e) {
                e.getLocalizedMessage();
                return webHelper.redirect(null, e.getLocalizedMessage());
            }
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
    }

    /********************************************************************
     * 테스트
     *******************************************************************/

    /********************************************************************
     * 좋아요 삭제
     *******************************************************************/
    @RequestMapping(value = "/main/delectstar.do", method = RequestMethod.GET)
    public ModelAndView delectstar(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/
        int userno = loginInfo.getUserno();
        int x = webHelper.getInt("x");

        Heart input = new Heart();
        input.setUserno(userno);
        input.setRoomno(x);
        System.out.println("--------------------------");
        System.out.println(x);
        System.out.println("--------------------------");

        try {
            heartService.delectHeart(input);
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        /** view 화면으로 보여주기 */
        return null;
    }

    /********************************************************************
     * 좋아요 저장
     *******************************************************************/
    @RequestMapping(value = "/main/insertstar.do", method = RequestMethod.GET)
    public ModelAndView insertstar(Model model, HttpServletRequest request) {
        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /*----------------------*/

        int userno = loginInfo.getUserno();
        int roomno = webHelper.getInt("x");

        Heart input = new Heart();
        input.setRoomno(roomno);
        input.setUserno(userno);
        System.out.println("-----------------------");
        System.out.println(roomno);
        System.out.println(userno);
        System.out.println("-----------------------");

        try {
            // 데이터 저장
            heartService.addHeart(input);

        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return null;

    }

    /********************************************************************
     * bottom
     *******************************************************************/
    @RequestMapping(value = "/etc/auto.do", method = RequestMethod.GET)
    public ModelAndView auto() {

        return new ModelAndView("/etc/auto");
    }

    @RequestMapping(value = "/etc/fake.do", method = RequestMethod.GET)
    public ModelAndView fake() {

        return new ModelAndView("/etc/fake");
    }

    @RequestMapping(value = "/etc/personal.do", method = RequestMethod.GET)
    public ModelAndView personal() {

        return new ModelAndView("/etc/personal");
    }

    @RequestMapping(value = "/etc/regulation.do", method = RequestMethod.GET)
    public ModelAndView regulation() {

        return new ModelAndView("/etc/regulation");
    }

    @RequestMapping(value = "/etc/team.do", method = RequestMethod.GET)
    public ModelAndView team() {

        return new ModelAndView("/etc/team");
    }

    @RequestMapping(value = "/etc/useSite.do", method = RequestMethod.GET)
    public ModelAndView useSite() {

        return new ModelAndView("/etc/useSite");
    }

}