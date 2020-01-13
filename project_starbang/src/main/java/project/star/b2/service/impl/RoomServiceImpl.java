package project.star.b2.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.model.FakeRoom;
import project.star.b2.model.Room;
import project.star.b2.service.RoomService;

/** Room테이블 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service
public class RoomServiceImpl implements RoomService {

    /** MyBatis */
    @Autowired
    SqlSession sqlSession;

    /**
     * Room테이블 데이터 상세 조회
     * 
     * @param 조회할 Room테이블의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    @Override
    public Room getRoomItem(Room input) throws Exception {
        Room result = null;

        try {
            result = sqlSession.selectOne("RoomMapper.selectItem", input);

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

    /**
     * Room테이블 데이터 목록 조회
     * 
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public List<Room> getRoomList(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectList", input);

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

    /**
     * 공실관리 전체 조회하기
     */
    @Override
    public List<Room> getRoomList_host_rmli1(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectList_host_rmli1", input);

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

    /**
     * 공실관리 공개 조회하기
     */
    @Override
    public List<Room> getRoomList_host_rmli2(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectList_host_rmli2", input);

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

    /**
     * 공실관리 비공개 조회하기
     */
    @Override
    public List<Room> getRoomList_host_rmli3(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectList_host_rmli3", input);

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

    @Override
    public int updateStatus(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("RoomMapper.updateStatus", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
    }

    /**
     * Room테이블 데이터가 저장되어 있는 갯수 조회
     * 
     * @return int
     * @throws Exception
     */
    @Override
    public int getRoomCount(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.selectOne("RoomMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
    }

    /**
     * Room테이블 데이터 등록하기
     * 
     * @param 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int addRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("RoomMapper.insertItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("저장된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 저장에 실패했습니다.");
        }

        return result;
    }

    /**
     * Room테이블 데이터 수정하기
     * 
     * @param 수정할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int editRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("RoomMapper.updateItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
    }

    /**
     * Room테이블 데이터 삭제하기
     * 
     * @param 삭제할 일련번호를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int deleteRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("RoomMapper.deleteItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("삭제된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 삭제에 실패했습니다.");
        }

        return result;
    }

    @Override
    public int editConfirmRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("RoomMapper.updateConfirmItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
    }

    @Override
    public int editHiddenRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("RoomMapper.updateHiddenItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
    }

    @Override
    public List<Room> getRoomCheckList(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectCheckList", input);

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

    @Override
    public List<Room> getRoomCheckConfirmList(Room input) throws Exception {
        List<Room> result = null;

        try {
            result = sqlSession.selectList("RoomMapper.selectCheckConfirmList", input);

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

    @Override
    public int addFakeRoom(FakeRoom input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("FakeRoomMapper.insertItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("저장된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 저장에 실패했습니다.");
        }

        return result;
    }

    @Override
    public int editFakeRoom(Room input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("RoomMapper.updateFakeItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
    }

    /**
     * 허위매물 상세 조회
     * 
     * @param FakeRoom 저장할 정보를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    @Override
    public FakeRoom getFakeRoomItem(FakeRoom input) throws Exception {
        FakeRoom result = null;

        try {
            result = sqlSession.selectOne("FakeRoomMapper.selectItem", input);

        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
    }
}