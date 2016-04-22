package cn.edu.ccu.model.student;

/**
 * Created by Administrator on 2016/4/11.
 */
public class StudentLoginRequest {

    private String account;

    private String password;

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
