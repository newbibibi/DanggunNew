package org.spring.service;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.QuestionsVO;
import org.spring.domain.ReportVO;
import org.spring.domain.UserVO;
import org.spring.mapper.AdminMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class AdminServiceImp implements AdminService{
	private final AdminMapper adminMapper;

	@Override
	public int updateAnswer(QuestionsVO vo) {
		return adminMapper.answerQ(vo);
	}

	@Override
	public int reportCount() {
		return adminMapper.reportCount();
	}

	@Override
	public List<ReportVO> reportList(Criteria cri) {
		// TODO Auto-generated method stub
		return adminMapper.listReport(cri);

	}

}
