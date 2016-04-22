package cn.edu.ccu.utils.common.properties;


import cn.edu.ccu.utils.common.LogHelper;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by john on 16/1/5.
 * 优先私有属性,其次公有属性,即私有属性可以覆盖共有属性
 */
public class PropertiesGetter {

    static Properties publicProperties = new Properties();

    static Properties privateProperties = new Properties();

    static {
        InputStream inputStream = null;
        InputStream is = null;

        try {
            inputStream = new FileInputStream(System.getProperty("configHome") + "/pub.properties");
            publicProperties.load(inputStream);
        } catch (IOException ex) {
            LogHelper.Error("不能读取属性文件,请确保db.properties在CLASSPATH指定的路径中", ex);
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        try {
            //appName在com.yiminbang.oversea.utils.ResourceListener.contextDestroyed()设置
            is = new FileInputStream(System.getProperty("configHome") + "/" + SystemConfig.getConfig("appName") + "/web.properties");
            privateProperties.load(is);
        } catch (IOException ex) {
            LogHelper.Error("不能读取属性文件,请确保web.properties在CLASSPATH指定的路径中", ex);
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static String getStringProperty(PropertiesNameEnum propertyNameEnum) {
        String propertyName = propertyNameEnum.toString();
        String result = null;
        if (propertyName != null && propertyName.length() > 0) {
            if (privateProperties.containsKey(propertyName)) {
                result = privateProperties.getProperty(propertyName);
            } else if (publicProperties.containsKey(propertyName)) {
                result = publicProperties.getProperty(propertyName);
            }
        }
        return result;
    }

    public static Boolean getBooleanProperty(PropertiesNameEnum propertyNameEnum) {
        return Boolean.parseBoolean(getStringProperty(propertyNameEnum));
    }

    public static Integer getIntegerProperty(PropertiesNameEnum propertyNameEnum) {
        return Integer.parseInt(getStringProperty(propertyNameEnum));
    }
}
