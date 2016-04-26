package cn.edu.ccu.model.user;

import cn.edu.ccu.model.SplitPageRequest;
import cn.edu.ccu.model.SplitPageResponse;
import cn.edu.ccu.model.user.UserModel;

import java.util.List;

/**
 * Created by kuangye on 2016/4/12.
 */
public class UserListResponse {

    List<UserModel> userModelList;


    SplitPageResponse splitPageResponse;

    public List<UserModel> getUserModelList() {
        return userModelList;
    }

    public void setUserModelList(List<UserModel> userModelList) {
        this.userModelList = userModelList;
    }

    public SplitPageResponse getSplitPageResponse() {
        return splitPageResponse;
    }

    public void setSplitPageResponse(SplitPageResponse splitPageResponse) {
        this.splitPageResponse = splitPageResponse;
    }
}
