package com.bjsy.sendEMail.util;

import microsoft.exchange.webservices.data.core.enumeration.misc.ExchangeVersion;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.bjsy.sendEMail.model.ExchangeSendModel;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


@Component
public class ExchangeSendUtil {

    @Value("${mail.host}")
     static String eHost;
    
    @Value("${mail.username}")
     static String euser;
    
    @Value("${mail.password}")
     static String epassword;
    
    public  void ExchangeSend(ExchangeSendModel exchangeSendModel) throws Exception {
        String password1 = epassword;
        DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
        LocalDateTime ldt = LocalDateTime.now();
        String today = dtf1.format(ldt);
        try {
            File file= new File(exchangeSendModel.getAttachments());
            if(file.exists()) {
                ExchangeClient client = new ExchangeClient.ExchangeClientBuilder()
                        .hostname(eHost)
                        .exchangeVersion(ExchangeVersion.Exchange2010)
                        .username(euser)
                        .password(password1)
                        .recipientBcc(exchangeSendModel.getRecipientBcc())
                        .attachments(exchangeSendModel.getAttachments())
                        .recipientTo(exchangeSendModel.getRecipientTo())
                        .recipientCc(exchangeSendModel.getRecipientCc())
                        .subject(exchangeSendModel.getSubject())
                        .message(exchangeSendModel.getMessage())
                        .build();
                client.sendExchange();
                System.err.println("北京石油日报发送成功!(带附件)");
            }else{
                ExchangeClient client = new ExchangeClient.ExchangeClientBuilder()
                        .hostname(eHost)
                        .exchangeVersion(ExchangeVersion.Exchange2010)
                        .username(euser)
                        .password(password1)
                        .recipientBcc(exchangeSendModel.getRecipientBcc())
                        .recipientTo(exchangeSendModel.getRecipientTo())
                        .recipientCc(exchangeSendModel.getRecipientCc())
                        .subject(exchangeSendModel.getSubject())
                        .message(exchangeSendModel.getMessage())
                        .build();
                client.sendExchange();
                System.err.println("北京石油日报发送成功!(不带附件)");
            }
        }catch (Exception e){
            System.err.println("北京石油日报发送失败");
        }
    }

    public  void ExchangeSendWariiing(String html,String warningUser,String subject) throws Exception {
        String password1 =epassword;
        DateTimeFormatter dtf1 = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
        LocalDateTime ldt = LocalDateTime.now();
        String today = dtf1.format(ldt);
        ExchangeClient client = new ExchangeClient.ExchangeClientBuilder()
                .hostname(eHost)
                .exchangeVersion(ExchangeVersion.Exchange2010)
                .username(euser)
                .password(password1)
                .recipientTo(warningUser)
                .subject(subject+today)
                .message(html)
                .build();
        client.sendExchange();
    }
}
