package cn.edu.ccu.utils.common.web; /**
* @Title: MultiReadHttpServletRequest.java 
* @Package com.yiminbang.utils.web 
* @Description: TODO(用一句话描述该文件做什么) 
* @author A18ccms A18ccms_gmail_com   
* @date 2015年4月28日 下午10:46:26 
* @version V1.0   
*//*
package com.yiminbang.utils.web;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;



*//** 
 * @ClassName: MultiReadHttpServletRequest 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author A18ccms a18ccms_gmail_com 
 * @date 2015年4月28日 下午10:46:26 
 *  
 *//*
public class MultiReadHttpServletRequest extends HttpServletRequestWrapper {
	  private ByteArrayOutputStream cachedBytes;

	  public MultiReadHttpServletRequest(HttpServletRequest request) {
	    super(request);
	  }

	  @Override
	  public ServletInputStream getInputStream() throws IOException {
	    if (cachedBytes == null)
	      cacheInputStream();

	      return new CachedServletInputStream();
	  }

	  @Override
	  public BufferedReader getReader() throws IOException{
	    return new BufferedReader(new InputStreamReader(getInputStream()));
	  }

	  private void cacheInputStream() throws IOException {
	     Cache the inputstream in order to read it multiple times. For
	     * convenience, I use apache.commons IOUtils
	     
	    cachedBytes = new ByteArrayOutputStream();
	    IOUtils.copy(super.getInputStream(), cachedBytes);
	  }

	   An inputstream which reads the cached request body 
	  public class CachedServletInputStream extends ServletInputStream {
	    private ByteArrayInputStream input;

	    public CachedServletInputStream() {
	       create a new input stream from the cached request body 
	      input = new ByteArrayInputStream(cachedBytes.toByteArray());
	    }

	    @Override
	    public int read() throws IOException {
	      return input.read();
	    }

		 （非 Javadoc）
		 * @see javax.servlet.ServletInputStream#isFinished()
		 
		@Override
		public boolean isFinished() {
			// TODO 自动生成的方法存根
			return false;
		}

		 （非 Javadoc）
		 * @see javax.servlet.ServletInputStream#isReady()
		 
		@Override
		public boolean isReady() {
			// TODO 自动生成的方法存根
			return false;
		}

		 （非 Javadoc）
		 * @see javax.servlet.ServletInputStream#setReadListener(javax.servlet.ReadListener)
		 
		@Override
		public void setReadListener(ReadListener arg0) {
			// TODO 自动生成的方法存根
			
		}
	  }
	}
*/