//
// 此文件是由 JavaTM Architecture for XML Binding (JAXB) 引用实现 v2.2.8-b130911.1802 生成的
// 请访问 <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// 在重新编译源模式时, 对此文件的所有修改都将丢失。
// 生成时间: 2015.06.15 时间 06:15:46 PM CST 
//


package cn.edu.ccu.model.message;


import cn.edu.ccu.model.SplitPageResponse;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>MSGMessageListResponse complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="MSGMessageListResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="splitPage" type="{http://api.yiminbang.com/model}SplitPageResponse" minOccurs="0"/>
 *         &lt;element name="messages" type="{http://api.yiminbang.com/customer/model/MsgMessageModel}MsgMessageModel" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "MSGMessageListResponse", namespace = "", propOrder = {
    "splitPage",
    "messages"
})
public class MSGMessageListResponse {

    protected SplitPageResponse splitPage;
    protected List<MsgMessageModel> messages;

    /**
     * 获取splitPage属性的值。
     * 
     * @return
     *     possible object is
     *     {@link SplitPageResponse }
     *     
     */
    public SplitPageResponse getSplitPage() {
        return splitPage;
    }

    /**
     * 设置splitPage属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link SplitPageResponse }
     *     
     */
    public void setSplitPage(SplitPageResponse value) {
        this.splitPage = value;
    }

    /**
     * Gets the value of the messages property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the messages property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getMessages().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link MsgMessageModel }
     * 
     * 
     */
    public List<MsgMessageModel> getMessages() {
        if (messages == null) {
            messages = new ArrayList<MsgMessageModel>();
        }
        return this.messages;
    }
    
    public void setMessages(List<MsgMessageModel> value){
    	this.messages =value;
    }

}
