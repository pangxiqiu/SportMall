package com.atguigu.partition;

import org.apache.kudu.ColumnSchema;
import org.apache.kudu.client.CreateTableOptions;
import org.apache.kudu.client.KuduClient;
import org.apache.kudu.client.KuduException;

import java.util.LinkedList;
import java.util.List;
import org.apache.kudu.Type;
import org.apache.kudu.Schema;

/**
 * Create by chenqinping on 2019/11/5 16:12
 * 哈希分区
 *
 * 哈希分区通过哈希值将行分配到许多 buckets ( 存储桶 )之一； 哈希分区是一种有效的策略，当不需要对表进行有序访问时。哈希分区对于在 tablet 之间随机散布这些功能是有效的，这有助于减轻热点和 tablet 大小不均匀。
 *
 * 创建一张表，要求按照如下方式进行分区：
 */
public class createHashPartition {

    private static ColumnSchema newColumn(String column, Type type, boolean isPrimary) {
        final ColumnSchema.ColumnSchemaBuilder columnSchemaBuilder = new ColumnSchema.ColumnSchemaBuilder(column, type);
        columnSchemaBuilder.key(isPrimary);
        return columnSchemaBuilder.build();
    }

    public static void main(String[] args) {
        //master地址
        final String master = "hadoop001,hadoop002,hadoop003,hadoop004";
        final KuduClient client = new KuduClient.KuduClientBuilder(master).defaultSocketReadTimeoutMs(6000).build();
        // 设置表的schema
        List<ColumnSchema> columns = new LinkedList<ColumnSchema>();
        columns.add(newColumn("CompanyId", Type.INT32, true));
        columns.add(newColumn("WorkId", Type.INT32, false));
        columns.add(newColumn("Name", Type.STRING, false));
        columns.add(newColumn("Gender", Type.STRING, false));
        columns.add(newColumn("Photo", Type.STRING, false));
        Schema schema = new Schema(columns);
        //创建表时提供的所有选项
        final CreateTableOptions options = new CreateTableOptions();
        //设置备份数
        options.setNumReplicas(1);
        //设置范围分区的分区规则
        List<String> parcols = new LinkedList<String>();
        parcols.add("CompanyId");
        //设置按照哪个字段进行Hash分区
        options.addHashPartitions(parcols, 6);

        try {
            client.createTable("hashTable", schema, options);
        } catch (KuduException e) {
            e.printStackTrace();
        } finally {
            try {
                client.close();
            } catch (KuduException e) {
                e.printStackTrace();
            }
        }
    }
}
