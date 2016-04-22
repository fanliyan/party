package cn.edu.ccu.utils.common.properties;


import cn.edu.ccu.utils.common.LogHelper;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by john on 15/8/27.
 */
public class PropertiesHelper {
	static Properties properties = new Properties();

	static {
		try {
			InputStream inputStream = new FileInputStream(System.getProperty("configHome") + "/pub.properties");
			properties.load(inputStream);
			inputStream.close();
		} catch (IOException e) {
			LogHelper.Error("配置文件未找到");
			e.printStackTrace();
		}
	}

	public static String getYiMinBangSecret() {
		return properties.getProperty("yiminbang_secret", "");
	}
	public static String getWeiguanhaiwaiSecret() {
		return properties.getProperty("weiguanhaiwai_secret", "");
	}
	public static String getCheesecanSecret() {
		return properties.getProperty("cheesecan_secret", "");
	}
	public static String getWeixinAppId() {
		return properties.getProperty("wechat_appId", "");
	}

	public static String getWeixinSecret() {
		return properties.getProperty("wechat_secret", "");
	}

	public static String getTestOpenId() {
		return properties.getProperty("wechat_test_openid", "");
	}

	public static String getWeixinTemplateLiveNotification() {
		return properties.getProperty("wechat_template_liveNotification", "");
	}

	/**
	 * 是否是debug，因为配置中的debug被使用，所以这里使用了test
	 * 
	 * @return
	 */
	public static boolean isDebug() {
		return Boolean.parseBoolean(properties.getProperty("test", "false"));
	}

	public static String getKey(){
		return properties.getProperty("key", "");
	}
	public static String getProperty(String key){
		return properties.getProperty(key, "");
	}
}
