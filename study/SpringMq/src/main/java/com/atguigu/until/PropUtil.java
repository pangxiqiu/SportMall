package com.atguigu.until;

import org.apache.log4j.Logger;

import java.io.*;
import java.util.Properties;

public class PropUtil {
	static Logger log = Logger.getLogger(
			PropUtil.class.getName());

	private static Properties prop = new Properties();

	public static void initial(String configPath) throws Exception{
		try {
			FileInputStream in = new FileInputStream(configPath);
			//log.error("FileInputStream:"+in);

			//InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(configPath);
			//支持utf8 解决中文乱码
			Reader reader = new InputStreamReader(in,"UTF-8");
			initial(reader);
		}catch (FileNotFoundException e){
			InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(configPath);
			//支持utf8 解决中文乱码
			Reader reader = new InputStreamReader(in,"UTF-8");
			initial(reader);
		}
		catch (Exception e){
			log.error("PropUtil初始化失败!",e);
		}
	}

	public static void initial(Reader in) {
	
		try {
			prop.load(in);
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					log.error("PropUtil初始化失败!", e);
				}
			}
		}
	}

	public static Properties getProp() {
		return prop;
	}

	public static String get(String key) {
		return prop.getProperty(key);
	}
}
