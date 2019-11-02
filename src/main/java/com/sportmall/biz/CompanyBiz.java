package com.sportmall.biz;

import com.sportmall.dao.IcompanyMapper;
import com.sportmall.entity.TCompany;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyBiz {

    @Autowired
    private IcompanyMapper companyMapper;

    /**
     * 公司列表
     * @param company
     * @return
     */
    public List<TCompany> getCompanys (TCompany company)throws  Exception{
        return companyMapper.getCompanys(company);
    }

    public  int getCounts(TCompany company){
        return companyMapper.getCounts(company);
    }

    public  TCompany getInfo(int cid)throws  Exception{
        return companyMapper.getInfo(cid);
    }


    //添加
    public void insertCompany(TCompany company)throws  Exception{
        companyMapper.insertCompany(company);
    }

    //启用/停用公司
    public int companyState(TCompany company){
        return companyMapper.companyState(company);
    }

    //修改公司信息
    public  int updateCompany(TCompany company)throws  Exception{
        return companyMapper.updateCompany(company);
    }


    /**
     * 未启用公司列表
     * @param company
     * @return
     */
    public List<TCompany> getOutCompanys(TCompany company){
        return companyMapper.getOutCompanys(company);
    }

    public int getOutCounts(TCompany company){
        return companyMapper.getOutCounts(company);
    }


}
