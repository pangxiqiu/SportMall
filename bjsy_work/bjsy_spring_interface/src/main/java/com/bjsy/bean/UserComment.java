package com.bjsy.bean;

/**
 * Create chenqinping 2019/12/4
 */
public class UserComment {
    /**
     * 作者
     */
    private String authorName;
    /**
     * 评分
     */
    private String score;
    /**
     * 评论日期
     */
    private String time;
    private String author_id;
    /**
     * 我是评论
     */
    private String content;

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(String author_id) {
        this.author_id = author_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
