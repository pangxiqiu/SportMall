package com.sportmall.dao;

import com.sportmall.entity.TAddress;

import java.util.List;

public interface IaddressMapper {

    List<TAddress> getAddress(int uid);

    TAddress getAddressById(int id);

    void addAddress(TAddress address);

    int updateAddress(TAddress address);

    int deleteAddress(int id);
}
