package com.sportmall.biz;

import com.sportmall.dao.IProductMapper;
import com.sportmall.dao.IUserMapper;
import com.sportmall.dao.IorderMapper;
import com.sportmall.entity.*;
import com.sportmall.entity.dto.TOrderCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class OrderBiz {
    @Autowired
    private IorderMapper orderMapper;
    @Autowired
    private ShopCarBiz shopCarBiz;
    @Autowired
    private IProductMapper productMapper;
    @Autowired
    private IUserMapper userMapper;

    @Transactional
    public void addOrder(TAddress address, Double allprice, int uid, int[] list) {
        TShopCar shopCar;
        TOrder order = new TOrder();
        TOrderDetail orderDetail = new TOrderDetail();
        SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
        String ono = "o" + sd.format(new Date()) + "-" + new Date().getTime();
        order.setOno(ono);
        order.setAddress(address.getAddress());
        order.setReceiver(address.getReceiver());
        order.setTel(address.getTel());
        order.setAllprice(allprice);
        order.setUid(uid);
        order.setOdate(new Date());
        order.setOstate(Iostate.nopay);
        orderMapper.insertOrder(order);

        for (int i = 0; i < list.length; i++) {
            int id = list[i];
            shopCar = shopCarBiz.getCarById(id);
            System.out.println(shopCar.getPno() + shopCar.getPrice() + shopCar.getPcount());
            orderDetail.setOno(ono);
            orderDetail.setPno(shopCar.getPno());
            orderDetail.setAmount(shopCar.getPcount());
            orderDetail.setPrice(shopCar.getPrice());
            orderDetail.setIscomment(0);
            orderMapper.insertOrderDetail(orderDetail);
            shopCarBiz.deleteCar(id);
        }
    }

    @Transactional
    public void justOrder(TProduct product, TAddress address,double allprice,int amount,int uid){
        TOrder order = new TOrder();
        TOrderDetail orderDetail = new TOrderDetail();
        SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
        String ono = "o" + sd.format(new Date()) + "-" + new Date().getTime();
        order.setOno(ono);
        order.setAddress(address.getAddress());
        order.setReceiver(address.getReceiver());
        order.setTel(address.getTel());
        order.setAllprice(allprice);
        order.setUid(uid);
        order.setOdate(new Date());
        order.setOstate(Iostate.nopay);
        orderMapper.insertOrder(order);
        orderDetail.setOno(ono);
        orderDetail.setPno(product.getPno());
        orderDetail.setAmount(amount);
        orderDetail.setPrice(product.getPrice());
        orderMapper.insertOrderDetail(orderDetail);
    }



    public void insertOrder(TAddress address, Double allprice, int uid) {
//
    }

    public void insertOrderDetail(TOrderDetail orderDetail) {

    }

    public List<TOrder> getMyOrder(TOrder order) {
        List<TOrder> orderlist = orderMapper.getMyOrder(order);
        List<TOrderDetail> detaillist;

        try {
            if (orderlist != null && orderlist.size() > 0) {
                for (TOrder o : orderlist) {
                    String ono = o.getOno();
                    detaillist = orderMapper.getOrderDetail(ono);
                    for (TOrderDetail d : detaillist) {
                        TProduct product = productMapper.getProductInfo(d.getPno());
                        d.setPname(product.getPname());
                        d.setImage(product.getImage());
                    }
                    o.setDetaillist(detaillist);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderlist;
    }


    public TOrderDetail isComment(String ono,Integer pno){
        return orderMapper.isComment(ono,pno);
    }

    public int isCommpented(String ono, Integer pno){
        return orderMapper.isCommpented(ono,pno);
    }


    public  List<TOrderDetail> getOrderDetail(String ono){
        return orderMapper.getOrderDetail(ono);
    }

    public TOrder getOrderByOno(String ono){
        return orderMapper.getOrderByOno(ono);
    }


    //支付
    @Transactional
    public int payOrder(TOrder order,TUser user) throws Exception {
        int a;
        try {
            order.setOstate(Iostate.payed);
            order.setPaydate(new Date());
            orderMapper.updateOstate(order);
            if(user!=null){
                a = userMapper.payMoney(user);
            }
            a=0;
        }catch (Exception e){
            e.printStackTrace();
            throw e;
        }
        return a;
    }

    public int  updateOstate(TOrder order)throws Exception{
        return orderMapper.updateOstate(order);
    }


    public  List<TOrder> getAllOrders(TOrderCondition orderCondition)throws Exception{
        return orderMapper.getAllOrders(orderCondition);
    }

    public Integer getOrderCounts(TOrderCondition orderCondition)throws  Exception{
        return orderMapper.getOrderCounts(orderCondition);
    }



}
