package cn.edu.ccu.manage.controller;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.ibusiness.system.IUser;
import cn.edu.ccu.manage.utils.*;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.student.*;
import cn.edu.ccu.model.system.ModuleGroupModel;
import cn.edu.ccu.model.user.UserModel;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.extention.StringExtention;
import cn.edu.ccu.utils.common.web.RequestParamHelper;
import cn.edu.ccu.utils.common.web.WebHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/main")
@AuthController(moduleId = -1)
public class MainController extends BaseController {

    @Autowired
    private IUser iUser;


    @RequestMapping("/login")
    @AuthMethod(mustLogin = false)
    public ModelAndView Login(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {
        ModelAndView mav = super.getModelAndView("", httpRequest);

        mav.addObject("backurl", httpRequest.getParameter("backurl"));
        try {
            if (WebHelper.getCookie(httpRequest, "rememberUserid") != null) {
                mav.addObject("userId", SecurityHelper.desDecrypt(WebHelper.getCookie(httpRequest, "rememberUserid"), WebProperties.getSecurityKey()));
            }
        } catch (Exception ex) {
        }

        mav.setViewName("main/login");
        return mav;
    }

    @RequestMapping("/logout")
    @AuthMethod(mustLogin = false)
    public void logout(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws IOException {
        AuthHelper.delLoginUser(httpRequest, httpResponse);
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/main/login");
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    @AuthMethod(mustLogin = false)
    public ModelAndView register(HttpServletRequest httpRequest) throws IOException {

        ModelAndView mav = super.getModelAndView("", httpRequest);

        UserModel userModel = AuthHelper.getLoginUserModel(httpRequest);

        if (userModel == null) {
            mav.setViewName("main/register");
        } else {
            mav.setViewName("main/login");
        }

        return mav;
    }

//    @RequestMapping(value = "/register", method = RequestMethod.POST)
//    @AuthMethod(mustLogin = false)
//    public
//    @ResponseBody
//    Map<String, Object>
//    registerDo(HttpServletRequest httpRequest, HttpServletResponse httpResponse, UserModel user) throws Exception {
//
//        Map<String, Object> map = new HashMap<>();
//        map.put("success", false);
//
//        if (user == null) {
//            httpResponse.sendRedirect(httpRequest.getContextPath() + "main/register");
//        } else {
//
//            StudentRegisterRequest studentRegisterRequest = new StudentRegisterRequest();
//            studentRegisterRequest.setUsername(user.getAccount());
//            studentRegisterRequest.setPassword(user.getPassword());
//            studentRegisterRequest.setName(user.getName());
//
//            StudentRegisterResponse studentRegisterResponse = iStudent.register(studentRegisterRequest, super.getRequestHead(httpRequest));
//
//            if (studentRegisterResponse.getRegisterResult() > 0) {
//                map.put("success", true);
//            }
//        }
//
//        return map;
//    }


    @RequestMapping("/index")
    @SuppressWarnings("unchecked")
    public ModelAndView index(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        UserModel loginUser = (UserModel) mav.getModel().get("loginUserModel");
        StringBuffer msg = new StringBuffer("");
        if (StringExtention.isNullOrEmpty(loginUser.getName())) {
            msg.append("请填写您的姓名     ");
        } else {
            Pattern pattern = Pattern.compile("[\u4E00-\u9FA5]{2,5}");
            Matcher matcher = pattern.matcher(loginUser.getName());
            if (!matcher.matches()) {
                msg.append("请填写您的真实姓名     ");
            }
        }
        if (msg.length() > 0) {//如果姓名不完整、邮箱没有绑定或者绑定的不是公司内部邮箱
            mav.setViewName("main/profile");
            mav.addObject("msg", msg.toString());
            mav.addObject("loginUser", loginUser);
        } else {

            // //获取用户菜单列表
            List<ModuleGroupModel> moduleGroupList = (List<ModuleGroupModel>) mav.getModelMap().get("loginModuleGroupList");
            // 获取当前登录用户的报表菜单
            mav.addObject("loginModuleGroupList", moduleGroupList);

            mav.setViewName("main/main");
        }

        return mav;
    }


    @RequestMapping(value = "/checklogin", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public
    @ResponseBody
    Map<String, Object> checklogin(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();
        String userId = httpRequest.getParameter("userId");
        String password = httpRequest.getParameter("password");
        RequestHead requestHead = super.getRequestHead(httpRequest);
        // 是否保存用户ID
        if (httpRequest.getParameter("rememberUserid") != null) {
            WebHelper.setCookie(httpResponse, "rememberUserid", SecurityHelper.desEncrypt(userId, WebProperties.getSecurityKey()), WebProperties.getCookieDomain());
        } else {
            WebHelper.delCookie(httpResponse, "rememberUserid");
        }

        UserModel userModel = iUser.checkUserPassword(userId, password, requestHead);
        if (userModel != null) {
            if (userModel.getHasRoles() == null || userModel.getHasRoles().size() == 0) {
                throw new BusinessException("尚未在云平台中设置您的角色，请联系工作人员");
            } else {
                AuthHelper.setLoginUser(httpRequest, httpResponse, userModel);
            }
            map.put("success", true);
        } else {
            AuthHelper.delLoginUser(httpRequest, httpResponse);
        }

        return map;

    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView profile(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        mav.addObject("loginUser", AuthHelper.getLoginUserModel(httpRequest));
        mav.setViewName("main/profile");
        return mav;
    }

    @RequestMapping(value = "/changepwd", method = RequestMethod.GET)
    public ModelAndView changepwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        ModelAndView mav = Common.getLoginModelAndView(httpRequest);
        mav.addObject("loginUser", AuthHelper.getLoginUserModel(httpRequest));

        mav.setViewName("main/changepwd");
        return mav;
    }

    /**
     * 请使用方法 @method fileUpload
     *
     * @param httpRequest
     * @param httpResponse
     * @param file
     * @return
     * @throws BusinessException
     */
    @RequestMapping(value = "/imgupload", method = RequestMethod.POST)
    @Deprecated
    public
    @ResponseBody
    Map<String, Object> imgUpload(HttpServletRequest httpRequest, HttpServletResponse httpResponse, @RequestParam CommonsMultipartFile file) throws BusinessException {
        Map<String, Object> map = new HashMap<>();

        String imageUrl = UtilsBusiness.fileUpload(file);
        if (imageUrl != null && !imageUrl.equals("")) {
            map.put("success", true);
            map.put("imageUrl", imageUrl);
        } else {
            map.put("success", false);
        }

        return map;
    }

    /**
     * 文件上传均使用该方法，不论是mp3或png
     *
     * @param httpRequest
     * @param httpResponse
     * @param file
     * @return
     * @throws BusinessException
     */
    @RequestMapping(value = "/fileupload", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> fileUpload(HttpServletRequest httpRequest, HttpServletResponse httpResponse, @RequestParam CommonsMultipartFile file) throws BusinessException {
        Map<String, Object> map = new HashMap<>();

        String fileUrl = UtilsBusiness.fileUpload(file);

        if (fileUrl != null && !fileUrl.equals("")) {
            map.put("success", true);
            map.put("imageUrl", fileUrl);
        } else {
            map.put("success", false);
        }

        return map;
    }

    @RequestMapping(value = "/resetpwd", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> resetpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        if (!httpRequest.getParameter("password").equals(httpRequest.getParameter("password2"))) {
            throw new BusinessException("两次输入的密码不一样!");
        } else {
            if (!AuthHelper.isLogin(httpRequest)) {
                throw new BusinessException("请重新登录");
            } else {
                iUser.updatePassword(httpRequest.getParameter("oldPassword"), httpRequest.getParameter("password"), super.getRequestHead(httpRequest));
                map.put("success", true);
            }
        }

        return map;
    }

    @RequestMapping(value = "/findpwd", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public ModelAndView findPwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId, String password) throws Exception {
        ModelAndView mav = new ModelAndView();
//        if (!httpRequest.getParameter("password").equals(httpRequest.getParameter("password2"))) {
//            throw new BusinessException("两次输入的密码不一样!");
//        } else {
//            String key = WebProperties.getSecurityKey();
//            accountId = SecurityHelper.desDecrypt(accountId, key);
////            UserBindAccount account = iUserBindAccount.selectByAccountId(accountId);
//            if (account == null) {
//                throw new BusinessException("没有找到您的账号,找回密码失败");
//            } else {
//                iUser.updatePassword(accountId, password);
//            }
//        }
//        mav.setViewName("main/login");
        return mav;
    }

//    @RequestMapping(value = "/sendCode", method = RequestMethod.POST)
//    @AuthMethod(mustLogin = false)
//    public
//    @ResponseBody
//    Map<String, Object> findpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//        boolean status = false;
//        String msg = "";
//        String flag = "";
//        if (accountId == null) {
//            msg = "手机/邮箱号码不能为空";
//        } else {
//            if (StringHelper.checkIsEmail(accountId)) {
//                flag = "email";
//            } else if (StringHelper.checkIsMobilePhone(accountId)) {
//                flag = "phone";
//            } else {
//                msg = "只能通过手机号码/邮箱号码找回";
//            }
//        }
//        if (!"".equals(msg)) {
//            throw new BusinessException(msg);
//        }
//        UserBindAccount account = iUserBindAccount.selectByAccountId(accountId);
//        if (account == null) {
//            if ("phone".equals(flag)) {
//                msg = "手机号码不存在";
//            } else {
//                msg = "邮箱号码不存在";
//            }
//        } else {
//            if ("phone".equals(flag)) {
//                // 发送短信
//                String code = iUserVerifyCode.getNumberCode(accountId, 300);
//                SMSRequest request = new SMSRequest();
//                request.setPhone(accountId);
//                request.setSmsTemplate(SMSTemplate.VerifyCodeForgetPassword);
//                request.setParam(new String[]{code, "5分钟"});
//                status = iSMS.SendSMS(request, super.getRequestHead(httpRequest));
//            } else {
//                // 发送邮件
//                String code = iUserVerifyCode.getNumberAndTextCode(accountId, 300);
//                EmailRequest request = new EmailRequest();
//                request.setTitle("移民帮云平台密码找回");
//                request.setEmail(accountId);
//                request.setEmailTemplate(EmailTemplate.VerifyCodeForgetPassword);
//                request.setParam(new Object[]{code, "5分钟"});
//                status = iEmail.SendEmail(request);
//            }
//        }
//        if (!"".equals(msg)) {
//            throw new BusinessException(msg);
//        }
//        map.put("success", status);
//        return map;
//    }
//
//    @RequestMapping(value = "/checkVerifyCode", method = RequestMethod.POST)
//    @AuthMethod(mustLogin = false)
//    public ModelAndView checkVerifyCode(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId, String verifyCode) throws Exception {
//        ModelAndView mav = new ModelAndView();
//        int result = iUserVerifyCode.verify(accountId, verifyCode, true);
//        String msg = "";
//        if (result == 0) {
//            String key = WebProperties.getSecurityKey();
//            accountId = SecurityHelper.desEncrypt(accountId, key);
//            mav.addObject("accountId", accountId);
//            mav.setViewName("main/findpwd");
//        } else {
//            if (result == -1) {
//                msg = "您的验证码不正确";
//            } else if (result == -2) {
//                msg = "您的验证码已过期";
//            } else if (result == -3) {
//                msg = "您的验证码已经使用过";
//            }
//            mav.addObject("accountId", accountId);
//            mav.addObject("msg", msg);
//            mav.setViewName("main/sendcode");
//        }
//        return mav;
//    }

//    @RequestMapping(value = "/tofindpwd", method = RequestMethod.GET)
//    @AuthMethod(mustLogin = false)
//    public ModelAndView toFindpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
//        ModelAndView mav = new ModelAndView("main/sendcode");
//        return mav;
//    }

    @RequestMapping(value = "/updateprofile", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateprofile(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        UserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
        Pattern pattern = Pattern.compile("[\u4E00-\u9FA5]{2,5}");
        Matcher matcher = pattern.matcher(RequestParamHelper.getString(httpRequest, "userName"));
        if (matcher.matches()) {

            userModel.setName(RequestParamHelper.getString(httpRequest, "nickName"));
            userModel.setBirthday((RequestParamHelper.getString(httpRequest, "birthDay")));
            userModel.setGender(RequestParamHelper.getString(httpRequest, "gender"));
            iUser.updateUser(userModel);
            AuthHelper.refreshLoginUser(userModel.getUserId(), httpRequest, httpResponse);
            map.put("success", true);
        } else {
            map.put("success", false);
            map.put("message", "请输入您的真实姓名");
        }
        return map;
    }

    @RequestMapping(value = "/updateHeadPic", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateHeadPic(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        Map<String, Object> map = new HashMap<>();
        String headPic = httpRequest.getParameter("headPic");
        if (headPic == null || "".equals(headPic)) {
            throw new BusinessException("更换头像失败");
        }

        UserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
        UserModel user = new UserModel();
        user.setUserId(userModel.getUserId());
//        user.setAvatarPic(headPic);
        iUser.updateUser(user);
        AuthHelper.refreshLoginUser(userModel.getUserId(), httpRequest, httpResponse);
        map.put("success", true);

        return map;
    }


//    @RequestMapping(value = "/sendVerifyCode", method = RequestMethod.POST)
//    public
//    @ResponseBody
//    Map<String, Object> sendVerifyCode(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//
//        String key = RequestParamHelper.getString(httpRequest, "accountId");
//        String verifyCode = "";
//        String accountType = RequestParamHelper.getString(httpRequest, "accountType");
//        switch (accountType) {
//            case "Phone":
//                // 验证码，五分钟有效
//                verifyCode = iUserVerifyCode.getNumberCode(key, 300);
//                SMSRequest smsRequest = new SMSRequest();
//                smsRequest.setPhone(key);
//                smsRequest.setParam(new String[]{verifyCode, "5分钟"});
//                smsRequest.setSmsTemplate(SMSTemplate.VerifyCode);
//
//                iSMS.SendSMS(smsRequest, super.getRequestHead(httpRequest));
//                break;
//            case "Email":
//                // 发送邮件
//                String code = iUserVerifyCode.getNumberAndTextCode(key, 300);
//                EmailRequest request = new EmailRequest();
//                request.setTitle("移民帮云平台");
//                request.setEmail(key);
//                request.setEmailTemplate(EmailTemplate.VerifyCode);
//                request.setParam(new Object[]{code, "5分钟"});
//                iEmail.SendEmail(request);
//                break;
//            default:
//                break;
//        }
//        map.put("success", true);
//
//        return map;
//    }
//
//    @RequestMapping(value = "/delBindAccount", method = RequestMethod.POST)
//    public
//    @ResponseBody
//    Map<String, Object> delBindAccount(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//        iUserBindAccount.delBinAccount(AccountGroup.YiMinBang, RequestParamHelper.getString(httpRequest, "accountId"), super.getRequestHead(httpRequest));
//        YmbUserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
//        AuthHelper.refreshLoginUser(userModel.getUserid(), httpRequest, httpResponse);
//        map.put("success", true);
//
//        return map;
//    }

}

