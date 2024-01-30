package org.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QuestionsVO {
	private int qno;
	private String nickname;
	private String title;
	private String content;
	private String answer;
	private Timestamp regDate;
}
