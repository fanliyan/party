package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.NotificationModelMapper;
import cn.edu.ccu.ibusiness.common.ISchoolNotification;
import cn.edu.ccu.model.common.NotificationModel;
import cn.edu.ccu.model.common.NotificationModelWithBLOBs;
import cn.edu.ccu.model.exception.BusinessException;
import cn.edu.ccu.utils.common.ErrorCodeEnum;
import cn.edu.ccu.utils.common.extention.IntegerExtention;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kuangye on 2016/5/11.
 */
@Service
public class SchoolNotificationBusiness implements ISchoolNotification {

    @Autowired
    private NotificationModelMapper notificationModelMapper;


    public List<NotificationModelWithBLOBs> getNotificationByDepartment(Integer id) {

        List<NotificationModelWithBLOBs> notificationModelList = notificationModelMapper.select(id);

        return notificationModelList;
    }

    public NotificationModelWithBLOBs getByRoleAndDepartment(Integer roleId, Integer departmentId) {

        if (IntegerExtention.hasValueAndMaxZero(roleId)
                && IntegerExtention.hasValueAndMaxZero(departmentId)) {
            return notificationModelMapper.getByRoleAndDepartment(roleId, departmentId);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public boolean updateNotification(NotificationModelWithBLOBs notificationModel) {

        if (notificationModel != null
                && IntegerExtention.hasValueAndMaxZero(notificationModel.getRoleId())
                && IntegerExtention.hasValueAndMaxZero(notificationModel.getDepartmentId())) {

            NotificationModel model = notificationModelMapper.getByRoleAndDepartment(notificationModel.getRoleId(), notificationModel.getDepartmentId());

            if (model == null) {
                return notificationModelMapper.insertSelective(notificationModel) > 0;
            } else {
                notificationModel.setId(model.getId());
                return notificationModelMapper.updateByPrimaryKeySelective(notificationModel) > 0;

            }
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }
}
