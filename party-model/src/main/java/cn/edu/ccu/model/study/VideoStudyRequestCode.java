package cn.edu.ccu.model.study;

/**
 * Created by Administrator on 2016/4/21.
 */
public class VideoStudyRequestCode {


    //建立连接
    public static final Integer START = 200;

    //=================================================

    //开始学习
    public static final Integer ON_START = 301;
    //暂停
    public static final Integer ON_PAUSE = 302;
    //继续
    public static final Integer ON_STOP = 304;

    //=================================================

    //连接断开
    public static final Integer END = 400;

    //=================================================

    //心跳检测
    public static final Integer PING_PONG = 500;
}
