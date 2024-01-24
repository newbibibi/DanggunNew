package org.spring.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.spring.domain.Criteria;
import org.spring.domain.QuestionsVO;
import org.spring.domain.ReportVO;
import org.spring.domain.UserVO;

@Mapper
public interface AdminMapper {
	public UserVO showProfile();
	public List<UserVO> listUser();
	public List<Map<String,Object>> listReport(Criteria cri);
	public List<QuestionsVO> listQ();
	public int answerQ(QuestionsVO vo);
	public List<ReportVO> ReportInfo(String type,String no);
	public int reportCount();
	public int baned(Map<String, Object> map);
	public int reportDelete(Map<String, Object> map);
}
