package cn.edu.ccu.business.student;

import cn.edu.ccu.business.UtilsBusiness;
import cn.edu.ccu.data.TransactionManagerName;
import cn.edu.ccu.data.student.StudentModelMapper;
import cn.edu.ccu.data.student.RStudentRoleModelMapper;
import cn.edu.ccu.data.student.SRoleModelMapper;
import cn.edu.ccu.ibusiness.student.IStuLog;
import cn.edu.ccu.ibusiness.student.IStudent;
import cn.edu.ccu.model.RequestHead;
import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.model.student.*;
import cn.edu.ccu.model.system.LogType;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.SecurityHelper;
import cn.edu.ccu.utils.common.constants.SRoleConstant;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import cn.edu.ccu.utils.common.extention.StringExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kuangye on 2016/4/10.
 */
@Service
public class StudentBusiness implements IStudent {


    @Autowired
    private IStuLog iLog;


    @Autowired
    private StudentModelMapper studentModelMapper;
    @Autowired
    private RStudentRoleModelMapper rStudentRoleModelMapper;
    @Autowired
    private SRoleModelMapper sRoleModelMapper;


    // 登录
    public StudentLoginResponse login(StudentLoginRequest request, RequestHead requestHead) throws Exception {

        if (StringExtention.isNullOrEmpty(request.getAccount())) {
            throw new BusinessException("用户名不能为空");
        }
        if (StringExtention.isNullOrEmpty(request.getPassword())) {
            throw new BusinessException("密码不能为空");
        }

        StudentModel studentModel = this.checkUserPassword(request.getAccount(), request.getPassword(), requestHead);

        StudentLoginResponse response = new StudentLoginResponse();

        // String sha1Password=SecurityHelper.SHA1(request.getPassword());

        if (studentModel != null && studentModel.getId() > 0) {

            // 将不需要的属性置null 不序列话出去
            studentModel.setAccount(null);
            studentModel.setPassword(null);

            studentModel.setCreateTime(null);
            studentModel.setCreateTime(null);
            studentModel.setStatus(null);
            studentModel.setLastLoginIp(null);
            studentModel.setLastLoginTime(null);
            studentModel.setLastModifyTime(null);
            studentModel.setLoginCount(null);
            studentModel.setLoginFailCount(null);


            //获取角色
            this.getStudentRole(studentModel);

//            if (ymbModel.getAvatarPic() == null) {
//                ymbModel.setAvatarPic("");
//            } else if (ymbModel.getAvatarPic().toLowerCase().startsWith("static/images/")) {
//                ymbModel.setAvatarPic("//www.yiminbang.com/" + ymbModel.getAvatarPic());
//            }


            response.setLoginResult(1);
            // Httpser
//            String authToken = AuthHelper.createAuthToken(requestHead.getUserIp(), requestHead.getUseAgent(), ymbModel.getUserid().toString(), request.getAccountId(), requestHead.getAppId());
//            response.setLoginUserToken(authToken);

            response.setStudentModel(studentModel);
        } else {
            response.setLoginResult(0);
        }
        return response;
    }


    private StudentModel checkUserPassword(String account, String password, RequestHead requestHead) throws BusinessException {

        String errorMessage = "";
        Long errorCode = -998L;
        StudentModel model = null;
        //最多登录次数
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
                errorMessage = "您帐户已经被锁定，请联系管理员解锁";
            } else if (model.getStatus() == -2) {
                errorMessage = "帐户已经被禁用，如有疑问请联系管理员";
            } else if (!SecurityHelper.SHA1(password).equals(model.getPassword())) {
                errorMessage = String.format("您的密码不正确！还有%s次重试机会，超过%s次帐户将被锁定", maxLoginCount - (model.getLoginFailCount() + 1), maxLoginCount);
            } else {
                model.setLastLoginIp(requestHead.getUserIp());
                model.setLastLoginTime(new Date());
                model.setLoginCount(model.getLoginCount() + 1);
                model.setLoginFailCount(0);
                requestHead.setLoginUserId(model.getId());

                studentModelMapper.updateByPrimaryKeySelective(model);
                iLog.addLog(LogType.LoginSuccess, String.format("用户登录成功，IP地址:%s", requestHead.getUserIp()), requestHead);
            }

        }

        if (!errorMessage.equals("")) {
            // 记录用户登录失败次数
            if (model != null && model.getId() != null && model.getStatus() == 0) {
                requestHead.setLoginUserId(model.getId());
                model.setLoginFailCount(model.getLoginFailCount() + 1);
                if (model.getLoginFailCount() >= maxLoginCount) {
                    errorMessage = "您帐户已经被锁定，请联系移民帮客服解锁";
                    model.setLoginFailCount(0);
                    model.setStatus((byte) -1);
                }
                studentModelMapper.updateByPrimaryKeySelective(model);
            }
            iLog.addLog(LogType.LoginFail, String.format("用户登录失败，IP地址：%s，错误信息：%s", requestHead.getUserIp(), errorMessage), requestHead);
            throw new BusinessException(errorCode, errorMessage);
        }

        return model;
    }

    private StudentModel getUserByKey(String account, String password) {

        if (!StringExtention.isTrimNullOrEmpty(account) && !StringExtention.isTrimNullOrEmpty(password)) {
            String encodePassword = SecurityHelper.SHA1(password);

            return studentModelMapper.selectByKey(account, encodePassword);
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    /***
     * 注册
     *
     * @date 4:01:04 PM Aug 6, 2015
     * @author kuangye
     */
    @Transactional(value = TransactionManagerName.partyTransactionManager)
    public StudentRegisterResponse register(StudentRegisterRequest request, RequestHead requestHead) throws Exception {

        try {
            StudentRegisterResponse response = new StudentRegisterResponse();
            // 必须有accountID或者有手机号 还得有昵称
            if (StringExtention.isNullOrEmpty(request.getUsername()))
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            if (StringExtention.isNullOrEmpty(request.getPassword()))
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            if (StringExtention.isNullOrEmpty(request.getName()))
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            if (StringExtention.isNullOrEmpty(request.getStudentCode()))
                throw new BusinessException(ErrorCodeEnum.registerInfoError);

            // 当做ID用户
            StudentModel studentModel = new StudentModel();


            studentModel.setAccount(request.getUsername());
            studentModel.setPassword(request.getPassword());
            studentModel.setStudentCode(request.getStudentCode());


            //学号 唯一标识
            String studentCode = request.getStudentCode();

            // 判断学号是否被占用
            boolean isOccupied = isStudentCodeOccupied(studentCode);
            if (isOccupied)
                throw new BusinessException("学号已存在");


            int executeResult = this.register(studentModel);

            response.setRegisterResult(executeResult);

            // 注册成功 默认取登录态
            if (executeResult > 0) {

                StudentLoginRequest loginRequest = new StudentLoginRequest();
                loginRequest.setAccount(request.getUsername());
                loginRequest.setPassword(request.getPassword());

                StudentLoginResponse loginResponse = this.login(loginRequest, requestHead);
                if (loginResponse.getLoginResult() > 0) {
                    response.setStudentModel(loginResponse.getStudentModel());
                }
            }

            return response;
        } catch (Exception e) {
            throw e;
        }
    }

    @Transactional(value = TransactionManagerName.partyTransactionManager)
    private int register(StudentModel model) throws Exception {

        int executeResult;
        // 验证账户是否已经存在
        if (model == null) {
            throw new BusinessException("请填写完整的注册信息");
        } else {
            if (StringExtention.isNullOrEmpty(model.getAccount())) {
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            } else if (StringExtention.isNullOrEmpty(model.getPassword())) {
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            } else if (StringExtention.isNullOrEmpty(model.getName())) {
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            } else if (StringExtention.isNullOrEmpty(model.getStudentCode())) {
                throw new BusinessException(ErrorCodeEnum.registerInfoError);
            } else {

                model.setCreateTime(new Date());
                model.setLastModifyTime(new Date());

                // 密码加密
                String sha1Password = SecurityHelper.SHA1(model.getPassword());
                if (StringExtention.isNullOrEmpty(sha1Password)) {
                    throw new BusinessException(ErrorCodeEnum.passwordError);
                }

                model.setPassword(sha1Password);
                model.setStatus((byte) 0);

                // 设置随机默认头像
//                    model.setAvatarPic("static/images/default_avatar/" + (new Random().nextInt(6) + 1) + ".png");

                executeResult = studentModelMapper.insertSelective(model);

                if (executeResult > 0 && model.getId() > 0) {

                    //默认角色 普通学生
                    RStudentRoleModel rStudentRoleModel = new RStudentRoleModel();
                    rStudentRoleModel.setStudentId(model.getId());
                    rStudentRoleModel.setRoleId(SRoleConstant.GENERAL_STUDENT);

                    rStudentRoleModelMapper.insertSelective(rStudentRoleModel);
                }
            }
        }

        return executeResult;
    }

    /**
     * 判断昵称是否被占用
     *
     * @return boolean
     * @date 4:51:41 PM Aug 10, 2015
     * @author kuangye
     */
    private boolean isStudentCodeOccupied(String studentCode) throws Exception {

        StudentModel studentModel = studentModelMapper.selectByStudentCode(studentCode);

        return studentModel != null;
    }

    public boolean studentCodeCheck(NickNameCheckRequest request, RequestHead requestHead) throws Exception {

        if (StringExtention.isNullOrEmpty(request.getNickName()))
            throw new BusinessException(ErrorCodeEnum.requestParamError);

        return !isStudentCodeOccupied(request.getNickName());
    }


    public StudentModel getStudentById(Integer id) {

        StudentModel studentModel;

        if (IntegerExtention.hasValueAndMaxZero(id)) {

            studentModel = studentModelMapper.selectByPrimaryKey(id);

            this.getStudentRole(studentModel);

            return studentModel;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }

    public StudentModel getStudentDetailById(Integer id) {

        StudentModel studentModel;

        if (IntegerExtention.hasValueAndMaxZero(id)) {

            studentModel = studentModelMapper.selectDetail(id);

            return studentModel;
        }

        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    //获取学生角色
    private void getStudentRole(StudentModel studentModel) {

        if (studentModel != null && IntegerExtention.hasValueAndMaxZero(studentModel.getId())) {

            Integer roleId = rStudentRoleModelMapper.selectRoleIdByStudentId(studentModel.getId());
            if (roleId != null) {
                SRoleModel sRoleModel = sRoleModelMapper.selectByPrimaryKey(roleId);

                studentModel.setsRoleModel(sRoleModel);
            }
        }
    }


    // 修改密码
    public boolean updatePassword(StudentModel studentModel, String oldPassword, String newPassword, RequestHead requestHead) throws Exception {

        boolean result;
        if (newPassword == null) {
            throw new BusinessException("请输入新密码");
        } else if (newPassword.length() < 6) {
            throw new BusinessException("新密码不得少于6位");
        } else {
            newPassword = newPassword.trim();
        }

        if (oldPassword == null) {
            throw new BusinessException("请输入原密码");
        } else {
            oldPassword = oldPassword.trim();
        }

        if (studentModel == null) {
            throw new BusinessException("请重新登录");
        }

        StudentModel model = studentModelMapper.selectByPrimaryKey(studentModel.getId());
        if (!SecurityHelper.SHA1(oldPassword).equals(model.getPassword())) {
            throw new BusinessException("原密码不正确");
        } else {
            studentModel.setPassword(SecurityHelper.SHA1(newPassword));
            int i = studentModelMapper.updateByPrimaryKeySelective(studentModel);
            result = i > 0;
        }
        return result;
    }


    public StudentListResponse listByPage(StudentListRequest studentListRequest) {

        Map<String, Object> map = new HashMap<>();
        StudentModel studentModel = studentListRequest.getStudentModel();
        if (!StringExtention.isTrimNullOrEmpty(studentModel.getName())) {
            map.put("name", studentModel.getName());
        }
        if (IntegerExtention.hasValueAndMaxZero(studentModel.getId())) {
            map.put("userId", studentModel.getId());
        }
        if (!StringExtention.isTrimNullOrEmpty(studentModel.getStudentCode())) {
            map.put("studentCode", studentModel.getStudentCode());
        }
        if (studentModel.getsRoleModel() != null
                && IntegerExtention.hasValueAndMaxZero(studentModel.getsRoleModel().getRoleId())) {
            map.put("roleId", studentModel.getsRoleModel().getRoleId());
        }
        if (studentModel.getAreaModel() != null
                && StringExtention.isTrimNullOrEmpty(studentModel.getAreaModel().getCode())) {
            map.put("areaCode", studentModel.getAreaModel().getCode());
        }
        if (studentModel.getCityModel() != null
                && StringExtention.isTrimNullOrEmpty(studentModel.getCityModel().getCode())) {
            map.put("cityCode", studentModel.getCityModel().getCode());
        }
        if (studentModel.getProvinceModel() != null
                && StringExtention.isTrimNullOrEmpty(studentModel.getProvinceModel().getCode())) {
            map.put("provinceCode", studentModel.getProvinceModel().getCode());
        }

        SplitPageRequest pageRequest = studentListRequest.getSplitPageRequest();
        UtilsBusiness.pubMapforSplitPage(pageRequest, map);

        int totalSize = studentModelMapper.count(map);
        List<StudentModel> list = studentModelMapper.select(map);

        StudentListResponse response = new StudentListResponse();
        response.setSplitPageResponse(UtilsBusiness.getSplitPageResponse(totalSize, pageRequest.getPageSize(), pageRequest.getPageNo()));
        response.setStudentModelList(list);
        return response;
    }

}
