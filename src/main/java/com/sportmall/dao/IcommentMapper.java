package com.sportmall.dao;

import com.sportmall.entity.TComment;

import java.util.List;

public interface IcommentMapper {

    List<TComment> getCommentByPno(int pno);

    Integer getCommentCount(int pno);

    void insertComment(TComment comment);

    int deleteComment(int id);

    int updateComment(TComment comment);


}
