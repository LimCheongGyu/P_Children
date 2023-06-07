package com.web.root.board.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.web.root.board.dto.BoardDTO;
import com.web.root.board.dto.BoardRepDTO;
import com.web.root.board.dto.NoticeBoardDTO;


public interface BoardService {
	
	//============================ 주진욱 시작 ===========================================
	
	//public static final String IMAGE_REPO = "C:\\0900_JAVA_jjw\\6. Spring\\image-repo";
	//public void boardAllList(Model model);
	
	public void boardAllList(Model model, int num, HttpServletRequest request);
	
	public String writeSave(MultipartHttpServletRequest mul, 
			HttpServletRequest request);
	
	public BoardDTO contentView(Model model, HttpServletRequest request);
	
	public void hitplus(BoardDTO dto);
	
	public String modifySave(MultipartHttpServletRequest mul, 
			HttpServletRequest request);
	
	public String deleteBoard(Model model, HttpServletRequest request);
	
	// 댓글 기능 ----------------------------------------------------------
	public int addReply(Map<String, Object> map);
	
	public List<BoardRepDTO> getRepList(int write_group);
	
	public String deleteReply(HttpServletRequest request);
	
	public String updateReply(HttpServletRequest request);

	// 답글(대댓글) 기능 -------------------------------------------------
	public List<BoardRepDTO> getReCommentList(int reply_no);
	
	public int addReComment(Map<String, Object> map);
	
	public String updateReComment(HttpServletRequest request);
	
	
	//============================ 주진욱 끝 ===========================================
	
	
	
	
	//============================ 최윤희 시작 ===========================================
	
	// 공지사항 게시판 리스트
	public void noticeBoardAllList(Model model, int num, HttpServletRequest request); 
	
	// 공지사항 게시글 보기
	public NoticeBoardDTO noticeBoardContentView(HttpServletRequest request);
	
	// 조회수 증가
	public void noticeBoardHitplus(NoticeBoardDTO noticeBoardDTO);
	
	// 공지사항 게시글 작성
	public String noticeBoardWriteSave(MultipartHttpServletRequest mul, HttpServletRequest request); 
	
	// 공지사항 게시글 수정
	public String noticeBoardModifySave(MultipartHttpServletRequest mul, HttpServletRequest request);
	
	// 공지사항 게시글 삭제
	public String noticeBoardDelete(HttpServletRequest request);
		
	//============================ 최윤희 끝 ===========================================
	
	
}

