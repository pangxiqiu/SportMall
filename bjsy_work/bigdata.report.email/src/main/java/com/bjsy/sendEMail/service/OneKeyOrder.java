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
public class OneKeyOrder {
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
//	@Value("${hive.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${onekeyOrder.toUser}")
	public void setToUser(String toUser) {
		OneKeyOrder.toUser = toUser;
	}
	
	// 收送人
	@Value("${onekeyOrder.testUser}")
	public void setTestUser(String testUser) {
		OneKeyOrder.testUser = testUser;
	}

	// 抄送人
	@Value("${onekeyOrder.ccUser}")
	public void setCcUser(String ccUser) {
		OneKeyOrder.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${onekeyOrder.path}")
	public void setPath(String path) {
		OneKeyOrder.path = path;
	}

	static List<String> list = new ArrayList<String>();
	static Map<String, String> tabinfo = new HashMap<String, String>();

	static {
		list.add("xuhao^序号");
		list.add("area^区域");
		list.add("stationcode^站编码");
		list.add("stationname^站名称");
		list.add("price^订单价格");
		list.add("orders^订单数");
		tabinfo.put("fromSql", "from hivelocal.ads_ygjt.rpt_yjdc_xiaoshoue_to_phj where dayid1='$date'");
	}

	

	
	
	

	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
//		HiveUtil pu = new HiveUtil();
		pu.setUrl(url);
		pu.setDt(dt);
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(dt);
		sheet = pu.executeSqlToExcel(tabinfo.get("fromSql"), sheet, list);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【一键到车订单】" + dt + "sheet页异常,";
		}
		
		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/一键到车订单--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/一键到车订单--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "北京石油一键到车日报-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/一键到车订单--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
				subject = "【异常报警】----北京石油一键到车订单-";
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
			subject = "北京石油一键到车订单-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
