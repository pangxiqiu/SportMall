package com.sportmall.dao;

import com.sportmall.entity.TProductType;

import java.util.List;

public interface ITypeMapper {

    //获取所有类别
    List<TProductType> getAllType(TProductType tProductType) throws Exception;

    //添加类别
    int addType(TProductType tProductType) throws Exception;

    //修改类别信息 -- 类别启用（禁用）
    int updateType(TProductType tProductType) throws Exception;

    //获取类别数量
    int getCount(TProductType tProductType) throws Exception;

    //获取类别ById
    TProductType getTypeInfo(Integer typeno);

}
