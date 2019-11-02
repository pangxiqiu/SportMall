package com.sportmall.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class PicUpload {

    public static String getPic(MultipartFile file) throws IOException {
        if (file!=null){

            //图片上传成功后，将图片的地址写到数据库
            String filePath = "D:\\sportmall-image";//保存图片的路径,tomcat中有配置
            //获取原始图片的拓展名
            String originalFilename = file.getOriginalFilename();
            //新的文件名字，使用uuid随机生成数+原始图片名字，这样不会重复
            String newFileName = UUID.randomUUID()+originalFilename;
            //封装上传文件位置的全路径，就是硬盘路径+文件名
            File targetFile = new File(filePath,newFileName);
            //把本地文件上传到已经封装好的文件位置的全路径就是上面的targetFile
            file.transferTo(targetFile);
            return newFileName;
        }else{
            return null;
        }
    }
}
