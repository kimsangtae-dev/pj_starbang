package project.star.b2.model;

import lombok.Data;

@Data
public class FakeRoom {
    private int fakeno; // 허위매물의 고유 일련번호
    private String regdate; // 허위매물 등록일자
    private int reason; // 허위매물 신고사유
    private int roomno; // 신고당한 매물번호 / room 참조키
    private int userno; // 신고당한 회원번호 / user 참조키
    private int singo; // 신고한 회원번호
}
