package com.sportmall.biz;

import com.sportmall.dao.ITypeMapper;
import com.sportmall.entity.TProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("typeBiz")
public class typeBiz {

    @Autowired
    private ITypeMapper iTypeMapper;

    public List<TProductType> getAllType(TProductType tProductType) throws Exception {
        return iTypeMapper.getAllType(tProductType);
    }

    public int getCount(TProductType tProductType) throws  Exception{
        return iTypeMapper.getCount(tProductType);
    }


    public int addType(TProductType tProductType) throws Exception {
        return iTypeMapper.addType(tProductType);
    }

    public int updateType(TProductType tProductType) throws Exception{
        return iTypeMapper.updateType(tProductType);
    }

    public TProductType getTypeInfo(Integer typeno)throws Exception{
        return iTypeMapper.getTypeInfo(typeno);
    }
}
