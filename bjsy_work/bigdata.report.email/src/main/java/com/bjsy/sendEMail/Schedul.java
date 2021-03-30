package com.bjsy.sendEMail;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bjsy.sendEMail.service.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class Schedul {

	String dt = "";
	String filepath = "";
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	private static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");

	private final static Logger logger = Logger.getLogger(Schedul.class);
	
	//本月车辆优惠附件路径
	private static String discountpath;

//	@Value("${discount.path}")
	public void setDiscountpath(String discountpath) {
		Schedul.discountpath = discountpath;
	}

	//一键加油（剔除精准召回部分）月末统计保存路径
	private static String discountEndpath;

//	@Value("${discountEnd.path}")
	public void setDiscountEndpath(String discountEndpath) {
		Schedul.discountEndpath = discountEndpath;
	}

	//一键加油销量流量分网点统计路径
	private static String nosenserefuelpath;

//	@Value("${nosenserefuel.path}")
	public void setNosenserefuelpath(String nosenserefuelpath) {
		Schedul.nosenserefuelpath = nosenserefuelpath;
	}

	//日报数据模板路径
	private static String dataTemplatepath;

	@Value("${dataTemplate.path}")
	public void setDataTemplatepath(String dataTemplatepath) {
		Schedul.dataTemplatepath = dataTemplatepath;
	}

	//新平台合并日报路径
	private static String newplatMergepath;

	@Value("${newplatMerge.path}")
	public void setNewplatMergepath(String newplatMergepath) {
		Schedul.newplatMergepath = newplatMergepath;
	}

	//次日达订单路径
	private static String ciridapath;

	@Value("${cirida.path}")
	public void setCiridapath(String ciridapath) {
		Schedul.ciridapath = ciridapath;
	}

	//分开销售明细计路径
	private static String classifySalespath;

	@Value("${classifySales.path}")
	public void setClassifySalespath(String classifySalespath) {
		Schedul.classifySalespath = classifySalespath;
	}

	//商品销售日报
	private static String goodsSalepath;

	@Value("${goodsSale.path}")
	public void setGoodsSalepath(String goodsSalepath) {
		Schedul.goodsSalepath = goodsSalepath;
	}

	//活动销售数据监控
	private static String saledataMonitorpath;

	@Value("${saledataMonitor.path}")
	public void setSaledataMonitorpath(String saledataMonitorpath) {
		Schedul.saledataMonitorpath = saledataMonitorpath;
	}


	//发送内部邮件
	//一键到车日报
	@Scheduled(cron = "${test.onekey}")
	public void SendInsideOneKey() throws Exception {
		OneKeyToCar ok = new OneKeyToCar();
		if (!"".equals(dt)) {
			ok.setDt(dt);
		}
		filepath = ok.saveReport();
		logger.info(filepath);
		ok.sendInsideReport(filepath, null,null);
		ok=null;
	}


}
