# 小麦苗dbhealthcheck

## 小麦苗PostgreSQL的巡检脚本使用方法

参考： https://www.xmmup.com/pgshujukuxunjianjiaoben.html

### 其它开源工具
- 1、https://github.com/awslabs/pg-collector
- 2、https://github.com/jobinau/pg_gather


## 国产崖山YashanDB的巡检脚本使用方法

参考：https://www.xmmup.com/yashanyashandbshujukuxunjianjiaoben.html







## 1、巡检脚本简介


该套数据库巡检脚本多数为纯SQL脚本开发，如下所示：

![](https://pic.xmmup.com/i/2023/11/21/202311211316420-3.png)

![](https://pic.xmmup.com/i/2023/11/21/202311211317746-3.png)

![](https://pic.xmmup.com/i/2023/11/21/202311211317065-3.png)

> - 目前一共包含**33**个脚本，若脚本的扩展名为“.sql”则表示该脚本为sql脚本；若脚本的扩展名为“.pl”则表示该脚本为perl脚本；若脚本的扩展名为“.sh”则表示该脚本为shell脚本。
> - 对于Oracle的SQL脚本而言，脚本DB_Oracle_HC_lhr_v7.0.0_10g.sql适用于Oracle 10g数据库，脚本DB_Oracle_HC_lhr_v7.0.0_11g.sql适用于Oracle 11g的数据库，脚本DB_Oracle_HC_lhr_v7.0.0_12c.sql适用于Oracle 12c及其以上版本，这3个脚本都是**只读**版本，这3个脚本只会对数据库做查询操作，不会做DML和DDL操作，这也是很多朋友所期待的功能。
> - 脚本DB_OS_HC_lhr_v7.0.0.pl是perl脚本，执行后会对OS的信息进行收集，并且输出到html中。脚本DB_OS_HC_lhr_v7.0.0.sh是shell脚本，执行后会对OS的信息进行收集。
> - 脚本DB_MySQL_HC_lhr_v7.0.0.sql是MySQL脚本，执行后会产生MySQL的健康检查html报告，该脚本为**只读**脚本。该脚本也适用于mariadb数据库。
> - 脚本DB_SQLServer_HC_lhr_v7.0.0_2005.sql和DB_SQLServer_HC_lhr_v7.0.0_2008R2.sql是SQL Server脚本，存在部分DDL和DML操作，执行后会产生SQL Server的健康检查html报告。脚本DB_SQLServer_HC_lhr_v7.0.0_2005.sql最低支持2005版本，而脚本DB_SQLServer_HC_lhr_v7.0.0_2008R2.sql最低支持2008R2版本，而脚本DB_SQLServer_HC_lhr_v7.0.0_2016.sql最低支持2016版本。
> - 脚本DB_PG_HC_lhr_v7.0.0.sql是PG数据库脚本，执行后会产生PostgreSQL数据库的健康检查html报告。
> - 脚本DB_GP_HC_lhr_v7.0.0.sql是Greenplum数据库脚本，执行后会产生Greenplum数据库的健康检查html报告。
> - 脚本DB_DM_HC_lhr_v7.0.0是达梦数据库脚本，执行后会产生达梦数据库的健康检查html报告。
> - 脚本DB_TiDB_HC_lhr_v7.0.0.sql是TiDB数据库脚本，执行后会产生TiDB数据库的健康检查html报告。
> - 脚本DB_openGauss_HC_lhr_v7.0.0.sql是openGauss数据库脚本，执行后会产生openGauss数据库的健康检查html报告。
> - 脚本DB_DB2_HC_lhr_v7.0.0.sql是DB2数据库脚本，执行后会产生DB2数据库的健康检查html报告。
> - 脚本DB_OceanBase_HC_lhr_v7.0.0.sql是DB2数据库脚本，执行后会产生OceanBase数据库的健康检查html报告。
> - 脚本DB_kingbase_HC_lhr_v7.0.0.sql是人大金仓OLTP数据库KES脚本，执行后会产生人大金仓数据库KES版的健康检查html报告。
> - 脚本DB_kingbase_kadb_HC_lhr_v7.0.0.sql是人大金仓分析型数据库KingbaseAnalyticsDB及KADB数据库脚本，执行后会产生人大金仓KADB数据库的健康检查html报告。
> - 脚本DB_GreatDB_HC_lhr_v7.0.0.sql是万里GreatDB数据库脚本，执行后会产生万里GreatDB数据库的健康检查html报告。
> - 脚本DB_TBase_HC_lhr_v7.0.0.sql是TDSQL_for_PG（原 TBase）数据库脚本，执行后会产生TDSQL_for_PG（原 TBase）数据库的健康检查html报告。
> - 脚本DB_MogDB_HC_lhr_v7.0.0.sql是MogDB数据库脚本，执行后会产生云和恩墨MogDB数据库的健康检查html报告。
> - 脚本DB_OushuDB_HC_lhr_v7.0.0.sql是OushuDB数据库脚本，执行后会产生OushuDB数据库的健康检查html报告。
> - 脚本DB_PolarDB_for_PG_HC_lhr_v7.0.0.sql是PolarDB_for_PG数据库脚本，执行后会产生PolarDB_for_PG数据库的健康检查html报告。
> - 脚本DB_OSCAR_HC_lhr_v7.0.0.sql是神舟通用数据库脚本，执行后会产生神通数据库的健康检查html报告。
> - 脚本DB_GBase8a_HC_lhr_v7.0.0.sql是南大通用GBase 8a数据库脚本，执行后会产生南大通用GBase 8a数据库的健康检查html报告。
> - 脚本DB_GBase8c_HC_lhr_v7.0.0.sql是南大通用GBase 8c数据库脚本，执行后会产生南大通用GBase 8c数据库的健康检查html报告。
> - 脚本DB_StarRocks_HC_lhr_v7.0.0.sql是StarRocks数据库脚本，执行后会产生StarRocks数据库的健康检查html报告。
> - 脚本DB_YMatrix_HC_lhr_v7.0.0.sql是matrixdb数据库脚本，执行后会产生YMatrix数据库的健康检查html报告。
> - 脚本DB_YashanDB_HC_lhr_v7.0.0.sql是YashanDB数据库脚本，执行后会产生崖山数据库的健康检查html报告。
>




## 2、巡检脚本特点


>1、可以巡检`Oracle、MySQL（包括Mariadb）、SQL Server、PostgreSQL、Greenplum、OceanBase、TiDB、openGauss、DB2、达梦、人大金仓（KES+KADB）、万里GreatDB、TDSQL_for_PG（原 TBase）、MogDB、OushuDB、PolarDB_for_PG、神通、南大通用GBase 8a+8c、StarRocks、YMatrix、YashanDB`等**21**种数据库，也可以巡检Linux操作系统（后续会免费逐步增加MongoDB、Redis等数据库）
>
>2、脚本为绿色版、免安装、纯SQL文本
>
>3、跨平台，只要有`sqlplus（Oracle）、mysql（MySQL、Mariadb、TiDB、OceanBase、万里GreatDB、南大通用GBase 8a、StarRocks）、sqlcmd（SSMS、Navicat皆可）、psql（PG、Greenplum、openGauss、人大金仓KES+KADB、TBase、MogDB、OushuDB、PolarDB_for_PG、南大通用GBase 8c、YMatrix）、gsql（openGauss、GaussDB、MogDB、南大通用GBase 8c）、disql（国产达梦）、db2（DB2数据库）、obclient（OceanBase）、ksql(人大金仓KES)、isql(神舟通用)、gccli（南大通用GBase 8a）、yasql（崖山数据库）`环境即可运行脚本
>
>4、脚本内容可视化，可以看到脚本内容，因此可供学习数据库使用
>
>5、兼容Oracle 10g、11g、12c、18c、19c、20c、21c等高版本Oracle数据库
>
>6、对Oracle 10g、11g、12c、18c、19c、20c、21c等版本分别提供了只读版（只对数据库查询，不做DDL和DML操作）
>
>7、MySQL最低支持5.5版本，小于5.5版本未进行测试
>
>8、SQL Server最低支持2005版本
>
>9、增删监控项非常方便，只需要提供相关SQL即可
>
>10、一次购买，所有脚本终身免费升级
>
>11、检查内容非常全面
>
>12、针对每种数据库，只有1个SQL脚本，不存在嵌套调用脚本等其它问题
>
>13、最终生成html文件格式的健康检查结果
>
>14、Oracle数据库对巡检结果进行过滤，列出了数据库有问题的内容
>
>15、对OS的信息提供了收集（单独脚本）







## 3、PG数据库运行方式

需要有psql客户端，运行方式如下：

```sql
psql -U postgres -h 192.168.66.35 -p 54324 -d postgres -W -H -q -f D:\DB_PG_HC_lhr_v7.0.0.sql > d:\a.html
```

输入密码，回车即可。

> 注意：
>
> 1、该脚本的字符集为utf8，若修改文件内容请使用utf8格式打开该文件。
>
> 2、巡检内容“**WAL日志切换频率（需要手动修改脚本路径）**”部分的“`/pg13/pgdata/pg_wal`”路径需要手动修改为自己环境真实的路径，否则会报错：`ERROR:  absolute path not allowed`

### 注意：

由于**用户环境的版本或插件问题**，如下的报错请忽略，不影响最终的结果：

```sql
[pg94@lhrpgall ~]$ psql -W -H -f DB_PG_HC_lhr_v7.0.0.sql  >  a.html        
Password: 
psql:DB_PG_HC_lhr_v7.0.0.sql:291: ERROR:  column p.prokind does not exist
LINE 2:  CASE p.prokind
              ^
psql:DB_PG_HC_lhr_v7.0.0.sql:359: ERROR:  column "total_exec_time" does not exist
LINE 3:       round(total_exec_time::numeric, 2) AS total_time,
                    ^
psql:DB_PG_HC_lhr_v7.0.0.sql:368: ERROR:  column "mean_time" does not exist
LINE 4:       round(mean_time::numeric, 2) AS mean_time,
                    ^
psql:DB_PG_HC_lhr_v7.0.0.sql:385: ERROR:  column "total_exec_time" does not exist
LINE 3:       round(total_exec_time::numeric, 2) AS total_time,
                    ^
psql:DB_PG_HC_lhr_v7.0.0.sql:401: ERROR:  pg_stat_statements must be loaded via shared_preload_libraries                    
                    
psql:DB_PG_HC_lhr_v7.0.0.sql:423: ERROR:  relation "pg_stat_wal_receiver" does not exist
LINE 1: select * from pg_stat_wal_receiver;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:430: ERROR:  function pg_current_wal_lsn() does not exist
LINE 3:      pg_current_wal_lsn() AS A(c1)
             ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
psql:DB_PG_HC_lhr_v7.0.0.sql:450: ERROR:  relation "pg_publication" does not exist
LINE 1: select * from pg_publication;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:453: ERROR:  relation "pg_publication_tables" does not exist
LINE 1: select * from pg_publication_tables;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:460: ERROR:  relation "pg_stat_subscription" does not exist
LINE 1: select * from pg_stat_subscription;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:464: ERROR:  relation "pg_subscription" does not exist
LINE 1: select * from pg_subscription;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:468: ERROR:  relation "pg_subscription_rel" does not exist
LINE 1: select *,srrelid::regclass from pg_subscription_rel;
                                        ^
psql:DB_PG_HC_lhr_v7.0.0.sql:490: ERROR:  relation "pg_file_settings" does not exist
LINE 1: select * from pg_file_settings;
                      ^
psql:DB_PG_HC_lhr_v7.0.0.sql:528: ERROR:  relation "pg_hba_file_rules" does not exist
LINE 1: select * from pg_hba_file_rules;
                      ^                      
psql:DB_PG_HC_lhr_v7.0.0.sql:588: ERROR:  absolute path not allowed
psql:DB_PG_HC_lhr_v7.0.0.sql:589: ERROR:  could not open directory "/pg13/pgdata/pg_wal": Permission denied
psql:DB_PG_HC_lhr_v7.0.0.sql:666: ERROR:  relation "pg_config" does not exist
LINE 1: SELECT * FROM pg_config ;
                      ^
                      
                      
```



## 4、html巡检结果

这里只列出**部分结果**，其它的详细内容可以参考：https://share.weiyun.com/5lb2U2M

![](https://pic.xmmup.com/i/img/20210721171524.png)

![](https://pic.xmmup.com/i/img/20210721171614.png)

![](https://pic.xmmup.com/i/img/20210721171651.png) 

![](https://pic.xmmup.com/i/img/20210721171836.png)






## 5、所有数据库类型巡检

请参考：https://www.xmmup.com/shujukuxunjianjiaoben.html












