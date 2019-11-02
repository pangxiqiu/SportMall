package com.sportmall.dao;

import com.sportmall.entity.TVip;
import com.sportmall.entity.dto.RoleId;

import java.util.List;

public interface IVipMapper {

    void addVip(TVip vip);

    List<TVip> getAllVip();

    TVip getVipInfo(int uid);

    //查找消费额度
    RoleId getRoleId(int uid);

    //修改用户级别
    int updateRole(RoleId roleid);

    TVip getVip(int id);

    int updateVip(TVip vip);
}
