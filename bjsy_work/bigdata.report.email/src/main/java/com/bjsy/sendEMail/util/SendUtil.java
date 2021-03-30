package com.bjsy.sendEMail.util;

import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import microsoft.exchange.webservices.data.core.enumeration.misc.ExchangeVersion;

/**
 * 项目名称：com.bjsy.bigdata.report.mail<br>
 * *********************************<br>
 * <P>类名称：SendUtil</P>
 * *********************************<br>
 * <P>类描述：发送邮件的工具类</P>
 * 创建人：ck<br>
 * 创建时间：2019年6月20日 下午11:21:18<br>
 * 修改人：ck<br>
 * 修改时间：2019年6月20日 下午11:21:18<br>
 * 修改备注：<br>
 * @version 1.0<br>    
 */
@Component
public class SendUtil {

	private final static Logger logger = Logger.getLogger(SendUtil.class);
	
	private static String mailhost;

	@Value("${mail.host}")
   public void setMailhost(String mailhost){
		SendUtil.mailhost = mailhost;
	}

	//邮箱用户
	private static String mailuser;

	//邮箱密码
	private static String mailpassword;
	
	//发送异常时邮件收件人
	private static String warningUser;
	
	@Value("${mail.username}")
	public void setMailuser(String mailuser){
		SendUtil.mailuser=mailuser;
	}
	
	@Value("${mail.password}")
	public void setMailpasssword(String mailpassword){
		SendUtil.mailpassword=mailpassword;
	}	
	@Value("${mail.warningUser}")
	public void setWarningUser(String warningUser){
		SendUtil.warningUser=warningUser;
	}
	
	//发送邮件
	public static void sendEmail(String path, String message, String toUser, String ccUser, String subject) throws Exception {
		boolean flag = false;
		ExchangeClient client = null;
		logger.info(path+","+mailhost+","+mailuser+","+mailpassword+","+warningUser);
		String[] paths=path.split(",");
		List<String> pathlist=Arrays.asList(paths);
	for(int i=0;i<pathlist.size();i++){
	    logger.info(pathlist.get(i));
	}
		if (ccUser == null || ccUser == "") {
			client = new ExchangeClient.ExchangeClientBuilder().hostname(mailhost)
					.exchangeVersion(ExchangeVersion.Exchange2010).username(mailuser).password(mailpassword).attachments(pathlist)
					.recipientTo(toUser).subject(subject).message(message).build();
		} else {
			client = new ExchangeClient.ExchangeClientBuilder().hostname(mailhost)
					.exchangeVersion(ExchangeVersion.Exchange2010).username(mailuser).password(mailpassword).attachments(pathlist)
					.recipientTo(toUser).recipientCc(ccUser).subject(subject).message(message).build();
		}
		flag = client.sendExchange();
		System.err.println();
		System.err.println(subject + "发送完毕!");
	    logger.info(subject+"发送完毕！");
		if (!flag) {
			ExchangeSendUtil esu= new ExchangeSendUtil();
			esu.eHost=mailhost;
			esu.euser=mailuser;
			esu.epassword=mailpassword;
			esu.ExchangeSendWariiing("", warningUser, subject + "发送失败");
		}
	}
}
