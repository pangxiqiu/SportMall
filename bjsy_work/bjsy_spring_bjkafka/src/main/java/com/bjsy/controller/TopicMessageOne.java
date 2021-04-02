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

import javax.jms.*;
import java.io.IOException;

/**
 * Create by Administrator on 2019/12/11
 */

public class TopicMessageOne {
    private static final String ACTIVE_URL = "tcp://10.6.170.45:8086";
    private static final String TOPIC_NMAE = "scapp";

    public static String WEBHOOK_TOKEN = "https://oapi.dingtalk.com/robot/send?access_token=061776ca7ded924abf62d1db5e4fd07f3c";

    public static void main(String[] args) throws JMSException, IOException {
        //System.out.println("我是z3号消费者");

        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVE_URL);

        Connection connection = activeMQConnectionFactory.createConnection();

        connection.setClientID("z3");
        //两个参数,第一个叫事务,第二个叫签收
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Topic topic = session.createTopic(TOPIC_NMAE);

        TopicSubscriber topicSubscriber = session.createDurableSubscriber(topic, "remake...");

        connection.start();
        Message message = topicSubscriber.receive();


        HttpClient httpclient = HttpClients.createDefault();

        HttpPost httppost = new HttpPost(WEBHOOK_TOKEN);
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
    }
}
