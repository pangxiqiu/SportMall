package com.sportmall.dao;

public interface IadminMapper {

    int userCount()throws Exception;

    int vipCount()throws Exception;

    int productCount()throws Exception;

    int companyCount()throws Exception;

    int orderCount()throws Exception;

    int commentCount()throws Exception;
}
