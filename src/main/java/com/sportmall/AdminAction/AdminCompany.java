package com.sportmall.AdminAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.CompanyBiz;
import com.sportmall.entity.TCompany;
import com.sportmall.util.JBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.FaultAction;
import java.util.List;

@Controller
@RequestMapping("/com")
public class AdminCompany {

    @Autowired
    private CompanyBiz companyBiz;

    @GetMapping(value = "/companys")
    public String getCompanys(){
        return "admin/company-list.jsp";
    }

    @GetMapping(value = "/getCompanys")
    @ResponseBody
    public String Companys(TCompany company, @RequestParam int page,@RequestParam int limit){
        int startResult = (page-1)*limit;
        company.setStartResult(startResult);
        company.setMaxSize(limit);
        JBean jBean = new JBean();
        try {
            List<TCompany> list = companyBiz.getCompanys(company);
            int count = companyBiz.getCounts(company);
            jBean = JBean.by(0,"成功",list,count);
        } catch (Exception e) {
            e.printStackTrace();
            e.printStackTrace();
            jBean.set(-1,"失败");
        }
        return jBean.toJson();
    }

    @GetMapping(value ="/send-company")
    public String SendCompanys(@RequestParam String ono, Model model){
        String str ;
        try {
            TCompany company = new TCompany();
            company.setCstate(1);
            List<TCompany> list = companyBiz.getCompanys(company);
            model.addAttribute("ono",ono);
            model.addAttribute("list",list);
            str="admin/send-company.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","内部服务器异常");
            str="main/error.jsp";
        }
        return str;
    }



    //状态改变
    @GetMapping(value = "/upstate")
    @ResponseBody
    public String downProduct(Integer cid,Integer cstate){
        JSONObject json = new JSONObject();
        TCompany company = new TCompany();
        if(cid!=null){
            company.setCid(cid);
            company.setCstate(cstate);
            companyBiz.companyState(company);
            json.put("code",200);
            json.put("msg","下架成功");
        }
        return json.toJSONString();
    }



    @GetMapping(value = "/editCompany")
    public String editCompany(@RequestParam int cid, Model model){
        String str;
        TCompany company;
        try {
            company = companyBiz.getInfo(cid);
            model.addAttribute("company",company);
            str = "admin/company-update.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","服务器异常");
            str = "main/error.jsp";
        }
        return str;
    }

    @PostMapping(value ="/updateCompany")
    @ResponseBody
    public String updateCompany(Integer cid,String cname,String ctel,String cweb){
        JSONObject json = new JSONObject();
        TCompany company = new TCompany();
        company.setCid(cid);
        company.setCname(cname);
        company.setCtel(ctel);
        company.setCweb(cweb);
        try {
            companyBiz.updateCompany(company);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }

    @GetMapping(value = "/toAddCompany")
    public String addCompany(){
        return "admin/company-add.jsp";
    }

    @PostMapping(value = "/insertCompany")
    @ResponseBody
    public String insertCompany(TCompany company){
        JSONObject json = new JSONObject();
        try {
            company.setCstate(1);
            companyBiz.insertCompany(company);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }












}
