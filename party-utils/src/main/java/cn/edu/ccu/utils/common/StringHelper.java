package cn.edu.ccu.utils.common;

import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringHelper {
	//生成随机数字和字母,  
    public static String getStringRandom(int length) {
          
        String val = "";
        Random random = new Random();
          
        //参数length，表示生成几位随机数  
        for(int i = 0; i < length; i++) {  
              
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
            //输出字母还是数字  
            if( "char".equalsIgnoreCase(charOrNum) ) {  
                //输出是大写字母还是小写字母  
                int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;  
                val += (char)(random.nextInt(26) + temp);  
            } else if( "num".equalsIgnoreCase(charOrNum) ) {  
                val += String.valueOf(random.nextInt(10));
            }  
        }  
        return val;  
    } 
    
    /**
     * @param 被检查字符串
     * @return
     * @Description 检查字符串是否是邮箱 
     */
    public static boolean checkIsEmail(String checkStr){
		String checkRegex = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		return patternCheck(checkStr,checkRegex);
    }
    /**
     * @param str
     * @return
     * @Description 验证指定字符串是否是手机号
     */
    public static boolean checkIsMobilePhone(String checkStr) {
		String checkRegex = "^[1][0-9]{10}$";
		return patternCheck(checkStr,checkRegex);
    }
    /**
     * 
    * @Title: checkIsNum 
    * @Description: 检查是否是数字
    * @param checkStr
    * @return
    * @author yinqiang
    * @throws
     */
    public static boolean checkIsNum(String checkStr) {
		String checkRegex="^\\d+$";
		return patternCheck(checkStr,checkRegex);
	}
    private static boolean patternCheck(String checkStr, String checkRegex) {
		//String checkFormat = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		Pattern regex = Pattern.compile(checkRegex);
		Matcher matcher = regex.matcher(checkStr);
		return matcher.matches();
	}
    /**
     * 返回日期是周几
     * @param date
     * @return
     */
    public static String getWeekDayString(Date date)
    {
	    String weekString = "";
	    final String dayNames[] = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"};
	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(date); 
	    int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
	    weekString = dayNames[dayOfWeek - 1];
	    return weekString;
    }
    
	/**
	 * 判断日期是否为今天
	 * @param date
	 * @return
	 */
    public static String getDateIsToday(Date date) {

		Calendar current = Calendar.getInstance();
		
		Calendar today = Calendar.getInstance();	//今天
		
		today.set(Calendar.YEAR, current.get(Calendar.YEAR));
		today.set(Calendar.MONTH, current.get(Calendar.MONTH));
		today.set(Calendar.DAY_OF_MONTH,current.get(Calendar.DAY_OF_MONTH));
		//  Calendar.HOUR——12小时制的小时数 Calendar.HOUR_OF_DAY——24小时制的小时数
		today.set( Calendar.HOUR_OF_DAY, 0);
		today.set( Calendar.MINUTE, 0);
		today.set(Calendar.SECOND, 0);
		
		Calendar tommorrow = Calendar.getInstance();	//昨天
		
		tommorrow.set(Calendar.YEAR, current.get(Calendar.YEAR));
		tommorrow.set(Calendar.MONTH, current.get(Calendar.MONTH));
		tommorrow.set(Calendar.DAY_OF_MONTH,current.get(Calendar.DAY_OF_MONTH)+1);
		tommorrow.set( Calendar.HOUR_OF_DAY, 0);
		tommorrow.set( Calendar.MINUTE, 0);
		tommorrow.set(Calendar.SECOND, 0);
		
		Calendar afterTommorrow = Calendar.getInstance();	//昨天
		
		afterTommorrow.set(Calendar.YEAR, current.get(Calendar.YEAR));
		afterTommorrow.set(Calendar.MONTH, current.get(Calendar.MONTH));
		afterTommorrow.set(Calendar.DAY_OF_MONTH,current.get(Calendar.DAY_OF_MONTH)+2);
		afterTommorrow.set( Calendar.HOUR_OF_DAY, 0);
		afterTommorrow.set( Calendar.MINUTE, 0);
		afterTommorrow.set(Calendar.SECOND, 0);
		
		current.setTime(date);
		
		if(current.after(tommorrow)&& current.before(afterTommorrow)){
			return "明天";
		}else if(current.before(tommorrow) && current.after(today)){
			return "今天";
		}else{
			return "";
		}
	}
    
	/**
	 * 获取sub 在str中出现的次数
	 * @param str
	 * @param sub
	 * @return
	 */
    public static int getCount(String str, String sub)
    {  
        int index = 0;  
        int count = 0;  
        while((index = str.indexOf(sub,index))!=-1)  
        {  
      
            index = index + sub.length();  
            count++;  
        }  
        return count;  
    } 
    
    public static boolean isEmptyString(Object obj){
    	boolean isEmpty = false;
    	if(obj == null || obj.toString().length() == 0){
    		isEmpty = true;
    	}
    	return isEmpty;
    }
    /**
     * 
    * @Title: removeParams 
    * @Description: 删除url中的指定参数
    * @param @param url
    * @param @param params
    * @param @return    
    * @return String
    * @author wt
    * @date Dec 2, 2015 3:32:36 PM
    * @throws
     */
    public static String removeParams(String url, String[] params) {
        String reg = null;
        for (int i = 0; i < params.length; i++) {
            reg = "(?<=[\\?&])" + params[i] + "=[^&]*&?";
            url = url.replaceAll(reg, "");
        }
        url = url.replaceAll("&+$", "");
        return url;
    }
}
