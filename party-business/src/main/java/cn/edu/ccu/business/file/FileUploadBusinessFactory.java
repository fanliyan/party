package cn.edu.ccu.business.file;


import cn.edu.ccu.model.exception.BusinessException;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class FileUploadBusinessFactory {

    static final List<String> AUDIO_FORMAT = new ArrayList<String>() {{
        add("mp3");
    }};

    static final List<String> VIDEO_FORMAT = new ArrayList<String>() {{
        add("mp4");
    }};


    static final List<String> PIC_FORMAT = new ArrayList<String>() {{
        add("png");
        add("jpg");
        add("bmp");
        add("gif");
        add("jpeg");
    }};

    public static FileAbstract create(InputStream inputStream, String fileName) {
        if (fileName != null && fileName.lastIndexOf('.') >= 0) {
            String format = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            if (AUDIO_FORMAT.contains(format)) {
                return new AudioUpload(inputStream, fileName);
            } else if (VIDEO_FORMAT.contains(format)) {
                return new VideoUpload(inputStream, fileName);
            } else if (PIC_FORMAT.contains(format)) {
                return new PictureUpload(inputStream, fileName);
            }
        }
        throw new BusinessException(-1, "暂不支持此格式上传");
    }
}
