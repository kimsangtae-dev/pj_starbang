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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.helper.DownloadHelper;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.UploadItem;
import project.star.b2.model.User;
import project.star.b2.service.UploadService;
import project.star.b2.service.UserService;

@Slf4j
@Controller
public class UploadController {
    @Autowired
    WebHelper webHelper;

    @Autowired
    DownloadHelper downloadHelper;

    @Autowired
    RegexHelper regexHelper;

    @Autowired
    UploadService uploadservice;

    @Autowired
    UserService userService;

    /** "/프로젝트이름"에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;

    /** 업로드 폼을 구성하는 페이지 */
    @RequestMapping(value = "/upload/upload.do", method = RequestMethod.GET)
    public String upload() {
        return "upload/upload";
    }

    /** 업로드 폼에 대한 action 페이지 */
    @RequestMapping(value = "/upload/upload_ok.do", method = RequestMethod.POST)
    public ModelAndView uploadOk(Model model) {
        /** 1) 업로드를 수행 */
        try {
            webHelper.upload();
        } catch (Exception e) {
            e.printStackTrace();
            return webHelper.redirect(null, "업로드에 실패했습니다.");
        }

        /** 2) 업로드 된 정보 추출하기 */
        // 파일 정보 추출
        List<UploadItem> fileList = webHelper.getFileList();

        // 조회결과의 Beans에 검색 날짜 추가 후 로그를 통해 내역 확인
        for (UploadItem item : fileList) {
            item.setFieldName(item.getFieldName());
            item.setOriginName(item.getOriginName());
            item.setFilePath(item.getFilePath());
            item.setContentType(item.getContentType());
            item.setFileSize(item.getFileSize());
            item.setFileName(item.getFileName());
            item.setRegDate(item.getRegDate());
            item.setEditDate(item.getEditDate());
            item.setRoomno(item.getRoomno());
            log.debug(item.toString());

            // DB에 저장하기
            try {
                uploadservice.addUploadItem(item);
            } catch (Exception e) {
                log.error(e.getLocalizedMessage());
                e.printStackTrace();
            }
        }

        /** 3) 업로드 결과를 View에게 전달한다 */
        model.addAttribute("fileList", fileList);

        // 중단 없이 정상적인 실행 종료를 통해 View를 호출해야 하는 경우
        // View의 경로를 ModelAndView 타입의 객체로 생성하여 리턴한다.
        String viewPath = "upload/upload_ok";
        return new ModelAndView(viewPath);
    }

    /** 파일 다운로드 및 썸네일을 생성하는 페이지 */
    // --> 다운로드 ex) /upload/download.do?file=이미지경로&origin=원본파일이름
    // --> 썸네일 ex) /upload/download.do?file=이미지경로&size=240x320&crop=true
    @RequestMapping(value = "/upload/download.do", method = RequestMethod.GET)
    public ModelAndView download(Model model, @RequestParam(value = "file") String filePath, @RequestParam(value = "origin", required = false) String originName, @RequestParam(value = "size", required = false) String size,
            @RequestParam(value = "crop", defaultValue = "false", required = false) String crop) {
        // 서버상에 저장되어 있는 파일경로 (필수)
        // String filePath = webHelper.getString("file");
        // 원본 파일이름 (미필수)
        // String originName = webHelper.getString("origin");
        // 축소될 이미지 해상도 --> 320x320
        // String size = webHelper.getString("size");
        // 이미지 크롭 여부 --> 값이 없을 경우 기본값 false
        // String crop = webHelper.getString("crop", "false");

        /** 다운로드 스트림 출력하기 */
        if (filePath != null) {
            try {
                // 썸네일 생성을 위해 축소될 이미지의 사이즈가 요청되었다면?
                if (size != null) {
                    // x를 기준으로 나눠서 숫자로 변환
                    String[] temp = size.split("x");
                    int width = Integer.parseInt(temp[0]);
                    int height = Integer.parseInt(temp[1]);

                    // 모든 파라미터는 문자열이므로 크롭 여부를 boolean으로 재설정
                    boolean is_crop = false;
                    if (crop.equals("true")) {
                        is_crop = true;
                    }

                    // 썸네일 생성 후 다운로드 처리
                    downloadHelper.download(filePath, width, height, is_crop);
                } else {
                    // 원본에 대한 다운로드 처리
                    downloadHelper.download(filePath, originName);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // View를 사용하지 않고 FileStream을 출력하므로 리턴값은 없다.
        return null;
    }

    /** 마이페이지 프로필 업로드 폼을 구성하는 페이지 */
    @RequestMapping(value = "/main/mypageProfile.do", method = RequestMethod.GET)
    public String mypageupload() {

        return "main/mypage";
    }

    /** 마이페이지 프로필 업로드 폼에 대한 action 페이지 */
    @RequestMapping(value = "/main/Profileupload_ok.do", method = RequestMethod.POST)
    public ModelAndView ProfileuploadOk(Model model, HttpServletRequest request) {

        /** 1) 업로드를 수행 */
        try {
            webHelper.profileUpload();
            log.debug("profileUpload();다녀왔다");
        } catch (Exception e) {
            e.printStackTrace();
            return webHelper.redirect(null, "업로드에 실패했습니다.");
        }

        /** 2) 업로드 된 정보 추출하기 */
        // 파일 정보 추출
        List<User> fileList = webHelper.getProfileFile();

        if (fileList == null) {
            return webHelper.redirect(null, "파일이 없다.");
        }

        String transfer = null;

        // 조회결과의 Beans에 검색 날짜 추가 후 로그를 통해 내역 확인
        for (User item : fileList) {
            item.setUserno(item.getUserno());
            item.setName(item.getName());
            item.setEmail(item.getEmail());
            item.setPasswd(item.getPasswd());
            item.setTel(item.getTel());
            item.setRegdate(item.getRegdate());
            item.setProfile_img(item.getProfile_img());
            item.setEditdate(item.getEditdate());
            log.debug(item.toString());

            transfer = item.getProfile_img();

            // DB에 저장하기
            try {
                userService.addUploadProfileItem(item);
            } catch (Exception e) {
                log.error(e.getLocalizedMessage());
                e.printStackTrace();
            }
        }

        HttpSession session = request.getSession();
        User loginInfo = (User) session.getAttribute("loginInfo");
        loginInfo.setProfile_img(transfer);

        session.setAttribute("loginInfo", loginInfo);

        /** 3) 업로드 결과를 View에게 전달한다 */
        model.addAttribute("fileList", fileList);

        /*
         * webHelper.redirect(null, fileList + "");
         * 
         *//** 1)필요한 변수값 생성 */
        /*
         * int userno = 1; // 회원 이메일기저오기
         * 
         *//** 2)데이터 조회하기 */
        /*
         * // 조회에 필요한 조건값(검색어)를 Beans에 담는다. User input = new User();
         * input.setUserno(userno);
         * 
         * User output = null; // 조회결과가 저장될 객체
         * 
         * try { // 현재 로그인 되어있는 회원번호를 사용해 정보를 추출한다 output =
         * userService.getUserItem(input); } catch (Exception e) { return
         * webHelper.redirect(null, e.getLocalizedMessage()); }
         * 
         *//** 3)View 처리 *//*
                            * model.addAttribute("output", output);
                            */

        // 중단 없이 정상적인 실행 종료를 통해 View를 호출해야 하는 경우
        // View의 경로를 ModelAndView 타입의 객체로 생성하여 리턴한다.
//		String viewPath = "main/mypage";
        // return new ModelAndView("main/mypage");

        String redirectUrl = contextPath + "/main/mypage.do";
        return webHelper.redirect(redirectUrl, "저장완료");
    }

}
