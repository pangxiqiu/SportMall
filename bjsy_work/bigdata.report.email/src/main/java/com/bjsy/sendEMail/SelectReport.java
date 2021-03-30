package com.bjsy.sendEMail;

import org.springframework.stereotype.Component;


@Component
public class SelectReport {
	
    String reportname;
   
    String dt;
   
   public void sendEmail() throws Exception{
	   Schedul s=new Schedul();
	   switch (reportname) {
	   case "onekey":
			//一键到车日报
		   System.out.println("onekey发送");
		   s.dt=dt;
		   s.SendOneKey();
		   break;   
	   case "onekeyOrder":
			//一键到车订单
		   System.out.println("onekeyOrder发送");
		   s.dt=dt;
		   s.SendOneKeyOrder();
		   break;   
	   case "onekeyOil":
			//一键加油日报
		   System.out.println("onekeyOil发送");
		   s.dt=dt;
		   s.SendOneKeyOil();
		   break;   		   
	   case "newUser":
			//每日油站拉新情况表
		   System.out.println("newUser发送");
		   s.dt=dt;
		   s.SendStationNewUser();
		   break;   
	   case "discountBegin":
			 //一键加油（剔除精准召回部分）月初统计邮件
		   System.out.println("discountBegin发送");
		   s.dt=dt;
		   s.SendDiscountBegin();
		   break;  
	   case "discount":
		 //本月车辆优惠邮件
		   System.out.println("discount日报发送");
		   s.dt=dt;
		   s.SendDiscount();
		   break;
	   case "nosenserefuel":
		 //一键加油销量流量分网点统计邮件
		   System.out.println("nosenserefuel日报发送");
		   s.dt=dt;
		   s.SendNoSenseRefuel();	
		   break;
	   case "nosenserefuelSanyuan":
		 //三元一键加油销量流量分网点统计邮件
		   System.out.println("nosenserefuelSanyuan日报发送");
		   s.dt=dt;
		   s.SendNoSenseRefuelSanyuan();	
		   break;
	   case "all":
			//大数据统计日报邮件
		   System.out.println("三份日报统一发送");
		   s.dt=dt;
		   s.SendDailyReport();
		   break;
	   case "discountEnd":
		 //一键加油（剔除精准召回部分）月末统计邮件
		   System.out.println("discountEnd发送");
		   s.dt=dt;
		   s.SendDiscountEnd();
		   break;	
	   case "shopDaily":
		 //一键加油（剔除精准召回部分）月末统计邮件
		   System.out.println("shopDaily发送");
		   s.dt=dt;
		   s.SendShoppingDaily();
		   break;
	   case "dataStatistics":
		 //数据统计报表
		   System.out.println("dataStatistics发送");
		   s.dt=dt;
		   s.SendDataStatistics();
		   break;	
	   case "dataTemplate":
		 //日报数据模板
		   System.out.println("dataTemplate发送");
		   s.dt=dt;
		   s.SendDataTemplate();
		   break;	
	   case "newplatMerge":
		 //新平台合并日报
		   System.out.println("newplatMerge发送");
		   s.dt=dt;
		   s.SendNewPlatMerge();
		   break;	
	   case "cirida":
		 //次日达订单
		   System.out.println("cirida发送");
		   s.dt=dt;
		   s.SendCirida();
		   break;	
	   case "classifySales":
		 //分开销售明细
		   System.out.println("classifySales发送");
		   s.dt=dt;
		   s.SendClassifySales();
		   break;	
	   case "goodsSale":
		 //商品销售日报
		   System.out.println("goodsSale发送");
		   s.dt=dt;
		   s.SendGoodsSale();
		   break;	
	   case "saledataMonitor":
		 //活动销售数据监控
		   System.out.println("saledataMonitor发送");
		   s.dt=dt;
		   s.SendSaleDataMonitor();
		   break;	
	   case "nooilsalesdetail":
		 //非油当月累计销售明细
		   System.out.println("nooilsalesdetail发送");
		   s.dt=dt;
		   s.SendNoOilMonthSalesDetail();
		   break;	
	   case "DetailSalesDaily":
		 //消费日报统一发送
		   System.out.println("分开销售数据日报统一发送");
		   s.dt=dt;
		   s.SendDetailSaleDaily();
		   break;
	   case "salesdetail":
		 //当月累计销售明细
		   System.out.println("当月累计销售明细发送");
		   s.dt=dt;
		   s.SendMonthSalesDetail();
		   break;   
	   case "MergeSalesDaily":
		 //消费日报统一发送
		   System.out.println("合并销售数据日报统一发送");
		   s.dt=dt;
		   s.SendMergeSaleDaily();
		   break;
		case "dieselMail":
			//消费日报统一发送
			System.out.println("合并销售数据日报统一发送");
			s.dt=dt;
			s.dieselClient();
			break;
	   default:
	      throw new Exception("无对应的日报发送选项");
	   }
   }

}
