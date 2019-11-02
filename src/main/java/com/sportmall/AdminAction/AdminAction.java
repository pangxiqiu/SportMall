package com.sportmall.AdminAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.*;
import com.sportmall.entity.TProduct;
import com.sportmall.entity.TProductType;
import com.sportmall.entity.TUser;
import com.sportmall.entity.TVip;
import com.sportmall.entity.dto.TProductCondition;
import com.sportmall.entity.dto.TUserCondition;
import com.sportmall.entity.dto.adminData;
import com.sportmall.util.Log;
import com.sportmall.util.JBean;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/back")
public class AdminAction {

    @Autowired
    private adminBiz adminBiz;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private ProductBiz productBiz;
    @Autowired
    private VipBiz vipBiz;
    @Autowired
    private typeBiz typeBiz;



    @RequestMapping(value="getAllProducts",method= RequestMethod.GET)
    public String getAllProducts(Model model){
        String str;
        TProductType productType = new TProductType();
        productType.setStartResult(0);
        productType.setMaxSize(99999);
        try {
            List<TProductType> list = typeBiz.getAllType(productType);
            model.addAttribute("list",list);
            str = "admin/product-list.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            str ="main/error.jsp";
        }

        return str;
    }

    @RequestMapping(path="/adminindex",method=RequestMethod.GET)
    public String index(){
        return "admin/main.jsp";
    }


    @RequestMapping(path="/addType",method=RequestMethod.GET)
    public String addType(){
        return "admin/addType.jsp";
    }

//    @PostMapping(value = "/addType")
//    public String addType(TProductType productType,Model model){
//        String str = null;
//        try {
//            productBiz.addType(productType);
//            model.addAttribute("msg",productType.getTypename()+"添加成功");
//            str = "admin/addType.jsp";
//        } catch (Exception e) {
//            e.printStackTrace();
//            str = "main/error.jsp";
//        }
//        return str;
//    }

    @GetMapping(value = "/getProducts")
    @ResponseBody
    public String  getProducts(TProductCondition  productCondition,@RequestParam int page,@RequestParam int limit){
        int startResult = (page-1)*limit;
        productCondition.setStartResult(startResult);
        productCondition.setMaxSize(limit);
        JBean jBean = new JBean();
        try {
            List<TProduct> list = productBiz.getAllProducts(productCondition);
            int count = productBiz.productCount(productCondition);
            jBean = JBean.by(0,"成功",list,count);
        } catch (Exception e) {
            e.printStackTrace();
            jBean.set(-1,"失败");
        }
            return jBean.toJson();
    }

    @GetMapping(value = "product-image")
    public String productImage(@RequestParam int pno,Model model){
        String str;
        TProduct product;
        try {
            product = productBiz.getProductInfo(pno);
            model.addAttribute("product",product);
            str = "admin/product-image.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","服务器异常");
            str = "main/error.jsp";
        }
        return str;
    }


    //上  下   架
    @GetMapping(value = "product-down")
    @ResponseBody
    public String downProduct(Integer pno,Integer pstate){
        JSONObject json = new JSONObject();
        if(pno!=null){
            productBiz.deleteProduct(pno,pstate);
            json.put("code",200);
            json.put("msg","下架成功");
        }
        return json.toJSONString();
    }

    //补充库存
    @GetMapping(value = "addProductCount")
    @ResponseBody
    public String addProductCount(Integer pno,Integer count){
        JSONObject json = new JSONObject();
        if(pno!=null){
            productBiz.addProductCount(pno,count);
            json.put("code",200);
            json.put("msg","补充成功");
        }
        return json.toJSONString();
    }


    @GetMapping(value = "/productAdd")
    public String productAdd(Model model){
        String str ;
        TProductType productType = new TProductType();
        productType.setMaxSize(1000);
        try {
            productType.setTypestate(1);
            List<TProductType> list = typeBiz.getAllType(productType);
            model.addAttribute("list",list);
            str = "admin/product-add.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            str = "main/error.jsp";
        }
        return str;
    }

    @GetMapping(value = "editProduct")
    public String editProduct(@RequestParam int pno, Model model){
        String str;
        try {
            TProduct product = productBiz.getProductInfo(pno);
            model.addAttribute("product",product);
            str = "admin/product-edit.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","服务器异常");
            str = "main/Aerror.jsp";
        }
        return str;
    }

    @PostMapping(value = "updateProduct")
    public String updateProduct(
                                @RequestParam("pno") String pno,
                                @RequestParam("pname") String pname,
                                @RequestParam("pstate") Integer pstate,
                                @RequestParam("vender") String vender,
                                @RequestParam("pubdate") String pubdate,
                                @RequestParam("price") Double price,
                                @RequestParam("pdesc") String pdesc,
                                @RequestParam("pic") MultipartFile pic,
                                @RequestParam("pic1") MultipartFile pic1,
                                @RequestParam("pic2") MultipartFile pic2,Model model){
        TProduct product = new TProduct();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String str;
        Date date = new Date();
        try {
            if(pubdate!=null&&!pubdate.equals("")){
                date = format.parse(pubdate);
            }
            product.setPno(Integer.parseInt(pno));
            product.setPname(pname);
            product.setPstate(pstate);
            product.setVender(vender);
            product.setPubdate(date);
            product.setPrice(price);
            product.setPdesc(pdesc);
            productBiz.updateProduct(product,pic,pic1,pic2);
            model.addAttribute("msg",pname+" -修改成功");
            str = "main/Asucceed.jsp";
        } catch (Exception e) {
            e.printStackTrace();

            model.addAttribute("msg","修改失败");
            str = "main/Aerror.jsp";
        }
        return str;



    }




    //图片上传，添加路径
    @PostMapping(value = "addProductInfo")
//    @ResponseBody
    public String addProductInfo(@RequestParam("pname") String pname,
                                 @RequestParam("typeno") Integer typeno,
                                 @RequestParam("pstate") Integer pstate,
                                 @RequestParam("vender") String vender,
                                 @RequestParam("pubdate") String pubdate,
                                 @RequestParam("price") Double price,
                                 @RequestParam("pdesc") String pdesc,
                                 @RequestParam("count") Integer count,
                                 @RequestParam("pic") MultipartFile pic,
                                 @RequestParam("pic1") MultipartFile pic1,
                                 @RequestParam("pic2") MultipartFile pic2,Model model){
        TProduct product = new TProduct();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String str;
        JSONObject json = new JSONObject();
        Date date = new Date();
        try {
            if(pubdate!=null&&!pubdate.equals("")){
               date = format.parse(pubdate);
            }
            product.setPname(pname);
            product.setTypeno(typeno);
            product.setPstate(pstate);
            product.setVender(vender);
            product.setPubdate(date);
            product.setPrice(price);
            product.setPdesc(pdesc);
            product.setCount(count);
            productBiz.addProduct(product,pic,pic1,pic2);
            json.put("code",0);
            json.put("msg","成功");
            model.addAttribute("msg",pname+" -添加成功");
            str = "main/Asucceed.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
            model.addAttribute("msg","添加失败");
            str = "main/Aerror.jsp";
        }
        return str;
    }




    /**
     * 获取用户信息
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/getUsers")
    public String getAlluers(HttpServletRequest request,Model model){
        String str = null;
        TUserCondition userCondition = new TUserCondition();
        try {
            String uname = request.getParameter("uname");
            String tel = request.getParameter("tel");
            String role = request.getParameter("role");
            if(role!=null){
                userCondition.setRole(Integer.parseInt(role));
            }

            userCondition.setUname(uname);
            userCondition.setTel(tel);
            List<TVip> viplist = vipBiz.getAllVip();
            List<TUser> list = userBiz.getAllUsers(userCondition);
            if(list!=null){
                model.addAttribute("list",list);
                model.addAttribute("viplist",viplist);
                model.addAttribute("userCondition",userCondition);
                str = "admin/users-list.jsp";
            }
        } catch (Exception e) {
           e.printStackTrace();
            model.addAttribute("msg","暂无数据");
            str = "admin/users-list.jsp";
        }
        return str;
    }



    //获取用户信息json
    @GetMapping(value = "/getUser")
    @ResponseBody
    public String getAllUer(TUserCondition userCondition,@RequestParam int page,@RequestParam int limit){
        int startResult = (page-1)*limit;
        userCondition.setStartResult(startResult);
        userCondition.setMaxSize(limit);
        JSONObject json = new JSONObject();
        try {
            List<TUser> list = userBiz.getAllUsers(userCondition);
            int count = userBiz.getCount(userCondition);

            json.put("code",0);
            json.put("msg","成功");
            json.put("count",count);
            json.put("data",list);

        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",500);
            json.put("msg","服务器异常，暂无数据");
        }
        return json.toJSONString();
    }


    @PostMapping(value = "/repwd")
    public void updatePwd(HttpServletRequest request, HttpServletResponse response){
        String str = request.getParameter("uid");
        TUser user = new TUser();
        JSONObject jsonObject = new JSONObject();

        try {
            if(str!=null && str.length()>0){
                int uid = Integer.parseInt(str);
                user.setUid(uid);
                user.setPwd("123456");
            }
            int res_count = userBiz.updatePassword(user);
            if(res_count>0){
                jsonObject.put("state", res_count > 0 ? true:false);
                jsonObject.put("code",0);
                jsonObject.put("msg","成功");
                response.getWriter().print(jsonObject);
            }else{
                jsonObject.put("state", -1);
                jsonObject.put("code",500);
                jsonObject.put("msg","重置失败");
                response.getWriter().print(jsonObject);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("state", -1);
            jsonObject.put("code",500);
            jsonObject.put("msg","重置失败");
            try {
                response.getWriter().print(jsonObject);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }



    //后台首页
    @GetMapping(value = "/adminhome")
    public String adminHome(Model model){
        String str;

        try {
            int userCount = adminBiz.userCount();
            int vipCount = adminBiz.vipCount();
            int companyCount = adminBiz.companyCount();
            int orderCount = adminBiz.orderCount();
            int productCount = adminBiz.productCount();
            int commentCount = adminBiz.commentCount();
            adminData adminData = new adminData();
            adminData.setUserCount(userCount);
            adminData.setCompanyCount(companyCount);
            adminData.setOrderCount(orderCount);
            adminData.setProductCount(productCount);
            adminData.setVipCount(vipCount);
            adminData.setCommentCount(commentCount);
            model.addAttribute("adminData",adminData);
            Log.logger.info(userCount+vipCount+companyCount+orderCount+productCount);
            str = "admin/welcome.jsp";
            return str;
        } catch (Exception e) {
            e.printStackTrace();
            str = "main/error.jsp";
        }
        return str;
    }


}
