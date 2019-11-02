package com.sportmall.AdminAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.typeBiz;
import com.sportmall.entity.TProductType;
import com.sportmall.util.JBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/adminType")
public class AdminType {

    @Autowired
    private typeBiz typeBiz;

    @GetMapping(value = "/getAllType")
    public String getAllType(HttpServletRequest request,Model model){
        String str = null;
        List<TProductType> list = null;
        try {
            TProductType tProductType = new TProductType();

            String state = request.getParameter("typestate");
            String typename = request.getParameter("typename");
            if(state!=null && !state.equals("")){
                int typestate = Integer.parseInt(state);
                tProductType.setTypestate(typestate);
            }
            if(typename !=null && !typename.equals("")){
                tProductType.setTypename(typename);
            }
            System.out.println(tProductType.getTypename()+tProductType.getTypestate());
            list = typeBiz.getAllType(tProductType);
            for(TProductType t : list){
                System.out.println(t.getTypename());
            }
            model.addAttribute("list",list);
            str = "admin/type-list.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            str = "main/error.jsp";
        }

        return str;
    }


    @GetMapping(value = "/getTypes")
    @ResponseBody
    public String getTypes(TProductType productType, @RequestParam int page,@RequestParam int limit){
        int startResult = (page-1)*limit;
        productType.setStartResult(startResult);
        productType.setMaxSize(limit);
        JBean jBean = new JBean();
        try {
            List<TProductType> list = typeBiz.getAllType(productType);
            int count = typeBiz.getCount(productType);
            jBean = JBean.by(0,"成功",list,count);

        } catch (Exception e) {
            e.printStackTrace();
            jBean.set(-1,"失败");
        }
        return jBean.toJson();
    }

    @GetMapping(value = "/typestate")
    @ResponseBody
    public String updateState(Integer typeno,Integer typestate){
        JSONObject json = new JSONObject();
        try {
            TProductType productType = new TProductType();
            productType.setTypeno(typeno);
            productType.setTypestate(typestate);
            typeBiz.updateType(productType);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }


    @GetMapping(value = "/editType")
    public String eidtType(@RequestParam Integer typeno,Model model){
        String str;
        try {
            TProductType productType = typeBiz.getTypeInfo(typeno);
            model.addAttribute("productType",productType);
            str = "admin/type-edit.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg","服务器异常");
            str = "main/error.jsp";
        }
        return str;
    }

    @PostMapping(value ="/updateType")
    @ResponseBody
    public String updateType(Integer typeno,String typename){
        JSONObject json = new JSONObject();
        TProductType productType = new TProductType();
        try {
            productType.setTypeno(typeno);
            productType.setTypename(typename);
            typeBiz.updateType(productType);
            json.put("code",0);
            json.put("msg","成功");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","失败");
        }
        return json.toJSONString();
    }






    @GetMapping(value = "/addType")
    public String addType(){
        return "admin/type-add.jsp";
    }

    @PostMapping(value = "/addTyped")
    @ResponseBody
    public String addType(HttpServletRequest request){
        String str = null;
        try {
            TProductType tProductType = new TProductType();
            tProductType.setTypename(request.getParameter("typename"));
            tProductType.setTypestate(Integer.parseInt(request.getParameter("typestate")));
            System.out.println(tProductType.getTypename()+tProductType.getTypestate());
            typeBiz.addType(tProductType);
            str="adminType/getAllType.do";
        } catch (Exception e) {
            e.printStackTrace();
            str="main/error.jsp";
        }
        return str;
    }




}
