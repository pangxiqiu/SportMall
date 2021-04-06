package com.atguigu.partition;

import org.apache.kudu.ColumnSchema;
import org.apache.kudu.client.CreateTableOptions;
import org.apache.kudu.client.KuduClient;
import org.apache.kudu.client.KuduException;
import org.apache.kudu.client.PartialRow;
import org.apache.kudu.Type;
import org.apache.kudu.Schema;
import java.util.LinkedList;
import java.util.List;

/**
 * Create by chenqinping on 2019/11/5 17:19
 *
 * Multilevel Partitioning ( 多级分区 )
 * Kudu 允许一个表在单个表上组合多级分区。 当正确使用时，多级分区可以保留各个分区类型的优点，同时减少每个分区的缺点 需求：
 */
public class MultilevelParitition {
    private static ColumnSchema newColumn(String column , Type type , boolean isPrimary){
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
        options.setNumReplicas(1) ;
        //设置范围分区的分区规则
        List<String> parcols = new LinkedList<String>();
        parcols.add("CompanyId") ;
        //设置按照哪个字段进行range分区
        options.addHashPartitions(parcols , 10);
        options.setRangePartitionColumns(parcols);
        /**
         * 设置range的分区范围
         * 分区1：0 < value < 10
         * 分区2：10 <= value < 20
         * 分区3：20 <= value < 30
         * ........
         * 分区9：80 <= value < 90
         * */
        int count = 0 ;
        for(int i=1 ; i< 10 ; i++){
            PartialRow lower = schema.newPartialRow();
            lower.addInt("CompanyId" , count);
            PartialRow upper = schema.newPartialRow();
            count += 10;
            upper.addInt("CompanyId" , count);
            options.addRangePartition(lower , upper);
        }
        try {
            client.createTable("MultilevelTable" , schema , options);
        } catch (KuduException e) {
            e.printStackTrace();
        }finally {
            try {
                client.close();
            } catch (KuduException e) {
                e.printStackTrace();
            }
        }
    }
}