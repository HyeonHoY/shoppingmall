/**
 * 
 */
package com.project.sm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.sm.service.ReplyService;
import com.project.sm.vo.ReplyVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Controller
@RequestMapping("/reply")
@Slf4j
public class ReplyController {

	@Inject
	ReplyService service;
	
	@RequestMapping(value="insert.do", method=RequestMethod.GET,
					produces="application/json;charset=UTF-8")
	@ResponseBody
	public String insert(@RequestParam Map<String, String> map) throws JsonProcessingException {
		
		// log.info("map = " + map.get("boardNum"));
		// map.keySet().forEach(x->System.out.println(x+"="+map.get(x)));
		
		ReplyVO reply= new ReplyVO(new Integer(map.get("boardNum")),
											map.get("replyContent"),
											map.get("replyWriter"));
		
		log.info("reply/insert.do");
		service.insertReply(reply);
		
		// 전체 댓글 데이터가 15개보다 많을 경우 15개씩 보기 위해 15를 더해준다.
		int end = new Integer(map.get("page_count"));
		int start = 1;
		log.info("start = "+start);
		log.info("end = "+end);
		
		List<ReplyVO> list = 
				service.listReplyPageing(new Integer(map.get("boardNum")), start, end);
		
		log.info("list = " + list);
		
//		for(ReplyVO vo:service.listReplyPageing(new Integer(map.get("boardNum")), page)) {
//			log.info("vo="+vo);
//		}
		
		return new ObjectMapper().writeValueAsString(list);
	}
	
	@RequestMapping(value="update.do", method=RequestMethod.GET, produces="application/json; charset=UTF-8")
	@ResponseBody
	public String updateReply(@RequestParam Map<String, String> map) throws JsonProcessingException {
		
		int replyNo = new Integer(map.get("replyNo"));
		int boardNum = new Integer(map.get("boardNum"));
		String replyContent = map.get("replyContent");
		
		log.info("replyNo = "+ replyNo);
		log.info("boardNum = "+ boardNum);
		log.info("replyContent = "+ replyContent);
		
		ReplyVO reply = new ReplyVO(replyNo, boardNum, replyContent);
		service.updateReply(reply);
		
		List<ReplyVO> list = service.listReplyPageing(boardNum, 1, 15);
		
		return new ObjectMapper().writeValueAsString(list);
	}
	
	@RequestMapping(value="delete.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String deleteReply(@RequestParam("replyNo") String replyNo,
							@RequestParam("boardNum") String boardNum,
							@RequestParam("msg") String msg) throws JsonProcessingException {
		
		log.info("replyNo = "+ replyNo);
		log.info("boardNum = "+ boardNum);
		log.info("msg="+msg.length());
		
		List<ReplyVO> list = new ArrayList<>();
		 
		// msg의 값이 삭제하였습니다 일 경우 
		if(msg.length() == 8) {
			
			log.info("성공 진입");
			
			// 삭제를 성공했을 경우
			if(service.deleteReply(new Integer(replyNo), new Integer(boardNum)) == true){
				list = service.listReplyPageing(new Integer(boardNum), 1, 15);
			} // if
		}  // if
		
		return new ObjectMapper().writeValueAsString(list);
	}
}
