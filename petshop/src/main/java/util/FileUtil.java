package util;

import logic.Board;
import logic.Item;
import logic.ShopService;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUtil {
    public boolean FileUpload(int num, ShopService shopService, Object logic, ModelAndView mav, MultipartHttpServletRequest request, String url) {
        MultipartFile mf;
        String path;

        if (logic instanceof Board) {
            path = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";
            mf = request.getFile("file1");
        } else if (logic instanceof Item) {
            path = request.getServletContext().getRealPath("/") + "item/img/" + num + "/";
            mf = request.getFile("mainpic");
        } else {
            return false;
        }

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

            if (logic instanceof Board) {
                ((Board) logic).setFileurl(mf.getOriginalFilename());
            } else {
                ((Item) logic).setMainpicurl(mf.getOriginalFilename());
            }
        } else if (request.getRequestURI().contains("update") && logic instanceof Board) {
            Board board = (Board) logic;
            if ((board.getFile1() == null || board.getFile1().getOriginalFilename() == null ||
                    board.getFile1().getOriginalFilename().length() == 0)) {
                Board dbBoard = shopService.getBoard(num);

                if (dbBoard.getFileurl() != null && dbBoard.getFileurl().length() != 0) {
                    String filepath = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";
                    if (!DeleteFiles(num, mav, filepath)) {
                        return false;
                    }
                }

                board.setFileurl(null);
            }
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
                        System.out.println("Delete file failed : " + file.getPath());
                    }
                }

                if(folder_list.length == 0 && folder_path.isDirectory()){
                    if (!folder_path.delete()) {
                        System.out.println("Delete folder failed : " + folder_path.getPath());
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

    public boolean DeleteAllFiles(int num, Object logic, ModelAndView mav, HttpServletRequest request) {
        String filepath;
        String imgfilepath;

        if (logic instanceof Board) {
            filepath = request.getServletContext().getRealPath("/") + "board/file/" + num + "/";
            imgfilepath = request.getServletContext().getRealPath("/") + "board/imgfile/" + num + "/";

            return DeleteFiles(num, mav, filepath) && DeleteFiles(num, mav, imgfilepath);
        } else {
            imgfilepath = request.getServletContext().getRealPath("/") + "item/img/" + num + "/";

            return DeleteFiles(num, mav, imgfilepath);
        }
    }
}
