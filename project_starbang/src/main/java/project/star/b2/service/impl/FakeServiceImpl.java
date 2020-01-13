package project.star.b2.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.model.FakeRoom;
import project.star.b2.service.FakeService;

@Slf4j
@Service
public class FakeServiceImpl implements FakeService {

    /** MyBatis */
    // --> import org.apache.ibatis.session.SqlSession
    @Autowired
    SqlSession sqlSession;

    /**
     * 매물 데이터 목록 조회
     * 
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public int addFake(FakeRoom input) throws Exception {
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<FakeRoom> getFakeItem(FakeRoom input) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<FakeRoom> getFakeList(FakeRoom input) throws Exception {
        List<FakeRoom> result = null;

        try {
            result = sqlSession.selectList("FakeRoomMapper.selectList", input);

            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("조회된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
    }

}
