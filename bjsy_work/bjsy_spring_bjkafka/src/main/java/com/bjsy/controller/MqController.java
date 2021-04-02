package com.bjsy.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.jms.*;
import java.io.IOException;

/**
 * Create chenqinping 2019/12/23
 */
@RestController
@RequestMapping("/mqController")
public class MqController {

    @RequestMapping(value = "/getMq/{url}/{topicName}/{messageName}", method = RequestMethod.GET)
    public Object getMq(@PathVariable String url, @PathVariable String topicName, @PathVariable String messageName) throws Exception {
        System.out.println("进来了getBjjy");

        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(url);

        Connection connection = activeMQConnectionFactory.createConnection();

        connection.setClientID("z3");
        //两个参数,第一个叫事务,第二个叫签收
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Topic topic = session.createTopic(topicName);

        TopicSubscriber topicSubscriber = session.createDurableSubscriber(topic, "remake...");

        connection.start();
        Message message = topicSubscriber.receive();


        HttpClient httpclient = HttpClients.createDefault();

        HttpPost httppost = new HttpPost(messageName);
        httppost.addHeader("Content-Type", "application/json; charset=utf-8");
//        String textMsg = "{ \"msgtype\": \"text\", \"text\": {\"content\": \"bigdata,this is msg\"}}";


        while (null != message) {
            TextMessage textMessage = (TextMessage) message;
            String text = textMessage.getText();

            JSONObject jsonObject = JSON.parseObject(text);

            String status = (String) jsonObject.get("status");
            if (status.equals("KILLED")) {

                System.out.println("大数据," + textMessage.getText());

                String messageString = textMessage.getText();
                String textMsg = "{\n" +
                        "\t\"msgtype\": \"text\",\n" +
                        "\t\"text\": {\n" +
                        "\t\t\"content\": [{\n" +
                        "\t\t\t\"bigdata\": [" + messageString + "]\n" +
                        "\t\t}]\n" +
                        "\t}\n" +
                        "}";

                StringEntity se = new StringEntity(textMsg, "utf-8");
                httppost.setEntity(se);

                HttpResponse response = httpclient.execute(httppost);
                if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                    String result = EntityUtils.toString(response.getEntity(), "utf-8");
                    System.out.println(result);
                }
            }
            message = topicSubscriber.receive();
        }
        session.close();
        connection.close();
        return  null;
    }
}
