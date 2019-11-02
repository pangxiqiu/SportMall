package com.sportmall.dao;

import com.sportmall.entity.TOrder;
import com.sportmall.entity.TOrderDetail;
import com.sportmall.entity.dto.TOrderCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IorderMapper {

    void insertOrder(TOrder order);

    void insertOrderDetail(TOrderDetail orderDetail);

    List<TOrder> getMyOrder(TOrder order );

    //订单详细信息
    List<TOrderDetail> getOrderDetail(String ono);

    TOrderDetail isComment(@Param("ono") String ono, @Param("pno") Integer pno);

    int isCommpented(@Param("ono") String ono, @Param("pno") Integer pno);

    TOrder getOrderByOno(String ono);

    //修改状态
    int  updateOstate(TOrder order)throws Exception;

//    int payOrder(TOrder order)throws Exception;

    List<TOrder> getAllOrders(TOrderCondition orderCondition);

    Integer getOrderCounts(TOrderCondition orderCondition);

}
