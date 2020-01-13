package project.star.b2.service;

import java.util.List;

import project.star.b2.model.Price;

public interface PriceService {
    /**
     * @param 가격 정보를 조회
     * @return
     * @throws Exception
     */
    public Price getPriceItem(Price input) throws Exception;

    /**
     * @param 조회정보 결과 조회 by_roomno
     * @return 컬렉션 형태로 반환
     * @throws Exception
     */
    public List<Price> getPriceList_by_roomno(Price input) throws Exception;

    /**
     * @param 조회정보 결과 조회
     * @return 컬렉션 형태로 반환
     * @throws Exception
     */
    public List<Price> getPriceList(Price input) throws Exception;

    /**
     * @param 가격 정보의 갯수를 조회
     * @return int
     * @throws Exception
     */
    public int getPriceCount(Price input) throws Exception;

    /**
     * @param 가격 정보를 추가하기
     * @return int
     * @throws Exception
     */
    public int addPrice(Price input) throws Exception;

    /**
     * @param 가격 정보를 수정
     * @return int
     * @throws Exception
     */
    public int editPrice(Price input) throws Exception;

    /**
     * @param 가격 정보를 삭제
     * @return int
     * @throws Exception
     */
    public int deletePrice(Price input) throws Exception;

    /**
     * @param 체크박스 값들을 가져와서 비교하기 목록 조회
     * @return
     * @throws Exception
     */
    public List<Price> getCompareList(List<String> input) throws Exception;
}