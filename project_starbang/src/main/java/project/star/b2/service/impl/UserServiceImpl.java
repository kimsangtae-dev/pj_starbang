package project.star.b2.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.model.User;
import project.star.b2.service.UserService;

/** 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service
public class UserServiceImpl implements UserService {

    /** MyBatis */
    @Autowired
    SqlSession sqlSession;

    /**
     * 학과 데이터 상세 조회
     * 
     * @param User 조회할 학과의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    @Override
    public User getUserItem(User input) throws Exception {
        User result = null;

        try {
            result = sqlSession.selectOne("UserMapper.selectItem", input);

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
     * 데이터 목록 조회
     * 
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public List<User> getUserList(User input) throws Exception {
        List<User> result = null;

        try {
            result = sqlSession.selectList("UserMapper.selectList", input);

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
     * 데이터가 저장되어 있는 갯수 조회
     * 
     * @return int
     * @throws Exception
     */
    @Override
    public int getUserCount(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.selectOne("UserMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
    }

    /**
     * 데이터 등록하기
     * 
     * @param User 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int addUser(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("UserMapper.insertItem", input);

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
     * 데이터 수정하기
     * 
     * @param User 수정할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int editUser(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UserMapper.updateItem", input);

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
     * 데이터 삭제하기
     * 
     * @param User 삭제할 학과의 일련번호를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int deleteUser(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("UserMapper.deleteItem", input);

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

    /**
     * 유저 email 조회하기
     * 
     * @param User 조회할 email 를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public User getUserLogin(User input) throws Exception {
        User result = null;

        try {
            result = sqlSession.selectOne("UserMapper.selectlogin", input);

            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("회원정보가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("로그인에 실패했습니다.");
        }

        return result;
    }

    /**
     * 유저 email 중복체크하기
     * 
     * @throws Exception
     */
    @Override
    public int idCheck(String email) throws Exception {
        int result = sqlSession.selectOne("UserMapper.idCheck", email);
        return result;
    }

    /**
     * 비번 변경) DB에 있는 이메일 중복 조회
     */
    @Override
    public User getUserEmail(User input) throws Exception {
        User result = null;

        try {
            result = sqlSession.selectOne("UserMapper.selectEmail", input);

            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("가입된 이메일이 아닙니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("이메일 검색에 실패했습니다.");
        }

        return result;
    }

    /**
     * 비번 변경) 패스워드 변경
     */
    @Override
    public int getPassword(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UserMapper.updatePassword", input);

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
     * 마이페이지에서 프로필 수정
     */
    @Override
    public int addUploadProfileItem(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UserMapper.updateProfileItem", input);

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
     * 마이페이지에서 회원수정
     */
    @Override
    public int editUserMyPage(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UserMapper.mypageupdateItem", input);

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

    /** 회원 탈퇴 이유 */
    @Override
    public int outUserinsert(User input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UserMapper.outUserinsert", input);

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

}