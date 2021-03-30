package com.bjsy.sendEMail.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Component;

@Component
public class FileUtil {

	public static void saveExcel(HSSFWorkbook workbook, String filepath) {
		File file = new File(filepath);
		try {
            File parentFile=file.getParentFile();
			if (!parentFile.exists()) {
				parentFile.mkdirs();
			}
//			System.out.println(parentFile.getAbsolutePath());
			if (!file.exists()) {
				file.createNewFile();
			}
			FileOutputStream out = new FileOutputStream(filepath);
			workbook.write(out);// 保存Excel文件
			out.close();// 关闭文件流
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
