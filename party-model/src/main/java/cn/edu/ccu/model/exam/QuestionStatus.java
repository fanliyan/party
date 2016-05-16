package cn.edu.ccu.model.exam;

/**
 * Created by kuangye on 2016/4/24.
 */
public class QuestionStatus {

    //普通状态
    public static final byte NORMAL = 0;
    //问题状态 公用  外部可见
    public static final byte PUBLIC = 1;
    //问题状态 保密 仅后台可见
    public static final byte SECRET = 2;
    //问题状态 禁用
    public static final byte DISABLE = -1;
}
