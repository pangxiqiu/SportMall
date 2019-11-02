package com.sportmall.dao;

import com.sportmall.entity.dto.TUserCondition;
import org.apache.ibatis.annotations.Param;
import com.sportmall.entity.TUser;

import java.util.List;


public interface IUserMapper {
	
	//注册
	public void register(TUser user) throws Exception;

	//登录
	public TUser login(@Param("uname") String uname, @Param("pwd") String pwd) throws Exception;
	
	//退出
	public TUser isExist(@Param("uname") String uname) throws Exception;

	//条件查询用户
	List<TUser> getAllUsers(TUserCondition userCondition)throws Exception;

	//条件总数
	int getCount(TUserCondition userCondition)throws Exception;

	//修改 重置  密码
	int updatePassword(TUser user)throws Exception;

	int payMoney(TUser user)throws Exception;


}
