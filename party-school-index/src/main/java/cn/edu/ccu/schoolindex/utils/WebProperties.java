package cn.edu.ccu.schoolindex.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class WebProperties {
    static private Boolean isDebug = false;
    static private String securityKey = null;
    static private String domain = null;
    static private String cookieDomain = null;
    static private Boolean smsStatus = null;

    static {
        loads();
    }

    synchronized static private void loads() {

        InputStream is = WebProperties.class.getResourceAsStream("/resources/config/web.properties");
        try {

            Properties webProperties = new Properties();
            webProperties.load(is);

            isDebug = Boolean.parseBoolean(webProperties.getProperty("debug").toString());

            securityKey = webProperties.getProperty("securityKey").toString();

            domain = webProperties.getProperty("domain").toString();

            cookieDomain = webProperties.getProperty("cookieDomain").toString();

            smsStatus = Boolean.parseBoolean(webProperties.getProperty("smsStatus").toString());
        } catch (Exception e) {
            System.err.println("不能读取属性文件. " + "请确保web.properties在指定的路径中");
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
            }
        }
    }

    public static Boolean getIsDebug() {
        if (isDebug == null) {
            loads();
        }
        return isDebug;
    }

    public static String getSecurityKey() {
        if (securityKey == null) {
            loads();
        }
        return securityKey;
    }

    public static String getDomain() {
        if (domain == null) {
            loads();
        }
        return domain;
    }

    public static String getCookieDomain() {
        if (cookieDomain == null) {
            loads();
        }
        return cookieDomain;
    }

    public static Boolean getSmsStatus() {
        if (smsStatus == null) {
            loads();
        }
        return smsStatus;
    }
}
