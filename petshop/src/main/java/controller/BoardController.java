package controller;

import logic.Board;
import logic.Member;
import logic.ShopService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import util.FileUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("board")
public class BoardController {
    @Autowired
    private ShopService service;

    private FileUtil fileUtil = new FileUtil();

    @RequestMapping("list")
    public ModelAndView list(HttpSession session, Integer type, Integer pageNum, String searchtype, String searchcontent) {
        ModelAndView mav = new ModelAndView();

        if (pageNum == null || pageNum.toString().equals("")) {
            pageNum = 1;
        }

        Member loginMember = (Member)session.getAttribute(("loginMember"));
        int limit = 10;
        int listcount = service.boardcount(type, searchtype, searchcontent, loginMember.getId());
        List<Board> boardlist = service.boardlist(type, pageNum, limit, searchtype, searchcontent, loginMember.getId());
        if (boardlist != null) {
            for (Board board : boardlist) {
                Member member = service.memberSelect(board.getMember_id());
                if (member != null) {
                    board.setName(member.getName());
                }
            }
        }

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
    public ModelAndView writeBoard(HttpSession session, Integer type, String member_id, String item_name, MultipartHttpServletRequest request, @Valid Board board) {
        board.setType(type);
        board.setMember_id(member_id);
        board.setItem_name(item_name);

        ModelAndView mav = new ModelAndView("/alert");

        int num = service.boardmaxnum() + 1;

        if (!fileUtil.FileUpload(num, service, board, mav, request, "write.shop?num=" + num)) {
            return mav;
        }

        board.setNum(num);

        int result = service.boardInsert(board);

        if (result > 0) {
            mav.addObject("msg","게시글 작성이 완료되었습니다.");
            mav.addObject("url","detail.shop?type=" + type + "&num=" + num);
        } else {
            mav.addObject("msg","게시글 작성을 실패하였습니다!.");
            mav.addObject("url","write.shop?type=" + type + "&num=" + num);
        }

        return mav;
    }

    @PostMapping("update")
    public ModelAndView updateBoard(HttpSession session, Integer type, MultipartHttpServletRequest request, @Valid Board board) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("num") == null) {
            mav.addObject("msg","게시글 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop?type=" + type);

            return mav;
        }

        int num = Integer.parseInt(request.getParameter("num"));

        if (!fileUtil.FileUpload(num, service, board, mav, request, "update.shop?type=" + type + "&num=" + num)) {
            return mav;
        }

        int result = service.boardUpdate(board);

        if (result > 0) {
            mav.addObject("msg","게시글 수정이 완료되었습니다.");
            mav.addObject("url","detail.shop?type=" + type + "&num=" + num);
        } else {
            mav.addObject("msg","게시글 수정을 실패하였습니다!.");
            mav.addObject("url","update.shop?type=" + type + "&num=" + num);
        }

        return mav;
    }

    @PostMapping("delete")
    public ModelAndView deleteBoardPost(HttpSession session, Integer type, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/alert");

        if (request.getParameter("num") == null) {
            mav.addObject("msg","게시글 정보를 가져올 수 없습니다!");
            mav.addObject("url","list.shop?type=" + type);

            return mav;
        }

        int num = Integer.parseInt(request.getParameter("num"));

        if (!fileUtil.DeleteAllFiles(num, new Board(), mav, request)) {
            return mav;
        }

        int result = service.boardDelete(num);

        if (result > 0) {
            mav.addObject("msg","게시글 삭제가 완료되었습니다.");
            mav.addObject("url","list.shop?type=" + type);
        } else {
            mav.addObject("msg","게시글 삭제를 실패하였습니다!.");
            mav.addObject("url","detail.shop?type=" + type + "&num=" + num);
        }

        return mav;
    }

    @RequestMapping("imgupload")
    public String imgupload(HttpSession session, Integer type, MultipartHttpServletRequest request, MultipartFile upload, String CKEditorFuncNum, Model model) {
        int num = service.boardmaxnum() + 1;

        String path = request.getServletContext().getRealPath("/") + "board/imgfile/" + num + "/";

        File folder_path = new File(path);
        if (!folder_path.exists()) {
            if (!folder_path.mkdirs()) {
                return null;
            }
        }

        if (!upload.isEmpty()) {
            if (upload.getOriginalFilename() == null) {
                return null;
            }

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
    public ModelAndView getBoard(HttpSession session, Integer type, HttpServletRequest request, Integer num) {
        ModelAndView mav = new ModelAndView();
        Board board = new Board();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (num != null) {
            board = service.getBoard(num);
        }

        if (request.getRequestURI().contains("detail")) {
            Member member = service.memberSelect(board.getMember_id());
            if (member != null) {
                board.setName(member.getName());
            }
        } else if (request.getRequestURI().contains("update") || request.getRequestURI().contains("delete")) {
            if (request.getParameter("num") == null) {
                mav = new ModelAndView("/alert");
                mav.addObject("msg","게시글 정보를 가져올 수 없습니다!");
                mav.addObject("url","list.shop?type=" + type);

                return mav;
            }

            if (!loginMember.getId().equals(board.getMember_id())) {
                mav = new ModelAndView("/alert");
                if (request.getRequestURI().contains("update")) {
                    mav.addObject("msg", "본인 게시글만 수정 가능합니다!");
                } else {
                    mav.addObject("msg", "본인 게시글만 삭제 가능합니다!");
                }
                mav.addObject("url","detail.shop?type=" + type + "&num=" + num);

                return mav;
            }
        } else {
            board.setMember_id(loginMember.getId());
        }

        mav.addObject("board", board);

        return mav;
    }
}
