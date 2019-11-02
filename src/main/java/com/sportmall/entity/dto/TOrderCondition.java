package com.sportmall.entity.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TOrderCondition extends  Condition{


    private String ono;
    private Integer ostate;
    private Integer uid;
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
//    private Date begin_odate;
//    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
//    private Date end_odate;

    public String getOno() {
        return ono;
    }

    public void setOno(String ono) {
        this.ono = ono;
    }

    public Integer getOstate() {
        return ostate;
    }

    public void setOstate(Integer ostate) {
        this.ostate = ostate;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    //    public Date getBegin_odate() {
//        return begin_odate;
//    }
//
//    public void setBegin_odate(Date begin_odate) {
//        this.begin_odate = begin_odate;
//    }
//
//    public Date getEnd_odate() {
//        return end_odate;
//    }
//
//    public void setEnd_odate(Date end_odate) {
//        this.end_odate = end_odate;
//    }
}
