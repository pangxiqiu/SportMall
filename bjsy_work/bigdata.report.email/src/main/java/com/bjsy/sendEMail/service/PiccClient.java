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
 *中国人保客户开发情况
 */
@Component
public class PiccClient {
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

	@Value("${picc.testUser}")
	public  void setTestUser(String testUser) {
		this.testUser = testUser;
	}
	// presto地址
	@Value("${presto.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${picc.toUser}")
	public void setToUser(String toUser) {
		PiccClient.toUser = toUser;
	}

	// 抄送人
	@Value("${picc.ccUser}")
	public void setCcUser(String ccUser) {
		PiccClient.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${picc.path}")
	public void setPath(String path) {
		PiccClient.path = path;
	}

	static List<String> picclist = new ArrayList<String>();
	static Map<String, String> piccinfo = new HashMap<String, String>();


	static {
		picclist.add("lab^时间区间");
		picclist.add("coupon_user^实际领券客户数");
		picclist.add("new_user^其中:新增客户数");
		picclist.add("stock_user^存量客户数");
		picclist.add("oil_send_cnt^油品发券数量(张)");
		picclist.add("oil_used_cnt^油品用券数量(张)");
		picclist.add("oil_user_cnt^加油人数");
		picclist.add("oil_total^加油总量（吨）");
		picclist.add("goods_send_cnt^非油品发券数量（张）");
		picclist.add("goods_used_cnt^非油品用券数量（张）");
		picclist.add("goods_user_cnt^消费人数");
		picclist.add("goods_money^消费金额（元）");
		piccinfo.put("tabName", "hivelocal.ads_yjjy.daily_develop_of_renbao");
		piccinfo.put("sheetName", "中国人保客户开发情况日报");
	}


	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
		pu.setUrl(url);
		pu.setDt(dt);
		HSSFWorkbook workbook = new HSSFWorkbook();
		String orderstr="order by lab";
		HSSFSheet sheet = workbook.createSheet(piccinfo.get("sheetName"));
		sheet = pu.executeSqlToExcel(piccinfo.get("tabName"), sheet, picclist,null,orderstr);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【中国人保客户开发情况】" + piccinfo.get("sheetName") + "sheet异常,";
		}

		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/中国人保客户开发情况--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/中国人保客户开发情况--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "中国人保客户开发情况-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/中国人保客户开发情况--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
			if (subject != null) {
				subject = "【异常报警】----中国人保客户开发情况-";
			} else {
				subject = "【异常报警】----中国人保客户数据模板-";
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
			subject = "中国人保客户数据模板-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
