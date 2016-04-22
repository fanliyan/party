package cn.edu.ccu.utils.common.properties;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by john on 16/1/5.
 * 获取web.xml中配置的参数和本应用作用域全局变量
 */
public class SystemConfig {
    static Map<String, String> config;

    static {
        config = new HashMap<>();
    }

    public static String getConfig(String key) {
        return config.get(key);
    }

    public static boolean contain(String key) {
        return config.containsKey(key);
    }

    public static void setConfig(String key, String value) {
        config.put(key, value);
    }
}
