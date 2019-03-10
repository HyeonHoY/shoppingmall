package com.project.sm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.sm.service.BoardService;
import com.project.sm.service.FileUploadService;
import com.project.sm.service.ProductService;
import com.project.sm.service.ReplyService;
import com.project.sm.vo.BoardVO;
import com.project.sm.vo.PageVO;
import com.project.sm.vo.ProductVO;
import com.project.sm.vo.ReplyVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 게시판 관련 컨트롤러 클래스
 * 
 * @author a
 */
@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	// 게시판 서비스의 기능을 의존주입
	@Inject
	BoardService service;

	@Inject
	ReplyService replyService;

	@Inject
	ProductService productService;
	
	@Inject
	FileSystemResource boardImageUploadResource;

	@Inject
	FileUploadService fileUploadService;

	/**
	 * 게시판 전체 목록을 확인하는 매서드(페이지 처리 기능 추가)
	 * 
	 * @param page 페이지 넘버를 인자로 받는 변수
	 * @return
	 */
	@RequestMapping("list.do/boardKinds/{boardKinds}")
	public ModelAndView listBoard(@PathVariable("boardKinds") int boardKinds,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		log.info("BoardController listBoard");
		log.info("boardKinds : " + boardKinds);

		page = (page == 0) ? 1 : page;

		int pageLimit = 10;
		int pagingStep = 10;
		int count = service.getAllArticleCount(boardKinds);
		
		log.info("########### count ########### : " + count);
		
		List<BoardVO> list = service.articlePageProcessingList(page, pageLimit, boardKinds, "null");

		log.info("list : " + list);

		List<ProductVO> productList = new ArrayList<>();
		
		for(int i=0; i<list.size(); i++) {
			
			productList.add(productService.viewProduct(list.get(i).getProductId()));

		}
		
		
		
		log.info("상품 정보들" + productList.toString());
		
		int maxPage = (int) ((double) count / pageLimit + 0.95);
		int startPage = (((int) ((double) page / pagingStep + 0.9)) - 1) * pagingStep + 1;
		int endPage = startPage + pagingStep - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		// 페이지 처리하는 VO를 생성 후 model에 넣어주기 위해 생성
		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		pageVO.setListCount(count);
		pageVO.setMaxPage(maxPage);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);

		ModelAndView mav = new ModelAndView();

		mav.addObject("pageVO", pageVO);
		mav.addObject("articleList", list);
		mav.addObject("boardKinds", boardKinds);
		mav.addObject("productList", productList);
		
		// log.info("게시글 제목 : " + list.get(0).getBoardSubject());
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		mav.setViewName("/board/board_list");

		return mav;
	}

	
	/**
	 * 
	 * @param boardKinds
	 * @param page
	 * @return
	 */
	@RequestMapping("list.do")
	public ModelAndView PageListBoard(@RequestParam("boardKinds") int boardKinds,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		log.info("#############################################################");

		log.info("BoardController PageListBoard");
		log.info("boardKinds : " + boardKinds);

		page = (page == 0) ? 1 : page;

		int pageLimit = 10;
		int pagingStep = 10;

		int count = service.getAllArticleCount(boardKinds);
		log.info("########### count ########### : " + count);
		List<BoardVO> list = service.articlePageProcessingList(page, pageLimit, boardKinds, " ");

		log.info("list : " + list);

		int maxPage = (int) ((double) count / pageLimit + 0.95);
		int startPage = (((int) ((double) page / pagingStep + 0.9)) - 1) * pagingStep + 1;
		int endPage = startPage + pagingStep - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		// 페이지 처리하는 VO를 생성 후 model에 넣어주기 위해 생성
		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		pageVO.setListCount(count);
		pageVO.setMaxPage(maxPage);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);

		ModelAndView mav = new ModelAndView();

		mav.addObject("pageVO", pageVO);
		mav.addObject("articleList", list);
		mav.addObject("boardKinds", boardKinds);

		// log.info("게시글 제목 : " + list.get(0).getBoardSubject());

		mav.setViewName("/board/board_list");

		return mav;
	}

	/**
	 * 게시판 전체 목록을 확인하는 매서드(검색 기능 추가, 페이지처리 기능 추가)
	 * 
	 * @param page         페이지 변수
	 * @param searchOption select 태그의 검색옵션
	 * @param keyword      사용자가 검색한 keyword
	 * @param model        페이지 처리, 검색 기능이 있는 list와 검색 했을 경우 검색 옵션과 키워드에 맞는 게시판 개수,
	 *                     검색 키워드, 검색 옵션 페이지 처리VO
	 * @return
	 */
	@RequestMapping("search/all/list.do")
	public String combineList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "searchOption", required = false, defaultValue = "null") String searchOption,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam("boardKinds") int boardKinds, Model model) {

		log.info("#####################################################################################");
		log.info("BoardController combineList ");

		log.info(
				"page : " + page + "search : " + searchOption + "keyword : " + keyword + " boardKinds : " + boardKinds);

		page = (page == 0) ? 1 : page;

		int pageLimit = 10;
		int pagingStep = 10;

		List<BoardVO> list = service.articleCombineList(page, pageLimit, keyword, searchOption, boardKinds);
		int count = service.getAllSearchArticleCount(keyword, searchOption, boardKinds);

		log.info("count : " + count);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);

		model.addAttribute("map", map);

		int maxPage = (int) ((double) count / pageLimit + 0.95);
		int startPage = (((int) ((double) page / pagingStep + 0.9)) - 1) * pagingStep + 1;
		int endPage = startPage + pagingStep - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		pageVO.setListCount(count);
		pageVO.setMaxPage(maxPage);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("boardKinds", boardKinds);

		return "/board/board_list";
	}

	
	/**
	 * 
	 * @param page
	 * @param searchOption
	 * @param keyword
	 * @param boardKinds
	 * @param model
	 * @return
	 */
	@RequestMapping("search/list.do")
	public String PagecombineList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "searchOption", required = false, defaultValue = "null") String searchOption,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam("boardKinds") int boardKinds, Model model) {

		log.info("#####################################################################################");
		log.info("BoardController PagecombineList ");

		log.info(
				"page : " + page + "search : " + searchOption + "keyword : " + keyword + " boardKinds : " + boardKinds);

		page = (page == 0) ? 1 : page;

		int pageLimit = 10;
		int pagingStep = 10;

		List<BoardVO> list = service.articleCombineList(page, pageLimit, keyword, searchOption, boardKinds);
		int count = service.getAllSearchArticleCount(keyword, searchOption, boardKinds);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);

		model.addAttribute("map", map);

		int maxPage = (int) ((double) count / pageLimit + 0.95);
		int startPage = (((int) ((double) page / pagingStep + 0.9)) - 1) * pagingStep + 1;
		int endPage = startPage + pagingStep - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		pageVO.setListCount(count);
		pageVO.setMaxPage(maxPage);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("boardKinds", boardKinds);

		return "/board/board_list";
	}

	
	/**
	 * 
	 * @param boardKinds
	 * @param model
	 * @return
	 */
	@RequestMapping("write.do/boardKinds/{boardKinds}")
	public String createBoard(@PathVariable("boardKinds") int boardKinds, Model model) {
		log.info("글쓰기 폼");
		log.info("BoardController createBoard");
		log.info("boardKinds : " + boardKinds);

		model.addAttribute("boardKinds", boardKinds);

		return "/board/board_write";
	}

	
	/**
	 * 게시판 작성 폼 이동
	 * 
	 * @return
	 */
	@RequestMapping("write.do/boardKinds/{boardKinds}/product/{productId}")
	public String createBoard(@PathVariable("boardKinds") int boardKinds, Model model, 
							  @PathVariable(value="productId", required=false) String productId) {
		log.info("글쓰기 폼");

		log.info("BoardController createBoard");

		log.info("boardKinds : " + boardKinds);

		model.addAttribute("boardKinds", boardKinds);
		model.addAttribute("productId", productId);

		return "/board/board_write";
	}

	
	/**
	 * 
	 * @param boardKinds
	 * @param subject
	 * @param password
	 * @param content
	 * @param list
	 * @param productId
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "insert.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String insertBoard(@RequestParam("boardKinds") int boardKinds, @RequestParam("boardSubject") String subject,
							  @RequestParam(value = "boardPw", required = false, defaultValue="null") String password,
							  @RequestParam("boardContent") String content, @RequestParam("picUpload") List<MultipartFile> list,
							  @RequestParam("productId") String productId, HttpSession session, Model model) {

		log.info("################################################################");
		log.info("BoardController insertBoard");

		log.info("boardKinds : " + boardKinds + " , boardSubject : " + subject);
		log.info("boardPw : " + password + " , boardContent : " + content);

		log.info("list.size() = " + list.size());
		log.info("list.get(0).getOriginalFilename() = " + list.get(0).getOriginalFilename());

		BoardVO board = new BoardVO();

		String fileNameSave = "";
		String msg = "";
		board.setBoardWriter((String) session.getAttribute("id"));
		board.setBoardSubject(subject);
		board.setBoardPw(password);
		board.setBoardKinds(boardKinds);
		board.setProductId(productId);
		
		log.info("board = "+board);
		log.info("productId = "+productId);

		// 파일이 존재할 경우
		if (list.get(0).getOriginalFilename() != "") {

			String seq = service.getLastSeq() + "번 게시물";// 시퀀스 마지막 번호 가져오기
			String path = boardImageUploadResource.getPath() + seq + "/";// D:/fileUpload/image/110번 게시물/

			// 폴더가 있는지 없는지 체크 폴더가 없으면 자동으로 폴더 생성
			fileUploadService.checkFolder(path);

			// multipartFile 파일 개수만큼 반복
			for (int i = 0; i < list.size(); i++) {
				String fileName = list.get(i).getOriginalFilename();

				// 파일 저장소(D:\fileUpload\image) 에 저장
				if (fileUploadService.writeFile(path + fileName, list.get(i))) {
					msg = "파일 저장 성공";
					log.info(msg);
				} else {
					msg = "파일 저장 실패";
					log.info(msg);
				}
				fileNameSave += fileName + "?";
			} // for
			board.setBoardFile(fileNameSave);
		} else {
			board.setBoardFile("");
		} // if

		// 글 추가
		content = content.replace("\r\n", "<br>");
		board.setBoardContent(content);

		if(boardKinds == 1) {
			board.setProductId(" ");
		}
		
		service.insertBoard(board);

		if(boardKinds == 1) {
			return "redirect:/board/list.do/boardKinds/" + boardKinds + "";
		} else {
			return "redirect:/product/detail/"+board.getProductId();
		}
		
	} // boardWriting

	/**
	 * 게시판 상세보기 view(댓글 기능 추가)
	 * 
	 * @param num      사용자가 보이는 게시판 번호
	 * @param boardNum 실제 시퀀스 번호(시퀀스 번호로 view를 찾기 위함)
	 * @param model    가상 게시판 번호, 시퀀스 번호
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping("view.do")
	public String viewBoard(@RequestParam(value = "num", required = false, defaultValue = "0") int num,
							@RequestParam(value = "boardNum", required = false, defaultValue = "0") int boardNum,
							@RequestParam(value = "productId", required = false, defaultValue = "0") String productId, Model model) {

		BoardVO board = service.viewBoard(boardNum);

		log.info("boardController viewBoard : " + board.toString());

		log.info("fileName = " + board.getBoardFile());

		// DB에 저장되어 있는 파일 이름을 실제 이름으로 저장하기 위해 가공 시작
		int count = StringUtils.countOccurrencesOf(board.getBoardFile(), "?");
		String[] fileNameArray = StringUtils.delimitedListToStringArray(board.getBoardFile(), "?");

		List<String> list = new ArrayList<>();

		// 사진 개수만큼 모델에 저장
		for (int i = 0; i < count; i++) {
			list.add(fileNameArray[i]);
		}
		
		if(board.getBoardKinds() != 1) {
			board.setProductId(productId);
		}
		
		// 사진 가공 끝
		model.addAttribute("board", board);
		model.addAttribute("num", num);
		model.addAttribute("all_count", replyService.listReplyCount(boardNum));
		model.addAttribute("list", list);
		
		return "/board/board_view";
	}

	/**
	 * 
	 * @param boardNum
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "addReadCount.do")
	@ResponseBody
	public String addReadCount(@RequestParam String boardNum) throws JsonProcessingException {

		log.info("boardNum = " + boardNum);

		String msg = "";

		// 업데이트 실행
		// service.updateReadCount(new Integer(boardNum));

		if (service.updateReadCount(new Integer(boardNum)) == true) {
			msg = "조회수 증가";
			log.info(msg);
		}

		return new ObjectMapper().writeValueAsString(msg);
	}
	
	
	/**
	 * 
	 * @param boardNum
	 * @param checkPw
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@RequestMapping(value = "checkBoardPage.do", produces="application/json; charset=UTF-8")
	public String checkBoardPage(@RequestParam("boardNum") int boardNum, @RequestParam("checkPw") String checkPw)
			throws JsonProcessingException {

		log.info("BoardController checkBoardPage");

		String msg = "";

		BoardVO board = service.viewBoard(boardNum);

		log.info("board : " + board);

		if (board.getBoardPw().equals(checkPw)) {
			msg = "비밀번호 일치";
			log.info(msg);
		} else {
			msg = "실패";
		}
		log.info("##################################### boardNum : " + boardNum);
		log.info("##################################### checkPw : " + checkPw);
		log.info("##################################### boardPw : " + board.getBoardPw());
		log.info("##################################### result : " + msg);

		return new ObjectMapper().writeValueAsString(msg);
	}

	
	/**
	 * 
	 * @param boardNum
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "viewJsonBoard.do", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String viewJson(@RequestParam(value = "boardNum", required = false, defaultValue = "0") int boardNum)
			throws JsonProcessingException {

		log.info("viewJsonBoard.do");
		log.info("boardNum = " + boardNum);
		BoardVO board = service.viewBoard(boardNum);

		return new ObjectMapper().writeValueAsString(board);
	}

	
	/**
	 * 
	 * @param boardNum
	 * @param end
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "viewJsonReply.do", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String viewJsonReply(@RequestParam(value = "boardNum", required = false, defaultValue = "0") int boardNum,
			@RequestParam(value = "page_count") String end) throws JsonProcessingException {

		int start = new Integer(end) - 14;

		log.info("viewJsonReply.do");
		log.info("start=" + start);
		log.info("end=" + end);

		List<ReplyVO> list = replyService.listReplyPageing(boardNum, start, new Integer(end));
		log.info("list = " + list);

		return new ObjectMapper().writeValueAsString(list);
	}

	
	/**
	 * 
	 * @param boardNum
	 * @param model
	 * @return
	 */
	@RequestMapping("update.do")
	public String updateBoard(@RequestParam(value = "num", required = false, defaultValue = "0") int boardNum,
							  @RequestParam(value = "product", required = false, defaultValue = "0") String productId,
			Model model) {

		BoardVO board = new BoardVO();
		board = service.viewBoard(boardNum);

		String fileFullName = board.getBoardFile();

		int fileCount = StringUtils.countOccurrencesOf(fileFullName, "?");
		String[] fileArray = StringUtils.delimitedListToStringArray(fileFullName, "?");

		List<String> list = new ArrayList<>();

		for (int i = 0; i < fileCount; i++) {
			// log.info("@@@@@@@"+fileArray[i]);
			list.add(fileArray[i]);
		}

		if(board.getBoardKinds() != 1) {
			board.setProductId(productId);
		}
		
		model.addAttribute("board", board);
		model.addAttribute("list", list);
		
		return "/board/board_update";
	}

	
	/**
	 * 
	 * @param board
	 * @param boardPw
	 * @return
	 */
	@RequestMapping(value="update/execute.do")
	   public String updateExecute(@ModelAttribute("updateBoardForm") BoardVO board,
			   					   @RequestParam(value="boardPw", required=false, defaultValue="") String boardPw) {   
	      
		if(board.getBoardPw()==null) {
			board.setBoardPw(boardPw);
			log.info("비밀번호 없음 : "+board.getBoardPw());
		}
		
	      log.info("@@@@@@@@@board = "+board);
	      // log.info("list 개수 = "+board.getPicUpload());
	      
	      log.info("길이 "+board.getBoardWriter().length());
	      
	      // 기존에 있던 사진을 삭제했을 경우
	      if(board.getBoardDate().length() != 0) {
	         String path = boardImageUploadResource.getPath()+board.getBoardNum()+"번 게시물/";
	         // 기존의 파일 삭제하는 부분을 점검하는 변수
	         String[] rowFileDelete = StringUtils.delimitedListToStringArray(board.getBoardDate(), "?");
	         
	         log.info("기존 사진 삭제 전 DB : "+board.getBoardFile());
	         
	         for(int i=0; i<rowFileDelete.length-1; i++) {
	            // 파일 삭제
	            fileUploadService.deleteFile(path+rowFileDelete[i]);
	            board.setBoardFile(board.getBoardFile().replace(rowFileDelete[i]+"?", ""));
	         }
	         log.info("기존 사진 삭제 후 DB : "+board.getBoardFile());
	      }
	      
	      if(board.getBoardFile().length() == 0) {
	         fileUploadService.checkFolder(boardImageUploadResource.getPath()+board.getBoardNum()+"번 게시물/");
	      }
	      
	      // 파일 추가 후 추가했던 파일을 삭제했을 경우
	      if((board.getBoardWriter() != "") && (board.getBoardWriter().length()!=0) && (board.getPicUpload() != null)) {
	         String[] deleteFile = StringUtils.delimitedListToStringArray(board.getBoardWriter(), "?");
	         log.info("deleteFile.length = "+deleteFile.length);
	         
	         // 배열 크기를 삭제할 이미지 개수만큼 저장 
	         log.info("삭제 전 크기 : "+board.getPicUpload().size());
	         Iterator<MultipartFile> it = board.getPicUpload().iterator();
	         
	         for(int i=0; i<deleteFile.length-1; i++) {
	            
	            // log.info("delete = "+deleteFile[i]);
	            
	            it = board.getPicUpload().iterator();
	            
	            while(it.hasNext()) {
	               String fileName = it.next().getOriginalFilename();
	               // log.info(fileName);
	               // log.info("delete = "+deleteFile[i]);
	               
	               if(fileName.equals(deleteFile[i])) {
	                  // log.info("진입");
	                  it.remove();
	                  break;
	               }
	            } // while
	         } // for
	         
	         log.info("삭제 후 크기 : "+board.getPicUpload().size());
	      } // if
	      
	      // log.info("확인 : "+board.getPicUpload());
	      
	      // 사진 추가 부분
	      if(board.getPicUpload() != null) {
	         
	         String path = boardImageUploadResource.getPath()+board.getBoardNum()+"번 게시물/";
	         
	         // 실제 들어가야할 파일
	         for(int i=0; i<board.getPicUpload().size(); i++) {
	            String fileName = board.getPicUpload().get(i).getOriginalFilename();
	            log.info("실제 들어가는 파일 : "+board.getPicUpload().get(i).getOriginalFilename());
	            
	            if(fileUploadService.fileIsLive(path+fileName)) {
	               fileUploadService.writeFile(path+fileName, board.getPicUpload().get(i));
	               fileUploadService.boardThumbnail(100, 100, path, fileName);
	               
	               board.setBoardFile(board.getBoardFile()+fileName+"?");
	            }
	         }
	         
	         log.info("삭제 후 DB fileName = "+board.getBoardFile());
	      }
	      
	      service.updateBoard(board);
	      
	      if(board.getBoardKinds() == 1) {
	    	  return "redirect:/board/list.do/boardKinds/"+board.getBoardKinds();
	      } else {
	    	  return "redirect:/product/detail/"+board.getProductId();
	      }
	      
	   }

//	@ResponseBody
//	@RequestMapping(value="deleteFile.do", produces="application/json; charset=UTF-8")
//	public String deleteFile(@RequestParam("boardNum") String boardNum,
//							 @RequestParam("fileName") String fileName) throws JsonProcessingException {
//		
//		log.info("boardNum = "+boardNum);
//		log.info("fileName = "+fileName);
//		
//		// 데이터 베이스에 합쳐져 있는 파일명을 각각의 파일명을 배열에 넣기
//		String[] fileArray = StringUtils.delimitedListToStringArray(fileName, "?");
//		log.info("count = "+fileArray.length);
//		
//		// 배열의 개수가 파일 개수 +1로 저장
//		int count = fileArray.length-1;
//		
//		// 파일 삭제
//		for(int i=0; i<count; i++) {
//			String pathName = boardImageUploadResource.getPath()+boardNum+"번 게시물/"+fileArray[i];
//			fileUploadService.deleteFile(pathName);
//		}
//		
//		return new ObjectMapper().writeValueAsString(fileName);
//	}

	/**
	 * 
	 * @param boardNum
	 * @return
	 */
	@RequestMapping("delete.do")
	public String deleteBoard(@RequestParam(value = "num", required = false, defaultValue = "0") int boardNum,
			@RequestParam("boardKinds") int boardKinds) {

		// 게시판 삭제
		service.deleteBoard(boardNum);

		// 게시물
		if (fileUploadService.fileIsLive(boardImageUploadResource.getPath() + boardNum + "번 게시물") == false) {
			fileUploadService.deleteFolderAll(boardImageUploadResource.getPath() + boardNum + "번 게시물");
			log.info("게시물이 정상적으로 삭제되었습니다.");
		}

		return "redirect:/board/list.do/boardKinds/" + boardKinds;
	}

	
	
	@RequestMapping("test.do")
	public String test(Model model) {

		String msg = "테스트 메시지";

		model.addAttribute("msg", msg);

		return "/board/test";
	}

}
