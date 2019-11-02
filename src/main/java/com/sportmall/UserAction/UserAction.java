package com.sportmall.UserAction;

import javax.json.Json;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.GET;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.*;
import com.sportmall.entity.*;
import com.sportmall.entity.dto.RoleId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.*;

import com.sportmall.util.Log;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class UserAction {

	@Autowired
	private UserBiz userBiz;

	@Autowired
	private VipBiz vipBiz;

	@Autowired
	private ShopCarBiz shopCarBiz;

	@Autowired
	private addressBiz addressBiz;

	@Autowired
	private OrderBiz orderBiz;

	@Autowired
	private ProductBiz productBiz;

    //注册页面
	@RequestMapping(path="/regist",method=RequestMethod.GET)
	 public String register(){
		 return "register.jsp";
	 }

	/**
	 * 注册
	 * @param session
	 * @param model
	 * @param uname
	 * @param pwd
	 * @param rname
	 * @param tel
	 * @param sex
	 * @return
	 */
	 @RequestMapping(path="/regist",method=RequestMethod.POST)
	 public String register(HttpSession session,Model model,
			 String uname,String pwd,String rname,String tel,String sex){
		 String strRet = null;

		 TUser user = new TUser();
			if(!uname.equals("") && pwd != null){
				user.setUname(uname);
				user.setPwd(pwd);
				user.setRname(rname);
				user.setSex(sex);
				user.setTel(tel);
				try {
					userBiz.register(user);
					session.setAttribute("user", user);
					model.addAttribute("msg", "注册成功:"+user.getUname());
					model.addAttribute("message", "系统赠送您100元奖励");
					strRet = "main/succeed.jsp";
				} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
					Log.logger.error(e.getMessage(),e);
					model.addAttribute("msg","请不要重复提交数据");
					strRet = "main/error.jsp";
				}
				catch (Exception e) {
					Log.logger.error(e.getMessage(),e);
					model.addAttribute("msg", "网络连接异常");
					strRet = "main/error.jsp";
				}
			}else {
				model.addAttribute("msg", "注册信息有误");
				strRet = "main/error.jsp";
			}

			return strRet;
	 }



	/**
	 * 退出
	 * @param model
	 * @param uname
	 * @return
	 */
	@ResponseBody
	@RequestMapping(path = "/isExist", method=RequestMethod.GET)
	public boolean isExist(Model model,String uname) {

		boolean flag;
		try {
			flag = userBiz.isExist(uname);
			return flag;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;

		}


	}


	//登录页面
	 @RequestMapping(path="/login",method=RequestMethod.GET)
	 public String login(){
		 return "login.jsp";
	 }

	 /**
	  * 登录
	  * @param request
	  * @param uname
	  * @param pwd
	  * @return
	  */
	 @RequestMapping(path="/login",method=RequestMethod.POST)
	 public String login(HttpServletRequest request,HttpServletResponse response,String uname,String pwd){
		 String strRet;
		 String path = request.getContextPath();
		 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
			try {
				TUser user = userBiz.login(uname, pwd);
				if(user!=null){
					TVip vip = vipBiz.getVipInfo(user.getUid());
					request.getSession().setAttribute("user", user);
					request.getSession().setAttribute("vip", vip);
					Log.logger.info("uname:"+user.getUname()+",pwd:"+user.getPwd());
					Cookie c = new Cookie("user",uname+","+pwd);
					c.setMaxAge(30*24*3600);//设置Cookie有效期为30天
					response.addCookie(c);//将Cookie对象保存在客户端
			        strRet = "redirect:"+basePath+"home.do";

				}else{
					request.setAttribute("msg", "用户名或密码错误/请重新输入");
					strRet = "login.jsp";
				}
			} catch (Exception e) {
				Log.logger.error(e.getMessage(),e);
				request.setAttribute("msg", "网络连接异常");
				strRet = "main/error.jsp";
			}

		return strRet;
	 }

    //退出
	 @RequestMapping("/logout")
	 public String logout(HttpServletRequest request,HttpServletResponse response) {
		 request.getSession().invalidate();

		 String path = request.getContextPath();
		 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		 Cookie user = new Cookie("user", null);
		 response.addCookie(user);
		 Cookie[] cookies = request.getCookies();
		 for(int i = 0; i < cookies.length; i++){
			 if(cookies[i].getName().equals("user")){
				 cookies[i].setValue(null);
			 }
		 }
		 return "redirect:"+basePath+"home.do";
	 }

    //获取购物车信息
	 @GetMapping(value = "user/getShopCar")
	 public String getShopCar(HttpServletRequest request,Model model){
	 	String str ;
	 	TUser user = (TUser) request.getSession().getAttribute("user");

	 	List<TShopCar> list;
	 	List<TAddress> address;
		 try {

			 list = shopCarBiz.getCar(user.getUid());
			 address = addressBiz.getAddress(user.getUid());

			 model.addAttribute("list",list);
			 model.addAttribute("address",address);
			 str = "shop-car.jsp";
		 } catch (Exception e) {
			 e.printStackTrace();
			 model.addAttribute("msg","获取购物车数据失败");
			 str = "main/error.jsp";
		 }
		 return str;
	 }

	 //添加到购物车
	 @PostMapping(value = "user/addCar")
	 public String addShopCar(HttpServletRequest request,Model model){
	 	String str;
	 	TUser user = (TUser) request.getSession().getAttribute("user");
	 	int pno = Integer.parseInt(request.getParameter("pno"));
	 	String count = request.getParameter("pcount");
	 	TShopCar shopCar = new TShopCar();
        if(count!=null){
            shopCar.setPcount(Integer.parseInt(count));
        }else{
            shopCar.setPcount(1);
        }
		 try {
			 shopCar.setUid(user.getUid());
			 shopCar.setPno(pno);

			 shopCar.setScstate(0);
			 shopCarBiz.addShopCar(shopCar);
			 str="product-info.jsp";
		 } catch (Exception e) {
			 e.printStackTrace();
			 model.addAttribute("msg","添加购物车失败");
			 str="main/error.jsp";
		 }

		return str;
	 }

	 @GetMapping(value = "user/delete-car")
	 @ResponseBody
	 public String deleteCar(int id){
		 JSONObject json = new JSONObject();
		 int a = 0;
		 a = shopCarBiz.deleteCar(id);
		 if(a>0){
		 	json.put("code",200);
		 	json.put("msg","删除成功");
		 }else {
			 json.put("code",-1);
			 json.put("msg","删除失败");
		 }
		 return json.toJSONString();
	 }




	@PostMapping(value = "user/reduceCount")
	@ResponseBody
	public String reduceCount(HttpServletRequest request){
	 	String shopCarId = request.getParameter("id");
	 	TShopCar shopCar = new TShopCar();
		JSONObject json = new JSONObject();
		try {
			if(shopCarId!=null) {
				int id = Integer.parseInt(shopCarId);
				shopCar.setId(id);
				shopCar.setPcount(-1);
				int count = shopCarBiz.getCount(id);
				if(count > 1){
					shopCarBiz.updateCount(shopCar);
					json.put("code","0");
					json.put("msg","成功");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code","500");
			json.put("msg","失败");
		}
		return json.toJSONString();
	}


	@PostMapping(value = "user/insertCount")
	@ResponseBody
	public String insertCount(HttpServletRequest request){
		String shopCarId = request.getParameter("id");
		TShopCar shopCar = new TShopCar();
		JSONObject json = new JSONObject();
		try {
			if(shopCarId!=null) {
				int id = Integer.parseInt(shopCarId);
				shopCar.setId(id);
				shopCar.setPcount(1);
			}
			shopCarBiz.updateCount(shopCar);
			json.put("code","0");
			json.put("msg","成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code","500");
			json.put("msg","失败");
		}
		return json.toJSONString();
	}



	@PostMapping(value = "user/order")
	@ResponseBody
	public String getShop(HttpServletRequest request, int[] list, Double allprice, int address,Model model){
	 	String str ;
		TUser user = (TUser) request.getSession().getAttribute("user");
//		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
		if(user!=null){
//			TOrder order = new TOrder();
//			String ono = "o"+sd.format(new Date())+"-"+new Date().getTime();
//			order.setOno(ono);
			TAddress taddress = addressBiz.getAddressById(address);
			orderBiz.addOrder(taddress,allprice,user.getUid(),list);

			str="order.jsp";
		}else{
			model.addAttribute("msg","失败");
			str = "main/error.jsp";
		}

	 	System.out.println(allprice);
		return str;
	}

	@GetMapping(value = "user/getOrder")
	public String toOrder(){
		return "order.jsp";
	}



	@GetMapping(value = "user/justOrder")
	public String justOrder(HttpServletRequest request,String pno ,Model model){
	 	String str;
	 	TProduct product;
		List<TAddress> address ;
	 	try{
			TUser user = (TUser) request.getSession().getAttribute("user");
//			String id = request.getParameter("pno");
			if(pno!=null){
				int pno1 = Integer.parseInt(pno);
				product = productBiz.getProductInfo(pno1);
				if(user!=null){
					address = addressBiz.getAddress(user.getUid());
					model.addAttribute("address",address);
				}
				model.addAttribute("product",product);
				str="justbuy.jsp";
			}else {
				str="main/error.jsp";
			}
		}catch (Exception e){
			e.printStackTrace();
			str="main/error.jsp";
		}

		return str;
	}

	@PostMapping(value = "user/justOrder")
	@ResponseBody
	public String justOrder(HttpServletRequest request,int pno,int address,double allprice,int amount){
		JSONObject json = new JSONObject();
		try {
			TUser user = (TUser) request.getSession().getAttribute("user");
			TAddress taddress = addressBiz.getAddressById(address);
			TProduct product = productBiz.getProductInfo(pno);
			orderBiz.justOrder(product,taddress,allprice,amount,user.getUid());
			json.put("code",200);
			json.put("msg","成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code",500);
			json.put("msg","失败");
		}
		return json.toJSONString();
	}





	@GetMapping(value = "address")
	public String getAddress(HttpServletRequest request,Model model){
	 	String str ;
	 	TUser user = (TUser) request.getSession().getAttribute("user");
	 	List<TAddress> address ;
	 	if(user!=null){
	 		address = addressBiz.getAddress(user.getUid());
			model.addAttribute("address",address);
			str="address.jsp";
		}else{
	 		model.addAttribute("msg","失败");
	 		str = "main/error.jsp";
		}
	 	return str;

	}


	@GetMapping(value = "user/myOrder")
	public String myOrder(HttpServletRequest request,@RequestParam int ostate,Model model){
	 	String str;
		TUser user  = (TUser) request.getSession().getAttribute("user");
		TOrder order = new TOrder();
		order.setUid(user.getUid());
		order.setOstate(ostate);
		List<TOrder> orderlist;
		if(user!=null){
			orderlist = orderBiz.getMyOrder(order);
			System.out.println(orderlist);
			model.addAttribute("orderlist",orderlist);
			str = "order.jsp";
		}else{
			model.addAttribute("msg","用户已失效，请重新登录");
			str = "main/error.jsp";
		}
	 	return str;
	}

	@GetMapping(value = "user/payMoney")

	@Transactional
	public String payMoney(HttpServletRequest request,Model model){
	 	String str;
//		JSONObject json = new JSONObject();
		try {
			TUser user = (TUser) request.getSession().getAttribute("user");
			TProduct product = new TProduct();
			String ono = request.getParameter("ono");
			List<TOrderDetail> list = orderBiz.getOrderDetail(ono);

			double allprice = 0;
			for(TOrderDetail d : list){
				product.setPno(d.getPno());
				product.setCount(d.getAmount());
				productBiz.reduceCount(product);
				allprice = orderBiz.getOrderByOno(ono).getAllprice();
			}
			if(user.getAccount()>allprice){
				TOrder order = new TOrder();
				order.setOno(ono);
				user.setAccount(allprice);
				orderBiz.payOrder(order,user);
				RoleId roleId = vipBiz.getRoleId(user.getUid());
				if(roleId.getRole()!=roleId.getId() && !roleId.getId().equals(roleId.getRole())){
					roleId.setRole(roleId.getId());
					vipBiz.updateRole(roleId);
					TVip vip = vipBiz.getVipInfo(user.getUid());
					request.getSession().setAttribute("vip",vip);
//					json.put("code",0);
//					json.put("msg","根据您的消费额度，以为您升级到"+vip.getVipname());
					model.addAttribute("message","根据您的消费额度，以为您升级到"+vip.getVipname());
				}
//				json.put("code",0);
//				json.put("msg","支付成功，等待发货");
				model.addAttribute("msg","支付成功，等待发货");
				str="main/succeed.jsp";
			}else{
				model.addAttribute("msg","余额不足，请充值");
				str="main/error.jsp";
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg","支付失败，请稍后再试");
			str="main/error.jsp";

		}
		return str;
	}



	@GetMapping(value = "user/upstate")
	@ResponseBody
	public String updatste(String ono,Integer ostate){

	 	JSONObject json = new JSONObject();
		try {TOrder order = new TOrder();
			order.setOno(ono);
			order.setOstate(ostate);
			orderBiz.updateOstate(order);
			json.put("code",0);
			json.put("msg","成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("code",0);
			json.put("msg","失败");
		}
		return json.toJSONString();
	}








}
