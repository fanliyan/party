package cn.edu.ccu.ibusiness.common;

import cn.edu.ccu.model.common.NotificationModelWithBLOBs;

import java.util.List;

/**
 * Created by kuangye on 2016/5/11.
 */
public interface ISchoolNotification {

    List<NotificationModelWithBLOBs> getNotificationByDepartment(Integer id);

    NotificationModelWithBLOBs getByRoleAndDepartment(Integer roleId,Integer departmentId);

    boolean updateNotification(NotificationModelWithBLOBs notificationModel);
}
