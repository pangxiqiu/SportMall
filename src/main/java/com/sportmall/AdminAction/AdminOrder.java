package com.sportmall.AdminAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.OrderBiz;
import com.sportmall.biz.ProductBiz;
import com.sportmall.entity.TOrder;
import com.sportmall.entity.TOrderDetail;
import com.sportmall.entity.TProduct;
import com.sportmall.entity.dto.TOrderCondition;
import com.sportmall.util.JBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/Order")
public class AdminOrder {

    @Autowired
    private OrderBiz orderBiz;
    @Autowired
    private ProductBiz productBiz;


    @GetMapping(value = "/Orders")
    public String getOrders(){
        return "admin/order-list.jsp";
    }

    @GetMapping(value = "/getAllOrders")
    @ResponseBody
    public String getAllOrders(TOrderCondition orderCondition, @RequestParam int page, @RequestParam int limit){
        int startResult = (page-1)*limit;
        orderCondition.setStartResult(startResult);
        orderCondition.setMaxSize(limit);
        JBean jBean = new JBean();
        try {
            List<TOrder> list = orderBiz.getAllOrders(orderCondition);
            int count = orderBiz.getOrderCounts(orderCondition);
            jBean = JBean.by(0,"成功",list,count);
        } catch (Exception e) {
            e.printStackTrace();
            e.printStackTrace();
            jBean.set(-1,"失败");
        }
        return jBean.toJson();
    }


    @PostMapping(value = "/updateOstate")
    @ResponseBody
    public String updateOstate(TOrder order){
        JSONObject json = new JSONObject();
        try {
            order.setSenddate(new Date());
            order.setOstate(3);
            orderBiz.updateOstate(order);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }

    @GetMapping(value = "/sendedOstate")
    @ResponseBody
    public String sendOstate(Integer ostate,String ono){
        JSONObject json = new JSONObject();
        try {
            TOrder order = new TOrder();
            order.setOno(ono);
            order.setOstate(ostate);
            orderBiz.updateOstate(order);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }







    @GetMapping(value = "/orderDetail")
    public String orderDetail(@RequestParam String ono, Model model){
        String str;
        try {
            if(ono!=null && !ono.equals("")){
                List<TOrderDetail> list = orderBiz.getOrderDetail(ono);
                TProduct product;
                for(TOrderDetail d:list){
                    product = productBiz.getProductInfo(d.getPno());
                    d.setPname(product.getPname());
                    d.setImage(product.getImage());
                }
                TOrder order = orderBiz.getOrderByOno(ono);
                model.addAttribute("list",list);
                model.addAttribute("order",order);
                str = "admin/order-detail.jsp";
            }else{
                model.addAttribute("msg","服务器异常");
                str="main/error.jsp";
            }
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg","服务器异常");
            str="main/error.jsp";
        }
        return str;
    }







}
