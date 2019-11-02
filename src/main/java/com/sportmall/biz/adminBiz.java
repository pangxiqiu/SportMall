package com.sportmall.biz;

import com.sportmall.dao.IadminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminBiz")
public class adminBiz  {

    @Autowired
    private IadminMapper iadminMapper;

    public int userCount()throws Exception{
        return iadminMapper.userCount();
    }

    public int vipCount()throws Exception{
        return iadminMapper.vipCount();
    }

    public int companyCount()throws Exception{
        return iadminMapper.companyCount();
    }

    public int orderCount()throws Exception{
        return iadminMapper.orderCount();
    }

    public int productCount()throws Exception{
        return iadminMapper.productCount();
    }

    public int commentCount()throws Exception{
        return iadminMapper.companyCount();
    }
}
