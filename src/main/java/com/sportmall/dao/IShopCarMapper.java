package com.sportmall.dao;

import com.sportmall.entity.TShopCar;

import java.util.List;

public interface IShopCarMapper {

    //获取购物车信息
    List<TShopCar> getCarProduct(int uid);

    //添加购物车
    void addShopCar(TShopCar shopCar);

    //删除购物车中的一条数据
    int deleteCar(int id);

    //查询商品是否已存在
    int getUidPno (TShopCar shopCar);

    //修改购物车数量
    int updateCar(TShopCar shopCar);

    //获取购物车列表
    List<TShopCar> getCar(int uid);

    int updateCount (TShopCar shopCar);

    int getPcount(int id);


    //获取购物车列表ById
    TShopCar getCarById(int id);
}
