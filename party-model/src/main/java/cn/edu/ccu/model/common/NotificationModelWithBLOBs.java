package cn.edu.ccu.model.common;

public class NotificationModelWithBLOBs extends NotificationModel {
    private String content;

    private String extraContent;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getExtraContent() {
        return extraContent;
    }

    public void setExtraContent(String extraContent) {
        this.extraContent = extraContent == null ? null : extraContent.trim();
    }
}