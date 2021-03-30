package com.bjsy.sendEMail.service;

import com.bjsy.sendEMail.util.FileUtil;
import com.bjsy.sendEMail.util.PrestoUtil;
import com.bjsy.sendEMail.util.SendUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 *柴油营销站客户加油笔数及单笔加油量
 */
@Component
public class DieselMail {
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

	//内部邮件收件人	
	private static String testUser;

	private static String ccUser;

	private static String path;

	private static String url;

	@Value("${diesel.testUser}")
	public  void setTestUser(String testUser) {
		this.testUser = testUser;
	}
	// presto地址
	@Value("${presto.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${diesel.toUser}")
	public void setToUser(String toUser) {
		DieselMail.toUser = toUser;
	}

	// 抄送人
	@Value("${diesel.ccUser}")
	public void setCcUser(String ccUser) {
		DieselMail.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${diesel.path}")
	public void setPath(String path) {
		DieselMail.path = path;
	}

	static List<String> picclist = new ArrayList<String>();
	static Map<String, String> piccinfo = new HashMap<String, String>();

	/**
	 * 日期	站码	当日柴油销量	当日柴油笔数	当日单笔均销量
	 *
	 * select
	 * opedate
	 * ,stncode
	 * ,ererydayystotalD
	 * ,ererydaygasnum
	 * ,everydaygasD
	 * from hivelocal.ads_daily.diesel_oil
	 */

	static {
		picclist.add("opedate^日期");
		picclist.add("stncode^站码");
		picclist.add("ererydayystotald^当日柴油销量");
		picclist.add("ererydaygasnum^当日柴油笔数");
		picclist.add("everydaygasd^当日单笔均销量");
		piccinfo.put("tabName", "hivelocal.ads_daily.diesel_oil");
		piccinfo.put("sheetName", "柴油营销站客户加油笔数及单笔加油量");
	}


	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
		pu.setUrl(url);
		pu.setDt("0");
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(piccinfo.get("sheetName"));
		sheet = pu.executeSqlToExcel(piccinfo.get("tabName"), sheet, picclist,null);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【柴油营销站客户加油笔数及单笔加油量】" + piccinfo.get("sheetName") + "sheet异常,";
		}

		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/柴油营销站客户加油笔数及单笔加油量--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/柴油营销站客户加油笔数及单笔加油量--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "柴油营销站客户加油笔数及单笔加油量-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/柴油营销站客户加油笔数及单笔加油量--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
			if (subject != null) {
				subject = "【异常报警】----柴油营销站客户加油笔数及单笔加油量-";
			} else {
				subject = "【异常报警】----柴油营销站客户加油笔数及单笔加油量模板-";
			}
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
			subject = "柴油营销站客户加油笔数及单笔加油量模板-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
