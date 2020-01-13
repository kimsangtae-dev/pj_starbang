package project.star.b2.service;

import java.util.List;

import project.star.b2.model.Gallery;
import project.star.b2.model.Heart;

public interface HeartService {
    /**
     * 찜 데이터 목록 조회
     * 
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<Heart> getHeartGalleryList(Heart input) throws Exception;

    /**
     * 갤러리 데이터가 저장되어 있는 갯수 조회
     * 
     * @return int
     * @throws Exception
     */
    public int getGalleryCount(Gallery input) throws Exception;

    public List<Gallery> getGalleryList(Gallery input) throws Exception;

    public int getHeartGalleryCount(Heart input) throws Exception;

    public int addHeart(Heart input) throws Exception;

    public int deleteHeart(Heart input) throws Exception;

    public Heart getHeartItem(Heart input) throws Exception;

    public int numberHeart(Heart input) throws Exception;

    public int delectHeart(Heart input) throws Exception;

    public Heart getHeartitem(Heart input) throws Exception;

    public List<Heart> getHeartList(Heart input) throws Exception;

    public int getHeartitemox(Heart input) throws Exception;
}
