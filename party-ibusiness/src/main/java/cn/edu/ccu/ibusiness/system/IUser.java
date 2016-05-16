package cn.edu.ccu.ibusiness.system;

import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.user.UserListRequest;
import cn.edu.ccu.model.user.UserListResponse;
import cn.edu.ccu.model.user.UserModel;

import java.util.List;

/**
 * Created by kuangye on 2016/3/26.
 */
public interface IUser {


    /**
     * 用户绑定账号 解绑 绑定 修改
     * @date 11:03:43 AM Aug 11, 2015
     * @author kuangye
     * @param @throws Exception
     */
//    void bindAccountManage(BindAccountRequest request,
//                           RequestHead requestHead) throws Exception;

    /**
     * 判断昵称是否被占用
     * @date 4:51:41 PM Aug 10, 2015
     * @author kuangye
     * @return boolean
     */
//    boolean nickNameCheck(NickNameCheckRequest request, RequestHead requestHead) throws Exception;



    UserModel getUserById(int id) ;

     UserModel getUserDetailById(int userId) ;


//    UserListByKeywordResponse selectUserByKeyword(UserListByKeywordRequest request) throws Exception;

    /**
     * 登录
     * @param request
     * @return
     * @throws Exception
     */
//    LoginResponse login(LoginRequest request,RequestHead requestHead) throws Exception;

    /**
     * 新的登陆
     * @date 2:41:47 PM Aug 19, 2015
     * @author kuangye
     * @param @throws Exception
     * @return LoginResponse
     */
//     UserModel checkUserPassword(String account,
//                                             String password, RequestHead requestHead,boolean usePassword) throws BusinessException;

    int updatePassword(String oldPassword, String newPassword,
                                          RequestHead requestHead) throws Exception;

//    FindPasswordResponse findPassword(FindPasswordRequest request,RequestHead requestHead) throws Exception;


    /**
     * 校验邮箱链接是否过期
     * @date 3:41:16 PM Aug 18, 2015
     * @author kuangye
     * @param @throws Exception
     */
//    CheckEmailCodeResponse checkEmailSignOnDB(CheckEmailCodeRequest request,RequestHead requestHead) throws Exception;


    /**
     * 检查用户名密码
     * @param request
     * @return
     * @throws Exception
     */
    UserModel checkUserPassword(String account, String password,
                                   RequestHead requestHead) throws BusinessException;

    /**
     * 修改用户密码
     * @return
     * @throws Exception
     */
//    boolean updatePassword(UserModel userModel,String oldPassword,String newPassword,RequestHead requestHead) throws Exception;

    /**
     * 修改用户信息
     * @return
     * @throws Exception
     */
    int updateUser(UserModel userModel);

    byte register(UserModel model) throws Exception;


//    List<UserModel> selectByRoleId(Integer roleId);

    List<UserModel> selectByUserIds(List<Integer> userIds);

//    boolean updatePassword(String accountId,String password)throws Exception;

    UserModel getSimpleUserModelByUserId(Integer userId);

    UserListResponse listBySplitPage(UserListRequest userRequest);


    /**
     * 发送邮件
     * @date 5:37:04 PM Aug 8, 2015
     * @author kuangye
     * @param @throws Exception
     */
//    boolean sendMail(SendMailRequest request,RequestHead requestHead) throws Exception;

    int addUser(UserModel user)throws Exception;


}
