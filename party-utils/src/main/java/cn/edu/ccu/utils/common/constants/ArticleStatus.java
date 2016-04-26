package cn.edu.ccu.utils.common.constants;

import cn.edu.ccu.utils.common.ErrorCodeEnum;

/**
 * Created by kuangye on 2016/4/13.
 */
public class ArticleStatus {

    /* 审核通过 */
    public static  final byte SUCCESS = 1;
    /* 审核通过 */
    public static  final byte WAIT = 0;
    /* 审核通过 */
    public static  final byte DRAFT = -1;
    /* 审核通过 */
    public static  final byte FAIL = -2;
    /* 审核通过 */
    public static  final byte DELETE = -3;
    /* 审核通过 */
    public static  final byte ADMIN_DELETE = -4;


    public static String getStatus(Byte status) throws Exception{

        switch (status) {
            case (byte) 1:
                return "审核通过";
            case (byte) 0:
                return "等待审核";
            case (byte) -1:
                return "草稿状态";
            case (byte) -2:
                return "审核失败";
            case (byte) -3:
                return "已删除";
            case (byte) -4:
                return "管理员删除";
            default:
                throw new Exception(ErrorCodeEnum.requestParamError.getMessage());
        }
    }
}
