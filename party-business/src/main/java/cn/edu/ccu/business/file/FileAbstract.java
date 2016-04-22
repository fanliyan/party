package cn.edu.ccu.business.file;


import cn.edu.ccu.model.file.ExecuteResultModel;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by john on 15/8/13.
 */
public abstract class FileAbstract {

    protected String path ;


    /**
     * 格式
     */
    protected String format;
    /**
     * 文件流
     */
    protected InputStream inputStream;

    /**
     * 最大文件体积（Byte）上传校验使用
     */
    protected Integer maxSize;


    /**
     * 上传文件
     *
     * @return
     * @throws IOException
     */
    public final ExecuteResultModel uploadFile() throws IOException {

        ExecuteResultModel resultModel = new ExecuteResultModel();


        return this.upload();

    }


    /**
     * 上传逻辑
     *
     * @return
     * @throws IOException
     */
    protected abstract ExecuteResultModel upload() throws IOException;


}
