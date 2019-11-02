package com.sportmall.entity;

import com.sportmall.entity.dto.Condition;

public class TCompany extends Condition {

    private Integer cid;
    private String cname;
    private String ctel;
    private String cweb;
    private Integer cstate;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCtel() {
        return ctel;
    }

    public void setCtel(String ctel) {
        this.ctel = ctel;
    }

    public String getCweb() {
        return cweb;
    }

    public void setCweb(String cweb) {
        this.cweb = cweb;
    }

    public Integer getCstate() {
        return cstate;
    }

    public void setCstate(Integer cstate) {
        this.cstate = cstate;
    }
}
