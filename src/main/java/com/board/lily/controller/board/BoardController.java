package com.board.lily.controller.board;
import java.io.File;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.board.lily.model.board.dto.BoardVO;
import com.board.lily.service.board.BoardService;

@Controller    // 현재 클래스를 컨트롤러 빈(bean)으로 등록
public class BoardController {
	Logger logger = Logger.getLogger(BoardController.class);
   @RequestMapping(value="/", method=RequestMethod.GET)
	public String main() {
	   return "redirect:list.do";
   }

   String uploadPath = "/Users/ghyuk/Documents/lily_upload";
    // 의존관계 주입 => BoardServiceImpl 생성
    // IoC 의존관계 역전
    @Inject
    BoardService boardService;
    
    // 01. 게시글 목록
    @RequestMapping("list.do")
    public ModelAndView list() throws Exception{
    		logger.info("Call List Success");
        List<BoardVO> list = boardService.listAll();
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.setViewName("board/list"); // 뷰를 list.jsp로 설정
        mav.addObject("list", list); // 데이터를 저장
        return mav; // list.jsp로 List가 전달된다.
    }
    
    // 02_01. 게시글 작성화면
    // @RequestMapping("board/write.do")
    // value="", method="전송방식"
    @RequestMapping(value="write.do", method=RequestMethod.GET)
    public String write(){
    		logger.info("Call WriteFrom Success");
        return "board/write"; // write.jsp로 이동
    }
    
    // 02_02. 게시글 작성처리
    @RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insert(@ModelAttribute BoardVO vo, MultipartFile file) throws Exception{
    		logger.info("Call Insert Success");
    		BoardVO bvo = uploadFile(vo, file);
    		boardService.create(bvo);
    		//return "redirect:list.do";
    		return "redirect:view.do?bno="+bvo.getBno();
    }
    
    // File Upload
    @RequestMapping(value="uploadFile.do")
    public BoardVO uploadFile(BoardVO vo, MultipartFile file) throws Exception {
    		logger.info("Call UploadFile Success");
    		UUID uid = UUID.randomUUID();
    		String oriName = file.getOriginalFilename();
    		String savedName = uid.toString() + "_" + oriName;

    		vo.setOriFile(oriName);
    		vo.setSerFile(savedName);

    		File target = new File(uploadPath, savedName);

    		// 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
    		// FileCopyUtils.copy(바이트배열, 파일객체)
    		FileCopyUtils.copy(file.getBytes(), target);
    		
    		return vo;
    }
    
    // 03. 게시글 상세내용 조회, 게시글 조회수 증가 처리
    // @RequestParam : get/post방식으로 전달된 변수 1개
    // HttpSession 세션객체
    @RequestMapping(value="view.do", method=RequestMethod.GET)
    public ModelAndView view(@RequestParam int bno, HttpSession session) throws Exception{
    		logger.info("Call View Success");
        // 조회수 증가 처리
        boardService.increaseViewcnt(bno, session);
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView mav = new ModelAndView();
        // 뷰의 이름
        mav.setViewName("board/view");
        // 뷰에 전달할 데이터
        mav.addObject("dto", boardService.read(bno));
        return mav;
    }
    
    // 04. 게시글 수정
    // 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo로 전달됨
    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String update(@ModelAttribute BoardVO vo, MultipartFile file) throws Exception{
    		logger.info("Call Update Success");
    		if(!file.isEmpty()) {
    		int result = deleteFile(vo.getSerFile());
    		BoardVO bvo = new BoardVO();
    		if(result == 1) {
    			bvo = uploadFile(vo, file);
    			boardService.updateFile(bvo);
    			boardService.update(bvo);
    		}
    		return "redirect:view.do?bno="+bvo.getBno();
    		}else {
    			boardService.update(vo);
    			return "redirect:view.do?bno="+vo.getBno();
    		}
    }
    
    // 05. 게시글 삭제
    @RequestMapping("delete.do")
    public String delete(BoardVO vo) throws Exception{
    		logger.info("Call Delete Success");
    		int result = deleteFile(vo.getSerFile());
    		
    		if(result == 1) {
    			try {
    				boardService.deleteFile(vo.getBno());
    				boardService.delete(vo.getBno());
    			}catch(SQLException se) {
    				se.printStackTrace();
    			}
    		}
        return "redirect:list.do";
    }
    
    //	05. 파일 다운로드
    @RequestMapping(value="downloadFile.do")
    public void downloadFile(String oriFile, String serFile, HttpServletResponse response) throws Exception{
    		logger.info("Call DownloadFile Success");
        byte fileByte[] = FileUtils.readFileToByteArray(new File(uploadPath+"/"+serFile));
         
        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(oriFile,"UTF-8")+"\";");//download 될 파일 명 변경
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);

        response.getOutputStream().flush();
        response.getOutputStream().close();
    }

    // 06. 파일 삭제
    @RequestMapping(value="deleteFile.do")
    public int deleteFile(String serFile) {
    		logger.info("Call DeleteFile Success");
    		String path = uploadPath + "/" + serFile;
    		int result = 0;
    		File file = new File(path);
    		if(file.exists()) {
    			if(file.delete()) {
    				result = 1;
    				return result;
    			}
    		}
    		return result;
    }
}