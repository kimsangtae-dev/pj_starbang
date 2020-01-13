package project.star.b2.model;

import lombok.Data;

@Data
public class Info {
    private int feeitem; // 관리비정보
    private int parking; // 주차정보
    private int pet; // 애완동물 가능 여부
    private int elevator; // 엘리베이터 여부
    private int veranda; // 베란다 여부
    private int builtin; // 빌트인 여부
    private int optionitem; // 옵션아이템여부
    private int loan; // 대출 여부
    private float supplyarea; // 공급면적
    private int maxfloor; // 건물 최대 층 수
    private int heater; // 히터여부
    private String commingday; // 입주일
    private String buildtype; // 건물유형
    private String content; // 상세내용
    private int roomno; // 방 번호
    private int chart1; // 오각형 그래프 차트 수치 첫번째 값
    private int chart2; // 오각형 그래프 차트 수치 두번째 값
    private int chart3; // 오각형 그래프 차트 수치 세번째 값
    private int chart4; // 오각형 그래프 차트 수치 네번째 값
    private int chart5; // 오각형 그래프 차트 수치 다섯번째 값

    /** 페이지 구현이 필요한 경우 아래 속성들을 추가한다. (static) */
    private static int offset; // LIMIT 절에서 사용할 검색 시작 위치
    private static int listCount; // LIMIT 절에서 사용할 검색할 데이터 수

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        Info.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        Info.listCount = listCount;
    }
}
