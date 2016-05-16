package cn.edu.ccu.business.common;

import cn.edu.ccu.data.common.NotificationModelMapper;
import cn.edu.ccu.ibusiness.common.ISchoolNotification;
import cn.edu.ccu.model.common.NotificationModel;
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


    public List<NotificationModel> getNotification() {

        List<NotificationModel> notificationModelList = notificationModelMapper.select();

        return notificationModelList;
    }

    public NotificationModel getByRoleId(Integer roleId) {

        if (IntegerExtention.hasValueAndMaxZero(roleId)) {
            return notificationModelMapper.getByRoleId(roleId);
        }
        throw new BusinessException(ErrorCodeEnum.requestParamError);
    }


    public boolean updateNotification(NotificationModel notificationModel) {

        if (notificationModel != null && IntegerExtention.hasValueAndMaxZero(notificationModel.getRoleId())) {

            NotificationModel model = notificationModelMapper.getByRoleId(notificationModel.getRoleId());

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
