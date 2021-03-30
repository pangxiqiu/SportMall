package com.bjsy.sendEMail;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@EnableAutoConfiguration(exclude= {DataSourceAutoConfiguration.class})
@SpringBootApplication(exclude= {DataSourceAutoConfiguration.class})
@ComponentScan
@EnableAspectJAutoProxy
public class App {

    public static void main(String[] args) throws Exception {

   	//定时任务启动
    	SpringApplication.run(App.class, args);
/*    //手动补发方法  传入参数dt,reportname
   	ConfigurableApplicationContext  cac=SpringApplication.run(App.class, args);
      String name=cac.getEnvironment().getProperty("reportname");
       String dt=cac.getEnvironment().getProperty("dt");
       if(name!=null&&!"".equals(name)&&dt!=null&!"".equals(dt)){
       	SelectReport sr=new SelectReport();
       	String[] dts=dt.split(",");
       	for(String dt1:dts){
       	   sr.dt=dt1;
       	   sr.reportname=name;
       	   sr.sendEmail();
       	}
       }else{
         String message="输入参数不正确";
         throw new Exception(message);
       } */
    }
}
