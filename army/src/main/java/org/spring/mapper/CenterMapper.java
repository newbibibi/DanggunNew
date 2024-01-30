package org.spring.mapper;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.FAQVO;
import org.spring.domain.FileVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;

public interface CenterMapper {
	//공지사항
	public int createNotice(NoticeVO vo);
	public int modifyNotice(NoticeVO vo);
	public int removeNotice(int nno);
	public NoticeVO showNotice(int nno);
	public List<NoticeVO> noticeList(String search, String category);
	public List<NoticeVO> noticeListAll(Criteria cri);
	
	//FAQ
	public List<FAQVO> listFAQ(String category);
	
	//1:1문의
	public int createQuestion(QuestionsVO vo);
	public int modifyQuestion(QuestionsVO vo);
	public int removeQuestion(int qno);
	public List<QuestionsVO> questionListAll(Criteria cri);
	public List<QuestionsVO> myQuestionList(Criteria cri);
	public List<QuestionsVO> questionList(String nickname, String search);
	public QuestionsVO showQuestion(int qno);
	public int getTotalCount(Criteria cri);
	public int getFqnaTotalCount(Criteria cri);
	public int maxQno();
	public int uploadData(FileVO vo);
	public List<FileVO> getFileList(int qno);
	public int getTCN(Criteria cri);
	
	//식단표
	public List<MenuVO> listMenu();
	public List<MenuVO> getMenuList();
	
	//혜택
	public List<SaleVO> saleListAll();
	public List<SaleVO> saleList(Criteria cri);
	
	
	//메인
	public List<NoticeVO> mainNotice();
}
