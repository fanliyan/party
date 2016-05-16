package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.NotificationModel;

import java.util.List;

/**
 * Created by kuangye on 2016/5/11.
 */
public interface ISchoolNotification {

    List<NotificationModel> getNotification();

    NotificationModel getByRoleId(Integer roleId);

    boolean updateNotification(NotificationModel notificationModel);
}
