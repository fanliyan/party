package cn.edu.ccu.index.utils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Message {

	public static void showError(HttpServletRequest request, HttpServletResponse response,String errorMessage){
		showError(request, response, errorMessage,false);      
	}
	
	public static void showError(HttpServletRequest request, HttpServletResponse response, String errorMessage, boolean showBackButton){
		request.setAttribute("message",errorMessage);
		request.setAttribute("showBackButton", showBackButton);
    	try {
			request.getRequestDispatcher("/error/show").forward(request,response);
		} catch (ServletException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}      
	}
}
