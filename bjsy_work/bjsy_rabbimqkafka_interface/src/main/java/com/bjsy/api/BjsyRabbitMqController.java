package com.bjsy.api;

import com.bjsy.Server.BjbdydjyServer;
import com.bjsy.Server.BjjyServer;
import com.bjsy.Server.TestServer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


/**
 * Create chenqinping 2019/12/16
 */
@RestController
@RequestMapping("/bjsyRabbitMq")
public class BjsyRabbitMqController {

    @RequestMapping(value = "/bjsy/getJy", method = RequestMethod.GET)
    public Object getBjjy() throws Exception {
        System.out.println("进来了getJy");

        boolean isAsync = true;
        BjjyServer producerThread = new BjjyServer("bjsy_jy_mq_topic", isAsync);
        producerThread.start();
        return  null;
    }


    @RequestMapping(value = "/bjsy/getBjydjy", method = RequestMethod.GET)
    public Object getBjbdkydjy() throws Exception {
        System.out.println("进来了getBjydjy");
        boolean isAsync = true;
        BjbdydjyServer producerThread = new BjbdydjyServer("bjsy_jy_mq_topic", isAsync);
        producerThread.start();
        return null;
    }


    @RequestMapping(value = "/getTest", method = RequestMethod.GET)
    public Object getTest() throws Exception {
        System.out.println("进来了getTest");
        boolean isAsync = true;
        TestServer producerThread = new TestServer("test_mq_test", isAsync);
        producerThread.start();
        return null;
    }
}
