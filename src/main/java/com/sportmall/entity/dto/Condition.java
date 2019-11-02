package com.sportmall.entity.dto;

import java.io.Serializable;

public class Condition implements Serializable {

    //起始页
    private int startResult = 0;
    //每页最大页数
    private int maxSize = 10;
    //所有页
    private int allpages;
    //数据总量
    private int allrows;
    //当前页
    private int currentPage = 1;

    public int getStartResult() {
        return startResult;
    }

    public void setStartResult(int startResult) {
        this.startResult = startResult;
    }

    public int getMaxSize() {
        return maxSize;
    }

    public void setMaxSize(int maxSize) {
        this.maxSize = maxSize;
    }

    public int getAllpages() {
        return allpages;
    }

    public void setAllpages(int allpages) {
        this.allpages = allpages;
    }

    public int getAllrows() {
        return allrows;
    }

    public void setAllrows(int allrows) {
        this.allrows = allrows;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
