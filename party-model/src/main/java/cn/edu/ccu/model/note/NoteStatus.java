package cn.edu.ccu.model.note;

/**
 * Created by Administrator on 2016/4/22.
 */
public class NoteStatus {

    //自有
    public static  final byte OWNED = 0;
    //审核中
    public static  final byte REVIEW = 1;
    //已通过
    public static  final byte PUBLISH = 2;
    //不通过
    public static  final byte REFUSE = -1;

}
