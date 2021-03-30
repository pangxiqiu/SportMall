package com.bjsy;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Create chenqinping 2019/12/5
 */
public class Test1 {


    public static void main(String[] args) {
//        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
//        String format = df.format(new Date());
//        System.out.println();// new Date()为获取当前系统时间


        String s="{\n" +
                "  \"time\" : \"2019-11-28 16:09:12\",\n" +
                "  \"userId\" : \"b778a4e12bbe49e9b9f928e0445e6e3b\",\n" +
                "  \"phone\" : \"\",\n" +
                "  \"openid\" : \"\",\n" +
                "  \"event\" : \"ej_home_see\"\n" +
                "}";

        System.out.println(s);

        JSONObject jsonObject = JSON.parseObject(s);

        System.out.println(jsonObject.toString());
    }
}
