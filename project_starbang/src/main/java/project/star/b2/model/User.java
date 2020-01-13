package project.star.b2.model;

import lombok.Data;

/** 테이블 구조에 맞춘 Java Beans 생성 */
@Data
public class User {
    private int userno; // 유저번호
    private String name; // 유저이름
    private String email; // 이메일
    private String passwd; // 비밀번호
    private String tel; // 휴대폰번호
    private String regdate; // 등록일자
    private String editdate; // 수정일자
    private String profile_img; // 프로필 이미지

    private String reason; // 탈퇴이유
    // private String regdate; // 탈퇴 날짜
    private String joindate; // 가입 날짜

    /** 페이지 구현이 필요한 경우 아래 속성들을 추가한다. (static) */
    private static int offset; // LIMIT 절에서 사용할 검색 시작 위치
    private static int listCount; // LIMIT 절에서 사용할 검색할 데이터 수

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        User.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        User.listCount = listCount;
    }
}
