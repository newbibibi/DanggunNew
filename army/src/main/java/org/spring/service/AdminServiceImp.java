package org.spring.service;

import java.util.List;
import java.util.Map;

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
	public List<Map<String,Object>> reportList(Criteria cri) {
		return adminMapper.listReport(cri);
	}

	@Override
	public int reportCount() {
		return adminMapper.reportCount();
	}

	@Override
	public int baned(Map<String, Object> map) {
		return adminMapper.baned(map);
	}

	@Override
	public int reportDelete(Map<String, Object> map) {
		return adminMapper.reportDelete(map);
	}

	
}
