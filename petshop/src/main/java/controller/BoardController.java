package controller;

import logic.Board;
import logic.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private ShopService service;

    @RequestMapping("list")
    public ModelAndView list(Integer pageNum, String searchtype, String searchcontent) {
        ModelAndView mav = new ModelAndView();

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        int limit = 10;
        int listcount = service.boardcount(searchtype, searchcontent);
        List<Board> boardlist = service.boardlist(pageNum, limit, searchtype, searchcontent);
        int maxpage = listcount / limit;
        if (listcount % limit != 0) {
            maxpage++;
        }

        int startpage = pageNum / limit;
        if (pageNum % limit != 0) {
            startpage++;
        }

        int endpage = startpage + 9;
        if (endpage > maxpage) {
            endpage = maxpage;
        }

        int boardno = listcount - (pageNum - 1) * limit;

        mav.addObject("pageNum", pageNum);
        mav.addObject("maxpage", maxpage);
        mav.addObject("startpage", startpage);
        mav.addObject("endpage", endpage);
        mav.addObject("listcount", listcount);
        mav.addObject("boardlist", boardlist);
        mav.addObject("boardno", boardno);

        return mav;
    }

    @PostMapping("write")
    public ModelAndView writeBoard(@Valid Board board, BindingResult br, MultipartHttpServletRequest request) {
        if (br.hasErrors()) {
            return new ModelAndView();
        }

        ModelAndView mav = new ModelAndView("/alert");
        int num = service.boardmaxnum() + 1;

        if (!FileUpload(num, board, mav, request, "write.shop?num=" + num)) {
            return mav;
        }

        board.setNum(num);
        board.setRef(num);

        int result = service.boardInsert(board);

        if (result > 0) {
            mav.addObject("msg","게시글 작성이 완료되었습니다.");
            mav.addObject("url","detail.shop?num=" + num);
        } else {
            mav.addObject("msg","게시글 작성을 실패하였습니다!.");
            mav.addObject("url","write.shop");
        }

        return mav;
    }

    @PostMapping("reply")
    public ModelAndView replyBoard(@Valid Board board, BindingResult br, MultipartHttpServletRequest request) {
        if (br.hasErrors()) {
            ModelAndView mav = new ModelAndView();
            Board dbBoard = service.getBoard(board.getNum(), request);
            Map<String, Object> map = br.getModel();
            Board b = (Board)map.get("board");
            b.setTitle(dbBoard.getTitle());

            return mav;
        }

        ModelAndView mav = new ModelAndView("/alert");
        int num = service.boardmaxnum() + 1;

        if (!FileUpload(num, board, mav, request, "reply.shop?num=" + num)) {
            return mav;
        }

        board.setNum(num);
        board.setReflevel(board.getReflevel() + 1);
        board.setRefstep(board.getRefstep() + 1);

        service.updateRefStep(board);

        int result = service.boardInsert(board);

        if (result > 0) {
            mav.addObject("msg","답변글 작성이 완료되었습니다.");
            mav.addObject("url","detail.shop?num=" + num);
        } else {
            mav.addObject("msg","답변글 작성을 실패하였습니다!.");
            mav.addObject("url","reply.shop");
        }

        return mav;
    }

    @PostMapping("update")
    public ModelAndView updateBoard(@Valid Board board, BindingResult br, MultipartHttpServletRequest request) {
        if (br.hasErrors()) {
            return new ModelAndView();
        }

        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("num") == null) {
            mav.addObject("msg","게시글 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop");

            return mav;
        }

        int num = Integer.parseInt(request.getParameter("num"));

        Board dbBoard = service.getBoard(num, request);
        if (!dbBoard.getPass().equals(board.getPass())) {
            mav.addObject("msg","비밀번호가 일치하지 않습니다!");
            mav.addObject("url","update.shop?num=" + num);

            return mav;
        }

        if (!FileUpload(num, board, mav, request, "update.shop?num=" + num)) {
            return mav;
        }

        int result = service.boardUpdate(board);

        if (result > 0) {
            mav.addObject("msg","게시글 수정이 완료되었습니다.");
            mav.addObject("url","detail.shop?num=" + num);
        } else {
            mav.addObject("msg","게시글 수정을 실패하였습니다!.");
            mav.addObject("url","write.shop");
        }

        return mav;
    }

    @PostMapping("delete")
    public ModelAndView deleteBoard(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("num") == null) {
            mav.addObject("msg","게시글 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop");

            return mav;
        }

        int num = Integer.parseInt(request.getParameter("num"));

        Board dbBoard = service.getBoard(num, request);
        if (!dbBoard.getPass().equals(request.getParameter("password"))) {
            mav.addObject("msg","비밀번호가 일치하지 않습니다!");
            mav.addObject("url","delete.shop?num=" + num);

            return mav;
        }

        if (!DeleteAllFiles(num, mav, request)) {
            return mav;
        }

        int result = service.boardDelete(num);

        if (result > 0) {
            mav.addObject("msg","게시글 삭제가 완료되었습니다.");
            mav.addObject("url","list.shop");
        } else {
            mav.addObject("msg","게시글 삭제를 실패하였습니다!.");
            mav.addObject("url","detail.shop?num=" + num);
        }

        return mav;
    }

    @RequestMapping("imgupload")
    public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
        int num = service.boardmaxnum() + 1;

        String path = request.getServletContext().getRealPath("/") + "board/imgfile/" + num + "/";

        File folder_path = new File(path);
        if (!folder_path.exists()) {
            folder_path.mkdirs();
        }

        if (!upload.isEmpty()) {
            File file = new File(path, upload.getOriginalFilename());
            try {
                upload.transferTo(file);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String project = request.getContextPath();
        String fileName = project + "/board/imgfile/" + num + "/" + upload.getOriginalFilename();
        model.addAttribute("fileName", fileName);
        model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);

        return "ckeditor";
    }

    @RequestMapping("*")
    public ModelAndView getBoard(Integer num, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        Board board = new Board();
        if (num != null) {
            board = service.getBoard(num, request);
        }
        mav.addObject("board", board);

        return mav;
    }

    private boolean FileUpload(int num, Board board, ModelAndView mav, MultipartHttpServletRequest request, String url) {
        MultipartFile mf = request.getFile("file1");
        String path = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";

        if (mf != null && mf.getOriginalFilename() != null && mf.getOriginalFilename().length() != 0) {
            File folder_path = new File(path);
            if (!folder_path.exists()) {
                if (!folder_path.mkdirs()) {
                    mav.addObject("msg", "서버 폴더 생성 권한 오류!");
                    mav.addObject("url", url);

                    return false;
                }
            }

            try {
                mf.transferTo(new File(path, mf.getOriginalFilename()));
            } catch (IOException e) {
                e.printStackTrace();

                mav.addObject("msg", "파일 업로드 오류!");
                mav.addObject("url", url);

                return false;
            }

            board.setFileurl(mf.getOriginalFilename());
        } else if (request.getRequestURI().contains("update") &&
                (board.getFile1() == null || board.getFile1().getOriginalFilename().length() == 0)) {
            Board dbBoard = service.getBoard(num, request);

            if (dbBoard.getFileurl() != null && dbBoard.getFileurl().length() != 0) {
                String filepath = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";
                if (!DeleteFiles(num, mav, filepath)) {
                    return false;
                }
            }

            board.setFileurl(null);
        }

        return true;
    }

    private boolean DeleteFiles(int num, ModelAndView mav, String path) {
        File folder_path = new File(path);
        try {
            while(folder_path.exists()) {
                File[] folder_list = folder_path.listFiles();

                if (folder_list == null)
                    break;

                for (File file : folder_list) {
                    if (!file.delete()) {
                        System.out.println("Board delete file failed : " + file.getPath());
                    }
                }

                if(folder_list.length == 0 && folder_path.isDirectory()){
                    if (!folder_path.delete()) {
                        System.out.println("Board delete folder failed : " + folder_path.getPath());
                    }
                }
            }
        } catch (Exception e) {
            mav.addObject("msg", "기존 업로드 된 파일을 삭제하는 중 오류가 발생하였습니다!");
            mav.addObject("url","detail.shop?num=" + num);

            return false;
        }

        return true;
    }

    private boolean DeleteAllFiles(int num, ModelAndView mav, HttpServletRequest request) {
        String filepath = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";
        String imgfilepath = request.getServletContext().getRealPath("/") + "board/imgfile/" + num + "/";

        return DeleteFiles(num, mav, filepath) && DeleteFiles(num, mav, imgfilepath);
    }
}
