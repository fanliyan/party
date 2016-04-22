package cn.edu.ccu.utils.common.cache;


import cn.edu.ccu.utils.common.extention.StringExtention;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 静态实例缓冲 读和写均为锁定 只针对String操作
* @ClassName: LocalStaticCache 
* @Description: TODO
*
 */
public class LocalStaticCache {	
	
	private static Map<String, CacheNode> cache;
	private static Object lockObj;
	static{
		cache =new HashMap<String, CacheNode>();
		lockObj=new Object();
	}

	public static void setLocalStaticCache(String key, String value, Date expreDate){
		if(!StringExtention.isNullOrEmpty(key) &&
				!StringExtention.isNullOrEmpty(value) && 
				expreDate != null && 
				Calendar.getInstance().getTime().before(expreDate)){
			synchronized (lockObj) {
				CacheNode cn=new CacheNode();
				cn.setExipreDate(expreDate);
				cn.setValue(value);
				cache.put(key, cn);
			}
		}
	}
	public static String getLocalStaticCache(String key) {
		String result=null;
		if(!StringExtention.isNullOrEmpty(key)){
			CacheNode node= cache.get(key);
			if(node != null){
				if(node.getExipreDate().before(Calendar.getInstance().getTime())){
					synchronized (lockObj) {
						cache.remove(key);
					}
				}
				else {
					result = node.getValue();
				}
			}
		}
		return result;
	}

	private static class CacheNode{
		private String value;
		private Date exipreDate;
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		public Date getExipreDate() {
			return exipreDate;
		}
		public void setExipreDate(Date exipreDate) {
			this.exipreDate = exipreDate;
		}
		
	}
	
}

