package com.atguigu.kudu;

import org.apache.kudu.ColumnSchema;
import org.apache.kudu.Schema;
import org.apache.kudu.Type;
import org.apache.kudu.client.CreateTableOptions;
import org.apache.kudu.client.KuduClient;
import org.apache.kudu.client.KuduException;

import java.util.LinkedList;

/**
 * Create by chenqinping on 2019/11/5 10:46
 */
public class CreateTable {

    private static ColumnSchema newColumn(String name, Type type, boolean iskey) {

        ColumnSchema.ColumnSchemaBuilder column = new ColumnSchema.ColumnSchemaBuilder(name, type);
        column.key(iskey);
        return column.build();
    }

    public static void main(String[] args) throws KuduException {
        //地址
        String masteraddr = "hadoop001,hadoop002,hadoop003,hadoop004";
        KuduClient client = new KuduClient.KuduClientBuilder(masteraddr).defaultSocketReadTimeoutMs(6000).build();

        //设置表的schema

        LinkedList<ColumnSchema> columns = new LinkedList<>();
        /**
         与 RDBMS 不同，Kudu 不提供自动递增列功能，因此应用程序必须始终在插入期间提供完整的主键
         */

        columns.add(newColumn("id", Type.INT32, true));
        columns.add(newColumn("name", Type.STRING, false));
        columns.add(newColumn("id", Type.STRING, false));

        Schema schema = new Schema(columns);

        //创建表时提供的所有选项
        CreateTableOptions options = new CreateTableOptions();

        //设置表的replica备份和分区规则
        LinkedList<String> parcols = new LinkedList<>();

        parcols.add("id");

        //设置表的备份数
        options.setNumReplicas(1);

        //设置hash分区和数量
        options.addHashPartitions(parcols, 3);
        try {
            client.createTable("student", schema, options);
        } catch (KuduException e) {
            e.printStackTrace();
        } finally {
            client.close();
        }


    }

}
