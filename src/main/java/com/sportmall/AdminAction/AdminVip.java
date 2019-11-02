package com.sportmall.AdminAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.VipBiz;
import com.sportmall.entity.TVip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/back")
public class AdminVip {

    @Autowired
    private VipBiz vipBiz;

    @GetMapping(value = "/getAllVip")
    public String getAllVip(Model model) {
        String str = null;
        try {
            List<TVip> list = vipBiz.getAllVip();
            model.addAttribute("list", list);
            str = "admin/vip-list.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "获取vip列表失败");
            str = "main/error.jsp";
        }

        return str;
    }

    @PostMapping(value = "/addVip")
    public String addVip(HttpServletRequest request) {
        String str = null;
        try {
            TVip vip = new TVip();
            vip.setVipname(request.getParameter("vipname"));
            vip.setState(Integer.parseInt(request.getParameter("state")));
            vip.setDiscount(Double.parseDouble(request.getParameter("discount")));
            vip.setIspostage(Integer.parseInt(request.getParameter("ispostage")));
            vipBiz.addVip(vip);
            str = "";
        } catch (Exception e) {
            e.printStackTrace();
            str = "";
        }
        return str;
    }


    @GetMapping(value = "/editVip")
    public String toeditVip(@RequestParam Integer id, Model model) {
        String str;
        try {
            if (id != null && id != 0) {
                TVip vip = vipBiz.getVip(id);
                model.addAttribute("vip", vip);
                str = "admin/vip-edit.jsp";
            } else {
                model.addAttribute("msg", "参数有误");
                str = "main/error.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "服务器异常，请稍后再试");
            str = "main/error.jsp";
        }
        return str;
    }


    @PostMapping(value = "/updateVip")
    @ResponseBody
    public String updateVip(TVip vip){
        JSONObject json = new JSONObject();
        try {
            vipBiz.updateVip(vip);
            json.put("code",0);
            json.put("msg","修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","修改失败");
        }
        return json.toJSONString();
    }


}