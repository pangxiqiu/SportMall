package com.bjsy.api;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bjsy.unit.ConnectionUtils;
import com.bjsy.unit.Http;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

/**
 * Create chenqinping 2019/12/10
 */
@RestController
@RequestMapping("/redisFour")
public class RedisFourController {

    private static final String user_comment_QUEUE = "personal_client_mq";
//    private static final String user_comment_QUEUE = "test";

    @RequestMapping(value = "/getRedisFour", method = RequestMethod.GET)
    public Object getRedisFour() {
        System.out.println("进来了");
        String result = null;
        try {
            result = Http.doGet("" +
//                    "http://123.124.249.75:80/ncmi/findBjsyData.action"
                      "http://sales.sinopec.com/ncmi/findBjsyData.action"

            );
            System.out.println("出去了");

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("result=====" + result);


        Connection con = null;
        Channel channel = null;
        try {
            // 获取连接
            try {
                con = ConnectionUtils.getConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
            // 从连接中创建通道
            channel = con.createChannel();
            // 声明一个队列
            channel.queueDeclare(user_comment_QUEUE, true, false, false, null);
            // 消息内容
            JSONArray jsonArray1 = JSONArray.parseArray(result);
            System.out.println(jsonArray1);

            for (int i = 0; i < jsonArray1.size(); i++) {
                JSONObject jsonO = jsonArray1.getJSONObject(i);
                String s = jsonO.toString();
                channel.basicPublish("", user_comment_QUEUE, null, s.getBytes());
            }

            System.out.println("getRedisFour发送了多少条" + jsonArray1.size());
            System.out.println("send success");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接
            ConnectionUtils.close(channel, con);
        }


        return JSON.toJSON(result);

    }
}
