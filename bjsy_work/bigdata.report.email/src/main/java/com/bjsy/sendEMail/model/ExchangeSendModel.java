package com.bjsy.sendEMail.model;

import java.util.List;

/**
 * Created by LYS on 2019/1/30.
 */
public class ExchangeSendModel {

    private  String subject;
    private  String recipientTo;
    private  String recipientCc;
    private  List<String> recipientBcc;
    private  String attachments;
    private  String message;
    private  String waringUser;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getRecipientTo() {
        return recipientTo;
    }

    public void setRecipientTo(String recipientTo) {
        this.recipientTo = recipientTo;
    }

    public String getRecipientCc() {
        return recipientCc;
    }

    public void setRecipientCc(String recipientCc) {
        this.recipientCc = recipientCc;
    }

    public List<String> getRecipientBcc() {
        return recipientBcc;
    }

    public void setRecipientBcc(List<String> recipientBcc) {
        this.recipientBcc = recipientBcc;
    }

    public String getAttachments() {
        return attachments;
    }

    public void setAttachments(String attachments) {
        this.attachments = attachments;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


    public String getWaringUser() {
        return waringUser;
    }

    public void setWaringUser(String waringUser) {
        this.waringUser = waringUser;
    }

    @Override
    public String toString() {
        return "ExchangeSendModel{" +
                "subject='" + subject + '\'' +
                ", recipientTo='" + recipientTo + '\'' +
                ", recipientCc='" + recipientCc + '\'' +
                ", recipientBcc=" + recipientBcc +
                ", attachments=" + attachments +
                ", message='" + message + '\'' +
                '}';
    }
}
