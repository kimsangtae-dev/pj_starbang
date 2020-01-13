package project.star.b2.service;

import java.util.List;

import project.star.b2.model.FakeRoom;

public interface FakeService {
    /**
     * 허위매물 추가
     * 
     * @return int
     * @throws Exception
     */
    public int addFake(FakeRoom input) throws Exception;

    /**
     * 허위매물 단일행 조회
     * 
     * @return 조회결과에 따른 값
     * @throws Exception
     */
    public List<FakeRoom> getFakeItem(FakeRoom input) throws Exception;

    /**
     * 허위매물 리스트 조회
     * 
     * @return 조회 결과에 따른 컬렉션 형태
     * @throws Exception
     */
    public List<FakeRoom> getFakeList(FakeRoom input) throws Exception;

}
