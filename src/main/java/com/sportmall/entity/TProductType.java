package com.sportmall.entity;

import com.sportmall.entity.dto.Condition;

public class TProductType extends Condition {

    private Integer typeno;
    private String typename;
    private int typestate;

    public Integer getTypeno() {
        return typeno;
    }

    public void setTypeno(Integer typeno) {
        this.typeno = typeno;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public int getTypestate() {
        return typestate;
    }

    public void setTypestate(int typestate) {
        this.typestate = typestate;
    }
}
