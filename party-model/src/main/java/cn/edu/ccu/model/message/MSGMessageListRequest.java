//
// 此文件是由 JavaTM Architecture for XML Binding (JAXB) 引用实现 v2.2.8-b130911.1802 生成的
// 请访问 <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// 在重新编译源模式时, 对此文件的所有修改都将丢失。
// 生成时间: 2015.06.15 时间 06:15:46 PM CST 
//


package cn.edu.ccu.model.message;


import cn.edu.ccu.model.SplitPageRequest;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * 站内消息列表获取URL:/message/msglist
 * 
 * <p>MSGMessageListRequest complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="MSGMessageListRequest">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="splitPage" type="{http://api.yiminbang.com/model}SplitPageResponse" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "MSGMessageListRequest", namespace = "", propOrder = {
    "splitPage"
})
public class MSGMessageListRequest {
	private MsgMessageModel messageModel;
    protected SplitPageRequest splitPage;

    /**
     * 获取splitPage属性的值。
     * 
     * @return
     *     possible object is
     *     {@link SplitPageRequest }
     *     
     */
    public SplitPageRequest getSplitPage() {
        return splitPage;
    }

    /**
     * 设置splitPage属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link SplitPageRequest }
     *     
     */
    public void setSplitPage(SplitPageRequest value) {
        this.splitPage = value;
    }

	public MsgMessageModel getMessageModel() {
		return messageModel;
	}

	public void setMessageModel(MsgMessageModel messageModel) {
		this.messageModel = messageModel;
	}

}
