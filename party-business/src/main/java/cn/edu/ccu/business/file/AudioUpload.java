package cn.edu.ccu.business.file;

import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.file.ExecuteResultModel;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;

/**
 * Created by john on 15/10/27.
 */
public class AudioUpload extends FileAbstract {

    static final String HOST = "http://video.yiminbang.com/";

    public AudioUpload(CommonsMultipartFile file) {
        format = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
        try {
            inputStream = file.getInputStream();
        } catch (Exception e) {
            e.printStackTrace();
        }
        maxSize = 30 * 1024 * 1024;
    }

    public AudioUpload(InputStream inputStream, String fileName) {
        format = fileName.substring(fileName.lastIndexOf(".") + 1);
        this.inputStream = inputStream;
        maxSize = 30 * 1024 * 1024;
    }

    /**
     * 上传逻辑
     *
     * @return
     * @throws IOException
     */
    @Override
    protected ExecuteResultModel upload() throws IOException {

        ExecuteResultModel resultModel = new ExecuteResultModel();
        //文件上传地址
        Calendar clDate = Calendar.getInstance();
        String filePath = String.format("%s/%s/%s/%s.%s", clDate
                        .get(Calendar.YEAR), clDate.get(Calendar.MONTH) + 1,
                clDate.get(Calendar.DATE), java.util.UUID.randomUUID()
                        .toString(), this.format);
        try {

            if (this.inputStream.available() > this.maxSize) {
                resultModel.setMessage("文件超过上传大小限制");
            } else {

                StringBuffer path = new StringBuffer(System.getProperty("catalina.home") == null ? "" : System.getProperty("catalina.home"));
                if (path.length() == 0) {
                    path.append(System.getProperty("catalina.base") == null ? "" : System.getProperty("catalina.base"));
                }
                if (path.length() == 0) {
                    throw new BusinessException("+++++++++++system error: server home is not found!+++++++++++");
                } else {
                    String sep = System.getProperty("file.separator");
                    path.append(sep).append("pic").append(sep);

                    path.append(filePath);
                }

                try {
                    File file = new File(path.toString());

                    FileOutputStream fileOutputStream = new FileOutputStream(file);
                    byte[] buffer = new byte[1024];
                    int i;
                    while ((i = this.inputStream.read(buffer)) > 0) {
                        fileOutputStream.write(buffer, 0, i);
                    }

                    fileOutputStream.flush();
                    fileOutputStream.close();

                    this.inputStream.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }

                resultModel.setIsSuccess(true);
                resultModel.setMessage(HOST + filePath);

                this.inputStream.close();
            }
        } catch (Exception e) {
            resultModel.setMessage("上传失败");
            e.printStackTrace();
        }
        return resultModel;
    }
}
