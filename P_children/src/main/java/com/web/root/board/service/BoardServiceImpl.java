package com.web.root.board.service;



import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.web.root.board.dto.BoardDTO;
import com.web.root.board.dto.BoardRepDTO;
import com.web.root.board.dto.NoticeBoardDTO;
import com.web.root.mybatis.board.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper mapper;
	
	@Autowired
	BoardFileService bfs;
	
	
	//============================ 주진욱 시작 ===========================================
	
	
	/*
	@Override
	public void boardAllList(Model model) {
		model.addAttribute("boardList", mapper.boardAllList());
	}
	*/
	
	@Override
	public void boardAllList(Model model, int num, HttpServletRequest request) {
		
		int pageLetter = 3; // 한 페이지 당 글 목록수
		int allCount= mapper.selectBoardCount(); // 전체 글수
		int repeat = allCount/pageLetter; // 마지막 페이지 번호
		if(allCount % pageLetter != 0)
			repeat += 1;
		int end = num * pageLetter;
		int start = end +1 - pageLetter;
		//int start = (num - 1)/pageLetter + 1;
		//int end = start + pageLetter -1;
		
		// 페이징
		int totalPage = (allCount - 1)/pageLetter + 1;
		int block = 3;
		int startPage = (num - 1)/block*block + 1;
		int endPage = startPage + block - 1;
		if (endPage > totalPage) endPage = totalPage;

	
		model.addAttribute("repeat", repeat);
		model.addAttribute("boardList", mapper.boardAllList(start, end));
		model.addAttribute("endPage", endPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("block", block);
		model.addAttribute("totalPage", totalPage);
	}
	

	@Override
	public String writeSave(MultipartHttpServletRequest mul, HttpServletRequest request) {

		BoardDTO dto = new BoardDTO();
		dto.setId(mul.getParameter("id"));
		dto.setTitle(mul.getParameter("title"));
		dto.setContent(mul.getParameter("content"));
		MultipartFile file = mul.getFile("file");
		
		if(file.getSize() != 0) {	// 이미지가 있는지 확인
			
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss-");
//			Calendar calendar = Calendar.getInstance();
//			String sysFileName = sdf.format(calendar.getTime());
//			sysFileName += file.getOriginalFilename();
//			
//			// 실제 폴더에 파일 저장
//			File saveFile = new File(IMAGE_REPO+"/"+sysFileName);
//			
//			// DB에 파일 이름 정보 저장
//			dto.setImage_file_name(sysFileName);
			
			dto.setFile_name(bfs.saveFile(file));
			
		} else {
			dto.setFile_name("nan");
		}
		
		int result = 0;
		try {
			result = mapper.writeSave(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String msg, url;
		if(result == 1) {
			msg = "새글이 등록 되었습니다";
			url = "/board/boardAllList";
		} else {
			msg = "글등록 실패~";
			url = "/board/writeForm";
		}
		return bfs.getMessage(request, msg, url);
	}


	@Override
	public BoardDTO contentView(Model model, HttpServletRequest request) {
		
		int write_no = Integer.parseInt(request.getParameter("write_no"));
		
		BoardDTO dto = new BoardDTO();
		dto.setWrite_no(write_no);
		
		return mapper.contentView(dto);
	}

	@Override
	public void hitplus(BoardDTO dto) {
		
		mapper.hitplus(dto);
		
	}

	@Override
	public String modifySave(MultipartHttpServletRequest mul, HttpServletRequest request) {

		// form 에서 받은 정보 DTO에 담기
		BoardDTO dto = new BoardDTO();
		dto.setId(mul.getParameter("id"));
		dto.setTitle(mul.getParameter("title"));
		dto.setContent(mul.getParameter("content"));
		String no = mul.getParameter("write_no");
		dto.setWrite_no(Integer.parseInt(no));
		MultipartFile file = mul.getFile("file");

		int result = 0;	// modify 성공 여부 확인값
		
		// 수정파일 존재시 file_name 설정 및 실제 파일 저장
		if(file.getSize() != 0) {	// 이미지가 있는지 확인
			
			dto.setFile_name(bfs.saveFile(file));
			result = mapper.modifySaveWithFile(dto);
			
		} else {
			dto.setFile_name("nan");
			result = mapper.modifySave(dto);
		}
		// DB에서 Modify 실행
		
		
		// 실패
		String msg, url;
		if(result == 1) {
			msg = "글이 수정 되었습니다";
			url = "/board/boardAllList";
		} else {
			msg = "글수정 실패~";
			url = "/board/modifyForm?write_no=" + dto.getWrite_no();
		}
		return bfs.getMessage(request, msg, url);
//		return null;
	}
	
	public String deleteBoard(Model model, HttpServletRequest request) {
		
		int result = 0;
		int write_no = Integer.parseInt(request.getParameter("write_no"));
		result = mapper.deleteBoard(write_no);
		
		String msg, url;
		if(result == 1) {
			msg = "글이 삭제 되었습니다";
			url = "/board/boardAllList";
			// 선생님은 이자리에 bfs.delete(image_file_name); 을 넣으셨다.
		} else {
			msg = "글삭제 실패~";
			url = "/board/contentView?write_no=" + write_no;
		}
		return bfs.getMessage(request, msg, url);
	}

	// 댓글 기능 ---------------------------------------------------------
	
	@Override
	public int addReply(Map<String, Object> map) {
		int result = mapper.addReply(map);
		return result;
	}

	@Override
	public List<BoardRepDTO> getRepList(int write_group) {
		// TODO Auto-generated method stub
		return mapper.getRepList(write_group);
	}


	@Override
	public String deleteReply(HttpServletRequest request) {
		BoardRepDTO dto = new BoardRepDTO();
		dto.setReply_no(Integer.parseInt(request.getParameter("reply_no")));
		dto.setWrite_group(Integer.parseInt(request.getParameter("write_group")));
		
		System.out.println(dto.getReply_no() + " , " + dto.getWrite_group());
		int su = mapper.deleteReply(dto);
		
		String msg, url;
		if(su == 1) {
			msg = "댓글이 삭제 되었습니다";
			url = "/board/contentView?write_no=" + request.getParameter("write_group");
			// 선생님은 이자리에 bfs.delete(image_file_name); 을 넣으셨다.
		} else {
			msg = "댓글 삭제 실패~";
			url = "/board/contentView?write_no=" + request.getParameter("write_group");
		}
		return bfs.getMessage(request, msg, url);
		
	}


	@Override
	public String updateReply(HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("write_no", request.getParameter("write_no"));
		map.put("updateReply_no", request.getParameter("updateReply_no"));
		map.put("updateContent", request.getParameter("updateContent"));
		map.put("id", request.getParameter("id"));
		
		String num = request.getParameter("num");
		
		int su = mapper.updateReply(map);
		String write_noStr = (String) map.get("write_no");
		int write_no = Integer.parseInt(write_noStr);
	
		String msg, url;
		if(su == 1) {
			msg = "댓글이 수정 되었습니다";
			url = "/board/contentView?write_no=" + write_no + "&num=" + num;
		} else {
			msg = "댓글 수정 실패~";
			url = "/board/contentView?write_no=" + write_no + "&num=" + num;
		}
		return bfs.getMessage(request, msg, url);
	}


	// 대댓글 기능 -----------------------------------------------------------------------
	@Override
	public List<BoardRepDTO> getReCommentList(int reply_no) {
		return mapper.getReCommentList(reply_no);
	}


	@Override
	public int addReComment(Map<String, Object> map) {
		return mapper.addReComment(map);
	}


	@Override
	public String updateReComment(HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("write_no", request.getParameter("write_no"));
		map.put("updateReply_no", request.getParameter("updateReCommentReply_no"));
		map.put("updateContent", request.getParameter("updateReCommentContent"));
		map.put("id", request.getParameter("id"));

		String num = request.getParameter("num");
		
		int su = mapper.updateReComment(map);
		String write_noStr = (String) map.get("write_no");
		int write_no = Integer.parseInt(write_noStr);
		
		
		String msg, url;
		if(su == 1) {
			msg = "대댓글이 수정 되었습니다";
			url = "/board/contentView?write_no=" + write_no + "&num=" + num;
		} else {
			msg = "대댓글 수정 실패~";
			url = "/board/contentView?write_no=" + write_no + "&num=" + num;
		}
		return bfs.getMessage(request, msg, url);
	}

	
	//============================ 주진욱 끝 ===========================================
	
	
	
	
	
	//============================ 최윤희 시작 ===========================================
	
	@Override
	public void noticeBoardAllList(Model model, int num, HttpServletRequest request) {
		
		int pageLetter = 3;  // 한 페이지 당 글 목록수
		int allCount = mapper.selectNoticeBoardCount(); // DB에 담겨있는 전체 글 수
		int repeat = allCount/pageLetter; // 마지막 페이지 번호
		if(allCount % pageLetter != 0) {
			repeat += 1;
		}
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		
		// 페이징
		int totalPage = (allCount - 1)/pageLetter + 1;
		int block = 3;
		int startPage = (num - 1)/block * block + 1;
		int endPage = startPage + block - 1;
		if (endPage > totalPage) endPage = totalPage;
		
		model.addAttribute("repeat", repeat);
		model.addAttribute("noticeBoardList", mapper.noticeBoardAllList(start, end)); // 시작과 끝 페이지 안에서 내용 가져오기
		model.addAttribute("endPage", endPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("block", block);
		model.addAttribute("totalPage", totalPage);
		
	}
		
	
	// 공지사항 게시글 보기
	public NoticeBoardDTO noticeBoardContentView(HttpServletRequest request) {
		
		int write_no = Integer.parseInt(request.getParameter("write_no"));  // 요청온 글 번호를 받고
		
		NoticeBoardDTO noticeBoardDTO = new NoticeBoardDTO();
		noticeBoardDTO.setWrite_no(write_no);  // NoticeBoardDTO 안에 글번호 저장
		
		return mapper.noticeBoardContentView(noticeBoardDTO);
	}
	
	// 조회수 증가
	@Override
	public void noticeBoardHitplus(NoticeBoardDTO noticeBoardDTO) {
		mapper.noticeBoardHitplus(noticeBoardDTO);
	}
	
	// 공지사항 게시글 작성
	@Override
	public String noticeBoardWriteSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		NoticeBoardDTO noticeBoardDTO = new NoticeBoardDTO();
		// 요청온 내용 저장
		noticeBoardDTO.setId(mul.getParameter("id"));				// 작성자(아이디) 저장
		noticeBoardDTO.setTitle(mul.getParameter("title"));			// 제목 저장
		noticeBoardDTO.setContent(mul.getParameter("content"));		// 내용 저장
		MultipartFile file = mul.getFile("file");					// 파일 저장
		
		// 요청받은 파일이 있으면
		if(file.getSize() != 0) {
			noticeBoardDTO.setFile_name(bfs.noticeBoardSaveFile(file));
		} else {
			noticeBoardDTO.setFile_name("nan");
		}
		
		int result = 0;
		try {
			result = mapper.noticeBoardWriteSave(noticeBoardDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String msg, url;
		if(result == 1) {
			msg = "공지사항 게시글이 등록되었습니다.";
			url = "/board/notice/noticeBoardAllList";
		} else {
			msg = "게시글 등록이 실패하였습니다.";
			url = "/board/notice/noticeBoardWriteForm";
		}
		return bfs.getNoticeBoardMessage(request, msg, url);

	}
		
		
	// 공지사항 게시글 수정 작성
	@Override
	public String noticeBoardModifySave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		
		// noticeBoardModifyForm 에서 받은 정보 DTO에 담기
		NoticeBoardDTO noticeBoardDTO = new NoticeBoardDTO();
		noticeBoardDTO.setTitle(mul.getParameter("title"));			// 수정 타이틀 저장
		noticeBoardDTO.setContent(mul.getParameter("content"));		// 수정 내용 저장
		noticeBoardDTO.setWrite_no(Integer.parseInt(mul.getParameter("write_no")));  // 수정 글번호
		MultipartFile file = mul.getFile("file");  					// 기존 파일에서 수정 파일 저장

		int result = 0;	// 수정 성공 여부 확인
		
		// 수정파일 존재시 file_name 설정 및 실제 파일 저장
		if(file.getSize() != 0) {	// 이미지가 있는지 확인
			noticeBoardDTO.setFile_name(bfs.noticeBoardSaveFile(file));
			result = mapper.noticeBoardModifySaveWithFile(noticeBoardDTO);
			
		} else {
			noticeBoardDTO.setFile_name("nan");
			result = mapper.noticeBoardModifySaveWithFile(noticeBoardDTO);
		}
		
		// 성공, 실패에 따라 url + msg 반환
		String msg, url;
		if(result == 1) {
			msg = "공지사항 게시글이 수정되었습니다";
			url = "/board/notice/noticeBoardAllList";
		} else {
			msg = "게시글 수정이 실패하였습니다.";
			url = "/board/notice/noticeBoardModifyForm?write_no=" + noticeBoardDTO.getWrite_no();
		}
		return bfs.getNoticeBoardMessage(request, msg, url);
	}

	
	// 공지사항 게시글 삭제
	@Override
	public String noticeBoardDelete(HttpServletRequest request) {
		
		int result = 0;
		
		int write_no = Integer.parseInt(request.getParameter("write_no"));
		
		result = mapper.noticeBoardDelete(write_no);  // 삭제 성공, 실패 값 받기
		
		// 삭제 성공, 실패 url + 문자열 반환
		String msg, url;
		if(result == 1) {
			msg = "공지 게시글이 삭제되었습니다.";
			url = "/board/notice/noticeBoardAllList";
			// 선생님은 이자리에 bfs.delete(image_file_name); 을 넣으셨다.
		} else {
			msg = "공지 게시글 삭제가 실패되었습니다.";
			url = "/board/notice/noticeBoardContentView?write_no=" + write_no;
		}
		return bfs.getNoticeBoardMessage(request, msg, url);
	}
	
	
		
	//============================ 최윤희 끝 ===========================================
	

	
	
	
	
	
	
	
	
	
	

	
}
