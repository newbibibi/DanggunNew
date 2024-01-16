package org.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private int nno;
	private String title;
	private String content;
	private String regDate;
	private String category;
}
