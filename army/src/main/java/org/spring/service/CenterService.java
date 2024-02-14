package org.spring.service;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.FAQVO;
import org.spring.domain.FileVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;

public interface CenterService {
	public List<NoticeVO> noticeListAll(Criteria cri);
	public NoticeVO selectNotice(int nno);
	public List<NoticeVO> searchNotice(String search,String category);
	public int addNotice(NoticeVO vo);
	public int modifyNotice(NoticeVO vo);
	public int delNotice(int nno);
	public List<MenuVO> showMenu();
	
	public List<SaleVO> benefitListAll();
	
	public List<SaleVO> searchBenefit(Criteria cri);
	
	public List<FAQVO> FaqList(String category);
	public List<QuestionsVO> FqnaListAll(Criteria cri);
	public List<QuestionsVO> myFqnaList(Criteria cri);
	public List<QuestionsVO> searchFqna(String nickname, String search);
	public QuestionsVO selectFqna(int qno);
	public int addFqna(QuestionsVO vo);
	public int modifyFqna(QuestionsVO vo);
	public int delFqna(int qno);
	public int getTotal(Criteria cri);
	public int getfqnaTotal(Criteria cri);
	
	public int maxqno();
	public int upload(FileVO vo);
	
	public List<FileVO> fileList(int qno);
	public int getTN(Criteria cri);
	
	public List<MenuVO> getMenu();
	
	public List<NoticeVO> mainNList();
	
	public List<SaleVO> mainBList(String userRegion);
}
