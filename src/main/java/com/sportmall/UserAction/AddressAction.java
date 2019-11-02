package com.sportmall.UserAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.addressBiz;
import com.sportmall.entity.TAddress;
import com.sportmall.entity.TUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;

@Controller
public class AddressAction {

    @Autowired
    private addressBiz addressBiz;

    @GetMapping(value = "/add-Address")
    public String toInsertAddress(){
        return "address-add.jsp";
    }

    @PostMapping(value = "/address-add")
    @ResponseBody
    public String addAddress(HttpServletRequest request, String address, String receiver, String tel){
        JSONObject json = new JSONObject();
        try {
            TUser user = (TUser) request.getSession().getAttribute("user");
            TAddress taddress = new TAddress();
            taddress.setUid(user.getUid());
            taddress.setAddress(address);
            taddress.setReceiver(receiver);
            taddress.setTel(tel);
            addressBiz.addAddress(taddress);
            json.put("code","200");
            json.put("msg","地址添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code","500");
            json.put("msg","地址添加失败，服务器异常");
        }
        return json.toJSONString();
    }


    @GetMapping(value = "/deleteAddress")
    @ResponseBody
    public String deleteAddress(int id){
        JSONObject json = new JSONObject();
        int a;
        try {
            a = addressBiz.deleteAddress(id);
            if(a>0){
                json.put("code","200");
                json.put("msg","删除成功");
            }else{
                json.put("code","-1");
                json.put("msg","删除失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code","500");
            json.put("msg","内部服务器异常");
        }
        return json.toJSONString();
    }

    @GetMapping(value = "/to-upAddress")
    public String toUpAddress(@RequestParam int id, Model model){
        String str ;
        try {
            TAddress address = addressBiz.getAddressById(id);
            model.addAttribute("taddress",address);
            str = "address-update.jsp";
        }catch (Exception e){
            model.addAttribute("msg","暂时无法修改");
            str = "main/error.jsp";
        }
        return str;
    }



    @PostMapping(value = "/address-update")
    @ResponseBody
    public String updateAddress(String address, String receiver, String tel,int id){
        JSONObject json = new JSONObject();
        try {

            TAddress taddress = new TAddress();
            taddress.setId(id);
            if(address!=null && !address.equals("")){
                taddress.setAddress(address);
            }
            if(receiver!=null && !receiver.equals("")){
                taddress.setReceiver(receiver);
            }
            if(tel!=null && !tel.equals("")){
                taddress.setTel(tel);
            }
            addressBiz.updateAddress(taddress);
            json.put("code",200);
            json.put("msg","地址修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",500);
            json.put("msg","地址修改失败，服务器异常");
        }
        return json.toJSONString();
    }



}
