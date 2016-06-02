package cn.edu.ccu.school.controller;

import cn.edu.ccu.ibusiness.common.*;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.common.BranchModel;
import cn.edu.ccu.model.common.NotificationModel;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.model.student.*;
import cn.edu.ccu.school.utils.AuthController;
import cn.edu.ccu.school.utils.AuthHelper;
import cn.edu.ccu.school.utils.AuthMethod;
import cn.edu.ccu.school.utils.WebProperties;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.extention.StringExtention;
import cn.edu.ccu.utils.common.web.WebHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/main")
@AuthController(moduleId = -1)
public class MainController extends BaseController {

    @Autowired
    private IStudent iStudent;
    @Autowired
    private ISchoolNotification iSchoolNotification;

    @Autowired
    private INation iNation;
    @Autowired
    private IProvince iProvince;
    @Autowired
    private IDepartment iDepartment;
    @Autowired
    private IBranch iBranch;

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @RequestMapping("/login")
    @AuthMethod(mustLogin = false)
    public ModelAndView Login(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        ModelAndView mav = super.getModelAndView("", httpRequest);

        mav.addObject("backurl", httpRequest.getParameter("backurl"));
        try {
            if (WebHelper.getCookie(httpRequest, "rememberUserid") != null) {
                mav.addObject("userId", SecurityHelper.desDecrypt(WebHelper.getCookie(httpRequest, "rememberUserid"), WebProperties.getSecurityKey()));
            }
        } catch (Exception ex) {
        }

        //已登录
        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);
        if(studentModel!=null){
            String backUrl = httpRequest.getParameter("backurl");
            if (!StringExtention.isNullOrEmpty(backUrl)) {
                httpResponse.sendRedirect(backUrl);
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/main/index");
            }
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

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

        if (studentModel == null) {

            mav.addObject("nationlist", iNation.selectNationList());
            mav.addObject("provincelist", iProvince.selectProvinceList());
            mav.addObject("departmentlist", iDepartment.select());

            mav.setViewName("main/register");
        } else {
            mav.setViewName("main/login");
        }

        return mav;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public
    @ResponseBody
    Map<String, Object>
    registerDo(HttpServletRequest httpRequest, HttpServletResponse httpResponse, StudentModel user,String birthdayString,
               Integer branchId1) throws Exception {

        Map<String, Object> map = new HashMap<>();
        map.put("success", false);

        if (user == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "main/register");
        } else {

            if(!StringExtention.isTrimNullOrEmpty(birthdayString))
                user.setBirthday(sdf.parse(birthdayString));


            StudentRegisterRequest studentRegisterRequest = new StudentRegisterRequest();
            studentRegisterRequest.setUsername(user.getAccount());
            studentRegisterRequest.setPassword(user.getPassword());
            studentRegisterRequest.setName(user.getName());
            studentRegisterRequest.setStudentCode(user.getStudentCode());


            studentRegisterRequest.setIdCard(user.getIdCard());
            studentRegisterRequest.setBirthday(user.getBirthday());
            studentRegisterRequest.setNationId(user.getNationId());
            studentRegisterRequest.setAreaCode(user.getAreaCode());
            studentRegisterRequest.setBranchId(user.getBranchId());
            studentRegisterRequest.setGender(user.getGender());
            studentRegisterRequest.setPhone(user.getPhone());


            StudentRegisterResponse studentRegisterResponse;
            //教师 注册
            if(user.getType()!=null&&user.getType()==1){
                studentRegisterRequest.setBranchId(branchId1);
                studentRegisterRequest.setType((byte)1);

                studentRegisterResponse = iStudent.registerTeacher(studentRegisterRequest, super.getRequestHead(httpRequest));
            }else{
                studentRegisterResponse = iStudent.register(studentRegisterRequest, super.getRequestHead(httpRequest));
            }


            if (studentRegisterResponse.getRegisterResult() > 0) {
                map.put("success", true);
            }
        }

        return map;
    }

    @RequestMapping(value = "/checklogin", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public
    @ResponseBody
    Map<String, Object> checklogin(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        Map<String, Object> map = new HashMap<>();

        String username = httpRequest.getParameter("username");
        String password = httpRequest.getParameter("password");


        RequestHead requestHead = super.getRequestHead(httpRequest);
        // 是否保存用户ID
        if (httpRequest.getParameter("rememberUserid") != null) {
            WebHelper.setCookie(httpResponse, "rememberUserid", SecurityHelper.desEncrypt(username, WebProperties.getSecurityKey()), WebProperties.getCookieDomain());
        } else {
            WebHelper.delCookie(httpResponse, "rememberUserid");
        }

        StudentLoginRequest studentLoginRequest = new StudentLoginRequest();
        studentLoginRequest.setAccount(username);
        studentLoginRequest.setPassword(password);

        StudentLoginResponse studentLoginResponse = iStudent.login(studentLoginRequest, requestHead);

        if (studentLoginResponse.getStudentModel() != null) {
            if (studentLoginResponse.getStudentModel().getsRoleModel() == null) {
                throw new BusinessException("尚未在平台中设置您的角色，请联系工作人员");
            } else {
                AuthHelper.setLoginUser(httpRequest, httpResponse, studentLoginResponse.getStudentModel());
            }
            map.put("success", true);
        } else {
            AuthHelper.delLoginUser(httpRequest, httpResponse);
        }

        return map;
    }

    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = super.getModelAndView("main/main", httpRequest);

        StudentModel studentModel = AuthHelper.getLoginUserModel(httpRequest);

       BranchModel branchModel = iBranch.getById(studentModel.getBranchId());

        NotificationModel notificationModel = iSchoolNotification.getByRoleAndDepartment(studentModel.getsRoleModel().getRoleId(),branchModel.getDepartmentId());

        mav.addObject("notify", notificationModel);
        return mav;
    }


    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView profile(HttpServletRequest httpRequest, HttpServletResponse httpResponse,
                                Boolean relName, Boolean nikeName, Boolean interiorEmail) throws Exception {

        ModelAndView mav = super.getModelAndView("main/profile", httpRequest);

        mav.addObject("loginUser", AuthHelper.getLoginUserModel(httpRequest));
//        StringBuffer msg = new StringBuffer("");
//        if (relName != null && !relName) {
//            msg.append("请输入您的真实姓名      ");
//        }
//        if (nikeName != null && !nikeName) {
//        }
//        if (interiorEmail != null && !interiorEmail) {
//            msg.append("请绑定您的公司内部邮箱");
//        }
//        if (msg.length() > 0) {
//            mav.addObject("msg", msg.toString());
//        }


        mav.addObject("nationlist", iNation.selectNationList());
        mav.addObject("provincelist", iProvince.selectProvinceList());
        mav.addObject("departmentlist", iDepartment.select());


        return mav;
    }

    @RequestMapping(value = "/changepwd", method = RequestMethod.GET)
    public ModelAndView changepwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {

        ModelAndView mav = super.getModelAndView("main/changepwd", httpRequest);

        return mav;
    }

    @RequestMapping(value = "/resetpwd", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> resetpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        Map<String, Object> map = new HashMap<>();

        if (!httpRequest.getParameter("password").equals(httpRequest.getParameter("password2"))) {
            throw new BusinessException("两次输入的密码不一样!");
        } else {
            StudentModel userModel = AuthHelper.getLoginUserModel(httpRequest);
            if (userModel == null) {
                throw new BusinessException("请重新登录");
            } else {
                iStudent.updatePassword(userModel, httpRequest.getParameter("oldPassword"), httpRequest.getParameter("password"), super.getRequestHead(httpRequest));
                map.put("success", true);
            }
        }

        return map;
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
        Map<String, Object> map = new HashMap<String, Object>();
        String path = this.getClass().getClassLoader().getResource("/").getPath() + "images/logo.png";
        // String imageUrl = UtilsBusiness.imgUpload(file, false, path);
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
        Map<String, Object> map = new HashMap<String, Object>();

        String fileUrl = UtilsBusiness.fileUpload(file);

        if (fileUrl != null && !fileUrl.equals("")) {
            map.put("success", true);
            map.put("imageUrl", fileUrl);
        } else {
            map.put("success", false);
        }

        return map;
    }


    @RequestMapping(value = "/findpwd", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public ModelAndView findPwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId, String password) throws Exception {

        ModelAndView mav = super.getModelAndView("", httpRequest);

        if (!httpRequest.getParameter("password").equals(httpRequest.getParameter("password2"))) {
            throw new BusinessException("两次输入的密码不一样!");
        } else {
//            String key = WebProperties.getSecurityKey();
//            accountId = SecurityHelper.desDecrypt(accountId, key);
//            UserBindAccount account = iUserBindAccount.selectByAccountId(accountId);
//            if (account == null) {
//                throw new BusinessException("没有找到您的账号,找回密码失败");
//            } else {
//                iUser.updatePassword(accountId, password);
//            }
        }
        mav.setViewName("main/login");
        return mav;
    }

    @RequestMapping(value = "/sendCode", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public
    @ResponseBody
    Map<String, Object> findpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        boolean status = false;
        String msg = "";
        String flag = "";
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
        if (!"".equals(msg)) {
            throw new BusinessException(msg);
        }
        map.put("success", status);
        return map;
    }

    @RequestMapping(value = "/checkVerifyCode", method = RequestMethod.POST)
    @AuthMethod(mustLogin = false)
    public ModelAndView checkVerifyCode(HttpServletRequest httpRequest, HttpServletResponse httpResponse, String accountId, String verifyCode) throws Exception {

        ModelAndView mav = super.getModelAndView("", httpRequest);
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
        return mav;
    }

    @RequestMapping(value = "/tofindpwd", method = RequestMethod.GET)
    @AuthMethod(mustLogin = false)
    public ModelAndView toFindpwd(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        ModelAndView mav = super.getModelAndView("main/sendcode", httpRequest);
        return mav;
    }

    @RequestMapping(value = "/updateprofile", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> updateprofile(HttpServletRequest httpRequest, HttpServletResponse httpResponse,StudentModel studentModel) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

//        YmbUserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
        if(StringExtention.isTrimNullOrEmpty(studentModel.getName())){
            map.put("success", false);
            map.put("message", "请输入您的真实姓名");
        }

        Pattern pattern = Pattern.compile("[\u4E00-\u9FA5]{2,10}");
        Matcher matcher = pattern.matcher(studentModel.getName());
        if (matcher.matches()) {
//
//            userModel.setNickName(RequestParamHelper.getString(httpRequest, "nickName"));
//            userModel.setBirthday(RequestParamHelper.getDate(httpRequest, "brithDay"));
//            userModel.setUserName(RequestParamHelper.getString(httpRequest, "userName"));
//            userModel.setGender(RequestParamHelper.getString(httpRequest, "gender"));
            iStudent.updateStudent(studentModel);
            AuthHelper.refreshLoginUser(studentModel.getId(), httpRequest, httpResponse);
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
        Map<String, Object> map = new HashMap<String, Object>();
        String headPic = httpRequest.getParameter("headPic");
        if (headPic == null || (headPic != null && "".equals(headPic))) {
            throw new BusinessException("更换头像失败");
        }

//        YmbUserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
//        YmbUserModel user = new YmbUserModel();
//        user.setUserid(userModel.getUserid());
//        user.setAvatarPic(headPic);
//        iUser.updateUser(user);
//        AuthHelper.refreshLoginUser(userModel.getUserid(), httpRequest, httpResponse);
//        map.put("success", true);

        return map;
    }


    @RequestMapping(value = "/sendVerifyCode", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> sendVerifyCode(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

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
        map.put("success", true);

        return map;
    }

    @RequestMapping(value = "/delBindAccount", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> delBindAccount(HttpServletRequest httpRequest, HttpServletResponse httpResponse) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
//        iUserBindAccount.delBinAccount(AccountGroup.YiMinBang, RequestParamHelper.getString(httpRequest, "accountId"), super.getRequestHead(httpRequest));
//        YmbUserModel userModel = AuthHelper.getLoginUserModel(httpRequest);
//        AuthHelper.refreshLoginUser(userModel.getUserid(), httpRequest, httpResponse);
//        map.put("success", true);

        return map;
    }

}
