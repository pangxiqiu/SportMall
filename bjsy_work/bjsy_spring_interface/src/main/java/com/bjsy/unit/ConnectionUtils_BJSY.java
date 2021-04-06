package com.bjsy.unit;


import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

/**
 * rabbitmq连接工具类
 * @author Administrator
 *
 */
public class ConnectionUtils_BJSY {
    /**
     * 获取连接
     * @return
     * @throws IOException
     * @throws TimeoutException
     */
    public static Connection getConnection() throws Exception {
        ConnectionFactory factory = new ConnectionFactory();

        PropUtil.initial("rabbitmq.properties");
        // 设置服务地址
        factory.setHost(PropUtil.get("bjhost"));
        // 端口
        factory.setPort(5672);
        // vhost
//        factory.setVirtualHost(PropUtil.get("vHost"));
        // 用户名
        factory.setUsername(PropUtil.get("bjusername"));
        // 密码
        factory.setPassword(PropUtil.get("bjpassword"));
        return factory.newConnection();
    }
    /**
     * 关闭连接
     * @param channel
     * @param con
     */
    public static void close(Channel channel,Connection con){
        if(channel != null){
            try {
                channel.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if(con != null){
            try {
                con.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

}