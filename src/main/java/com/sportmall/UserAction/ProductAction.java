package com.sportmall.UserAction;

import com.sportmall.biz.CommentBiz;
import com.sportmall.biz.ProductBiz;
import com.sportmall.biz.UserBiz;
import com.sportmall.biz.typeBiz;
import com.sportmall.entity.TComment;
import com.sportmall.entity.TProduct;
import com.sportmall.entity.TProductType;
import com.sportmall.entity.TUser;
import com.sportmall.entity.dto.TProductCondition;
import com.sportmall.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ProductAction {

	@Autowired
	private ProductBiz productBiz;
	@Autowired
	private typeBiz typeBiz;
	@Autowired
	private UserBiz userBiz;
	@Autowired
	private CommentBiz commentBiz;

	@RequestMapping(path="/home",method=RequestMethod.GET)
	public String home(HttpServletRequest request,Model model) {
		String str;

		Object  obj = request.getSession().getAttribute("user");
		if(obj == null){
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
				for(int i = 0; i < cookies.length; i++){
					Cookie cookie = cookies[i];
					if(cookie.getName().equals("user")){
						if("".equals(cookie.getValue())){
							break;
						}else{
							String value = cookie.getValue();
							String [] upwd = value.split(",");
							System.out.print(upwd[0]+","+upwd[1]);
							try{

								TUser user = userBiz.login(upwd[0], upwd[1]);
								if(user != null){
									request.getSession().setAttribute("user", user);
								}
							}catch(Exception e){
								e.printStackTrace();
								Log.logger.error(e.getMessage(),e);
							}
							break;
						}
					}
				}
			}
		}

		String no = request.getParameter("typeno");
		String pname = request.getParameter("pname");
		TProductCondition tProductCondition = new TProductCondition();
		TProductType productType = new TProductType();
		try {
			if(no!=null && no.length()>0){
				tProductCondition.setTypeno(no);
			}
		if(pname!=null && !pname.equals("")){
				tProductCondition.setPname(pname);
			}
			tProductCondition.setPstate(1);
			tProductCondition.setMaxSize(100);
			productType.setMaxSize(1000);
			productType.setTypestate(1);
			List<TProduct> list = productBiz.getAllProducts(tProductCondition);
			List<TProductType> typelist = typeBiz.getAllType(productType);
			int count = productBiz.productCount(tProductCondition);
			model.addAttribute("count",count);
			model.addAttribute("list",list);
			model.addAttribute("typelist",typelist);
			str = "/home.jsp";
		} catch (Exception e) {
			Log.logger.error(e.getMessage(),e);
			model.addAttribute("msg", "网络异常，请和管理员联系");
			str = "/main/error.jsp";
		}
		return str;
	}


//	@GetMapping(value = "/home-pname")
//	public String getProductByName(HttpServletRequest request){
//		String pname = request.getParameter("pname");
//
//		if(pname!=null && !pname.equals("")){
//
//		}
//	}







	@RequestMapping("/pic")
	@ResponseBody
	public byte[] getPic(Integer pno){
		byte[] pic = null;
		if(pno != null && !pno.equals(0)){
			try {
				pic = productBiz.getPic(pno);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return pic;
	}

	@GetMapping(value = "/proInfo")
	public String productInfo(HttpServletRequest request,Model model){
		String str;
		Integer pno = Integer.parseInt(request.getParameter("pno"));
		List<TComment> comments ;
		try {
			TProduct product = productBiz.getProductInfo(pno);
			comments = commentBiz.getCommentByPno(pno);
			model.addAttribute("comments",comments);
			model.addAttribute("product",product);
			str = "product-info.jsp";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg","获取信息失败，请重试");
			str = "main/error.jsp";
		}
		return str;
	}

}
