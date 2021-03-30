package com.bjsy.sendEMail.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


@Component
public class PrestoUtil {

	private final static Logger logger = Logger.getLogger(PrestoUtil.class);

	private static String driverName = "com.facebook.presto.jdbc.PrestoDriver";

	String url;

	public void setUrl(String url) {
		this.url = url;
	}

	private static String user;

	private static String password;

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private String dt1 = sdf.format(new Date(System.currentTimeMillis() - 60 * 60 * 1000 * 24));
	private String dt;

	public void setDt(String dt) {
		this.dt = dt;
	}

	@Value("${hive.username}")
	public void setUser(String user) {
		PrestoUtil.user = user;
	}

	@Value("${hive.password}")
	public void setPassword(String password) {
		PrestoUtil.password = password;
	}

	private Connection getConn() throws ClassNotFoundException, SQLException {
		Class.forName(driverName);
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
	}

	
	/**
	 * <p>方法描述:查询hive表，将结果封装成一个list </p>
	 * @param sql
	 * @return
	 * <p>创建人：ck</p>
	 * <p>创建时间：2019年6月20日 下午11:13:59</p>
	 */
	public List<Map<String, Object>> executeSql(String sql) {
		Statement stmt = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try (Connection conn = getConn()) {
			stmt = conn.createStatement();
			logger.info("Running:" + sql);
			ResultSet res = stmt.executeQuery(sql);
			while (res.next()) {
				int u = res.getMetaData().getColumnCount();
				Map<String, Object> obj = new HashMap<String, Object>();
				for (int i = 1; i <= u; i++) {
					String colname = res.getMetaData().getColumnName(i);
					Object value = res.getObject(i);
					String[] colnames = colname.split("\\.");
					String col = colnames[colnames.length - 1];
					obj.put(col, value);
					// System.out.println(col+" "+value);
				}
				list.add(obj);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new RuntimeException();
		}
		return list;
	}

	/**
	 * <p>方法描述: 查询hive表，将结果封装到workbook中，针对查询数据过多，一个sheet页存储行数不够的情况</p>
	 * @param tabName  表名
	 * @param workbook 
	 * @param sheetName  要创建的sheet名称
	 * @param list 要查询的字段和sheet页对应的表头
	 * @param wheremap 查询条件
	 * @return
	 * <p>创建人：ck</p>
	 * <p>创建时间：2019年6月20日 下午11:14:45</p>
	 */
	public HSSFWorkbook executeSqlToExcel(String tabName, HSSFWorkbook workbook,String sheetName, List<String> list,
			Map<String, Object> wheremap) {
		String sql = "";
		if (!"1".equals(dt)) {
			if ("0".equals(dt)) {
				sql = " from " + tabName + " where 1=1 ";
			} else {
				sql = " from " + tabName + " where dt=\'" + dt + "\'";
			}
		} else {
			sql = " from " + tabName + " where dayid=\'" + dt1 + "\'";
		}
		if (wheremap != null) {
			for (String key : wheremap.keySet()) {
				String[] keys = key.split("--");
				if (keys.length == 1) {
					sql += " and " + key + "=\'" + wheremap.get(key) + "\'";
				} else {
					switch (keys[0]) {
					case "like":
						sql += " and " + keys[1] + " like \'%" + wheremap.get(key) + "%\'";
						break;
					case "lt":
						sql += " and " + keys[1] + "<=\'" + wheremap.get(key) + "\'";
						break;
					case "gt":
						sql += " and " + keys[1] + ">=\'" + wheremap.get(key) + "\'";
						break;
					case "l":
						sql += " and " + keys[1] + "<\'" + wheremap.get(key) + "\'";
						break;
					case "g":
						sql += " and " + keys[1] + ">\'" + wheremap.get(key) + "\'";
						break;
					}
				}
			}
		}
		String select = "select ";
		List<String> namelist = new ArrayList<String>();
		for (String key : list) {
			String[] keys = key.split("\\^");
			namelist.add(keys[1]);
			key = keys[0];
			select += key + ",";
		}
		select = select.substring(0, select.length() - 1);
		sql = select + sql;
		Statement stmt = null;
		try (Connection conn = getConn()) {
			stmt = conn.createStatement();
			logger.info("Running:" + sql);
			ResultSet res = stmt.executeQuery(sql);
			int s = 0;
			HSSFSheet sheet=workbook.createSheet(sheetName);
			HSSFRow row = sheet.createRow(s);
			int m = 0;
			for (String key : namelist) {
				row.createCell(m).setCellValue(key);
				m++;
			}
			while (res.next()) {
				int u = res.getMetaData().getColumnCount();
				s++;
				HSSFRow row1 = sheet.createRow(s);
				for (int i = 1; i <= u; i++) {
					Object value = res.getObject(i);
					row1.createCell(i - 1).setCellValue(String.valueOf(value));
				}
				//超过6万行，创建新sheet
				if(s==60000){
					sheet=workbook.createSheet(sheetName+"----1");
					row = sheet.createRow(s);
					m = 0;
					for (String key : namelist) {
						row.createCell(m).setCellValue(key);
						m++;
					}	
					s=0;
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		return workbook;
	}
	
	
	/**
	 * <p>方法描述: 查询hive表，将结果封装到sheet中</p>
	 * @param tabName  表名
	 * @param sheet
	 * @param list 要查询的字段和sheet页对应的表头
	 * @param wheremap 查询条件
	 * @param orderorlimit 其他语句，比如limit ,orderby等
	 * @return
	 * <p>创建人：ck</p>
	 * <p>创建时间：2019年6月20日 下午11:16:11</p>
	 */
	public HSSFSheet executeSqlToExcel(String tabName, HSSFSheet sheet, List<String> list,
			Map<String, Object> wheremap) {
		//拼装sql
		String sql = "";
		if (!"1".equals(dt)) {
			if ("0".equals(dt)) {
				sql = " from " + tabName + " where 1=1 ";
			} else {
				sql = " from " + tabName + " where dt=\'" + dt + "\'";
			}
		} else {
			sql = " from " + tabName + " where dayid=\'" + dt1 + "\'";
		}
		if (wheremap != null) {
			for (String key : wheremap.keySet()) {
				String[] keys = key.split("--");
				if (keys.length == 1) {
					sql += " and " + key + "=\'" + wheremap.get(key) + "\'";
				} else {
					switch (keys[0]) {
					case "like":
						sql += " and " + keys[1] + " like \'%" + wheremap.get(key) + "%\'";
						break;
					case "lt":
						sql += " and " + keys[1] + "<=\'" + wheremap.get(key) + "\'";
						break;
					case "gt":
						sql += " and " + keys[1] + ">=\'" + wheremap.get(key) + "\'";
						break;
					case "l":
						sql += " and " + keys[1] + "<\'" + wheremap.get(key) + "\'";
						break;
					case "g":
						sql += " and " + keys[1] + ">\'" + wheremap.get(key) + "\'";
						break;
					case "no":
						sql += " and " + keys[1] + "!=\'" + wheremap.get(key) + "\'";
						break;						
					}
				}
			}
		}
		String select = "select ";
		List<String> namelist = new ArrayList<String>();
		for (String key : list) {
			String[] keys = key.split("\\^");
			namelist.add(keys[1]);
			key = keys[0];
			select += key + ",";
		}
		select = select.substring(0, select.length() - 1);
		sql = select + sql;
		//执行查询
		Statement stmt = null;
		try (Connection conn = getConn()) {
			stmt = conn.createStatement();
			logger.info("Running:" + sql);
			ResultSet res = stmt.executeQuery(sql);
			int s = 0;
			HSSFRow row = sheet.createRow(s);
			int m = 0;
			for (String key : namelist) {
				row.createCell(m).setCellValue(key);
				m++;
			}
			while (res.next()) {
				int u = res.getMetaData().getColumnCount();
				s++;
				HSSFRow row1 = sheet.createRow(s);
				for (int i = 1; i <= u; i++) {
					Object value = res.getObject(i);
					row1.createCell(i - 1).setCellValue(String.valueOf(value));
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		return sheet;
	}
	
	public HSSFSheet executeSqlToExcel(String tabName, HSSFSheet sheet, List<String> list,
			Map<String, Object> wheremap,String orderorlimit) {
		//拼装sql
		String sql = "";
		if (!"1".equals(dt)) {
			if ("0".equals(dt)) {
				sql = " from " + tabName + " where 1=1 ";
			} else {
				sql = " from " + tabName + " where dt=\'" + dt + "\'";
			}
		} else {
			sql = " from " + tabName + " where dayid=\'" + dt1 + "\'";
		}
		if (wheremap != null) {
			for (String key : wheremap.keySet()) {
				String[] keys = key.split("--");
				if (keys.length == 1) {
					sql += " and " + key + "=\'" + wheremap.get(key) + "\'";
				} else {
					switch (keys[0]) {
					case "like":
						sql += " and " + keys[1] + " like \'%" + wheremap.get(key) + "%\'";
						break;
					case "lt":
						sql += " and " + keys[1] + "<=\'" + wheremap.get(key) + "\'";
						break;
					case "gt":
						sql += " and " + keys[1] + ">=\'" + wheremap.get(key) + "\'";
						break;
					case "l":
						sql += " and " + keys[1] + "<\'" + wheremap.get(key) + "\'";
						break;
					case "g":
						sql += " and " + keys[1] + ">\'" + wheremap.get(key) + "\'";
						break;
					}
				}
			}
		}
		String select = "select ";
		List<String> namelist = new ArrayList<String>();
		String delCell="";
		for (int i=0;i<list.size();i++) {
			String key=list.get(i);
			String[] keys = key.split("\\^");
			if(!keys[1].equals("XXXXX")){
			namelist.add(keys[1]);
			}else{
				delCell+="X"+i+"X";
			}
			key = keys[0];
			select += key + ",";
		}
		select = select.substring(0, select.length() - 1);
		sql = select + sql;
		sql+=" "+orderorlimit;
		//执行查询
		Statement stmt = null;
		try (Connection conn = getConn()) {
			stmt = conn.createStatement();
			logger.info("Running:" + sql);
			ResultSet res = stmt.executeQuery(sql);
			int s = 0;
			HSSFRow row = sheet.createRow(s);
			int m = 0;
			for (String key : namelist) {
				row.createCell(m).setCellValue(key);
				m++;
			}
			while (res.next()) {
				int u = res.getMetaData().getColumnCount();
				s++;
				HSSFRow row1 = sheet.createRow(s);
				if (delCell == "") {
					for (int i = 1; i <= u; i++) {
						Object value = res.getObject(i);
						row1.createCell(i - 1).setCellValue(String.valueOf(value));
					}
				} else {
					int j=0;
					for (int i = 1; i <= u; i++) {
						String str="X"+(i-1)+"X";
						j=j+1;
						if(str.contains(delCell)){
							j=j-1;
							continue;
						}
						Object value = res.getObject(i);
						row1.createCell(j - 1).setCellValue(String.valueOf(value));
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		return sheet;
	}
	
	
	public HSSFSheet executeSqlToExcel(String fromSql, HSSFSheet sheet, List<String> list) {
		//拼装sql
		String sql="";
		String select = "select ";
		List<String> namelist = new ArrayList<String>();
		String delCell="";
		for (int i=0;i<list.size();i++) {
			String key=list.get(i);
			String[] keys = key.split("\\^");
			if(!keys[1].equals("XXXXX")){
			namelist.add(keys[1]);
			}else{
				delCell+="X"+i+"X";
			}
			key = keys[0];
			select += key + ",";
		}
		select = select.substring(0, select.length() - 1);
		sql=select+" "+fromSql;
		if (!"0".equals(dt)) {
			sql=sql.replace("$date", dt);
		} 
		//执行查询
		Statement stmt = null;
		try (Connection conn = getConn()) {
			stmt = conn.createStatement();
			logger.info("Running:" + sql);
			ResultSet res = stmt.executeQuery(sql);
			int s = 0;
			HSSFRow row = sheet.createRow(s);
			int m = 0;
			for (String key : namelist) {
				row.createCell(m).setCellValue(key);
				m++;
			}
			while (res.next()) {
				int u = res.getMetaData().getColumnCount();
				s++;
				HSSFRow row1 = sheet.createRow(s);
				if (delCell == "") {
					for (int i = 1; i <= u; i++) {
						Object value = res.getObject(i);
						row1.createCell(i - 1).setCellValue(String.valueOf(value));
					}
				} else {
					int j=0;
					for (int i = 1; i <= u; i++) {
						String str="X"+(i-1)+"X";
						j=j+1;
						if(str.contains(delCell)){
							j=j-1;
							continue;
						}
						Object value = res.getObject(i);
						row1.createCell(j - 1).setCellValue(String.valueOf(value));
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		return sheet;
	}

}
