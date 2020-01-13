package project.star.b2.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.helper.MailHelper;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.WebHelper;
import project.star.b2.model.User;
import project.star.b2.service.UserService;

@Slf4j
@Controller
public class MailController {

    /** WebHelper 주입 */
    @Autowired
    WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired
    RegexHelper regexHelper;

    @Autowired
    MailHelper mailHelper;

    @Autowired
    UserService userService;

    /** 회원가입 메일인증번호 action 페이지 */
    @RequestMapping(value = "/modal/joinema.do", method = RequestMethod.POST)
    public ModelAndView join(Model model) {

        /** 사용자의 입력값 받기 */
        String to = webHelper.getString("allemail");
        String subject = "별방의 회원가입 메일 확인번호 확인 메일입니다";
        int ran = webHelper.getInt("auth");
        String content = "별방의 회원가입 메일 확인번호는" + ran + "입니다";
        log.debug("----------------------------------------------------");
        log.debug(String.format("controlloer To: %s", to));
        log.debug(String.format("controlloer Subject: %s", subject));
        log.debug(String.format("controlloer Content: %s", content));
        log.debug("----------------------------------------------------");

        /** 입력여부 검사후, 입력되지 않은 경우 이전 페이지로 보내기 */
        // 받는 메일 주소 검사하기
        if (!regexHelper.isValue(to)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소를 입력하세요.");
        }

        if (!regexHelper.isEmail(to)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소가 잘못되었습니다.");
        }

        /** 메일 발송 처리 */
        try {
            // sendMail() 메서드 선언시 throws를 정의했기 때문에 예외처리가 요구된다.
            mailHelper.sendMail(to, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
            return webHelper.redirect(null, "메일 발송에 실패했습니다.");
        }

        /** 결과처리 */
        return webHelper.redirect(null, "메일 발송에 성공했습니다.");
    }

    /** mypage 메일 인증 번호 action 페이지 */
    @RequestMapping(value = "/main/mypageema.do", method = RequestMethod.POST)
    public ModelAndView mypageema(Model model) {

        /** 사용자의 입력값 받기 */
        String to = webHelper.getString("email");
        String subject = "별방의 메일 변경 확인번호 확인 메일입니다";
        int ran = webHelper.getInt("auth");
        String content = "별방의 메일 변경 확인번호는" + ran + "입니다";
        log.debug("----------------------------------------------------");
        log.debug(String.format("controlloer To: %s", to));
        log.debug(String.format("controlloer Subject: %s", subject));
        log.debug(String.format("controlloer Content: %s", content));
        log.debug("----------------------------------------------------");

        /** 입력여부 검사후, 입력되지 않은 경우 이전 페이지로 보내기 */
        // 받는 메일 주소 검사하기
        if (!regexHelper.isValue(to)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소를 입력하세요.");
        }

        if (!regexHelper.isEmail(to)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소가 잘못되었습니다.");
        }

        /** 메일 발송 처리 */
        try {
            // sendMail() 메서드 선언시 throws를 정의했기 때문에 예외처리가 요구된다.
            mailHelper.sendMail(to, subject, content);
        } catch (Exception e) {
            e.printStackTrace();
            return webHelper.redirect(null, "메일 발송에 실패했습니다.");
        }

        /** 결과처리 */
        return webHelper.redirect(null, "메일 발송에 성공했습니다.");
    }

    /********************************************************************
     * 비밀번호 찾기 URL 인증 전송 페이지
     *******************************************************************/

    @RequestMapping(value = "/modal/pwd_ok.do", method = RequestMethod.POST)
    public ModelAndView pwd_ok(Model model, HttpServletRequest request) {
        /** 사용자의 입력값 받기 */
        String email = webHelper.getString("email");
        HttpSession session = request.getSession();
        session.setAttribute("fullemail", email);
        session.setMaxInactiveInterval(60 * 60);

        String subject = "비밀번호 변경을 위한 링크 주소입니다";
        String content = "별방의 비밀번호 재설정입니다. 링크를 클릭해주세요." + "  http://itproject.ezenac.co.kr/b2/main/repwd.do"; // 서버(이젠)
        // String content = "별방의 비밀번호 재설정입니다. 링크를 클릭해주세요." + "  http://localhost:8080/b2/main/repwd.do"; // 로컬

        log.debug("----------------------------------------------------");
        log.debug(String.format("controlloer To: %s", email));
        log.debug(String.format("controlloer Subject: %s", subject));
        log.debug(String.format("controlloer Content: %s", content));
        log.debug("----------------------------------------------------");

        /** 입력여부 검사후, 입력되지 않은 경우 이전 페이지로 보내기 */
        // 받는 메일 주소 검사하기
        if (!regexHelper.isValue(email)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소를 입력하세요.");
        }

        if (!regexHelper.isEmail(email)) {
            return webHelper.redirect(null, "받는 사람의 이메일 주소가 잘못되었습니다.");
        }

        // 2) 사용자가 입력한 이메일 값을 Beans에 저장
        User input = new User();
        input.setEmail(email);


        try {
            userService.getUserEmail(input);
            /** 메일 발송 처리 */
            try {
                // sendMail() 메서드 선언시 throws를 정의했기 때문에 예외처리가 요구된다.
                mailHelper.sendMail(email, subject, content);
            } catch (Exception e) {
                e.printStackTrace();
                return webHelper.redirect(null, "메일 발송에 실패했습니다.");
            }

            /** 결과처리 */
            return webHelper.redirect("/b2", "메일 발송에 성공했습니다.");
        } catch (Exception e) {
            e.getLocalizedMessage();
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
    }

}
