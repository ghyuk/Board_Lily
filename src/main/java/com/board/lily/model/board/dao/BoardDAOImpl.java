package com.board.lily.model.board.dao;

import java.util.List;
 
import javax.inject.Inject;
 
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
 
import com.board.lily.model.board.dto.BoardVO;
 
@Repository    // 현재 클래스를 dao bean으로 등록
public class BoardDAOImpl implements BoardDAO {
    @Inject
    SqlSession SqlSession;
    // 01. 게시글 작성
    @Override
    public void create(BoardVO vo) throws Exception {
    		SqlSession.insert("insert", vo);
    }
    // 02. 게시글 상세보기
    @Override
    public BoardVO read(int bno) throws Exception {
        return SqlSession.selectOne("view", bno);
    }
    // 03. 게시글 수정
    @Override
    public void update(BoardVO vo) throws Exception {
        SqlSession.update("updateArticle", vo);
 
    }
    // 04. 게시글 삭제
    @Override
    public void delete(int bno) throws Exception {
        SqlSession.delete("deleteArticle",bno);
 
    }
    // 05. 게시글 전체 목록
    @Override
    public List<BoardVO> listAll() throws Exception {
        return SqlSession.selectList("listAll");
    }
    // 게시글 조회수 증가
    @Override
    public void increaseViewcnt(int bno) throws Exception {
        SqlSession.update("increaseViewcnt", bno);
    }
    //	07. 첨부파일 삭제
	@Override
	public void deleteFile(int bno) throws Exception {
		SqlSession.delete("deleteFile");
	}
    
}
