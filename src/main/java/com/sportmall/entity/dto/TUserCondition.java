package com.sportmall.entity.dto;

import java.util.Date;

public class TUserCondition extends Condition {

    //用户名
    private String uname;
    //电话
    private String tel;
    //开始注册时间
    private Date start_regTime;
    //结束注册时间
    private Date end_regTime;
    //角色级别
    private int role;

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getStart_regTime() {
        return start_regTime;
    }

    public void setStart_regTime(Date start_regTime) {
        this.start_regTime = start_regTime;
    }

    public Date getEnd_regTime() {
        return end_regTime;
    }

    public void setEnd_regTime(Date end_regTime) {
        this.end_regTime = end_regTime;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
