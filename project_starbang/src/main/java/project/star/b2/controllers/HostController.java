package project.star.b2.controllers;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import project.star.b2.helper.DownloadHelper;
import project.star.b2.helper.PageData;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.RetrofitHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.Address;
import project.star.b2.model.Address.Documents;
import project.star.b2.model.Info;
import project.star.b2.model.Price;
import project.star.b2.model.Room;
import project.star.b2.model.UploadItem;
import project.star.b2.model.User;
import project.star.b2.service.ApiKakaoSearchService;
import project.star.b2.service.InfoService;
import project.star.b2.service.PriceService;
import project.star.b2.service.RIPService;
import project.star.b2.service.RoomService;
import project.star.b2.service.UploadService;
import project.star.b2.service.UserService;
import retrofit2.Call;
import retrofit2.Retrofit;

@Slf4j
@Controller
public class HostController {

    @Autowired
    WebHelper webHelper;
    @Autowired
    RegexHelper regexHelper;
    @Autowired
    RetrofitHelper retrofitHelper;
    @Autowired
    DownloadHelper downloadHelper;
    @Autowired
    RIPService ripService;
    @Autowired
    RoomService roomService;
    @Autowired
    UploadService uploadService;
    @Autowired
    InfoService infoService;
    @Autowired
    PriceService priceService;
    @Autowired
    UserService userService;

    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;

    /********************************************************************
     * 방주인 메인페이지
     *******************************************************************/
    @RequestMapping(value = "/host/main.do", method = RequestMethod.GET)
    public ModelAndView main() {

        return new ModelAndView("host/main");
    }

    /********************************************************************
     * 공실 등록하기
     *******************************************************************/
    @RequestMapping(value = "/host/rm_add.do", method = RequestMethod.GET)
    public ModelAndView rm_add(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();

        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return webHelper.redirect(null, "로그인 후 방등록이 가능합니다.");
        }

        return new ModelAndView("host/rm_add");
    }

    /********************************************************************
     * 공실 등록하기_ok
     * 
     * @return
     *******************************************************************/
    @RequestMapping(value = "/host/rm_add_ok.do", method = RequestMethod.POST)
    public ModelAndView put3(HttpServletRequest request) {

        try {
            webHelper.upload();
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        List<UploadItem> fileList = webHelper.getFileList();
        Map<String, String> paramMap = webHelper.getParamMap();

        /** * * 1) 사용자가 입력한 파라미터 수신 * * */

        /***
         * Room DB TABLE (15 Columns)
         * Column name(param) description info
         * 1. roomno 방번호 (Auto Increment)
         * 2. roomtype - o 매물종류
         * 3. title - o 매물에 대한 제목
         * 4. floor - o 매물 해당 층
         * 5. area - o 전용면적
         * 6. fee - o 관리비
         * 7. confirmdate 확인날짜 (초기 데이터 없음)
         * 8. address API에서 받아온 주소
         * 9. dong - o 사용자가 입력한 동
         * 10. ho - o 사용자가 입력한 호
         * 11. latitude API에서 받아온 경도-y축 (Kakao API)
         * 12. longitude API에서 받아온 위도-x축 (Kakao API)
         * 13. region_2depth_name 지도사용 2depth info (Kakao API)
         * 14. region_3depth_name 지도사용 3depth info (Kakao API)
         * 15. userno 세션에서 가져올 회원번호 (Session에서 값 주입)
         */

        /**
         * room ** parameter 수신 (8 / 15) except(7) - roomno(1)- PRI, confirmdate(1),
         * address API(4)
         */
        String roomtype = paramMap.get("roomtype");
        String title = paramMap.get("title");
        int floor = Integer.parseInt(paramMap.get("floor"));
        float area = Float.parseFloat(paramMap.get("area"));
        int fee = Integer.parseInt(paramMap.get("fee"));
        String dong = paramMap.get("dong");
        String ho = paramMap.get("ho");
        String address = paramMap.get("address");

        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = loginInfo.getUserno();

        /***
         * Info DB TABLE (15 Columns)
         * Column name(params) Description info
         * 1. feeitem - o 관리비 항목 8개 - 2진법 SUM 저장 및 인수분해로 추출
         * 2. parking - o 주차 및 주차비 여부 불가능 - -1 ; 가능 무료 - 0 ; 가능 가격o - int
         * 3. pet - o 애완동물 가능 여부
         * 4. elevator - o 엘리베이터 여부
         * 5. veranda - o 베란다 여부
         * 6. builtin - o 빌트인 여부
         * 7. optionitem - o 옵션 항목 선택 13개 - 2진법 SUM 저장 및 인수분해로 추출
         * 8. loan - o 대출 가능 여부
         * 9. supplyarea - o 공급면적
         * 10. maxfloor - o 매물의 전체 층수
         * 11. heater - o 난방 종류
         * 12. commingday - o 입주가능일
         * 13. buildtype - o 건물유형
         * 14. content - o 상세 설명
         * 15. roomno 방 번호 참조키 - room DB 입력시 생성될 PRI값 주입
         */

        /** info ** parameter 수신 (14 / 15) - except(1) roomno - mul */
        /** 관리비 항목 2진법 계산해서 DB 넣기 */
        int parking = Integer.parseInt(paramMap.get("parking"));
        int pet = Integer.parseInt(paramMap.get("pet"));
        int elevator = Integer.parseInt(paramMap.get("elevator"));
        int veranda = Integer.parseInt(paramMap.get("veranda"));
        int builtin = Integer.parseInt(paramMap.get("builtin"));

        /** 옵션항목 2진법 계산해서 DB 넣기 */
        // feeitem
        String feeitem = paramMap.get("feeitem"); // 관리비항목 계산해서 넣기

        log.debug("로그기록임!!" + feeitem);
        log.error(feeitem);
        log.info(feeitem);

        String[] feeitems = null;
        if (feeitem != null) {
            feeitems = feeitem.split(",");
        }

        int sum_fee = 0;
        if (feeitems != null) {
            for (String item : feeitems) {
                int bin_fee = Integer.parseInt(item);
                sum_fee += bin_fee;
            }
        }

        // optionitem
        String optionitem = paramMap.get("optionitem");

        String[] optionitems = null;
        if (optionitem != null) {
            optionitems = optionitem.split(",");
        }

        int sum_option = 0;
        if (optionitems != null) {
            for (String item : optionitems) {
                int bin_option = Integer.parseInt(item);
                sum_option += bin_option;
            }
        }

        int loan = Integer.parseInt(paramMap.get("loan"));
        float supplyarea = Float.parseFloat(paramMap.get("supplyarea"));
        int maxfloor = Integer.parseInt(paramMap.get("maxfloor"));
        int heater = Integer.parseInt(paramMap.get("heater"));
        String commingday = paramMap.get("commingday");
        String buildtype = paramMap.get("buildtype");
        String content = paramMap.get("content");

        /***
         * Price DB TABLE (6 Columns)
         * Column name(params) Description info
         * 1. priceno 가격정보 번호 (Auto Increment)
         * 3. dealingtype - o 매물종류 월세-o, 전세-o, 매매-o
         * 2. deposit - o 보증금 월세-o, 전세-x, 매매-x
         * 4. price - o 금액 월세-o, 전세-o, 매매-o
         * 5. short_room - o 단기가능 여부
         * 6. roomno 방번호 참조키 - room DB 입력시 생성될 PRI값 주입
         */

        /** price ** parameter 수신 */
        String dealingtype = paramMap.get("dealingtype");
        String deposit = paramMap.get("deposit");
        String price = paramMap.get("price");
        String short_room = paramMap.get("short_room");

        String[] dealingtypes = null;
        String[] deposits = null;
        String[] prices = null;

        if (dealingtype != null) {
            dealingtypes = dealingtype.split(",");
        }
        if (deposit != null) {
            deposits = deposit.split(",");
        }
        if (price != null) {
            prices = price.split(",");
        }

        /** * * 3) 데이터 저장하기 * * */
        Room input_R = new Room();
        Info input_I = new Info();

        /** (1) room 정보 받아오기 */
        input_R.setRoomtype(roomtype);
        input_R.setTitle(title);
        input_R.setFloor(floor);
        input_R.setArea(area);
        input_R.setFee(fee);
        input_R.setAddress(address);
        input_R.setDong(dong);
        input_R.setHo(ho);
        input_R.setUserno(userno);

        /***
         * KakaoSearch API 통해 주소정보 5가지 - (위도, 경도, 2depth, 3depth, road_address) 수신 및 쓰기
         */

        /** 1. API 연동 객체 생성 */
        Retrofit retrofit = retrofitHelper.getRetrofit(ApiKakaoSearchService.BASE_URL);
        ApiKakaoSearchService apiKakaoSearchService = retrofit.create(ApiKakaoSearchService.class);

        /** 2. 파라미터 처리 */

        String query = paramMap.get("address");

        /** 3. KAKAO API 요청 */
        Address kakaoAddress = null;
        if (!query.equals("")) {
            Call<Address> call = apiKakaoSearchService.getAddress(query);
            try {
                kakaoAddress = call.execute().body();
            } catch (Exception e) {
                e.printStackTrace();
            }

            List<Documents> list = kakaoAddress.getDocuments();

            for (Documents item : list) {
                input_R.setRegion_2depth_name(item.getRoad_address().region_2depth_name);
                input_R.setRegion_3depth_name(item.getRoad_address().region_3depth_name);
                input_R.setLongitude(Double.parseDouble(item.getRoad_address().x));
                input_R.setLatitude(Double.parseDouble(item.getRoad_address().y));
            }
        }

        /***
         * KakaoSearch API End
         */

        /** (2) info정보 받아오기 */
        input_I.setFeeitem(sum_fee);

        // 주차가능 체크박스에 체크되어 있다면? 금액정보를 가져와 인풋
        if (parking == 1) {
            parking = webHelper.getInt("parking_val");
        }

        input_I.setParking(parking);
        input_I.setPet(pet);
        input_I.setElevator(elevator);
        input_I.setVeranda(veranda);
        input_I.setBuiltin(builtin);
        input_I.setOptionitem(sum_option);
        input_I.setLoan(loan);
        input_I.setSupplyarea(supplyarea);
        input_I.setMaxfloor(maxfloor);
        input_I.setHeater(heater);
        input_I.setCommingday(commingday);
        input_I.setBuildtype(buildtype);
        input_I.setContent(content);

        /** * * 4) DB 저장하기 * * */

        /** 1. room DB, info DB 데이터 저장 */

        try {
            ripService.addRoom(input_R);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        try {
            input_I.setRoomno(input_R.getRoomno());
            ripService.addInfo(input_I);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());

        }

        /** 2. price DB 데이터 저장 */
        try {

            Price input_p = new Price();
            int deposit_temp = 0;
            int price_temp = 0;

            for (int i = 0; i < deposits.length; i++) {
                price_temp = Integer.parseInt(prices[i]);

                if (deposits[i] != null || deposits[i] != "") {
                    deposit_temp = Integer.parseInt(deposits[i]);
                }

                if (prices[i] != null || prices[i] != "") {
                    price_temp = Integer.parseInt(prices[i]);
                }

                input_p.setDeposit(deposit_temp);
                input_p.setDealingtype(dealingtypes[i]);
                input_p.setPrice(price_temp);
                input_p.setShort_room(short_room);
                input_p.setRoomno(input_R.getRoomno());

                ripService.addPrice(input_p);
            }

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /**
         * UPLOAD
         */

        // 조회결과의 Beans에 추가 후 로그를 통해 내역 확인
        for (UploadItem item : fileList) {

            String thumbnail = null;

            try {
                thumbnail = downloadHelper.createThumbnail(item.getFilePath(), 320, 320, false);
                log.debug(":::::::::::::::::::::" + thumbnail);
            } catch (Exception e1) {
                e1.printStackTrace();
            }

            item.setFieldName(item.getFieldName());
            item.setOriginName(item.getOriginName());
            item.setFilePath(item.getFilePath());
            item.setContentType(item.getContentType());
            item.setFileSize(item.getFileSize());
            item.setFileName(item.getFileName());
            item.setRegDate(item.getRegDate());
            item.setEditDate(item.getEditDate());
            item.setRoomno(input_R.getRoomno());
            log.debug("업로드 될 항목" + item.toString());

            item.setThumbnail(thumbnail);

            // DB에 저장하기
            try {
                uploadService.addUploadItem(item);
            } catch (Exception e) {
                log.error(e.getLocalizedMessage());
                e.printStackTrace();
                return webHelper.redirect(null, e.getLocalizedMessage());
            }

        } // end for

        String redirectUrl = contextPath + "/main/rmdt.do?roomno=" + input_R.getRoomno();
        return webHelper.redirect(redirectUrl, "저장되었습니다.");

    }

    /********************************************************************
     * 공실 수정하기
     *******************************************************************/
    @RequestMapping(value = "/host/rm_edit.do", method = RequestMethod.GET)
    public ModelAndView rm_edit(Model model) {

        HttpSession session = webHelper.getSession();

        User loginInfo = (User) session.getAttribute("loginInfo");
        if (loginInfo == null) {
            return webHelper.redirect(null, "로그인 후 방등록이 가능합니다.");
        }

        int roomno = webHelper.getInt("roomno");

        Room input_room = new Room();
        input_room.setRoomno(roomno);

        Info input_info = new Info();
        input_info.setRoomno(roomno);

        Price input_price = new Price();
        input_price.setRoomno(roomno);

        UploadItem input_image = new UploadItem();
        input_image.setRoomno(roomno);

        User input_user = new User();

        Room output_room = null;
        Info output_info = null;
        List<Price> output_price = null;
        List<UploadItem> output_image = null;
        User output_user = null;
        int primary = 0;

        try {

            output_room = roomService.getRoomItem(input_room);
            log.info("성공 roomService");

            output_info = infoService.getInfoItem(input_info);
            log.info("성공 infoService");

            output_price = priceService.getPriceList_by_roomno(input_price);
            log.info("성공 priceService");

            output_image = uploadService.getImageList_by_roomno(input_image);
            log.info("성공 uploadService");

            input_user.setUserno(output_room.getUserno());
            output_user = userService.getUserItem(input_user);

            primary = uploadService.getUploadMaxItem(null);

        } catch (Exception e) {
            log.debug("방 조회에 실패하였습니다.");
            log.error(e.getLocalizedMessage());
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        // view 화면으로 보여주기
        model.addAttribute("room", output_room);
        model.addAttribute("info", output_info);
        model.addAttribute("price", output_price);
        model.addAttribute("img", output_image);
        model.addAttribute("user", output_user);
        model.addAttribute("primary", primary);

        return new ModelAndView("host/rm_edit");
    }

    /********************************************************************
     * 공실 수정하기_ok
     * 
     * @return
     *******************************************************************/
    @RequestMapping(value = "/host/rm_edit_ok.do", method = RequestMethod.POST)
    public ModelAndView rm_edit_ok(HttpServletRequest request) {

        try {
            webHelper.upload();
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        List<UploadItem> fileList = webHelper.getFileList();
        Map<String, String> paramMap = webHelper.getParamMap();

        fileList.iterator();

        /** * * 1) 사용자가 입력한 파라미터 수신 * * */

        /***
         * Room DB TABLE (15 Columns)
         * Column name(param) description info
         * 1. roomno - o 방번호 (Auto Increment)
         * 2. roomtype - o 매물종류
         * 3. title - o 매물에 대한 제목
         * 4. floor - o 매물 해당 층
         * 5. area - o 전용면적
         * 6. fee - o 관리비
         * 7. confirmdate 확인날짜 (초기 데이터 없음)
         * 8. address API에서 받아온 주소
         * 9. dong - o 사용자가 입력한 동
         * 10. ho - o 사용자가 입력한 호
         * 11. latitude API에서 받아온 경도-y축 (Kakao API)
         * 12. longitude API에서 받아온 위도-x축 (Kakao API)
         * 13. region_2depth_name 지도사용 2depth info (Kakao API)
         * 14. region_3depth_name 지도사용 3depth info (Kakao API)
         * 15. userno 세션에서 가져올 회원번호 (Session에서 값 주입)
         */

        /** room ** parameter 수신 (10 / 15) except(5) - confirmdate(1), address API(4) */
        int roomno = Integer.parseInt(paramMap.get("roomno"));
        String roomtype = paramMap.get("roomtype");
        String title = paramMap.get("title");
        int floor = Integer.parseInt(paramMap.get("floor"));
        float area = Float.parseFloat(paramMap.get("area"));
        int fee = Integer.parseInt(paramMap.get("fee"));
        String dong = paramMap.get("dong");
        String ho = paramMap.get("ho");
        String address = paramMap.get("address");

        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        int userno = loginInfo.getUserno();

        /***
         * Info DB TABLE (15 Columns)
         * Column name(params) Description info
         * 1. feeitem - o 관리비 항목 8개 - 2진법 SUM 저장 및 인수분해로 추출
         * 2. parking - o 주차 및 주차비 여부 불가능 - -1 ; 가능 무료 - 0 ; 가능 가격o - int
         * 3. pet - o 애완동물 가능 여부
         * 4. elevator - o 엘리베이터 여부
         * 5. veranda - o 베란다 여부
         * 6. builtin - o 빌트인 여부
         * 7. optionitem - o 옵션 항목 선택 13개 - 2진법 SUM 저장 및 인수분해로 추출
         * 8. loan - o 대출 가능 여부
         * 9. supplyarea - o 공급면적
         * 10. maxfloor - o 매물의 전체 층수
         * 11. heater - o 난방 종류
         * 12. commingday - o 입주가능일
         * 13. buildtype - o 건물유형
         * 14. content - o 상세 설명
         * 15. roomno 방 번호 참조키 - room DB 입력시 생성될 PRI값 주입
         */

        /** info ** parameter 수신 (14 / 15) - except(1) roomno - mul */
        /** 관리비 항목 2진법 계산해서 DB 넣기 */
        int parking = Integer.parseInt(paramMap.get("parking"));
        int pet = Integer.parseInt(paramMap.get("pet"));
        int elevator = Integer.parseInt(paramMap.get("elevator"));
        int veranda = Integer.parseInt(paramMap.get("veranda"));
        int builtin = Integer.parseInt(paramMap.get("builtin"));

        /** 옵션항목 2진법 계산해서 DB 넣기 */
        // feeitem
        String feeitem = paramMap.get("feeitem"); // 관리비항목 계산해서 넣기

        log.debug("로그기록임!!" + feeitem);
        log.error(feeitem);
        log.info(feeitem);

        String[] feeitems = null;
        if (feeitem != null) {
            feeitems = feeitem.split(",");
        }

        int sum_fee = 0;
        if (feeitems != null) {
            for (String item : feeitems) {
                int bin_fee = Integer.parseInt(item);
                sum_fee += bin_fee;
            }
        }

        // optionitem
        String optionitem = paramMap.get("optionitem");

        String[] optionitems = null;
        if (optionitem != null) {
            optionitems = optionitem.split(",");
        }

        int sum_option = 0;
        if (optionitems != null) {
            for (String item : optionitems) {
                int bin_option = Integer.parseInt(item);
                sum_option += bin_option;
            }
        }

        int loan = Integer.parseInt(paramMap.get("loan"));
        float supplyarea = Float.parseFloat(paramMap.get("supplyarea"));
        int maxfloor = Integer.parseInt(paramMap.get("maxfloor"));
        int heater = Integer.parseInt(paramMap.get("heater"));
        String commingday = paramMap.get("commingday");
        String buildtype = paramMap.get("buildtype");
        String content = paramMap.get("content");

        /***
         * Price DB TABLE (6 Columns)
         * Column name(params) Description info
         * 1. priceno 가격정보 번호 (Auto Increment)
         * 3. dealingtype - o 매물종류 월세-o, 전세-o, 매매-o
         * 2. deposit - o 보증금 월세-o, 전세-x, 매매-x
         * 4. price - o 금액 월세-o, 전세-o, 매매-o
         * 5. short_room - o 단기가능 여부
         * 6. roomno 방번호 참조키 - room DB 입력시 생성될 PRI값 주입
         */

        /** price ** parameter 수신 */
        String priceno = paramMap.get("priceno");
        String dealingtype = paramMap.get("dealingtype");
        String deposit = paramMap.get("deposit");
        String price = paramMap.get("price");
        String short_room = paramMap.get("short_room");

        String[] pricenos = null;
        String[] dealingtypes = null;
        String[] deposits = null;
        String[] prices = null;

        if (priceno != null) {
            pricenos = priceno.split(",");
        }
        if (dealingtype != null) {
            dealingtypes = dealingtype.split(",");
        }
        if (deposit != null) {
            deposits = deposit.split(",");
        }
        if (price != null) {
            prices = price.split(",");
        }

        /** * * 3) 데이터 저장하기 * * */
        Room input_R = new Room();
        Info input_I = new Info();

        /** (1) room 정보 받아오기 */
        input_R.setRoomno(roomno);
        input_R.setRoomtype(roomtype);
        input_R.setTitle(title);
        input_R.setFloor(floor);
        input_R.setArea(area);
        input_R.setFee(fee);
        input_R.setAddress(address);
        input_R.setDong(dong);
        input_R.setHo(ho);
        input_R.setUserno(userno);

        /***
         * KakaoSearch API 통해 주소정보 5가지 - (위도, 경도, 2depth, 3depth, road_address) 수신 및 쓰기
         */

        /** 1. API 연동 객체 생성 */
        Retrofit retrofit = retrofitHelper.getRetrofit(ApiKakaoSearchService.BASE_URL);
        ApiKakaoSearchService apiKakaoSearchService = retrofit.create(ApiKakaoSearchService.class);

        /** 2. 파라미터 처리 */

        String query = paramMap.get("address");

        String temp_address = paramMap.get("address");
        String temp_region_2depth_name = paramMap.get("region_2depth_name");
        String temp_region_3depth_name = paramMap.get("region_3depth_name");
        Double temp_latitude = Double.parseDouble(paramMap.get("latitude"));
        Double temp_longitude = Double.parseDouble(paramMap.get("longitude"));

        /** 3. KAKAO API 요청 */
        Address kakaoAddress = null;
        if (!query.equals("")) {
            Call<Address> call = apiKakaoSearchService.getAddress(query);
            try {
                kakaoAddress = call.execute().body();
            } catch (Exception e) {
                e.printStackTrace();
            }

            List<Documents> list = kakaoAddress.getDocuments();

            for (Documents item : list) {
                input_R.setRegion_2depth_name(item.getRoad_address().region_2depth_name);
                input_R.setRegion_3depth_name(item.getRoad_address().region_3depth_name);
                input_R.setLongitude(Double.parseDouble(item.getRoad_address().x));
                input_R.setLatitude(Double.parseDouble(item.getRoad_address().y));
            }
        }

        if (input_R.getRegion_2depth_name() == null) {
            input_R.setAddress(temp_address);
            input_R.setRegion_2depth_name(temp_region_2depth_name);
            input_R.setRegion_3depth_name(temp_region_3depth_name);
            input_R.setLongitude(temp_latitude);
            input_R.setLatitude(temp_longitude);
        }

        /***
         * KakaoSearch API End
         */

        /** (2) info정보 받아오기 */
        input_I.setFeeitem(sum_fee);

        // 주차가능 체크박스에 체크되어 있다면? 금액정보를 가져와 인풋
        if (parking == 1) {
            parking = webHelper.getInt("parking_val");
        }

        input_I.setParking(parking);
        input_I.setPet(pet);
        input_I.setElevator(elevator);
        input_I.setVeranda(veranda);
        input_I.setBuiltin(builtin);
        input_I.setOptionitem(sum_option);
        input_I.setLoan(loan);
        input_I.setSupplyarea(supplyarea);
        input_I.setMaxfloor(maxfloor);
        input_I.setHeater(heater);
        input_I.setCommingday(commingday);
        input_I.setBuildtype(buildtype);
        input_I.setContent(content);
        input_I.setRoomno(roomno);

        /** * * 4) DB 수정하기 * * */

        /** 1. room DB 데이터 수정 */

        try {
            roomService.editRoom(input_R);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 2. info DB 데이터 수정 */

        try {
            infoService.editInfo(input_I);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());

        }

        /** 3. price DB 데이터 수정 및 추가 저장 {ing} */
        try {

            Price input_p = new Price();
            int priceno_temp = 0;
            int deposit_temp = 0;
            int price_temp = 0;

            int priceno_size = pricenos.length;
            int deposit_size = deposits.length;

            // 수정하는 경우의 수
            if (priceno_size == deposit_size) {

                for (int i = 0; i < deposits.length; i++) {

                    if (pricenos[i] != null || pricenos[i] != "") {
                        priceno_temp = Integer.parseInt(pricenos[i]);
                    } // 가격테이블번호가 있다면 할당
                    if (deposits[i] != null || deposits[i] != "") {
                        deposit_temp = Integer.parseInt(deposits[i]);
                    } // 보증금값이 있다면 할당
                    if (prices[i] != null || prices[i] != "") {
                        price_temp = Integer.parseInt(prices[i]);
                    } // 가격값이 있다면 할당

                    // 빈즈에 담기
                    input_p.setPriceno(priceno_temp);
                    input_p.setDeposit(deposit_temp);
                    input_p.setDealingtype(dealingtypes[i]);
                    input_p.setPrice(price_temp);
                    input_p.setShort_room(short_room);
                    input_p.setRoomno(roomno);

                    priceService.editPrice(input_p);
                }

            }
            
            // 추가하는 경우의 수
            else if (priceno_size < deposit_size) {
                // 수정하기
                for (int i = 0; i < priceno_size; i++) {
                	
                	// 가격테이블번호가 있다면 할당
                    if (pricenos[i] != null || pricenos[i] != "") {
                        priceno_temp = Integer.parseInt(pricenos[i]);
                    } 
                    
                    // 보증금값이 있다면 할당
                    if (deposits[i] != null || deposits[i] != "") {
                        deposit_temp = Integer.parseInt(deposits[i]);
                    }
                    
                    // 가격값이 있다면 할당
                    if (prices[i] != null || prices[i] != "") {
                        price_temp = Integer.parseInt(prices[i]);
                    }

                    // 빈즈에 담기
                    input_p.setPriceno(priceno_temp);
                    input_p.setDeposit(deposit_temp);
                    input_p.setDealingtype(dealingtypes[i]);
                    input_p.setPrice(price_temp);
                    input_p.setShort_room(short_room);
                    input_p.setRoomno(roomno);

                    priceService.editPrice(input_p);
                }

                // 추가하기
                for (int i = priceno_size; i < deposit_size; i++) {

                    if (deposits[i] != null || deposits[i] != "") {
                        deposit_temp = Integer.parseInt(deposits[i]);
                    } // 보증금값이 있다면 할당
                    if (prices[i] != null || prices[i] != "") {
                        price_temp = Integer.parseInt(prices[i]);
                    } // 가격값이 있다면 할당

                    // 빈즈에 담기
                    input_p.setDeposit(deposit_temp);
                    input_p.setDealingtype(dealingtypes[i]);
                    input_p.setPrice(price_temp);
                    input_p.setShort_room(short_room);
                    input_p.setRoomno(roomno);

                    priceService.addPrice(input_p);
                }

            }

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        String redirectUrl = contextPath + "/main/rmdt.do?roomno=" + input_R.getRoomno();
        return webHelper.redirect(redirectUrl, "수정되었습니다.");

    }

    /********************************************************************
     * 공실 수정하기 가격 테이블 행삭제 _ok_delPrice
     * 
     * @return
     *******************************************************************/
    @RequestMapping(value = "/host/rm_edit_delPrice.do", method = RequestMethod.POST)
    public ModelAndView rm_edit_delPrice(@RequestParam(value = "priceno", defaultValue = "") int priceno) {

        Price input = new Price();
        input.setPriceno(priceno);

        try {
            priceService.deletePrice(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        return null;

    }

    /********************************************************************
     * 공실 수정하기 이미지 테이블 행삭제 _ok_delImage
     * 
     * @return
     *******************************************************************/
    @RequestMapping(value = "/host/rm_edit_delImage.do", method = RequestMethod.POST)
    public ModelAndView rm_edit_delImage() {

        int imageno = webHelper.getInt("imageno");

        UploadItem input = new UploadItem();
        input.setImageno(imageno);

        UploadItem output = null;

        try {
            output = uploadService.getUploadItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        log.debug(output.getThumbnail() + ":::::::::::::::::::::::::");

        if (output.getThumbnail() != null) {
            String f = output.getThumbnail();
            if (f.substring(0, 1).equals("/")) {
                f = f.substring(1);
            }
            File thumbnail = new File(webHelper.getUploadDir(), f);
            boolean del_ok1 = thumbnail.delete();
            System.out.println("thumbnail 삭제성공여부 :" + del_ok1);

        }

        if (output.getFileName() != null) {
            String f = output.getFileName();
            if (f.substring(0, 1).equals("/")) {
                f = f.substring(1);
            }
            File originalFile = new File(webHelper.getUploadDir(), f);
            boolean del_ok2 = originalFile.delete();
            System.out.println("originalFile 삭제성공여부 :" + del_ok2);

        }

        try {
            uploadService.deleteUploadItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        return null;

    }

    /********************************************************************
     * 공실 수정하기 이미지 테이블 행추가 _ok_addImage
     * 
     * @return
     *******************************************************************/
    @RequestMapping(value = "/host/rm_edit_addImage.do", method = RequestMethod.POST)
    public ModelAndView rm_edit_addImage() {

        /**
         * UPLOAD
         */

        try {
            webHelper.upload();
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        List<UploadItem> fileList = webHelper.getFileList();
        Map<String, String> paramMap = webHelper.getParamMap();

        int roomno = Integer.parseInt(paramMap.get("roomno"));
        // 조회결과의 Beans에 추가 후 로그를 통해 내역 확인
        for (UploadItem item : fileList) {

            String thumbnail = null;

            try {
                thumbnail = downloadHelper.createThumbnail(item.getFilePath(), 320, 320, false);
            } catch (Exception e1) {
                e1.printStackTrace();
            }

            item.setFieldName(item.getFieldName());
            item.setOriginName(item.getOriginName());
            item.setFilePath(item.getFilePath());
            item.setContentType(item.getContentType());
            item.setFileSize(item.getFileSize());
            item.setFileName(item.getFileName());
            item.setRegDate(item.getRegDate());
            item.setEditDate(item.getEditDate());
            item.setRoomno(roomno);
            item.setThumbnail(thumbnail);
            log.debug("업로드 될 항목" + item.toString());

            // DB에 저장하기
            try {
                uploadService.addUploadItem(item);
            } catch (Exception e) {
                log.error(e.getLocalizedMessage());
                e.printStackTrace();
                return webHelper.redirect(null, e.getLocalizedMessage());
            }
        } // end for

        return null;

    }

    /********************************************************************
     * 공실관리
     *******************************************************************/
    @RequestMapping(value = "/host/rmli.do", method = RequestMethod.GET)
    public ModelAndView rmli(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");

        if (loginInfo == null) {
            return webHelper.redirect(null, "로그인 후 공실관리가 가능합니다.");
        }

        /** 1) 필요한 변수값 생성 */
        int userno = loginInfo.getUserno();
        int status = 0;

        if (webHelper.getInt("status") != 0 || webHelper.getInt("status") != 0) {
            status = webHelper.getInt("status");
            System.out.println(status);
        }

        // 페이징 처리
        int nowPage = webHelper.getInt("page", 1); // 페이지번호 (기본값 1)
        int totalCount = 0; // 전체 게시글 수
        int listCount = 10; // 한 페이지당 표시할 목록 수
        int pageCount = 5; // 한 그룹당 표시할 페이지 번호 수

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Room input_room = new Room();
        input_room.setUserno(userno);
        input_room.setStatus(status);

        PageData pageData = null;
        List<Room> output_room = null;
        String rememberChecked = "";

        try {
            // 전체 매물 수 조회
            totalCount = roomService.getRoomCount(input_room);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Room.setOffset(pageData.getOffset());
            Room.setListCount(pageData.getListCount());
            output_room = roomService.getRoomList_host_rmli1(input_room);
            /* room 테이블 조인문 불러오기 */
            if (status == 0) {
                output_room = roomService.getRoomList_host_rmli1(input_room);
                totalCount = roomService.getRoomCount(input_room);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            } else if (status == 1) {
                rememberChecked = "1"; // 확인매물
                output_room = roomService.getRoomList_host_rmli2(input_room);
                totalCount = roomService.getRoomCount(input_room);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            } else if (status == 2) {
                rememberChecked = "2"; // 허위매물
                output_room = roomService.getRoomList_host_rmli3(input_room);
                totalCount = roomService.getRoomCount(input_room);
                pageData = new PageData(nowPage, totalCount, listCount, pageCount);
            }

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** View 처리 */
        model.addAttribute("output", output_room);
        model.addAttribute("pageData", pageData);
        model.addAttribute("rememberChecked", rememberChecked);

        return new ModelAndView("host/rmli");
    }

    /********************************************************************
     * 공실관리 매물 삭제
     *******************************************************************/
    @RequestMapping(value = "/host/rmli_delete.do", method = RequestMethod.GET)
    public ModelAndView remove() {

        /** 1) 필요한 변수값 생성 */
        // 삭제할 대상에 대한 PK값
        int roomno = webHelper.getInt("roomno");

        // 이 값이 존재하지 않는다면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (roomno == 0) {
            return webHelper.redirect(null, "회원번호가 없습니다.");
        }

        /** 2) 데이터 삭제하기 */
        // 데이터 삭제에 필요한 조건값을 Beans에 저장하기
        Room input = new Room();
        input.setRoomno(roomno);

        try {
            // 데이터 수
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            roomService.deleteRoom(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        String viewPath = contextPath + "/host/rmli.do";
        return webHelper.redirect(viewPath, "삭제되었습니다");
    }

    /********************************************************************
     * 공실관리 공실상태 전환하기
     *******************************************************************/
    @RequestMapping(value = "/host/rmli_status.do", method = RequestMethod.GET)
    public ModelAndView rmli_status(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");

        if (loginInfo == null) {
            return webHelper.redirect(null, "로그인 후 공실관리가 가능합니다.");
        }

        /** 1) 필요한 변수값 생성 */
        //int userno = loginInfo.getUserno();
        int roomno = webHelper.getInt("roomno");
        int status = webHelper.getInt("status");

        /** 2) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Room input = new Room();
        input.setRoomno(roomno);
        input.setStatus(status);

        try {

            roomService.updateStatus(input);

        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        return null;
    }
}
