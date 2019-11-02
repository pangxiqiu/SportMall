package com.sportmall.entity;

import com.sportmall.entity.dto.Condition;

public class TVip extends Condition {

    private int id;
    private String vipname;
    private int state;
    private double discount;
    private int ispostage;
    private Double cost;
    private Double maxcost;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVipname() {
        return vipname;
    }

    public void setVipname(String vipname) {
        this.vipname = vipname;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getIspostage() {
        return ispostage;
    }

    public void setIspostage(int ispostage) {
        this.ispostage = ispostage;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Double getMaxcost() {
        return maxcost;
    }

    public void setMaxcost(Double maxcost) {
        this.maxcost = maxcost;
    }
}
