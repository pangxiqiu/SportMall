package com.bjsy.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Create chenqinping 2019/12/16
 */
public class PrestoTest {

    public static void main(String[] args) throws Exception {
        Class.forName("com.facebook.presto.jdbc.PrestoDriver");
        Connection connection = DriverManager.getConnection("jdbc:presto://10.6.70.88:8082/sales/ewallet_pro?SSL=true", "root", null);
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("show tables");
        while (rs.next()) {

            System.out.println("rs.getString(1) = " + rs.getString(1));
        }
        rs.close();
        connection.close();
    }
}
