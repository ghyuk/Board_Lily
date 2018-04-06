package com.board.lily.model.board.dto;

import java.util.Date;

public class BoardVO {
    private int bno;            // 게시글 번호
    private String title;       // 게시글 제목
    private String content;     // 게시글 내용
    private String writer;      // 게시글 작성자
    private Date regdate;       // 게시글 작성일자 util.Date
    private int viewcnt;        // 게시글 조회수
    private int fno;			//파일 번호
    private String oriFile;	//원 파일명
    private String serFile;	//서버 파일명
    
    
    public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public String getOriFile() {
		return oriFile;
	}
	public void setOriFile(String oriFile) {
		this.oriFile = oriFile;
	}
	public String getSerFile() {
		return serFile;
	}
	public void setSerFile(String serFile) {
		this.serFile = serFile;
	}
	// Getter/Setter
    public int getBno() {
        return bno;
    }
    public void setBno(int bno) {
        this.bno = bno;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }
    public Date getRegdate() {
        return regdate;
    }
    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }
    public int getViewcnt() {
        return viewcnt;
    }
    public void setViewcnt(int viewcnt) {
        this.viewcnt = viewcnt;
    }
    // toString()
    @Override
    public String toString() {
        return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
                + regdate + ", viewcnt=" + viewcnt + "]";
    }
    
}
