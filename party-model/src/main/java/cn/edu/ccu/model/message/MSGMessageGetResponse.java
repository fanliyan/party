//
// 此文件是由 JavaTM Architecture for XML Binding (JAXB) 引用实现 v2.2.8-b130911.1802 生成的
// 请访问 <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// 在重新编译源模式时, 对此文件的所有修改都将丢失。
// 生成时间: 2015.06.15 时间 05:09:01 PM CST 
//


package cn.edu.ccu.model.message;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>MSGMessageGetResponse complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="MSGMessageGetResponse">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="message" type="{http://api.yiminbang.com/customer/model/MsgMessageModel}MsgMessageModel" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "MSGMessageGetResponse", propOrder = {
    "message"
})
public class MSGMessageGetResponse {

    protected MsgMessageModel message;

    /**
     * 获取message属性的值。
     * 
     * @return
     *     possible object is
     *     {@link MsgMessageModel }
     *     
     */
    public MsgMessageModel getMessage() {
        return message;
    }

    /**
     * 设置message属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link MsgMessageModel }
     *     
     */
    public void setMessage(MsgMessageModel value) {
        this.message = value;
    }

}
