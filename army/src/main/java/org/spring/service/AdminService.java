package org.spring.service;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.QuestionsVO;
import org.spring.domain.ReportVO;
import org.spring.domain.UserVO;

public interface AdminService {
	public int updateAnswer(QuestionsVO vo);
	public List<ReportVO> reportList(Criteria cri);
	public int reportCount();
}
