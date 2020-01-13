package project.star.b2.controllers;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import project.star.b2.helper.CookieUtils;
import project.star.b2.helper.PageData;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.Gallery;
import project.star.b2.model.Gu;
import project.star.b2.model.Heart;
import project.star.b2.model.Info;
import project.star.b2.model.Popular;
import project.star.b2.model.User;
import project.star.b2.service.GalleryService;
import project.star.b2.service.HeartService;
import project.star.b2.service.InfoService;
import project.star.b2.service.PriceService;
import project.star.b2.service.RoomService;
import project.star.b2.service.UploadService;
import project.star.b2.service.UserService;

@RestController
public class MainRestController {
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

    /** 상세 페이지 */
    @RequestMapping(value = "/professor", method = RequestMethod.GET)
    public Map<String, Object> get_list(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        /** 1)필요한 변수값 생성 */
        int userno = loginInfo.getUserno();
        String keyword = webHelper.getString("keyword", ""); // 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 4; // 한 페이지당 표시할 목록 수
        int pageCount = 1; // 한 그룹당 표시할 페이지 번호 수

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Heart input = new Heart();
        input.setUserno(userno);

        List<Heart> output = null; // 조회결과가 저장될 객체
        PageData pageData = null;
        int heart_size = 0;

        try {
            // 전체 게시글 수 조회
            totalCount = heartService.getHeartGalleryCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Heart.setOffset(pageData.getOffset());
            Heart.setListCount(pageData.getListCount());
            // 데이터 조회하기
            output = heartService.getHeartGalleryList(input);
            heart_size = output.size();
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }

        /** 3)Json 출력 하기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("keyword", keyword);
        data.put("item", output);
        data.put("meta", pageData);
        data.put("heart_size", heart_size);

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * 쿠키로 보는 최근 본방
     *******************************************************************/
    @RequestMapping(value = "/professor2", method = RequestMethod.GET)
    public Map<String, Object> get_list2(HttpServletRequest request) {
        int totalCount = 0; // 전체 게시글 수
        int listCount = 4; // 한 페이지당 표시할 목록 수
        int pageCount = 1; // 한 그룹당 표시할 페이지 번호 수
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        List<String> list = null;
        PageData pageData = null;
        int cookie_size = 0;
        int heart_size = 0;

        try {
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Heart.setOffset(pageData.getOffset());
            Heart.setListCount(pageData.getListCount());
            // 데이터 조회하기
            list = CookieUtils.getValueList("cookieName", request);
            cookie_size = list.size();
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
            Collections.reverse(list);
            output = galleryService.getCookieMainList(list);
            if (userno != 0) {
                heartlist = galleryService.getHeartList(input_heart);
            }
            if (heartlist == null) {
                heart_size = 0;
            } else {
                heart_size = heartlist.size();
            }
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }

        /** view 화면으로 보여주기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output);
        data.put("meta", pageData);
        data.put("heart", heartlist);
        data.put("cookie_size", cookie_size);
        data.put("heart_size", heart_size); 

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * AJAX로 보는 인기있는 방
     *******************************************************************/
    @RequestMapping(value = "/famous", method = RequestMethod.GET)
    public Map<String, Object> get_list3(HttpServletRequest request) {
        /** 1)필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", ""); // 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 4; // 한 페이지당 표시할 목록 수
        int pageCount = 1; // 한 그룹당 표시할 페이지 번호 수

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /** 2)데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Popular input = new Popular();
        List<Popular> output = null; // 조회결과가 저장될 객체

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;
        int heart_size = 0;

        PageData pageData = null;

        try {
            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount2(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Popular.setOffset(pageData.getOffset());
            Popular.setListCount(pageData.getListCount());
            // 데이터 조회하기
            if (userno != 0) {
                heartlist = galleryService.getHeartList(input_heart);
            }
            if (heartlist == null) {
                heart_size = 0;
            } else {
                heart_size = heartlist.size();
            }
            output = galleryService.getPopularGalleryList(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }

        /** 3)Json 출력 하기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("keyword", keyword);
        data.put("item", output);
        data.put("meta", pageData);
        data.put("heart", heartlist);
        data.put("heart_size", heart_size);

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * AJAX로 차트값 가져오기
     *******************************************************************/
    @RequestMapping(value = "/chart", method = RequestMethod.GET)
    public Map<String, Object> get_chart(HttpServletRequest request) {
        int newRoomno = webHelper.getInt("chartdata");

        Info input_info = new Info();
        input_info.setRoomno(newRoomno);

        Info output_info = null;

        try {
            output_info = infoService.getInfoItem(input_info);

        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());

        }

        /** 3)Json 출력 하기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output_info);

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * AJAX로 좋아요 하기
     *******************************************************************/
    @RequestMapping(value = "/like", method = RequestMethod.GET)
    public Map<String, Object> get_like(HttpServletRequest request) {

        int newuserno = webHelper.getInt("userno");
        int newroomno = webHelper.getInt("roomno");

        Heart input = new Heart();
        input.setRoomno(newroomno);
        input.setUserno(newuserno);

        Heart output = null;

        try {
            // 데이터 저장
            heartService.addHeart(input);

            // 데이터 조회
            output = heartService.getHeartItem(input);

        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());

        }

        /** 3)Json 출력 하기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output);

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * AJAX로 좋아요 삭제하기
     *******************************************************************/
    @RequestMapping(value = "/dislike", method = RequestMethod.GET)
    public Map<String, Object> get_dislike(HttpServletRequest request) {

        int newuserno = webHelper.getInt("userno");
        int newroomno = webHelper.getInt("roomno");

        Heart input = new Heart();
        input.setRoomno(newroomno);
        input.setUserno(newuserno);

        Heart output = null;

        try {
            // 데이터 삭제
            heartService.deleteHeart(input);

            // 데이터 조회
            // output = heartService.getHeartItem(input);

        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());

        }

        /** 3)Json 출력 하기 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output);

        return webHelper.getJsonData(data);
    }

    /** --------구 별 이름,위경도,매물개수에 대한 json을 위한 페이지-------- */
    @RequestMapping(value = "/assets/guposition", method = RequestMethod.GET)
    public Map<String, Object> get_list() {
        String[] name = { "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" };
        double[] lat = { 37.4959854, 37.5492077, 37.6469954, 37.5657617, 37.4653993, 37.5481445, 37.4954856, 37.4600969, 37.655264, 37.6658609, 37.5838012, 37.4965037, 37.5622906, 37.5820369, 37.4769528, 37.5506753, 37.606991, 37.5048534,
                37.5270616, 37.520641, 37.5311008, 37.6176125, 37.5990998, 37.5579452, 37.5953795 };
        double[] lng = { 127.0664091, 127.1464824, 127.0147158, 126.8226561, 126.9438071, 127.0857528, 126.858121, 126.9001546, 127.0771201, 127.0317674, 127.0507003, 126.9443073, 126.9087803, 126.9356665, 127.0378103, 127.0409622,
                127.0232185, 127.1144822, 126.8561534, 126.9139242, 126.9810742, 126.9227004, 126.9861493, 126.9941904, 127.0939669 };

        List<Gu> guPositions = new ArrayList<Gu>();
        int output = 0;

        for (int i = 0; i < name.length; i++) {
            try {
                output = galleryService.getGalleryGuCount(name[i]);
            } catch (Exception e) {
                e.printStackTrace();
            }
            guPositions.add(new Gu(name[i], lat[i], lng[i], output));
        }

        Map<String, Object> data = new HashMap<String, Object>();
        data.put("guPositions", guPositions);

        return webHelper.getJsonData(data);
    }

    /********************************************************************
     * 방찾기
     *******************************************************************/
    @RequestMapping(value = "/main/search", method = RequestMethod.GET)
    public Map<String, Object> search(HttpServletRequest request) {
        /** 1) 필요한 변수값 생성 */
        String keyword = webHelper.getString("keyword", "");// 검색어
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 24; // 한 페이지당 표시할 목록 수
        int pageCount = 7; // 한 그룹당 표시할 페이지 번호 수
        int pagelist = webHelper.getInt("pagelist");

        /*---세션 불러오기 ----*/
        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = 0;
        if (loginInfo != null) {
            userno = loginInfo.getUserno();
        }

        /******** 필터 ********/
        /** 방 종류(roomtype) */
        String room = webHelper.getString("roomtype", "원룸,투룸,쓰리룸,오피스텔");
        /** 거래 종류(dealingtype) */
        String dealingtype = webHelper.getString("dealingtype", "월세,전세,매매");
        /** 보증금/전세가(deposit/price) */
        int depositFrom = webHelper.getInt("depositFrom");
        int depositTo = webHelper.getInt("depositTo", 999999);
        /** 월세(price) */
        int monthFrom = webHelper.getInt("monthFrom");
        int monthTo = webHelper.getInt("monthTo", 999999);
        /** 매매 (price) */
        int buyingFrom = webHelper.getInt("buyingFrom");
        int buyingTo = webHelper.getInt("buyingTo");
        /** 관리비(fee) */
        int feeFrom = webHelper.getInt("feeFrom");
        int feeTo = webHelper.getInt("feeTo", 999999);
        /** 방 크기(area) */
        int sizeFrom = webHelper.getInt("sizeFrom");
        int sizeTo = webHelper.getInt("sizeTo", 999999);

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

        /** 지도 매물위치 필터링 */
        double west = webHelper.getDouble("west");
        double east = webHelper.getDouble("east");
        double south = webHelper.getDouble("south");
        double north = webHelper.getDouble("north");

        Heart input_heart = new Heart();
        input_heart.setUserno(userno);
        List<Heart> heartlist = null;


        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Gallery input = new Gallery();
        input.setRoomtype(room);
        input.setDealingtype(dealingtype);

        List<Gallery> output = null;
        PageData pageData = null;

        try {
            Gallery.setRoomTypePate(roomtypepate);
            Gallery.setDealingTypePate(dealingtypepate);

            Gallery.setDepositFrom(depositFrom);
            Gallery.setDepositTo(depositTo);

            Gallery.setMonthFrom(monthFrom);
            Gallery.setMonthTo(monthTo);

            Gallery.setBuyingFrom(buyingFrom);
            Gallery.setBuyingTo(buyingTo);

            Gallery.setFeeFrom(feeFrom);
            Gallery.setFeeTo(feeTo);

            Gallery.setSizeFrom(sizeFrom);
            Gallery.setSizeTo(sizeTo);

            Gallery.setWest(west);
            Gallery.setEast(east);
            Gallery.setSouth(south);
            Gallery.setNorth(north);

            // 전체 게시글 수 조회
            totalCount = galleryService.getGalleryCount(input);
            // 페이지 번호 계산
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Gallery.setOffset(pageData.getOffset());
            if (pagelist == 1) {
                Gallery.setListCount(totalCount);
            } else {
                Gallery.setListCount(pageData.getListCount());
            }

            if (userno != 0) {
                heartlist = galleryService.getHeartList(input_heart);
            }

            output = galleryService.getGalleryList(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }

        /** View 처리 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("keyword", keyword);
        data.put("output", output);
        data.put("pageData", pageData);
        data.put("totalCount", totalCount);
        data.put("heart", heartlist);

        return webHelper.getJsonData(data);
    }
}
