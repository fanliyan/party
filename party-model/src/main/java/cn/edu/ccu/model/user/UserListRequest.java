package cn.edu.ccu.model.user;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.user.UserModel;

/**
 * Created by kuangye on 2016/4/12.
 */
public class UserListRequest {

    UserModel userModel;


    SplitPageRequest splitPageRequest;

    public UserModel getUserModel() {
        return userModel;
    }

    public void setUserModel(UserModel userModel) {
        this.userModel = userModel;
    }

    public SplitPageRequest getSplitPageRequest() {
        return splitPageRequest;
    }

    public void setSplitPageRequest(SplitPageRequest splitPageRequest) {
        this.splitPageRequest = splitPageRequest;
    }
}
