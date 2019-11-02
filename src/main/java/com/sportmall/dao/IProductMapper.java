package com.sportmall.dao;

import com.sportmall.entity.TProduct;
import com.sportmall.entity.TProductType;
import com.sportmall.entity.dto.TProductCondition;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface IProductMapper {



    //获取所有产品
    List<TProduct> getAllProducts(TProductCondition tProductCondition) throws Exception;
    //获取产品总数
    Integer productCount(TProductCondition tProductCondition);

    //添加产品信息
    void addProduct(TProduct product) throws Exception;

    //获取图片
    TProduct getPic(Integer pno) throws Exception;

    //获取产品详细信息
    TProduct getProductInfo(Integer pno) throws Exception;

    //获取购物车信息
    List<TProduct> getCarProducts(@Param("uname") String uname) throws Exception;

    //产品下架
    Integer deleteProduct (@Param("pno") Integer pno,@Param("pstate") Integer pstate);

    //补充库存
    Integer addProductCount(@Param("pno") Integer pno,@Param("count") Integer count);

    //修改产品信息
    Integer updateProduct(TProduct product);

    int reduceCount(TProduct product)throws Exception;


}
