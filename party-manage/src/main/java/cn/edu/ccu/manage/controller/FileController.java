package cn.edu.ccu.manage.controller;

import cn.edu.ccu.manage.utils.AuthController;
import cn.edu.ccu.manage.utils.AuthMethod;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.file.FileHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by kuangye on 2016/4/16.
 */
@Controller
@RequestMapping("/file")
@AuthController(moduleId = -1)
public class FileController extends BaseController {

    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/pic/{y}/{m}/{d}/{name}", method = RequestMethod.GET)
    public void pic(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                    @PathVariable("y") String y, @PathVariable("m") String m, @PathVariable("d") String d,
                    @PathVariable("name") String name) throws Exception {

        try {
            //获取后缀
            String uri = httpServletRequest.getRequestURI();
            String suffix = uri.substring(uri.lastIndexOf("."), uri.length());

            byte[] buffer = new byte[1024];
            InputStream is = new FileInputStream(new File(FileHelper.getPicturePath()
                    + "/pic/" + y + File.separator + m + File.separator + d
                    + File.separator + name + suffix));
            OutputStream ps = null;
            httpServletResponse.setCharacterEncoding("UTF-8");
            httpServletResponse.setContentType("image/*");
            try {
                ps = httpServletResponse.getOutputStream();
                int i;
                while ((i = is.read(buffer)) > 0) {
                    ps.write(buffer, 0, i);
                }
                ps.flush();
            } catch (IOException e) {
                //
            } finally {
                if (ps != null) {
                    try {
                        is.close();
                        ps.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            throw new BusinessException("获取图片失败");
        }


    }


    @AuthMethod(mustLogin = false)
    @RequestMapping(value = "/video/{y}/{m}/{d}/{name}", method = RequestMethod.GET)
    public void video(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                      @PathVariable("y") String y, @PathVariable("m") String m, @PathVariable("d") String d,
                      @PathVariable("name") String name) throws Exception {

        try {
            //获取后缀
            String uri = httpServletRequest.getRequestURI();
            String suffix = uri.substring(uri.lastIndexOf("."), uri.length());

            byte[] buffer = new byte[1024];
            InputStream is = new FileInputStream(new File(FileHelper.getPicturePath()
                    + "/video/" + y + File.separator + m + File.separator + d
                    + File.separator + name + suffix));
            OutputStream ps = null;
            httpServletResponse.setCharacterEncoding("UTF-8");
            httpServletResponse.setContentType("video/*");
            try {
                ps = httpServletResponse.getOutputStream();
                int i;
                while ((i = is.read(buffer)) > 0) {
                    ps.write(buffer, 0, i);
                }
                ps.flush();
            } catch (IOException e) {
                //
            } finally {
                if (ps != null) {
                    try {
                        is.close();
                        ps.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            throw new BusinessException("获取图片失败");
        }


    }
}
