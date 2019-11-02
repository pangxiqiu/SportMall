package com.sportmall.util;

import com.alibaba.fastjson.JSONObject;

public class JBean {
    private int code;
    private int count;
    private String msg;
    private Object data;
    private long timestamp;

    public static JBean by(int code, String msg) {
        JBean jBean = new JBean();
        jBean.code = code;
        jBean.msg = msg;
        jBean.timestamp = System.currentTimeMillis();
        return jBean;
    }

    public static JBean by(int code, String msg, Object data,int count) {
        JBean jBean = new JBean();
        jBean.code = code;
        jBean.msg = msg;
        jBean.count = count;
        jBean.data = data;
        jBean.timestamp = System.currentTimeMillis();
        return jBean;
    }

    public JBean set(int code, String msg) {
        this.code = code;
        this.msg = msg;
        return this;
    }

    public JBean setCode(int code) {
        this.code = code;
        return this;
    }

    public JBean setMessage(String msg) {
        this.msg = msg;
        return this;
    }

    public JBean setBody(Object data) {
        this.data = data;
        return this;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public Object getData() {
        return data;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public int getCount() {
        return count;
    }

    public String toJson() {
        return JSONObject.toJSONString(this);
    }
}
