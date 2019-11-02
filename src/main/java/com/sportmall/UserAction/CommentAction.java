package com.sportmall.UserAction;

import com.alibaba.fastjson.JSONObject;
import com.sportmall.biz.CommentBiz;
import com.sportmall.biz.OrderBiz;
import com.sportmall.biz.ProductBiz;
import com.sportmall.entity.TComment;
import com.sportmall.entity.TOrderDetail;
import com.sportmall.entity.TProduct;
import com.sportmall.entity.TUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CommentAction {

    @Autowired
    private CommentBiz commentBiz;
    @Autowired
    private OrderBiz orderBiz;
    @Autowired
    private ProductBiz productBiz;

    @GetMapping(value = "user/getComments")
    public String getComments(@RequestParam String ono,Integer pno, Model model){
        String str ;
        try {
            TOrderDetail detail = orderBiz.isComment(ono,pno);
            TProduct product = productBiz.getProductInfo(pno);
            model.addAttribute("detail",detail);
            model.addAttribute("product",product);
            str = "comments.jsp";
        } catch (Exception e) {
            model.addAttribute("msg","暂时无响应，请稍后再试");
            str = "main/error.jsp";
        }
        return str;
    }


    @PostMapping(value = "user/addComments")
    @ResponseBody
    @Transactional
    public String addComments(HttpServletRequest request, Integer pno, String udesc,String ono){
        JSONObject json = new JSONObject();
        try {
            TUser user = (TUser) request.getSession().getAttribute("user");
            TComment comment = new TComment();
            comment.setPno(pno);
            comment.setUdesc(udesc);
            comment.setUid(user.getUid());
            comment.setUname(user.getUname());
            comment.setTdate(new Date());
            commentBiz.insertComment(comment);
            int a = orderBiz.isCommpented(ono,pno);
            if(a>0){
                json.put("code",0);
                json.put("msg","评论成功");
            }else {
                json.put("code",-1);
                json.put("msg","评论失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("code",-1);
            json.put("msg","网络不顺畅，请稍后再试");
        }
        return json.toJSONString();
    }
}
