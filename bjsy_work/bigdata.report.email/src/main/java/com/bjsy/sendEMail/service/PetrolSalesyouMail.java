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
 *加油站销量及优惠结构
 */
@Component
public class PetrolSalesyouMail {
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

	@Value("${petrolSalesyou.testUser}")
	public  void setTestUser(String testUser) {
		this.testUser = testUser;
	}
	// presto地址
	@Value("${presto.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${petrolSalesyou.toUser}")
	public void setToUser(String toUser) {
		PetrolSalesyouMail.toUser = toUser;
	}

	// 抄送人
	@Value("${petrolSalesyou.ccUser}")
	public void setCcUser(String ccUser) {
		PetrolSalesyouMail.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${petrolSalesyou.path}")
	public void setPath(String path) {
		PetrolSalesyouMail.path = path;
	}

	static List<String> petrolSalesyoulist = new ArrayList<String>();
	static Map<String, String> petrolSalesyouinfo = new HashMap<String, String>();


	static {
		petrolSalesyoulist.add("stncode^油站编码");
		petrolSalesyoulist.add("yyystotald^运营销量");
		petrolSalesyoulist.add("yyyhtotal^运营优惠");
		petrolSalesyoulist.add("plummetsystotald^直降销量");
		petrolSalesyoulist.add("plummetsyhtotal^直降优惠");
		petrolSalesyoulist.add("lostystotald^流失销量)");
		petrolSalesyoulist.add("lostyhtotal^流失优惠");
		petrolSalesyoulist.add("regionalmarketingystotald^区公司销量");
		petrolSalesyoulist.add("regionalmarketingyhtotal^区公司优惠");
		petrolSalesyoulist.add("myyystotald^当月运营销量");
		petrolSalesyoulist.add("myyyhtotal^当月运营优惠");
		petrolSalesyoulist.add("mplummetsystotald^当月直降销量");
		petrolSalesyoulist.add("mplummetsyhtotal^当月直降优惠");
		petrolSalesyoulist.add("mlostystotald^当月流失销量");
		petrolSalesyoulist.add("mlostyhtotal^当月流失优惠");
		petrolSalesyoulist.add("mregionalmarketingystotald^当月区公司销量");
		petrolSalesyoulist.add("mregionalmarketingyhtotal^当月区公司优惠");
		petrolSalesyouinfo.put("tabName", "hivelocal.dws_rcl.gasstation_volansyh_daily");
		petrolSalesyouinfo.put("sheetName", "加油站销量及优惠结构");
	}



	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
		pu.setUrl(url);
		pu.setDt(dt);
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(petrolSalesyouinfo.get("sheetName"));
		sheet = pu.executeSqlToExcel(petrolSalesyouinfo.get("tabName"), sheet, petrolSalesyoulist,null);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【加油站销量及优惠结构】" + petrolSalesyouinfo.get("sheetName") + "sheet异常,";
		}

		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/加油站销量及优惠结构--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/加油站销量及优惠结构--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "加油站销量及优惠结构-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/加油站销量及优惠结构--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
			if (subject != null) {
				subject = "【异常报警】----加油站销量及优惠结构-";
			} else {
				subject = "【异常报警】----加油站销量及优惠结构模板-";
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
			subject = "加油站销量及优惠结构模板-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
