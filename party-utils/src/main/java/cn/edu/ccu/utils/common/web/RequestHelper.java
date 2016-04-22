package cn.edu.ccu.utils.common.web;

import cn.edu.ccu.utils.common.LogHelper;
import org.apache.commons.io.IOUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class RequestHelper {
	/**
     * 向指定URL发送GET方法的请求
     * 
     * @param url
     *            发送请求的URL
     * @param param
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return URL 所代表远程资源的响应结果
     */
    public static String sendGet(String url, String param) {
        String result = "";
        BufferedReader in = null;
        try {
            String urlNameString =param==null? url:url + "?" + param;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 向指定 URL 发送POST方法的请求
     * 
     * @param url
     *            发送请求的 URL
     * @param param
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return 所代表远程资源的响应结果
     */
    public static String sendPost(String url, String param) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            out.print(param);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！"+e);
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
        }
        return result;
    }
    
    
    /**
     * 向指定URL发送GET方法的请求获取音频
     * 
     * @param url
     *            发送请求的URL
     * @param param
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return URL 所代表远程资源的响应结果
     */
	@Deprecated
    public static String sendGetAudio(String url, String param) {
        BufferedReader in = null;
        FileOutputStream fos = null;
        String path = "";
        try {
            String urlNameString =param==null? url:url + "?" + param;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
           // Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
/*            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }*/
            File file = new File("/opt/audio/");
            file.mkdirs();
            //流转换为文件输出到指定目录
            String audioName = UUID.randomUUID().toString();
            path = "/opt/audio/"+audioName+".amr";
            InputStream is = connection.getInputStream();
            fos = new FileOutputStream(path);
            byte buffer[]=new byte[4*1024];
            int length = 0;
            while(((length=is.read(buffer)))!=-1){
            	fos.write(buffer,0,length);
            }
        } catch (Exception e) {
            System.out.println("发送GET请求获取音频出现异常！" + e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
                if (fos != null) {
                	fos.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return path;
    }
    
    /**
     * 获取微信音频
     * @param url 发送请求的URL
     * @return URL 音频在服务器存储地址
     */
	public static String sendGetAudio(String url) {
		LogHelper.info("===============>从微信获取音频文件 start <=============== \n 取音频文件url=："+url);
        // 创建GET请求
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url);
        String path = "";
        try {
            HttpResponse response = httpClient.execute(httpGet);
            StatusLine statusLine = response.getStatusLine();
            int statusCode = statusLine.getStatusCode();// 响应码
            String reasonPhrase = statusLine.getReasonPhrase();// 响应信息
            if (statusCode == 200) {// 请求成功
                File file = new File("/opt/audio/");
                file.mkdirs();
                //流转换为文件输出到指定目录
                String audioName = UUID.randomUUID().toString();
                path = "/opt/audio/"+audioName+".amr";   

                // 获取响应MineType
            	HttpEntity entity = response.getEntity();
            	Header header = entity.getContentType();            	
            	LogHelper.info("======从微信获取音频文件返回信息类型 ======"+header);
            	//System.out.println("======>>>>>>从微信获取音频文件返回信息类型 ======>>>>>>"+header);
            	//如果不是音频类型，则说明
            	if(!"audio/amr".equals(header.getValue())){
            		//1：重新设置缓存
            		path =  null;
            	}else{
                    // 写入文件
                    InputStream is = entity.getContent();
                    FileOutputStream fos = new FileOutputStream(path);
                    IOUtils.copy(is, fos);
                    fos.flush();
            	}
            } else {
            	LogHelper.Error("GET：code[" + statusCode + "],desc[" + reasonPhrase + "]");
            }
        }catch (Exception e){
        	LogHelper.Error("======从微信获取音频文件出错：message=:"+e.getMessage());
        	//e.printStackTrace();
        } finally {
            // 释放资源
            httpGet.releaseConnection();
            try {
                httpClient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        LogHelper.info("===============>从微信获取音频文件 end <===============");
        return path;
    }
    
	public static void main(String args[]){
		//String url="http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=4JbhVqR1K6b8sBNIDot_wdSZiucoXAZhdhRclBEx2azGkqBywtclPbXkKujFkjb_XuI6R81GU738QXAYlNx6Zf8tsEEd0D3MNBRHGY2ZGlwJMPdAGARUX&media_id=H5fuXVzst7W3wfQnWzVL4kLSfQDrO3mh_eutC2QxgFP4Ny_nfWPX3b7-Uj9MLF91";
		String url ="http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=fcSWiKp_EFBbby9A7IabRsc1AfqsXERoCBaCGLkR1YazbkBIXvC7RZ4K85jgHD_aVgdojXZBFvSyZlhkHgJyHKSfyIIJvFHJsN0LirRB6kgLFJgAAAVPT&media_id=H5fuXVzst7W3wfQnWzVL4kLSfQDrO3mh_eutC2QxgFP4Ny_nfWPX3b7-Uj9MLF91";
		String path =sendGetAudio(url);
		System.out.println(path);
	}
	
	
}
