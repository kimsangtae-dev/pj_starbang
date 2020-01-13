package project.star.b2.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.model.UploadItem;
import project.star.b2.service.UploadService;

/** 이미지 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service
public class UploadServiceImpl implements UploadService {

    /** MyBatis */
    @Autowired
    SqlSession sqlSession;

    @Override
    public UploadItem getUploadItem(UploadItem input) throws Exception {
        UploadItem result = null;

        try {
            result = sqlSession.selectOne("UploadMapper.selectItem", input);

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
    public List<UploadItem> getImageList_by_roomno(UploadItem input) throws Exception {
        List<UploadItem> result = null;

        try {
            result = sqlSession.selectList("UploadMapper.selectList_by_roomno", input);

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
    public List<UploadItem> getUploadItemList(UploadItem input) throws Exception {
        return null;
    }

    @Override
    public int getUploadItemCount(UploadItem input) throws Exception {
        return 0;
    }

    @Override
    public int getUploadMaxItem(UploadItem input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.selectOne("UploadMapper.selectMaxItem", input);

            if (result == 0) {
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
    public int addUploadItem(UploadItem input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("UploadMapper.insertItem", input);

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
    public int editUploadItem(UploadItem input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("UloadMapper.updateItem", input);

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
    public int deleteUploadItem(UploadItem input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("UploadMapper.deleteItem_by_imageno", input);

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

}
