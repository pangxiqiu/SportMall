package com.sportmall.biz;

import com.sportmall.dao.IUserMapper;
import com.sportmall.entity.TVip;
import com.sportmall.entity.dto.TUserCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportmall.entity.IRole;
import com.sportmall.entity.TUser;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("userBiz")
public class UserBiz {

	@Autowired
	private IUserMapper userDao;


	public void register(TUser user) throws Exception {
		if(user == null) {
			throw new Exception("用户为空");
		}else {
			user.setRole(IRole.CUSER);
			user.setAccount(100);
			user.setCost(0);
			user.setRegdate(new Date());
			System.out.println(user.getRegdate());
			userDao.register(user);
		}
	}

	public TUser login(String uname,String pwd) throws Exception {

		return userDao.login(uname, pwd);
	}

	public boolean isExist(String uname) throws Exception {
		TUser user = userDao.isExist(uname);
		if(user==null) {
			return false;
		}else {
			return true;
		}
	}

	//获取数据集
	public List<TUser> getAllUsers(TUserCondition userCondition) throws Exception {
		return  userDao.getAllUsers(userCondition);
	}

	//获取数据集总量
	public int getCount(TUserCondition userCondition){
		int a = 0;
		try {
			 a = userDao.getCount(userCondition);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}

	//修改密码
	public int updatePassword(TUser user) throws Exception {

		return userDao.updatePassword(user);
	}







}
