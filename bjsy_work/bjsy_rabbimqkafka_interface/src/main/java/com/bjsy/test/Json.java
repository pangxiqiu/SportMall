package com.bjsy.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.io.*;

/**
 * Create chenqinping 2020/3/1
 */
public class Json {

    public static class Fozu {

        public static void main(String[] args) {
            readFileByLines("C:\\Users\\chenq\\Desktop\\2\\oc_orderdetail_20200228.json","C:\\Users\\chenq\\Desktop\\2\\detail.json");
        }

        public static void readFileByLines(String pactFile,String path) {

            StringBuffer strbuffer = new StringBuffer();
            File myFile = new File(pactFile);//"D:"+File.separatorChar+"DStores.json"
            if (!myFile.exists()) {
                System.err.println("Can't Find " + pactFile);
            }
            try {
                FileInputStream fis = new FileInputStream(pactFile);
                InputStreamReader inputStreamReader = new InputStreamReader(fis, "UTF-8");
                BufferedReader in = new BufferedReader(inputStreamReader);

                String str;
                while ((str = in.readLine()) != null) {
                    strbuffer.append(str);  //new String(str,"UTF-8")


                }
                in.close();
            } catch (IOException e) {
                e.getStackTrace();
            }
            //System.out.println("读取文件结束util");
            System.out.println(strbuffer.toString());
            try {
                File file = new File(path);
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                file.createNewFile();
                if (strbuffer.toString() != null && !"".equals(strbuffer.toString())) {
                    FileOutputStream fos = new FileOutputStream(file);
                    OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
                    osw.write(strbuffer.toString());
                    osw.flush();
                    osw.close();
                    System.out.println("执行完毕!");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }


            /**
             * str:    要写入的文件内容   例如:{\"id\":1777944995971746430,\"frName\":\"会议纪要\",\"createDate\":\"2018-7-11\"}
             * path：      文件具体路径        例如:D:/111/2018/7/11/会议纪要.json
             */

            /*try {
                File file = new File(path);
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                file.createNewFile();
                if (str != null && !"".equals(str)) {
                    FileOutputStream fos = new FileOutputStream(file);
                    OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
                    osw.write(str);
                    osw.flush();
                    osw.close();
                    System.out.println("执行完毕!");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }*/

        }

    }


}
