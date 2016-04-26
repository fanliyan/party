package cn.edu.ccu.utils.common.file;

/**
 * Created by kuangye on 2016/4/13.
 */
public class FileHelper {

    public static String getPicturePath() throws Exception {
        StringBuffer path = new StringBuffer(System.getProperty("catalina.home") == null ? "" : System.getProperty("catalina.home"));
        if (path.length() == 0) {
            path.append(System.getProperty("catalina.base") == null ? "" : System.getProperty("catalina.base"));
        }
        if (path.length() == 0) {
            throw new Exception("+++++++++++system error: server home is not found!+++++++++++");
        } else {
            return path.toString();
        }
    }

}
