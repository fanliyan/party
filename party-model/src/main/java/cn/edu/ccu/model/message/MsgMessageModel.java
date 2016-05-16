package cn.edu.ccu.model.message;

import java.util.Date;

public class MsgMessageModel {
    private Long messageId;

    private String sendUserid;

    private String receiveUserid;

    private Boolean isRead;

    private Date createTime;
    /**
     * 获取创建时间是周几
     */
    private String weekOfCreateTime;
    
    private Date lastModifyTime;

    private Integer msgType;

    private String title;
    
    private String content;
    //发送人头像
    private String avatarPic;

    public String getAvatarPic() {
		return avatarPic;
	}

	public void setAvatarPic(String avatarPic) {
		this.avatarPic = avatarPic;
	}

	public Long getMessageId() {
        return messageId;
    }

    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    public String getSendUserid() {
        return sendUserid;
    }

    public void setSendUserid(String sendUserid) {
        this.sendUserid = sendUserid == null ? null : sendUserid.trim();
    }

    public String getReceiveUserid() {
        return receiveUserid;
    }

    public void setReceiveUserid(String receiveUserid) {
        this.receiveUserid = receiveUserid == null ? null : receiveUserid.trim();
    }

    public Boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLastModifyTime() {
        return lastModifyTime;
    }

    public void setLastModifyTime(Date lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    public Integer getMsgType() {
        return msgType;
    }

    public void setMsgType(Integer msgType) {
        this.msgType = msgType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWeekOfCreateTime() {
		return weekOfCreateTime;
	}

	public void setWeekOfCreateTime(String weekOfCreateTime) {
		this.weekOfCreateTime = weekOfCreateTime;
	}
}