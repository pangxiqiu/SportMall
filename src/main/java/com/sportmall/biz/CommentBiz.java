package com.sportmall.biz;

import com.sportmall.dao.IcommentMapper;
import com.sportmall.entity.TComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentBiz {

    @Autowired
    private IcommentMapper commentMapper;

    /**
     * 获取商品评价
     * @param pno
     * @return
     */
    public List<TComment> getCommentByPno(int pno)throws Exception{
        return commentMapper.getCommentByPno(pno);
    }

    /**
     * 获取商品评价总数
     * @param pno
     * @return
     */
    public Integer getCommentCount(int pno)throws Exception{
        return commentMapper.getCommentCount(pno);
    }

    /**
     * 添加评论
     * @param comment
     */
    public  void insertComment(TComment comment)throws Exception{
        commentMapper.insertComment(comment);
    }

    /**
     * 删除评价
     * @param id
     * @return
     */
    public  int deleteComment(int id)throws Exception{
        return commentMapper.deleteComment(id);
    }

    /**
     * 修改评价
     * @param comment
     * @return
     */
    public int updateComment(TComment comment)throws Exception{
        return commentMapper.updateComment(comment);
    }
}
