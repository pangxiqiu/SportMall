package com.sportmall.biz;

import com.sportmall.dao.IaddressMapper;
import com.sportmall.entity.TAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class addressBiz {

    @Autowired
    private IaddressMapper addressMapper;

    public List<TAddress> getAddress(int uid){
        return addressMapper.getAddress(uid);
    }

    public TAddress getAddressById(int id){
        return addressMapper.getAddressById(id);
    }

    public void addAddress(TAddress address)throws Exception{
       addressMapper.addAddress(address);
    }

    public int updateAddress(TAddress address)throws Exception{
        return addressMapper.updateAddress(address);
    }

    public  int deleteAddress(int id)throws Exception{
        return addressMapper.deleteAddress(id);
    }

}
