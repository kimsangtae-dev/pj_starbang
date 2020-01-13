package project.star.b2.model;

import lombok.Data;

/** 테이블 구조에 맞춘 Java Beans 생성 */
@Data
public class Room {
    private int roomno; // 방 번호
    private String roomtype; // 방 종류
    private String title; // 제목
    private int floor; // 층
    private float area; // 전용면적
    private int fee; // 관리비
    private String confirmdate; // 확인매물
    private String address; // 주소
    private String dong; // 주소 (동)
    private String ho; // 주소 (호)
    private double latitude; // 위도
    private double longitude; // 경도
    private String region_2depth_name; // 지역 2depth
    private String region_3depth_name; // 지역 3depth
    private int userno; // 유저 번호
    private int status; // 상태
    private int cnt; // select count(roomno)된 값

    /** User랑 조인된 값 */
    private String name; // 유저 이름

    /** 가격이랑 조인된 값 */
    private String price; // 가격
    private String deposit; // 보증금 ,전세
    private String dealingtype; // 거래종류

    /** 페이지 구현이 필요한 경우 아래 속성들을 추가한다. (static) */
    private static int offset; // LIMIT 절에서 사용할 검색 시작 위치
    private static int listCount; // LIMIT 절에서 사용할 검색할 데이터 수

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        Room.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        Room.listCount = listCount;
    }

}
