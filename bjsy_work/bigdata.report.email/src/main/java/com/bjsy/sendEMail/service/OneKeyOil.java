package com.bjsy.sendEMail.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.bjsy.sendEMail.util.FileUtil;
import com.bjsy.sendEMail.util.PrestoUtil;
import com.bjsy.sendEMail.util.SendUtil;


@Component
public class OneKeyOil {
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	private String dt = sdf.format(new Date(System.currentTimeMillis() - 60 * 60 * 1000 * 24));
	private String errorinfo = "";

	public String getErrorinfo() {
		return errorinfo;
	}

	public void setDt(String dt) {
		this.dt = dt;
	}

	private static String toUser;
	
	private static String testUser;

	private static String ccUser;

	private static String path;

	private static String url;

	// hive地址
	@Value("${presto.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${onekeyOil.toUser}")
	public void setToUser(String toUser) {
		OneKeyOil.toUser = toUser;
	}
	
	// 收送人
	@Value("${onekeyOil.testUser}")
	public void setTestUser(String testUser) {
		OneKeyOil.testUser = testUser;
	}

	// 抄送人
	@Value("${onekeyOil.ccUser}")
	public void setCcUser(String ccUser) {
		OneKeyOil.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${onekeyOil.path}")
	public void setPath(String path) {
		OneKeyOil.path = path;
	}

	static List<String> classList = new ArrayList<String>();
	static Map<String, String> classTabinfo = new HashMap<String, String>();
	static Map<String, String> classSumTabinfo = new HashMap<String, String>();

	static {
		classList.add("qyname^区域");
		classList.add("oilfirst^首次使用一键加油人数");
		classList.add("oilall^使用一键加油人数");
		classList.add("sumvolume^当日销量(吨)");
		classTabinfo.put("tabName", "newhive.temp.region_classification");
		classTabinfo.put("sheetName", "区域");	
		classSumTabinfo.put("tabName", "newhive.temp.region_classification_Summary");
		classSumTabinfo.put("sheetName", "汇总");			
	}
	
	static List<String> stationList = new ArrayList<String>();
	static Map<String, String> stationTabinfo = new HashMap<String, String>();

	static {
		stationList.add("stncode^站号");
		stationList.add("stnname^加油站");
		stationList.add("oilfirst^首次使用一键加油人数");
		stationList.add("oilall^使用一键加油人数");
		stationList.add("sumvolume^当日销量(吨)");
		stationTabinfo.put("tabName", "newhive.temp.Station_classification");
		stationTabinfo.put("sheetName", "加油站");		
	}

	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
		pu.setUrl(url);
		pu.setDt(dt);
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(classTabinfo.get("sheetName"));
		sheet = pu.executeSqlToExcel(classTabinfo.get("tabName"), sheet, classList,null);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【一键加油日报】" + classTabinfo.get("sheetName") + "sheet页异常,";
		}
		HSSFSheet sheet1 = workbook.createSheet(stationTabinfo.get("sheetName"));
		sheet1 = pu.executeSqlToExcel(stationTabinfo.get("tabName"), sheet1, stationList,null);
		if (sheet1 == null || sheet1.getLastRowNum() < 1) {
			errorinfo += "【一键加油日报】" + stationTabinfo.get("sheetName") + "sheet页异常,";
		}		
		HSSFSheet sheet2 = workbook.createSheet(classSumTabinfo.get("sheetName"));
		sheet2 = pu.executeSqlToExcel(classSumTabinfo.get("tabName"), sheet2, classList,null);
		if (sheet2 == null || sheet2.getLastRowNum() < 1) {
			errorinfo += "【一键加油日报】" + classSumTabinfo.get("sheetName") + "sheet页异常,";
		}
		
		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/一键加油日报--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/一键加油日报--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "北京石油一键加油日报-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/一键加油日报--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
				subject = "【异常报警】----北京石油一键加油日报-";
		}
		SendUtil su = new SendUtil();
		String error = "";
		if (!"".equals(msg)) {
			String[] msgs = msg.replace(",", " ").split(" ");
			for (String str : msgs) {
				error += "<h5>" + str + "</h5>";
			}
		}
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + error + "</body>" + "</html>";
		if (subject == null) {
			subject = "北京石油一键加油日报-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
