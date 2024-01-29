package org.spring.domain;



import lombok.Data;

@Data
public class CommentVO {
	private int cno;
	private String content;
	private String nickname;
	private int bno;
	private int dislikes;
	private String cTime;
	private int isCFC;
	private int parentCno;
	private int likes;
	private int isAnonymous;
	
	
	public String getcTime() {
		return cTime;
	}
	public void setcTime(String cTime) {
		this.cTime = cTime;
	}
	
	
}

