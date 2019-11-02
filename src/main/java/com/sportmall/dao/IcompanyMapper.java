package com.sportmall.dao;

import com.sportmall.entity.TCompany;

import java.util.List;

public interface IcompanyMapper {
    /**
     * 公司列表
     * @param company
     * @return
     */
    List<TCompany> getCompanys (TCompany company);

    int getCounts(TCompany company);

    //添加
    void insertCompany(TCompany company);

    TCompany getInfo(int cid);

    //启用/停用公司
    int companyState(TCompany company);

    //修改公司信息
    int updateCompany(TCompany company);


    /**
     * 未启用公司列表
     * @param company
     * @return
     */
    List<TCompany> getOutCompanys(TCompany company);

    int getOutCounts(TCompany company);

}
