package cn.edu.ccu.business.user;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.user.UserModelMapper;
import cn.edu.ccu.ibusiness.system.ISysLog;
import cn.edu.ccu.ibusiness.system.IModule;
import cn.edu.ccu.ibusiness.system.IRole;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.model.system.ModuleModel;
import cn.edu.ccu.model.system.RoleModel;
import cn.edu.ccu.model.user.UserListRequest;
import cn.edu.ccu.model.user.UserListResponse;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by kuangye on 2016/3/26.
 */
@Service
public class UserBusiness implements IUser {


    @Autowired
    private UserModelMapper userModelMapper;

    @Autowired
    private ISysLog iLog;

    @Autowired
    private IModule iModule;

    @Autowired
    private IRole iRole;

//
//    @Autowired
//    private ICountry iCountryBusiness;
//
//    @Autowired
//    private IEmail iEmailBusiness;


//    // 注册加密
//    private static final String REGISTER_HAT = "YMB2&|^.";
//    private static final String REGISTER_KEY = "654789YyMmBb~!@#";
//    // 找回密码加密
//    private static final String FIND_PWD_HAT = "yMb4&|^.";
//    private static final String FIND_PWD_KEY = "852741YyMmBb~!@#";
//    // 邮箱绑定加密
//    private static final String BINDING_HAT = "YmB6&|^.";
//    private static final String BINDING_KEY = "753429YyMmBb~!@#";


    public UserModel getUserById(int id) {
        if (IntegerExtention.hasValueAndMaxZero(id)) {
            UserModel userModel = userModelMapper.selectByPrimaryKey(id);

            this.getUserDetail(userModel);

            return userModel;
        }
        return null;
    }

    public UserModel getUserDetailById(int userId) {

        UserModel userModel = userModelMapper.selectByPrimaryKey(userId);
        if (userModel != null) {
            // 所含模块
            List<ModuleModel> moduleModelList = iModule.listByUserId(userModel.getUserId());
            userModel.setHasModules(moduleModelList);

            // 所有角色
            List<RoleModel> rolesModelList = iRole.listRolesByUserId(userModel.getUserId());
            userModel.setHasRoles(rolesModelList);
        }

        return userModel;
    }

    private UserModel getUserDetail(UserModel userModel) {

        if (userModel != null && userModel.getUserId() != null) {
            // 所含模块
            List<ModuleModel> moduleModelList = iModule.listByUserId(userModel.getUserId());
            userModel.setHasModules(moduleModelList);

            // 所有角色
            List<RoleModel> rolesModelList = iRole.listRolesByUserId(userModel.getUserId());
            userModel.setHasRoles(rolesModelList);
        }

        return userModel;
    }

    @Override
    @Transactional(value = TransactionManagerName.partyTransactionManager)
    public byte register(UserModel model) throws Exception {

        int executeResult = 0;
        // 验证账户是否已经存在
        if (model == null) {
            throw new BusinessException("请填写完整的注册信息");
        } else {
            if (StringExtention.isTrimNullOrEmpty(model.getAccount()) && StringExtention.isTrimNullOrEmpty(model.getPassword())) {
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            } else {

//                    int existsCount = 0;
//                    // 判断是否已有绑定账号
//                    for (UserBindAccount bindAccount : bindAccounts) {
//                        UserBindAccount userBindAccount = userBindAccountMapper.selectByPrimaryKey(bindAccount);
//                        if (userBindAccount != null && userBindAccount.getUserid().intValue() > 0) {
//                            existsCount++;
//                            if (AccountType.Phone.equals(userBindAccount.getAccountType())) {
//                                throw new BusinessException(ErrorCodeEnum.samePhoneError);
//                            } else if (AccountType.Email.equals(userBindAccount.getAccountType())) {
//                                throw new BusinessException(ErrorCodeEnum.sameEmailError);
//                            } else if (AccountType.QQ.equals(userBindAccount.getAccountType())) {
//                                throw new BusinessException(ErrorCodeEnum.sameQQError);
//                            } else if (AccountType.WeChat.equals(userBindAccount.getAccountType())) {
//                                throw new BusinessException(ErrorCodeEnum.sameWechatError);
//                            } else if (AccountType.WeiBo.equals(userBindAccount.getAccountType())) {
//                                throw new BusinessException(ErrorCodeEnum.sameWeiboError);
//                            } else {
//                                throw new BusinessException(ErrorCodeEnum.sameAccountError);
//                            }
//                        }
//                    }
//                    if (existsCount > 0) {
//                        return (byte) 0;// 任何一种存在,直接返回错误信息
//                    }

                // 密码加密
                String sha1Password = SecurityHelper.SHA1(model.getPassword());
                if (StringExtention.isNullOrEmpty(sha1Password)) {
                    throw new BusinessException(ErrorCodeEnum.passwordError);
                }
                model.setPassword(sha1Password);

//                    // 设置随机默认头像
//                    model.setAvatarPic("static/images/default_avatar/" + (new Random().nextInt(6) + 1) + ".png");

                executeResult = userModelMapper.insertSelective(model);
//
//                    if (executeResult > 0 && model.getUserId() > 0) {
//
//
//
//                    }
            }
        }

        return (byte) executeResult;
    }


    @Override
    public UserModel checkUserPassword(String account, String password, RequestHead requestHead) throws BusinessException {
        String errorMessage = "";
        Long errorCode = -998L;
        UserModel model = null;
        int maxLoginCount = 5;
        if (StringExtention.isTrimNullOrEmpty(account)) {
            errorMessage = "用户名不能为空！";
        } else if (StringExtention.isTrimNullOrEmpty(password)) {
            errorMessage = "密码不能为空！";
        } else {
            model = this.getUserByKey(account, password);
            if (model == null) {
                errorMessage = "用户不存在！";
                errorCode = ErrorCodeEnum.noUserError.getValue();
            } else if (model.getStatus() == -1) {
                errorMessage = "您帐户已经被锁定，请联系移民帮客服解锁";
            } else if (model.getStatus() == -2) {
                errorMessage = "帐户已经被禁用，如有疑问请联系移民帮客服";
            } else if (!SecurityHelper.SHA1(password).equals(model.getPassword())) {
                errorMessage = String.format("您的密码不正确！还有%s次重试机会，超过%s次帐户将被锁定", maxLoginCount - (model.getLoginFailCount() + 1), maxLoginCount);
            } else {
                model.setLastLoginIp(requestHead.getUserIp());
                model.setLastLoginTime(new Date());
                model.setLoginCount(model.getLoginCount() + 1);
                model.setLoginFailCount(0);
                requestHead.setLoginUserId(model.getUserId());

                userModelMapper.updateByPrimaryKeySelective(model);
                iLog.addLog(LogType.LoginSuccess, String.format("manage用户 %s 登录成功，IP地址:%s", model.getName(), requestHead.getUserIp()), requestHead);
            }

        }

        if (!errorMessage.equals("")) {
            // 记录用户登录失败次数
            if (model != null && model.getUserId() != null && model.getStatus() == 0) {
                requestHead.setLoginUserId(model.getUserId());
                model.setLoginFailCount(model.getLoginFailCount() + 1);
                if (model.getLoginFailCount() >= maxLoginCount) {
                    errorMessage = "您帐户已经被锁定，请联系移民帮客服解锁";
                    model.setLoginFailCount(0);
                    model.setStatus((byte) -1);
                }
                userModelMapper.updateByPrimaryKeySelective(model);
            }
            iLog.addLog(LogType.LoginFail, String.format("manage用户登录失败，IP地址：%s，错误信息：%s", requestHead.getUserIp(), errorMessage), requestHead);
            throw new BusinessException(errorCode, errorMessage);
        }

        this.getUserDetail(model);

        return model;
    }


    private UserModel getUserByKey(String account, String password) {

        if (!StringExtention.isTrimNullOrEmpty(account) && !StringExtention.isTrimNullOrEmpty(password)) {
            String encodePassword = SecurityHelper.SHA1(password);

            return userModelMapper.selectByKey(account, encodePassword);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


//    /**
//     * 验证微信登陆 如果openid存在 unionid不存在，则accountid更改为unionid 如果unionid存在
//     * openid不存在，则正常返回userdetail 如果都存在则删除openid记录 如果都不存在则抛异常
//     *
//     * @param request
//     * @return
//     */
//    private UserDetailModel checkWechatUser(LoginRequest request) throws Exception {
//        UserDetailModel model = null;
//        if (request == null || request.getAccountId().equals("")) {
//            throw new BusinessException(ErrorCodeEnum.noAccountError);
//        } else if (StringExtention.isTrimNullOrEmpty(request.getOpenId())) {
//            throw new BusinessException(ErrorCodeEnum.noOpenIdError);
//        } else {
//            Integer flag = 0;
//            UserBindAccountKey userBindAccountKey = new UserBindAccountKey();
//            userBindAccountKey.setAccountGroup(AccountGroup.Tencent);
//
//            // 1.验证openid作为accountid的情况
//            userBindAccountKey.setAccountId(request.getOpenId());
//            UserBindAccount userBindAccount = userBindAccountMapper.selectByPrimaryKey(userBindAccountKey);
//            if (userBindAccount != null)
//                flag++;
//            // 2.验证unionid作为accountid的情况
//            userBindAccountKey.setAccountId(request.getAccountId());
//            userBindAccount = userBindAccountMapper.selectByPrimaryKey(userBindAccountKey);
//            if (userBindAccount != null)
//                flag += 2;
//
//            switch (flag) {
//                case 0:
//                    throw new BusinessException(ErrorCodeEnum.noUserError);
//                case 1:
//                    userBindAccountMapper.updateAccountId(new HashMap<String, Object>() {
//                        {
//                            put("newAccountId", request.getAccountId());
//                            put("accountId", request.getOpenId());
//                            put("accountGroup", AccountGroup.Tencent.toString());
//                        }
//                    });
//                case 3:
//                    userBindAccountKey.setAccountId(request.getOpenId());
//                    userBindAccountMapper.deleteByPrimaryKey(userBindAccountKey);
//                default:
//                    break;
//            }
//            userBindAccountKey.setAccountId(request.getAccountId());
//            model = getUserByBindAccountKey(userBindAccountKey, null);
//        }
//
//        return model;
//    }

    // 修改密码
    public int updatePassword(String oldPassword, String newPassword, RequestHead requestHead) throws Exception {

        String errorMessage = null;

        // 第三方可能没密码
        if (StringExtention.isTrimNullOrEmpty(oldPassword)) {
            errorMessage = "原密码必须填写";
        }
        if (StringExtention.isTrimNullOrEmpty(newPassword)) {
            errorMessage = "新密码不能为空";
        }
        if (!IntegerExtention.hasValueAndMaxZero(requestHead.getLoginUserId())) {
            errorMessage = "登录凭证必须传";
        }
        if (errorMessage != null) {
            throw new BusinessException(errorMessage);
        }

        int result;// 0 失败 1成功 -1 账户锁定 -2账户禁用 -3 原密码错误

        UserModel model = getUserById(requestHead.getLoginUserId());
        // 老密码可能是空
        if (model == null || !(SecurityHelper.SHA1(oldPassword).equals(model.getPassword()) || newPassword.equals(model.getPassword()))) {
            result = -3;
        } else {
            result = model.getStatus();
        }
        if (result == 0) {
            String encodeNewPassword = SecurityHelper.SHA1(newPassword);
            model.setPassword(encodeNewPassword);
            result = (byte) userModelMapper.updateByPrimaryKeySelective(model);
        }

        return result;
    }

    /**
     * 发送邮件
     *
     * @param @param  request
     * @param @param  requestHead
     * @param @throws Exception
     * @date 5:37:26 PM Aug 8, 2015
     * @author kuangye
     */
//    public boolean sendMail(SendMailRequest request, RequestHead requestHead) throws Exception {
//
//        if (StringExtention.isNullOrEmpty(request.getMail()) || !StringHelper.checkIsEmail(request.getMail())) {
//            throw new BusinessException(ErrorCodeEnum.requestParamError);
//        }
//        if (request.getType() == null || request.getType() < 0 || request.getType() > 3) {
//            throw new BusinessException(ErrorCodeEnum.requestParamError);
//        }
//
//        String addr = null;
//        String subject = "移民帮";
//        if (request.getType() != null && request.getType() >= 0 && request.getType() < 3) {
//            if (StringExtention.isNullOrEmpty(request.getAddr())) {
//                throw new BusinessException(ErrorCodeEnum.requestParamError);
//            }
//            // 解码
//            addr = URLDecoder.decode(request.getAddr(), "UTF-8");
//        } else if (request.getType() != null && request.getType().intValue() == 3) {
//            // 自定义邮件
//
//            if (StringExtention.isTrimNullOrEmpty(request.getContent())) {
//                throw new BusinessException(ErrorCodeEnum.requestParamError);
//            }
//            if (!StringExtention.isTrimNullOrEmpty(request.getSubject())) {
//                subject = request.getSubject();
//            }
//
//        } else {
//            throw new BusinessException(ErrorCodeEnum.requestParamError);
//        }
//
//        boolean status = false;
//
//        // 首先检查用户是否存在
//        UserBindAccountKey userBindAccountKey = new UserBindAccountKey();
//        userBindAccountKey.setAccountId(request.getMail());
//        userBindAccountKey.setAccountGroup(AccountGroup.YiMinBang);
//        YmbUserModel model = getUserByBindAccountKey(userBindAccountKey, requestHead);
//
//        switch (request.getType()) {
//            case 0:// 找回密码
//                if (model == null) {
//                    throw new BusinessException(ErrorCodeEnum.noEmailError);
//                }
//                status = sendFindPasswordMail(request.getMail(), requestHead, addr);
//                break;
//            case 1:// 绑定邮箱
//                if (model != null) {
//                    throw new BusinessException(ErrorCodeEnum.sameEmailError);
//                }
//                status = sendBindAccountMail(request.getMail(), requestHead, addr);
//                break;
//            case 2:// 注册
//                if (model != null) {
//                    throw new BusinessException(ErrorCodeEnum.sameEmailError);
//                }
//                status = registerMail(request.getMail(), requestHead, addr);
//                break;
//            case 3:// 自定义邮件
//                status = customMail(request.getMail(), requestHead, subject, request.getContent());
//                break;
//            default:
//                throw new BusinessException(ErrorCodeEnum.requestParamError);
//        }
//
//        return status;
//    }

    /**
     * 发送邮件 点击链接激活
     *
     * @param @param  mailaddr 邮箱地址
     * @param @param  title 邮件标题
     * @param @param  addr 链接地址
     * @param @param  template 链接模板
     * @param @param  c 过期时间
     * @param @param  time 中文时间
     * @param @param  secret_key MD5加密
     * @param @param  secret_hat DES加密
     * @param @throws Exception
     * @return boolean
     * @date 2:26:47 PM Aug 17, 2015
     * @author kuangye
     */
//    private boolean mailTemplate(String mailaddr, String title, String addr, EmailTemplate template, Calendar c, String time, String secret_key, String secret_hat) throws Exception {
//
//        boolean flag = false;
//
//        // 加密 MAIL+时间+KEY
//        StringBuffer des = new StringBuffer();
//        des.append(mailaddr);
//        des.append("+");
//
//        // 过期时间
//        des.append(c.getTime().getTime());
//
//        String code = SecurityHelper.desEncrypt(des.toString(), secret_hat);
//
//        // 验证
//        String sign = SecurityHelper.MD5(code + secret_key);
//
//        // 设置过期时间
//        UserVerifyCodeModel userVerifyCodeModel = new UserVerifyCodeModel();
//        userVerifyCodeModel.setKey(mailaddr);
//        userVerifyCodeModel.setCode(code);
//        userVerifyCodeModel.setCodeExpireTime(c.getTime());
//        int i = userVerifyCodeModelMapper.insertSelective(userVerifyCodeModel);
//        if (i != 1) {
//            throw new BusinessException(ErrorCodeEnum.systemError);
//        }
//
//        // 地址可带参数
//        int index = addr.indexOf("?");
//        if (index > 0) {
//            addr = String.format("%s&se=%s&sign=%s", addr, code, sign);
//        } else {
//            addr = String.format("%s?se=%s&sign=%s", addr, code, sign);
//        }
//
//        // send mail
//        EmailRequest emailRequest = new EmailRequest();
//        emailRequest.setEmail(mailaddr);
//        emailRequest.setEmailTemplate(template);
//        emailRequest.setTitle(title);
//        emailRequest.setParam(new Object[]{time, addr, addr});
//        flag = iEmailBusiness.SendEmail(emailRequest, "移民帮", null);
//
//        return flag;
//    }

    /**
     * 发送找回密码邮件
     *
     * @param @throws Exception
     * @date 6:02:15 PM Aug 8, 2015
     * @author kuangye
     */
//    private boolean sendFindPasswordMail(String mailaddr, RequestHead requestHead, String linkAddr) throws Exception {
//
//        Calendar calendar = Calendar.getInstance();
//        calendar.add(Calendar.HOUR_OF_DAY, 24);
//
//        // 发送邮件
//        return mailTemplate(mailaddr, "【移民帮】找回密码", linkAddr, EmailTemplate.findPasswordEmail, calendar, "24小时", FIND_PWD_KEY, FIND_PWD_HAT);
//    }

    /**
     * 绑定邮箱
     *
     * @param @throws Exception
     * @date 2:10:29 PM Aug 11, 2015
     * @author kuangye
     */
//    private boolean sendBindAccountMail(String mailaddr, RequestHead requestHead, String linkAddr) throws Exception {
//
//        // 24小时过期
//        Calendar calendar = Calendar.getInstance();
//        calendar.add(Calendar.HOUR_OF_DAY, 24);
//
//        // 发送邮件
//        return mailTemplate(mailaddr, "【移民帮】绑定邮箱", linkAddr, EmailTemplate.ConfirmEmail, calendar, "24小时", BINDING_KEY, BINDING_HAT);
//    }

    // 邮件注册
//    private boolean registerMail(String mailaddr, RequestHead requestHead, String linkAddr) throws Exception {
//
//        // 24小时过期
//        Calendar calendar = Calendar.getInstance();
//        calendar.add(Calendar.HOUR_OF_DAY, 24);
//
//        // 发送邮件
//        return mailTemplate(mailaddr, "【移民帮】邮件注册", linkAddr, EmailTemplate.ConfirmEmail, calendar, "24小时", REGISTER_KEY, REGISTER_HAT);
//    }

    // 自定义邮件
//    private boolean customMail(String mailaddr, RequestHead requestHead, String subject, String content) throws Exception {
//
//        // send mail
//        EmailRequest emailRequest = new EmailRequest();
//        emailRequest.setEmail(mailaddr);
//        emailRequest.setTitle(subject);
//
//        return iEmailBusiness.SendEmail(emailRequest, "移民帮", content);
//    }

    /**
     * 校验邮箱链接是否过期
     *
     * @param @throws Exception
     * @date 4:20:56 PM Aug 18, 2015
     * @author kuangye
     */
//    @Override
//    public CheckEmailCodeResponse checkEmailSignOnDB(CheckEmailCodeRequest request, RequestHead requestHead) throws Exception {
//
//        if (StringExtention.isNullOrEmpty(request.getSign()) || StringExtention.isNullOrEmpty(request.getVerifyCode()) || request.getType() == null) {
//            throw new BusinessException(ErrorCodeEnum.requestParamError);
//        }
//
//        String email;
//
//        switch (request.getType()) {
//            case 0:
//                // 注册;
//                email = checkEmailSign(request.getVerifyCode(), request.getSign(), null, REGISTER_HAT, REGISTER_KEY);
//                ;
//                break;
//            case 1:
//                // 找回密码;
//                email = checkEmailSign(request.getVerifyCode(), request.getSign(), null, FIND_PWD_HAT, FIND_PWD_KEY);
//                ;
//                break;
//            case 2:
//                // 绑定邮箱;
//                email = checkEmailSign(request.getVerifyCode(), request.getSign(), null, BINDING_HAT, BINDING_KEY);
//                ;
//                break;
//            default:
//                throw new BusinessException(ErrorCodeEnum.operationError);
//        }
//
//        iUserVerifyCode.verifyThrows(email, request.getVerifyCode(), false);
//
//        CheckEmailCodeResponse response = new CheckEmailCodeResponse();
//        response.setMail(email);
//
//        return response;
//    }

    /**
     * 检验邮件码是否篡改
     *
     * @return String
     * @date 9:41:42 AM Aug 10, 2015
     * @author kuangye
     */
    public String checkEmailSign(String desCode, String sign, String email, String hat, String key) throws Exception {

        if (StringExtention.isNullOrEmpty(sign)) {
            throw new BusinessException(ErrorCodeEnum.requestParamError);
        }

        // 验证码是否存在
        if (StringExtention.isNullOrEmpty(sign))
            throw new BusinessException(ErrorCodeEnum.requestParamError.getValue(), ErrorCodeEnum.requestParamError.getMessage());
        // 解密
        String code = SecurityHelper.desDecrypt(desCode, hat);
        // 匹配 是否篡改
        String md5Code = SecurityHelper.MD5(desCode + key);
        if (!md5Code.equals(sign)) {
            throw new BusinessException(ErrorCodeEnum.verifyCodeError);
        }

        String[] str = code.split("\\+");
        // 长度是否符合
        if (str.length != 2) {
            throw new BusinessException(ErrorCodeEnum.operationError);
        }

        if (email != null) {
            // 邮箱是否正确
            if (!str[0].equals(email)) {
                throw new BusinessException(ErrorCodeEnum.emailError);
            }
        }

        Long nowTime = Long.parseLong(str[1]);
        // 是否过期
        if (new Date().getTime() > nowTime) {
            throw new BusinessException(ErrorCodeEnum.verifyCodeExpiredError);
        }

        return str[0];
    }

    /**
     * 邮件找回密码
     *
     * @param @param  request
     * @param @param  requestHead
     * @param @return
     * @return boolean
     * @throws
     * @date 9:41:07 AM Aug 10, 2015
     * @author kuangye
     */
//    private boolean findPasswordByEmail(FindPasswordRequest request, RequestHead requestHead) throws Exception {
//
//        // 首先检查用户是否存在
//        UserBindAccountKey bindKey = new UserBindAccountKey();
//        bindKey.setAccountId(request.getFindValue());
//        bindKey.setAccountGroup(AccountGroup.YiMinBang);
//        YmbUserModel model = getUserByBindAccountKey(bindKey, requestHead);
//        if (model == null) {
//            throw new BusinessException(ErrorCodeEnum.noUserError);
//        }
//
//        String desCode = request.getVerifyCode();
//        String sign = request.getSign();
//        // 校验
//        checkEmailSign(desCode, sign, request.getFindValue(), FIND_PWD_HAT, FIND_PWD_KEY);
//        // 数据库校验
//        iUserVerifyCode.verifyThrows(request.getFindValue(), desCode, true);
//
//        return true;
//    }

//    /**
//     * 找回密码
//     *
//     * @param request
//     * @param requestHead
//     * @return
//     * @throws Exception
//     */
//    public FindPasswordResponse findPassword(FindPasswordRequest request, RequestHead requestHead) throws Exception {
//
//        String errorMessage = null;
//        if (StringExtention.isNullOrEmpty(request.getFindValue())) {
//            errorMessage = "找回值必须填写";
//        }
//        if (StringExtention.isNullOrEmpty(request.getVerifyCode())) {
//            errorMessage = "验证码必须填写";
//        }
//        if (StringExtention.isNullOrEmpty(request.getPassword())) {
//            errorMessage = "密码必须填写";
//        }
//        if (errorMessage != null) {
//            throw new BusinessException(errorMessage);
//        }
//        FindPasswordResponse response = new FindPasswordResponse();
//
//        // 这里验证验证码 后面补充
//        if (StringHelper.checkIsMobilePhone(request.getFindValue())) {
//            iUserVerifyCode.verifyThrows(request.getFindValue(), request.getVerifyCode(), true);
//
//        } else if (StringHelper.checkIsEmail(request.getFindValue())) {
//
//            if (!findPasswordByEmail(request, requestHead)) {
//                throw new BusinessException(ErrorCodeEnum.findPwdError);
//            }
//
//        } else {
//            throw new BusinessException("不支持非手机和邮箱的密码找回");
//        }
//
//        UserBindAccountKey bindKey = new UserBindAccountKey();
//
//        bindKey.setAccountId(request.getFindValue());
//        bindKey.setAccountGroup(AccountGroup.YiMinBang);
//
//        byte result = 0;// 0 失败 1 成功 -1 手机号或邮箱未绑定
//        // 首先检查用户是否存在
//        YmbUserModel model = getUserByBindAccountKey(bindKey, requestHead);
//        if (model == null) {
//            result = -1;
//        } else {
//            String newPassword = SecurityHelper.SHA1(request.getPassword());
//            model.setPassword(newPassword);
//            result = (byte) ymbUserModelMapper.updateByPrimaryKeySelective(model);
//
//        }
//
//        // FindPasswordResponse response = new FindPasswordResponse();
//        response.setFindResult(result);
//        return response;
//    }

//    @Override
//    @Transactional(value = TransactionManagerName.centerTransactionManager)
//    public EditUserInfoResponse editUserInfo(EditUserInfoRequest request, RequestHead requestHead) throws Exception {
//
//        if (requestHead.getLoginUserId() == null || requestHead.getLoginUserId() <= 0) {
//            throw new BusinessException("必须登录");
//        }
//        byte result = 0;
//        EditUserInfoResponse response = new EditUserInfoResponse();
//        if (!StringExtention.isNullOrEmpty(request.getAvatarPic()) || !StringExtention.isNullOrEmpty(request.getPhone()) || request.getGender() != null
//                || !StringExtention.isNullOrEmpty(request.getNickName())) {
//
//            if (request.getGender() != null && !request.getGender().toLowerCase().equals("m") && !request.getGender().toLowerCase().equals("f")) {
//                throw new BusinessException("性别参数错误");
//            }
//            YmbUserModel userModel = ymbUserModelMapper.selectByPrimaryKey(requestHead.getLoginUserId());
//            if (userModel == null) {
//                throw new BusinessException("未查询到用户信息");
//            }
//            try {
//                boolean isUpdateUser = false;
//                if (!StringExtention.isNullOrEmpty(request.getAvatarPic())) {
//                    userModel.setAvatarPic(request.getAvatarPic());
//                    isUpdateUser = true;
//                }
//                if (!StringExtention.isNullOrEmpty(request.getNickName())) {
//                    userModel.setNickName(request.getNickName());
//                    isUpdateUser = true;
//                }
//                if (request.getGender() != null) {
//                    userModel.setGender(request.getGender());
//                    isUpdateUser = true;
//                }
//                if (isUpdateUser) {
//                    result = ymbUserModelMapper.updateByPrimaryKeySelective(userModel) > 0 ? (byte) 1 : (byte) 0;
//                }
//                if (!StringExtention.isNullOrEmpty(request.getPhone())) {
//
//                    List<UserBindAccount> bindAccounts = userBindAccountMapper.selectByUserId(requestHead.getLoginUserId());
//                    if (bindAccounts == null || bindAccounts.size() < 1) {
//                        throw new BusinessException("未绑定任何账户");
//                    }
//
//                    if (StringExtention.isNullOrEmpty(request.getVerifyCode())) {
//                        throw new BusinessException("修改手机号验证码必须填写");
//                    }
//                    // 验证验证码
//                    int verResult = iUserVerifyCode.verify(request.getPhone(), request.getVerifyCode(), true);
//                    if (verResult != 0) {
//                        result = -1;
//                        response.setEditResult(result);
//                        ;// 验证码错误
//                        return response;
//                    }
//                    UserBindAccountKey uba = new UserBindAccountKey();
//                    uba.setAccountGroup(AccountGroup.YiMinBang);
//                    uba.setAccountId(request.getPhone());
//                    UserBindAccount currentAccount = userBindAccountMapper.selectByPrimaryKey(uba);
//                    if (currentAccount == null) {
//                        UserBindAccount phoneAccount = null;
//                        for (UserBindAccount userBindAccount : bindAccounts) {
//                            if (userBindAccount.getAccountType() == AccountType.Phone) {
//                                phoneAccount = userBindAccount;
//                                break;
//                            }
//                        }
//                        if (phoneAccount == null) {
//                            phoneAccount = new UserBindAccount();
//                            phoneAccount.setAccountGroup(AccountGroup.YiMinBang);
//                            phoneAccount.setAccountId(request.getPhone());
//                            phoneAccount.setAccountType(AccountType.Phone);
//                            phoneAccount.setUserid(userModel.getUserid());
//                            try {
//                                result = userBindAccountMapper.insertSelective(phoneAccount) > 0 ? (byte) 1 : (byte) 0;
//                            } catch (Exception e) {
//                                // TODO: handle exception
//                            }
//
//                        } else {
//                            phoneAccount.setNewAccountId(request.getPhone());
//                            result = userBindAccountMapper.updateByPrimaryKeySelective(phoneAccount) > 0 ? (byte) 1 : (byte) 0;
//                        }
//                    } else {
//                        result = -2;
//                    }
//                }
//            } catch (Exception e) {
//                LogHelper.Error(e.getMessage());
//            }
//
//        }
//
//        response.setEditResult(result);
//        return response;
//    }

//    public boolean updatePassword(YmbUserModel userModel, String oldPassword, String newPassword, RequestHead requestHead) throws Exception {
//        boolean result = false;
//        if (newPassword == null) {
//            throw new BusinessException("请输入新密码");
//        } else if (newPassword.length() < 6) {
//            throw new BusinessException("新密码不得少于6位");
//        } else {
//            newPassword = newPassword.trim();
//        }
//
//        if (oldPassword == null) {
//            throw new BusinessException("请输入原密码");
//        } else {
//            oldPassword = oldPassword.trim();
//        }
//
//        if (userModel == null) {
//            throw new BusinessException("请重新登录");
//        } else if (!SecurityHelper.SHA1(oldPassword).equals(userModel.getPassword())) {
//            throw new BusinessException("原密码不正确");
//        } else {
//            userModel.setPassword(SecurityHelper.SHA1(newPassword));
//            ymbUserModelMapper.updateByPrimaryKeySelective(userModel);
//            result = true;
//        }
//        return result;
//    }
    public int updateUser(UserModel userModel) {
        return userModelMapper.updateByPrimaryKeySelective(userModel);
    }


//    /**
//     * @param request
//     * @param requestHead
//     * @return
//     * @throws Exception
//     * @throws
//     * @Title: custAuthGet
//     * @Description: 用户认证信息获取
//     * @author yinqiang
//     */
//    @Override
//    public CustAuthGetResponse custAuthGet(CustAuthGetRequest request, RequestHead requestHead) throws Exception {
//        if (!IntegerExtention.hasValueAndMaxZero(requestHead.getLoginUserId())) {
//            throw new BusinessException("用户id必传");
//        }
//        CustAutSalesModel cusModel = salesModelMapper.selectOnlyBaseByPrimaryKey(requestHead.getLoginUserId());
//        CustAuthGetResponse response = new CustAuthGetResponse();
//        response.setCustAutSales(cusModel);
//        return response;
//    }

//    @Override
//    public UserModel getUserById(int userId) {
//
//        UserModel userModel = iUserModelMapper.selectByPrimaryKey(userId);
//
//        if (userModel != null) {
//            //设置角色
//            List<RoleModel> roleModelList = iRole.listRolesByUserid(userModel.getUserId());
//            userModel.setHasRoles(roleModelList);
//
//            //设置模块
//            List<ModuleModel> moduleModelList = iModule.listByUserId(userModel.getUserId());
//            userModel.setHasModules(moduleModelList);
//        }
//
//        return userModel;
//    }

//    // 添加反馈
//    public boolean addFeedback(FeedbackRequest request, RequestHead requestHead) throws Exception {
//        if (requestHead.getLoginUserId() == null || requestHead.getLoginUserId() <= 0) {
//            throw new BusinessException("必须登录");
//        }
//        if (StringExtention.isNullOrEmpty(request.getContent())) {
//            throw new BusinessException("反馈内容不能为空");
//        }
//        UserFeedbackModel feedbackModel = new UserFeedbackModel();
//        feedbackModel.setContent(request.getContent());
//        feedbackModel.setUserid(requestHead.getLoginUserId());
//        int executeResult = userFeedbcakModelMapper.insertSelective(feedbackModel);
//        return executeResult > 0;
//    }

    //    @Override
//    public List<YmbUserModel> selectByRoleId(Integer roleId) {
//        return ymbUserModelMapper.selectByRoleId(roleId);
//    }
//
    @Override
    public List<UserModel> selectByUserIds(List<Integer> ids) {
        if (ids != null && ids.size() > 0)
            return userModelMapper.selectByIds(ids);

        return null;
    }
//
//    @Override
//    public boolean updatePassword(String accountId, String password) throws Exception {
//        UserBindAccount account = userBindAccountMapper.selectByAccountId(accountId);
//        if (account == null) {
//            throw new BusinessException("账号不存在");
//        }
//        YmbUserModel userModel = new YmbUserModel();
//        userModel.setUserid(account.getUserid());
//        userModel.setPassword(SecurityHelper.SHA1(password));
//        userModel.setAccountGroup(AccountGroup.YiMinBang);
//        int result = ymbUserModelMapper.updateByPrimaryKeySelective(userModel);
//        return result > 0;
//    }

    public UserModel getSimpleUserModelByUserId(Integer userId) {
        UserModel userModel = userModelMapper.selectByPrimaryKey(userId);

        //不序列化
        userModel.setAccount(null);
        userModel.setPassword(null);
        userModel.setLastLoginIp(null);
        userModel.setLoginCount(null);
        userModel.setLoginFailCount(null);
        userModel.setStatus(null);
        userModel.setCreateTime(null);
        userModel.setLastLoginTime(null);
        userModel.setLastModifyTime(null);

        userModel.setGender(null);
        userModel.setBirthday(null);

        return userModel;
    }

    @Override
    public UserListResponse listBySplitPage(UserListRequest userRequest) {

        Map<String, Object> map = new HashMap<>();
        UserModel user = userRequest.getUserModel();
        if (!StringExtention.isTrimNullOrEmpty(user.getName())) {
            map.put("name", user.getName());
        }
        if (IntegerExtention.hasValueAndMaxZero(user.getUserId())) {
            map.put("userId", user.getUserId());
        }

        SplitPageRequest pageRequest = userRequest.getSplitPageRequest();
        UtilsBusiness.pubMapforSplitPage(pageRequest, map);

        int totalSize = userModelMapper.selectCount(map);
        List<UserModel> list = userModelMapper.selectByUserMap(map);

        UserListResponse response = new UserListResponse();
        response.setSplitPageResponse(UtilsBusiness.getSplitPageResponse(totalSize, pageRequest.getPageSize(), pageRequest.getPageNo()));
        response.setUserModelList(list);
        return response;
    }

    /**
     * @param avatarPic
     * @param userid
     * @return
     * @throws
     * @Title: updateAvatarPic
     * @Description: 更新用户头像
     * @author yinqiang
     */
//    public int updateAvatarPic(String avatarPic, Integer userid) {
//        return userModelMapper.updateAvatarPic(avatarPic, userid);
//    }
    @Override
    public int addUser(UserModel user) throws Exception {
        if (StringExtention.isNullOrEmpty(user.getAccount()))
            throw new BusinessException("账号不能为空");
        if (StringExtention.isNullOrEmpty(user.getPassword()))
            throw new BusinessException("密码不能为空");
        if (StringExtention.isNullOrEmpty(user.getName()))
            throw new BusinessException("姓名不能为空");

        UserModel model = userModelMapper.selectByKey(user.getAccount(), null);
        if (model != null) {
            throw new BusinessException("相同账号已经存在");
        }

        return userModelMapper.insertSelective(user);
    }

//
//    @Override
//    public List<YmbUserModel> listByMap(YmbUserModel user) {
//        if (StringExtention.isNullOrEmpty(user.getUserName()) && StringExtention.isNullOrEmpty(user.getEmail())) {
//            return null;
//        }
//        Map<String, Object> map = new HashMap<String, Object>();
//        if (!StringExtention.isNullOrEmpty(user.getUserName())) {
//            map.put("userName", user.getUserName());
//        }
//        if (!StringExtention.isNullOrEmpty(user.getEmail())) {
//            map.put("email", user.getEmail());
//        }
//        List<YmbUserModel> list = ymbUserModelMapper.selectByUser(map);
//        for (YmbUserModel ymbUserModel : list) {
//            ymbUserModel.setEmail(ymbUserModel.getUserBindAccount().getAccountId());
//        }
//        return list;
//    }


}
