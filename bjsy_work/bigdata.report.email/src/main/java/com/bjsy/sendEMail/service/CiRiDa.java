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
import com.bjsy.sendEMail.util.HiveUtil;
import com.bjsy.sendEMail.util.PrestoUtil;
import com.bjsy.sendEMail.util.SendUtil;

/**
 *次日达
 */
@Component
public class CiRiDa {

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
	
	@Value("${cirida.testUser}")
	public  void setTestUser(String testUser) {
		this.testUser = testUser;
	}
	// presto地址
	@Value("${presto.url}")
	public void setUrl(String url) {
		this.url = url;
	};

	// 收送人
	@Value("${cirida.toUser}")
	public void setToUser(String toUser) {
		CiRiDa.toUser = toUser;
	}

	// 抄送人
	@Value("${cirida.ccUser}")
	public void setCcUser(String ccUser) {
		CiRiDa.ccUser = ccUser;
	}

	// 附件保存路径
	@Value("${cirida.path}")
	public void setPath(String path) {
		CiRiDa.path = path;
	}

	static List<String> ciridalist = new ArrayList<String>();
	static Map<String, String> ciridainfo = new HashMap<String, String>();

	static {
		ciridalist.add("dt^日期");
		ciridalist.add("money^销售额");
		ciridalist.add("num^订单数量");
		ciridalist.add("paynum^总下单人数");
		ciridalist.add("countfirst^首单人数");
		ciridalist.add("chengben^销售成本");
		ciridalist.add("shitui^实付销售额");
		ciridainfo.put("tabName", "hivelocal.ads_yjjy.daily_cirida");
		ciridainfo.put("sheetName", "次日达汇总表");
	}
	
	static List<String> mingxilist = new ArrayList<String>();
	static Map<String, String> mingxiinfo = new HashMap<String, String>();


	static {
		mingxilist.add("dt^日期");
		mingxilist.add("goods_id^SPUID");
		mingxilist.add("goods_name^SPU名称");
		mingxilist.add("price^销售额");
		mingxilist.add("number^销售数量");
		mingxilist.add("actual_price^实付金额");
		mingxilist.add("discount_price^总优惠金额");
		mingxilist.add("use_coin^易捷币抵扣");
		mingxilist.add("goods_voucher^商品抵用券");
		mingxilist.add("coupon^优惠券抵用");
		mingxilist.add("chengben^销售成本");
		mingxilist.add("kuisun^亏损");
		mingxiinfo.put("tabName", "hivelocal.ads_yjjy.daily_cirida_mingxi");
		mingxiinfo.put("sheetName", "次日达详细明细");
	}

	// 保存附件
	public String saveReport() throws Exception {
		errorinfo = "";
		PrestoUtil pu = new PrestoUtil();
		pu.setUrl(url);
		pu.setDt(dt);
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(ciridainfo.get("sheetName"));
		sheet = pu.executeSqlToExcel(ciridainfo.get("tabName"), sheet, ciridalist, null);
		if (sheet == null || sheet.getLastRowNum() < 1) {
			errorinfo += "【次日达】" + ciridainfo.get("sheetName") + "sheet异常,";
		}
		HSSFSheet sheet1 = workbook.createSheet(mingxiinfo.get("sheetName"));
		sheet1 = pu.executeSqlToExcel(mingxiinfo.get("tabName"), sheet1, mingxilist, null);
/*		if (sheet1 == null || sheet1.getLastRowNum() < 1) {
			errorinfo += "【次日达】" + mingxiinfo.get("sheetName") + "sheet异常,";
		}*/
		if (!"".equals(errorinfo)) {
			errorinfo = errorinfo.substring(0, errorinfo.length() - 1);
		}
		String filepath = path + "/" + dt + "/次日达--" + dt + ".xls";
		FileUtil.saveExcel(workbook, filepath);
		return filepath;
	}

	// 发送正式邮件
	public void sendReport(String filepath, String subject) throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/次日达--" + dt + ".xls";
		}
		SendUtil su = new SendUtil();
		String message = "<!DOCTYPE html>\n" + "<html>\n" + "  <head>\n" + "    <meta charset=\"utf-8\" />\n"
				+ "    <meta http-equiv=\"x-ua-compatible\" content=\"ie=edge,chrome=1\" />\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width\" />\n" + "    <title>北京石油大数据管理平台</title>\n"
				+ "  </head>\n" + "  <body>\n" + "<h2>内部资料，请注意保存!</h2>" + "</body>" + "</html>";
		if (subject == null) {
			subject = "北京石油次日达日报-";
		}
		subject += dt;
		su.sendEmail(filepath, message, toUser, ccUser, subject);
	}

	// 发送内部邮件
	public void sendInsideReport(String filepath, String subject, String msg)
			throws Exception {
		if (filepath == null || "".equals(filepath)) {
			filepath = path + "/" + dt + "/次日达--" + dt + ".xls";
		}
		if (msg == null || "".equals(msg)) {
			msg = errorinfo;
		}
		if (!"".equals(msg)) {
				subject = "【异常报警】----北京石油次日达日报-";
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
			subject = "北京石油次日达日报-";
		}
		subject += dt;
		su.sendEmail(filepath, message, testUser, null, subject);
	}

}
