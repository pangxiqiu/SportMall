package com.bjsy.test;


/**
 * Create chenqinping 2019/12/2
 */

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bjsy.unit.Http;

/**
 * get请求测试
 *
 * @author liujilong
 * @since 2019-7-18 10:26:49
 */
public class TestRedis {

    public static void main(String[] args) {
        String result = null;
        try {
            result = Http.doGet("" +
			//      "http://123.124.249.75/sales/htmlTest/findBjsyData.action"
                    "http://sales.sinopec.com/sales/htmlTest/findBjsyData.action"

            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("result=====" + result);

        JSONArray jsonArray2 = JSONArray.parseArray(result);

        for (int i=0;i<jsonArray2.size();i++){
            JSONObject jsonO = jsonArray2.getJSONObject(i);
            System.out.println(jsonO);
        }

//        JSONObject parse = (JSONObject) JSONObject.parse(result);
//
//        String data = parse.get("data").toString();
//
//        System.out.println(JSON.toJSON(data));


    }


}