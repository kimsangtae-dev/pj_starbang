package project.star.b2.service;

import project.star.b2.model.Info;
import project.star.b2.model.Price;
import project.star.b2.model.Room;

public interface RIPService {

    /**
     * 추가정보 데이터 등록하기
     * 
     * @param Room 테이블을 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    public int addRoom(Room input) throws Exception;

    /**
     * 추가정보 데이터 등록하기
     * 
     * @param Info 테이블을 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    public int addInfo(Info input) throws Exception;

    /**
     * 추가정보 데이터 등록하기
     * 
     * @param Price 테이블을 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    public int addPrice(Price input) throws Exception;

    // 조회를 위한 임시
    public Room getRoomItem(Room input) throws Exception;

    public Info getInfoItem(Info input) throws Exception;

}
