package cn.edu.ccu.data;


/**
 * @ClassName: JDBCProperties
 * @Description: JDBCProperties文件属性 如果增加一个数据库 且有自己对应的事务管理器必须在这里定义 且和配置文件中定义的管理器名称一致
 * @date Jun 30, 2015 3:24:14 PM
 */
public class TransactionManagerName {

    /**
     * partyTransactionManager事务管理器
     */
    public final static String partyTransactionManager = "partyTransactionManager";

}
