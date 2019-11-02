package com.sportmall.biz;

import com.sportmall.dao.IVipMapper;
import com.sportmall.entity.TVip;
import com.sportmall.entity.dto.RoleId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VipBiz {

    @Autowired
    private IVipMapper vipmapper;

    public void addVip(TVip vip){
        vipmapper.addVip(vip);
    }

    public int updateVip(TVip vip)throws Exception{
        return vipmapper.updateVip(vip);
    }

    public List<TVip> getAllVip(){
        return vipmapper.getAllVip();
    }

    public  TVip getVipInfo(int uid){
        return vipmapper.getVipInfo(uid);
    }

    public RoleId getRoleId(int uid){
        return vipmapper.getRoleId(uid);
    }

    public int updateRole(RoleId roleid){
        return vipmapper.updateRole(roleid);
    }

    public TVip getVip(int id)throws Exception{
        return vipmapper.getVip(id);
    }
}
