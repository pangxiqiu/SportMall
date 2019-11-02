package com.sportmall.biz;

import com.sportmall.dao.IShopCarMapper;
import com.sportmall.entity.TShopCar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopCarBiz {

    @Autowired
    private IShopCarMapper shopCarMapper;

    public void addShopCar(TShopCar shopCar)throws Exception{
        int count = shopCarMapper.getUidPno(shopCar);
        if(count != 0){
            shopCarMapper.updateCar(shopCar);
        }else{
            shopCarMapper.addShopCar(shopCar);
        }

    }

    public List<TShopCar> getCarProducts(int uid)throws Exception{
        return shopCarMapper.getCarProduct(uid);
    }

    public List<TShopCar> getCar(int uid){
        return shopCarMapper.getCar(uid);
    }

    public int deleteCar(int id){
        return shopCarMapper.deleteCar(id);
    }


    public int updateCount(TShopCar shopCar) throws Exception{
        return shopCarMapper.updateCount(shopCar);
    }

    public int getCount(int id){
        return shopCarMapper.getPcount(id);
    }

    public TShopCar getCarById(int id){
        return shopCarMapper.getCarById(id);
    }

}
