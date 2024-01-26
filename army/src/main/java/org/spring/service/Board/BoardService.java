package org.spring.service.Board;

import java.util.Date;
import java.util.List;

import org.spring.domain.BoardVO;
import org.spring.domain.CommentVO;
import org.spring.domain.Criteria;
import org.spring.domain.ReportVO;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {

	public List<BoardVO> getPostList(Criteria cri);

	public BoardVO getPost(int bno);

	public int addPost(BoardVO vo); 

	public List<BoardVO> searchPost(String search);
	
	public List<CommentVO> getCommentList(int bno); 
	
	public int modifyPost(BoardVO vo);

	public int delPost(int bno);

	public int addComment(CommentVO vo);

	public int modifyComment(CommentVO vo);

	public int delComment(int cno);

	public void plusView(int bno);

	public int report(ReportVO vo);

	public int ban(String nickname, Date date);

	int getTotal(Criteria cri);
	
	public void cntcmt(int bno);

	public int isLiked(int bno, String nickname);

	public void addLike(int bno, String nickname, int likestatus);

	public void removeLike(int bno, String nickname);

	public void updateLikes(int bno, int likestatus);

	public int toggleLikeComment(Integer cno, String nickname, int likestatus);

	public String saveFile(MultipartFile file);

	
	public List<BoardVO> mainList();

	public int getOrDefault(long postId, String nickname);

	public int getReportStatus(long cno, String nickname);







}
