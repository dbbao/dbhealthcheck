-- 运行方式： psql -U postgres -h 192.168.66.35 -p 54324 -d postgres -W -H -q -f D:\DB_PG_HC_lhr_v7.0.0.sql > d:\PG_health_check.html

\set QUIET 1
\setenv lc_messages 'C'

set session statement_timeout = '30s';
set session lock_timeout = '10s';


\pset footer off


\qecho <html lang="en"><head><title>PG Report</title> <style type="text/css">
\qecho body.awr {font:bold 10pt Consolas;color:black;background:White;}
\qecho table  {font:11px Consolas; color:Black; background:#FFFFCC; padding:1px; margin:0px 0px 0px 0px; cellspacing:0px;border-collapse:collapse;}
\qecho th  {font:bold 11px Consolas; color:White; background:#0066cc; padding:5px; cellspacing:0px;border-collapse:collapse;white-space: nowrap;}
\qecho td {font-family:Consolas; white-space: pre-wrap; }
\qecho tr:nth-child(odd){background:White;}
\qecho tr:hover   {background-color: yellow;}
\qecho h1.awr     {font:bold 20pt Consolas;color:#336699;background-color:White;border-bottom:1px solid #cccc99;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}
\qecho h2.awr     {font:bold 16pt Consolas;color:#336699;background-color:White;margin-top:0pt; margin-bottom:0pt;}
\qecho th.awrbg   {font:bold 10pt Consolas; color:White; background:#0066CC;padding-left:0px; padding-right:0px;padding-bottom:0px}
\qecho th.awrnc   {font:9pt Consolas;color:black;background:White;}
\qecho th.awrc    {font:9pt Consolas;color:black;background:#FFFFCC;}
\qecho td.awrnc   {font:9pt Consolas;color:black;background:White;vertical-align:middle;padding:4;}
\qecho a.info:hover {background:#eee;color:#000000; position:relative;}
\qecho a.info span {display: none; }
\qecho a.info:hover span {font-size:11px!important; color:#000000; display:block;position:absolute;top:30px;left:40px;width:150px;border:1px solid #ff0000; background:#FFFF00; padding:1px 1px;text-align:left;word-wrap: break-word; white-space: pre-wrap;}
\qecho td.awrc    {font:9pt Consolas;color:black;background:#FFFFCC; vertical-align:middle;padding:4;}</style></head>
\qecho <body class="awr">

\qecho <Marquee  align="absmiddle" scrolldelay="100" behavior="alternate" direction="left" onmouseover="this.stop()" onmouseout="this.start()" bgcolor="#FFCC00"  height=18 width=100%  vspace="1" hspace="1"><font face="Consolas" color="#008B00" size="2"> <div style="font-weight:lighter">巡检人:小麦苗　QQ:646634621　微信公众号：DB宝　提供OCP、OCM、高可用（rac+dg）、PostgreSQL和MySQL培训　BLOG地址: <a target="_blank"  href=https://www.xmmup.com><font size="2">https://www.xmmup.com</font></a> 若需要脚本可私聊我</div></font></Marquee>

\qecho <center><font size=+3 color=darkgreen><b>PG数据库巡检报告</b></font></center>



-- +----------------------------------------------------------------------------+
-- +----------------------------------------------------------------------------+
-- |                             - REPORT HEADER -                              |
-- +----------------------------------------------------------------------------+


\qecho <a name=top></a>
\qecho <hr>
\qecho <p>
\qecho <div style="font-weight:lighter"><font face="Consolas" color="#336699">Copyright (c) 2015-2100 (https://www.xmmup.com) <a target="_blank" href="https://www.xmmup.com">xmmup</a>. All rights reserved.</font></div>
\qecho <p>
\qecho <a style="font-weight:lighter">巡 检 人：小麦苗([QQ：646634621]   [微信公众号：DB宝]   [提供OCP、OCM、高可用、MySQL和PostgreSQL最实用的培训])</a></br>
\qecho <a style="font-weight:lighter">版 本 号：v7.0.0</a></br>
\qecho <a style="font-weight:lighter">修改日期：2024-04-25</a></br>
\qecho <p>
\qecho [<a class="noLink" href="#html_bottom_link"  style="font-weight:lighter">转到页底</a>]
\qecho <hr>

 

\qecho <a name="directory"><font size=+2 face="Consolas" color="#336699"><b>目录</b></font></a>
\qecho <hr>

\qecho <table width="100%" border="1" bordercolor="#000000" cellspacing="0px" style="border-collapse:collapse; margin-top:0.3cm;" align="center">

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="2"  nowrap align="center" width="10%"><a class="info" href="#db_info_link"><font size=+0.5 face="Consolas" color="#000000"><b>总体概况</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_instance_info"><font size=2.5 face="Consolas" color="#336699">实例信息<span>数据库实例信息</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_base_info"><font size=2.5 face="Consolas" color="#336699">数据库基本信息<span>数据库的总体概况、版本、主机情况、数据库负载情况、数据库属性等</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_ts_info"><font size=2.5 face="Consolas" color="#336699">所有表空间<span>所有表空间</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_client_info"><font size=2.5 face="Consolas" color="#336699">当前客户端连接信息<span>当前客户端连接信息</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_top_table_info"><font size=2.5 face="Consolas" color="#336699">前几张大表<span>前几张大表</span></font></a></td>
\qecho </tr> 

\qecho <tr>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#curr_all_object"><font size=2.5 face="Consolas" color="#336699">当前库的所有数据库对象<span>当前库的所有数据库对象</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#lOCK_INFO"><font size=+0.5 face="Consolas" color="#000000"><b>锁情况</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#all_processlist"><font size=2.5 face="Consolas" color="#336699">所有进程<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#sql_info"><font size=+0.5 face="Consolas" color="#000000"><b>SQL部分</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#sql_exec_time"><font size=2.5 face="Consolas" color="#336699">总执行时间最长的SQL<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#sql_exec_io"><font size=2.5 face="Consolas" color="#336699">最耗IO的SQL<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#sql_exec_shared_mem"><font size=2.5 face="Consolas" color="#336699">最耗共享内存<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#index_info"><font size=+0.5 face="Consolas" color="#000000"><b>索引部分</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#ha_info"><font size=+0.5 face="Consolas" color="#000000"><b>高可用情况</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#master_slave_stats"><font size=2.5 face="Consolas" color="#336699">主从流复制情况<span>主从流复制情况</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#logical_stats"><font size=2.5 face="Consolas" color="#336699">逻辑复制<span>PG逻辑复制情况</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#db_performance_info"><font size=+0.5 face="Consolas" color="#000000"><b>数据库性能</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#db_per_config_stats"><font size=2.5 face="Consolas" color="#336699">参数配置<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#pg_hba"><font size=2.5 face="Consolas" color="#336699">pg_hba参数文件<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#pg_stat_bgwriter"><font size=2.5 face="Consolas" color="#336699">后台写进程统计信息<span></span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho </tr>

\qecho <tr>
\qecho <td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#others_info"><font size=+0.5 face="Consolas" color="#000000"><b>其它</b><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#user_and_role"><font size=2.5 face="Consolas" color="#336699">用户和角色<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#extensions_info"><font size=2.5 face="Consolas" color="#336699">所有插件<span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#pg_config_info"><font size=2.5 face="Consolas" color="#336699">获取已安装的PostgreSQL的信息<span>获取已安装的PostgreSQL的信息，表pg_config</span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho <td nowrap align="center" style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
\qecho </tr>

\qecho </table>


\qecho <br />
\qecho <hr>
\qecho <br />


-- +----------------------------------------------------------------------------+
-- +----------------------------------------------------------------------------+
-- |                             - DATABASE OVERVIEW -                          |
-- +----------------------------------------------------------------------------+


\qecho <a name="db_info_link"></a>
\qecho <font size="+2" color="00CCFF"><b>数据库总体概况</b></font><hr align="left" width="800">



\qecho <a name="db_instance_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 实例信息</b></font>

select pg_postmaster_start_time() pg_start_time ,
extract(epoch from now() - pg_postmaster_start_time()) run_time,
pg_conf_load_time() config_file_load_time,
inet_server_addr() server_IP,
inet_server_port() server_port,
inet_client_addr() client_ip,
inet_client_port() client_port,
version() server_version,
(case when pg_is_in_recovery()='f' then 'primary' else 'standby' end ) as  primary_or_standby,
now() now_date,
(SELECT trunc(sum(blks_hit)/(sum(blks_read)+sum(blks_hit))*100,2)||'%' hit from pg_stat_database) all_db_hit 
;
-- show server_version;
-- select version();

\qecho <p>● 用户认证方式（PG16）
select  "system_user"();


\qecho <p>● 服务器OS类型
select version();
select * from pg_config d WHERE d.name='BINDIR' ;


\qecho <a name="db_base_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 数据库基本信息</b></font>

-- \l+

SELECT d.datname as "Name",
       pg_catalog.pg_get_userbyid(d.datdba) as "Owner",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding",
       d.datcollate as "Collate",
       d.datctype as "Ctype",
       pg_catalog.array_to_string(d.datacl, E'\n') AS "Access privileges",
       CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
            THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))
            ELSE 'No Access'
       END as "Size",
       t.spcname as "Tablespace",
       pg_catalog.shobj_description(d.oid, 'pg_database') as "Description",
       age(datfrozenxid) age
FROM pg_catalog.pg_database d
  JOIN pg_catalog.pg_tablespace t on d.dattablespace = t.oid
ORDER BY 1;


/* 数据库大小
SELECT pg_size_pretty(pg_database_size('your_database_name')) AS size;
SELECT
  datname AS database_name,
  pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database;
*/



\qecho ● 查看各数据库数据创建时间
SELECT
	datname,
	(
	pg_stat_file (
	format ( '%s/%s/PG_VERSION', CASE WHEN spcname = 'pg_default' THEN 'base' ELSE'pg_tblspc/' || t2.oid || '/PG_11_201804061/' END, t1.oid ))).* 
FROM
	pg_database t1,
	pg_tablespace t2 
WHERE
	t1.dattablespace = t2.oid;


\qecho <a name="db_ts_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 所有表空间 </b></font>
SELECT oid,spcname AS "Name",
  pg_catalog.pg_get_userbyid(spcowner) AS "Owner",
  pg_catalog.pg_tablespace_location(oid) AS "Location",
  pg_catalog.array_to_string(spcacl, E'\n') AS "Access privileges",
  spcoptions AS "Options",
  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS "Size",
  pg_catalog.shobj_description(oid, 'pg_tablespace') AS "Description"
FROM pg_catalog.pg_tablespace
ORDER BY 1;


\qecho <a name="db_client_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 当前客户端连接信息</b></font>
-- select current_user,current_database(),pg_backend_pid(),pg_current_wal_lsn() lsn,pg_walfile_name(pg_current_wal_lsn()) pg_walfile_name;
select current_user,current_database(),pg_backend_pid();
-- select user,current_database(),pg_backend_pid();



\qecho <a name="db_top_table_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 前几张大表</b></font>



SELECT
	t.table_catalog as db,
	n.nspname AS schemaname,
	c.relname,
	c.reltuples::numeric as rowcount,
	pg_size_pretty(pg_table_size ( '"' || nspname || '"."' || relname || '"' )) AS table_size,
    pg_size_pretty(pg_indexes_size ( '"' || nspname || '"."' || relname || '"' )) AS indexes_size,
	pg_size_pretty (pg_total_relation_size ( '"' || nspname || '"."' || relname || '"' )) AS total_size --,pg_relation_filepath(table_name) filepath
FROM pg_class C 
	LEFT JOIN pg_namespace N ON ( N.oid = C.relnamespace ) 
	left join information_schema.tables t on (n.nspname= t.table_schema and c.relname=t."table_name" )
WHERE
	nspname NOT IN ( 'information_schema' ) 
	AND relkind in ('r','p')  
ORDER BY
	pg_total_relation_size ( '"' || nspname || '"."' || relname || '"' ) DESC 
	LIMIT 20;
	

/* -- 这个也需要查询
SELECT  table_schema || '.' || table_name 
AS table_full_name, pg_size_pretty(pg_total_relation_size('"' ||table_schema || '"."' || table_name || '"')) AS size --,pg_relation_filepath(table_name) filepath
FROM information_schema.tables
ORDER by  pg_total_relation_size('"' || table_schema || '"."' || table_name || '"')
desc
limit 10;
*/




\qecho <a name="db_top_age_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查询当前所有表的年龄</b></font>

SELECT c.oid::regclass as table_name,
     greatest(age(c.relfrozenxid),age(t.relfrozenxid)) as age
FROM pg_class c
LEFT JOIN pg_class t ON c.reltoastrelid = t.oid
WHERE c.relkind IN ('r', 'm')
order by age desc 
limit 20;



\qecho <a name="curr_all_object"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 当前库的所有数据库对象 </b></font>
select 
    nsp.nspname as SchemaName
    ,case cls.relkind
        when 'r' then 'TABLE'
        when 'm' then 'MATERIALIZED_VIEW'
        when 'i' then 'INDEX'
        when 'S' then 'SEQUENCE'
        when 'v' then 'VIEW'
        when 'c' then 'composite type'
        when 't' then 'TOAST'
        when 'f' then 'foreign table'
        when 'p' then 'partitioned_table'
        when 'I' then 'partitioned_index'
        else cls.relkind::text
    end as ObjectType,
    COUNT(*) cnt
from pg_class cls
join pg_namespace nsp 
 on nsp.oid = cls.relnamespace
where nsp.nspname not in ('information_schema', 'pg_catalog')
  and nsp.nspname not like 'pg_toast%'
GROUP BY nsp.nspname,cls.relkind
;

SELECT n.nspname as "Schema",
 CASE p.prokind
  WHEN 'a' THEN 'agg'
  WHEN 'w' THEN 'window'
  WHEN 'p' THEN 'proc'
  ELSE 'func'
 END as "Type",
 COUNT(*) cnt
FROM pg_catalog.pg_proc p
LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
WHERE pg_catalog.pg_function_is_visible(p.oid)
AND n.nspname not in ('information_schema', 'pg_catalog')
GROUP BY n.nspname ,p.prokind;




\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>



----------------------------------------
------- 锁情况
----------------------------------------
\qecho <a name="lOCK_INFO"></a>
\qecho <font size="+2" color="00CCFF"><b>锁情况</b></font><hr align="left" width="800">

\qecho <a name="all_processlist"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 所有进程</b></font>

\qecho <p>● 总计
SELECT
	max_conn 最大连接数,
	now_conn 当前连接数,
	max_conn - now_conn 剩余连接数 
FROM
	( SELECT setting::int8  AS max_conn, ( SELECT COUNT ( * ) FROM pg_stat_activity ) AS now_conn FROM pg_settings WHERE NAME = 'max_connections' ) T;


\qecho <p>● 用户统计
select a.usename ,COUNT(*) cnt   from pg_stat_activity  a  GROUP BY a.usename ORDER BY cnt;

\qecho <p>● 状态统计
select a.state,COUNT(*) cnt   from pg_stat_activity  a  GROUP BY a.state;

\qecho <p>● 详情
select a.*   from pg_stat_activity  a order by a.state,query_start  limit 100;
-- select pg_terminate_backend(a.pid) from pg_stat_activity   a;
-- where pid<>pg_backend_pid();




\qecho <a name="pg_locks"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 锁</b></font>
SELECT * FROM pg_locks;




\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 锁详情</b></font>
SELECT pg_locks.pid as pid,  --进程ID
      transactionid as transaction_id, --事务ID
			 pd.datname db_name,
      nspname as schemaname,  --schema名
      relname as object_name,  --对象名
      locktype as lock_type,  --锁类型
      mode lock_mode,  --锁模式
      CASE
        WHEN granted = 'f' THEN
         'get_lock'
        WHEN granted = 't' THEN
         'wait_lock'
      END lock_satus,   --锁状态：持有锁|等待锁
      least(query_start, xact_start) AS query_start,  --query请求开始时间
      substr(query, 1, 25) AS query_text   --当前SQL语句
 FROM pg_locks
	left join pg_database pd
	on (pg_locks.database=pd.oid)
 LEFT OUTER JOIN pg_class
   ON (pg_locks.relation = pg_class.oid)
 LEFT OUTER JOIN pg_namespace
   ON (pg_namespace.oid = pg_class.relnamespace),  pg_stat_activity
WHERE NOT pg_locks.pid = pg_backend_pid()
  AND pg_locks.pid = pg_stat_activity.pid
ORDER BY query_start;



\qecho <a name="pg_stat_activity"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● state_change字段长时间没有更新过的连接信息</b></font>
SELECT * FROM pg_stat_activity where state='idle' order by state_change limit  20;


\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>



----------------------------------------
-------SQL情况
----------------------------------------
\qecho <a name="sql_info"></a>
\qecho <font size="+2" color="00CCFF"><b>SQL情况</b></font><hr align="left" width="800">



\qecho <a name="long_sql"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 慢查询SQL</b></font>
SELECT pgsa.pid,
      pgsa.client_port,
      pgsa.datname AS datname, 
      pgsa.usename AS usename, 
      pgsa.client_addr client_addr, 
      pgsa.application_name AS application_name, 
      pgsa.state AS state, 
      pgsa.backend_start AS backend_start, 
      pgsa.xact_start AS xact_start, 
      state_change,
      pgsa.query_start AS query_start, 
      TRUNC(EXTRACT( epoch  FROM  (NOW() - pgsa.xact_start)  )) AS xact_stay, 
      trunc(EXTRACT( epoch  FROM  (NOW() - pgsa.query_start) )) AS query_stay, 
      REPLACE(pgsa.QUERY, chr(10),  ' ') AS QUERY,
      pgsa.wait_event,pgsa.wait_event_type,pgsa.backend_type,
      'select pg_terminate_backend('||pgsa.pid||');' kill1,
      'select pg_cancel_backend('||pgsa.pid||');' kill2
    FROM   pg_stat_activity AS pgsa
	WHERE   pgsa.state not in ( 'idle' ,'idle in transaction (aborted)' )
ORDER BY  query_stay DESC,xact_stay DESC
LIMIT  100;




\qecho <a name="sql_exec_time"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 总执行时间最长的SQL（需要配置插件）</b></font>
-- 若报错“pg_stat_statements must be loaded via shared_preload_libraries”，请执行如下的SQL并重启DB
-- create extension pg_stat_statements;
-- alter system set shared_preload_libraries = 'pg_stat_statements';
SELECT query,
      calls,
      round(total_exec_time::numeric, 2) AS total_time,
      round(mean_exec_time::numeric, 2) AS mean_time,
      round((100 * total_exec_time / sum(total_exec_time) OVER ())::numeric, 2) AS percentage
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;

SELECT query,
      calls,
      round(total_time::numeric, 2) AS total_time,
      round(mean_time::numeric, 2) AS mean_time,
      round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;



\qecho <a name="sql_exec_io"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 最耗IO的SQL</b></font>

-- 如果要跟踪IO消耗的时间，还需要打开trace_io_timing参数

SELECT query,
      calls,
      round(total_exec_time::numeric, 2) AS total_time,
      round(blk_read_time::numeric, 2) AS io_read_time,
      round(blk_write_time::numeric, 2) AS io_write_time,
      round((100 * total_exec_time / sum(total_exec_time) OVER ())::numeric, 2) AS percentage
FROM pg_stat_statements
ORDER BY blk_read_time + blk_write_time DESC
LIMIT 10;


SELECT query,
      calls,
      round(total_time::numeric, 2) AS total_time,
      round(blk_read_time::numeric, 2) AS io_read_time,
      round(blk_write_time::numeric, 2) AS io_write_time,
      round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage
FROM pg_stat_statements
ORDER BY blk_read_time + blk_write_time DESC
LIMIT 10;

\qecho <a name="sql_exec_shared_mem"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 最耗共享内存 SQL</b></font>

select * from pg_stat_statements order by shared_blks_hit+shared_blks_read desc limit 5;


\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>





----------------------------------------
------- 索引
----------------------------------------
\qecho <a name="index_info"></a>
\qecho <font size="+2" color="00CCFF"><b>索引</b></font><hr align="left" width="800">

\qecho <a name="index_no_scan"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 从未使用过的索引统计</b></font>

SELECT    
schemaname || '.' || relname AS table,
indexrelname AS index,
pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
idx_scan as index_scans
FROM pg_stat_user_indexes ui
JOIN pg_index i ON ui.indexrelid = i.indexrelid
WHERE NOT indisunique
AND idx_scan < 50
AND pg_relation_size(relid) > 5 * 8192
ORDER BY pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,
pg_relation_size(i.indexrelid) DESC;



\qecho <a name="index_top"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 占用空间最大的几个索引</b></font>

SELECT
    t.schemaname,
    t.tablename,
    c.reltuples::bigint                            AS num_rows,
    pg_size_pretty(pg_relation_size(c.oid))        AS table_size,
    psai.indexrelname                              AS index_name,
    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
    CASE WHEN i.indisunique THEN 'Y' ELSE 'N' END  AS "unique",
    psai.idx_scan                                  AS number_of_scans,
    psai.idx_tup_read                              AS tuples_read,
    psai.idx_tup_fetch                             AS tuples_fetched,
    pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)   as  create_index
FROM
    pg_tables t
    LEFT JOIN pg_class c ON t.tablename = c.relname
    LEFT JOIN pg_index i ON c.oid = i.indrelid
    LEFT JOIN pg_stat_all_indexes psai ON i.indexrelid = psai.indexrelid
WHERE t.schemaname NOT IN ('pg_catalog', 'information_schema')
AND pg_relation_size(i.indexrelid) > 0
ORDER BY pg_relation_size(i.indexrelid) DESC
limit 10;



\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>




----------------------------------------
------- 高可用情况
----------------------------------------
\qecho <a name="ha_info"></a>
\qecho <font size="+2" color="00CCFF"><b>高可用情况</b></font><hr align="left" width="800">

\qecho <a name="master_slave_stats"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 主从流复制情况</b></font>

\qecho <p>● 主库查看wal日志发送状态
select * from pg_stat_replication;

\qecho <p>● 从库查看wal日志接收状态
select * from pg_stat_wal_receiver;


\qecho <p>● 主从库延迟数据（单位MB）
select pg_wal_lsn_diff(A .c1, replay_lsn) /(1024 * 1024) AS slave_latency_MB
from pg_stat_replication,
     pg_current_wal_lsn() AS A(c1)
ORDER BY slave_latency_MB LIMIT 1;


\qecho <p>● 主从流复制冲突统计
select * from pg_stat_database_conflicts;



\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>



\qecho <a name="logical_stats"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 逻辑复制</b></font>

\qecho <p>● 查看发布
select * from pg_publication;

\qecho <p>● 查看发布的表
select * from pg_publication_tables;


\qecho <p>● 查看所有的订阅者
select * from pg_stat_replication;

\qecho <p>● 复制进度
select * from pg_stat_subscription;


\qecho <p>● 查看订阅
select * from pg_subscription;


\qecho <p>● 查看订阅的表
select *,srrelid::regclass from pg_subscription_rel; 


\qecho <p>● 查看复制槽
select * from pg_replication_slots;

\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>





----------------------------------------
------- 数据库性能
----------------------------------------
\qecho <a name="db_performance_info"></a>
\qecho <font size="+2" color="00CCFF"><b>数据库性能</b></font><hr align="left" width="800">

\qecho <a name="db_per_config_stats"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 相关参数</b></font>
\qecho <p>● 参数文件记录的参数
select * from pg_file_settings;
\qecho ● 重要参数
SELECT *
FROM   pg_settings a
WHERE  a.name IN ('data_directory',
                  'port',
                  'client_encoding',
                  'config_file',
                  'hba_file',
                  'ident_file',
                  'archive_mode',
                  'logging_collector',
                  'log_directory',
                  'log_filename',
                  'log_truncate_on_rotation',
                  'log_statement',
                  'log_min_duration_statement',
                  'max_connections',
                  'listen_addresses',
                  'shared_buffers')
ORDER  BY NAME;
-- show data_directory;
-- show config_file;
-- show hba_file;
-- show ident_file;
-- 查看当前会话的参数值
-- show all;
-- show archive_mode; -- 查看是否归档
-- show logging_collector;--启动日志收集
-- show log_directory;--日志输出路径
-- show log_filename;--日志文件名
-- show log_truncate_on_rotation;--当生成新的文件时如果文件名已存在，是否覆盖同名旧文件名
-- show log_statement;--设置日志记录内容
-- show log_min_duration_statement;--运行XX毫秒的语句会被记录到日志中，-1表示禁用这个功能，0表示记录所有语句，类似-- mysql的慢查询配置
-- 查看wal日志的配置，wal日志就是redo重做日志



\qecho <a name="pg_hba"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● pg_hba.conf配置文件信息（PG10新增）</b></font>
select * from pg_hba_file_rules;


\qecho
\qecho <a name="pg_stat_bgwriter"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 后台写进程统计信息</b></font>
select * from pg_stat_bgwriter;


\qecho
\qecho <a name="pg_stat_bgwriter"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● WAL日志切换频率（需要手动修改脚本路径）</b></font>
with tmp_file as (
  select t1.file,
      t1.file_ls,
      (pg_stat_file(t1.file)).size as size,
      (pg_stat_file(t1.file)).access as access,
      (pg_stat_file(t1.file)).modification as last_update_time,
      (pg_stat_file(t1.file)).change as change,
      (pg_stat_file(t1.file)).creation as creation,
      (pg_stat_file(t1.file)).isdir as isdir
   from (select dir||'/'||pg_ls_dir(t0.dir) as file,
          pg_ls_dir(t0.dir) as file_ls
       from ( select '/pg13/pgdata/pg_wal'::text as dir  -- 需要修改这个物理路径
          ) t0
      ) t1 
   where 1=1
   order by (pg_stat_file(file)).modification desc
) 
select to_char(date_trunc('day',tf0.last_update_time),'yyyymmdd') as day_id,
    sum(case when date_part('hour',tf0.last_update_time) >=0 and date_part('hour',tf0.last_update_time) <24 then 1 else 0 end) as wal_num_all,
    sum(case when date_part('hour',tf0.last_update_time) >=0 and date_part('hour',tf0.last_update_time) <1 then 1 else 0 end) as wal_num_00_01,
    sum(case when date_part('hour',tf0.last_update_time) >=1 and date_part('hour',tf0.last_update_time) <2 then 1 else 0 end) as wal_num_01_02,
    sum(case when date_part('hour',tf0.last_update_time) >=2 and date_part('hour',tf0.last_update_time) <3 then 1 else 0 end) as wal_num_02_03,
    sum(case when date_part('hour',tf0.last_update_time) >=3 and date_part('hour',tf0.last_update_time) <4 then 1 else 0 end) as wal_num_03_04,
    sum(case when date_part('hour',tf0.last_update_time) >=4 and date_part('hour',tf0.last_update_time) <5 then 1 else 0 end) as wal_num_04_05,
    sum(case when date_part('hour',tf0.last_update_time) >=5 and date_part('hour',tf0.last_update_time) <6 then 1 else 0 end) as wal_num_05_06,
    sum(case when date_part('hour',tf0.last_update_time) >=6 and date_part('hour',tf0.last_update_time) <7 then 1 else 0 end) as wal_num_06_07,
    sum(case when date_part('hour',tf0.last_update_time) >=7 and date_part('hour',tf0.last_update_time) <8 then 1 else 0 end) as wal_num_07_08,
    sum(case when date_part('hour',tf0.last_update_time) >=8 and date_part('hour',tf0.last_update_time) <9 then 1 else 0 end) as wal_num_08_09,
    sum(case when date_part('hour',tf0.last_update_time) >=9 and date_part('hour',tf0.last_update_time) <10 then 1 else 0 end) as wal_num_09_10,
    sum(case when date_part('hour',tf0.last_update_time) >=10 and date_part('hour',tf0.last_update_time) <11 then 1 else 0 end) as wal_num_10_11,
    sum(case when date_part('hour',tf0.last_update_time) >=11 and date_part('hour',tf0.last_update_time) <12 then 1 else 0 end) as wal_num_11_12,
    sum(case when date_part('hour',tf0.last_update_time) >=12 and date_part('hour',tf0.last_update_time) <13 then 1 else 0 end) as wal_num_12_13,
    sum(case when date_part('hour',tf0.last_update_time) >=13 and date_part('hour',tf0.last_update_time) <14 then 1 else 0 end) as wal_num_13_14,
    sum(case when date_part('hour',tf0.last_update_time) >=14 and date_part('hour',tf0.last_update_time) <15 then 1 else 0 end) as wal_num_14_15,
    sum(case when date_part('hour',tf0.last_update_time) >=15 and date_part('hour',tf0.last_update_time) <16 then 1 else 0 end) as wal_num_15_16,
    sum(case when date_part('hour',tf0.last_update_time) >=16 and date_part('hour',tf0.last_update_time) <17 then 1 else 0 end) as wal_num_16_17,
    sum(case when date_part('hour',tf0.last_update_time) >=17 and date_part('hour',tf0.last_update_time) <18 then 1 else 0 end) as wal_num_17_18,
    sum(case when date_part('hour',tf0.last_update_time) >=18 and date_part('hour',tf0.last_update_time) <19 then 1 else 0 end) as wal_num_18_19,
    sum(case when date_part('hour',tf0.last_update_time) >=19 and date_part('hour',tf0.last_update_time) <20 then 1 else 0 end) as wal_num_19_20,
    sum(case when date_part('hour',tf0.last_update_time) >=20 and date_part('hour',tf0.last_update_time) <21 then 1 else 0 end) as wal_num_20_21,
    sum(case when date_part('hour',tf0.last_update_time) >=21 and date_part('hour',tf0.last_update_time) <22 then 1 else 0 end) as wal_num_21_22,
    sum(case when date_part('hour',tf0.last_update_time) >=22 and date_part('hour',tf0.last_update_time) <23 then 1 else 0 end) as wal_num_22_23, 
    sum(case when date_part('hour',tf0.last_update_time) >=23 and date_part('hour',tf0.last_update_time) <24 then 1 else 0 end) as wal_num_23_24
from tmp_file tf0
where 1=1
 and tf0.file_ls not in ('archive_status')
group by to_char(date_trunc('day',tf0.last_update_time),'yyyymmdd')
order by to_char(date_trunc('day',tf0.last_update_time),'yyyymmdd') desc
;


\qecho
\qecho <a name="pg_wal"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● wal日志统计（PG14）</b></font>
SELECT * FROM pg_stat_wal ;



\qecho
\qecho <a name="pg_prepared_statements"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 统计软硬解析次数</b></font>
select * from pg_prepared_statements;



\qecho
\qecho <a name="pg_pz"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看当前库的表膨胀信息</b></font>
-- 统计信息需要准确
SELECT
    schemaname||'.'||relname as table_name,
    pg_size_pretty(pg_table_size(schemaname||'.'||relname)) as table_size,
    pg_size_pretty(pg_indexes_size(schemaname||'.'||relname)) as index_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||relname)) as all_size,
    pg_size_pretty(pg_table_size(schemaname||'.'||relname) *  (n_dead_tup * 100 / (n_live_tup + n_dead_tup))/100) as swell_size,
    n_dead_tup,
    n_live_tup,
    round(n_dead_tup * 100 / (n_live_tup + n_dead_tup),2) AS dead_tup_ratio,
    'vacuum full '||schemaname||'.'||relname||';' vacuums,
	'analyze ' || a.schemaname || '.' || a.relname||';' anaylze_tb
FROM pg_stat_all_tables a
WHERE   n_dead_tup >= 1000
and pg_table_size(schemaname||'.'||relname) >=1*1024*1024*1024
and round(n_dead_tup * 100 / (n_live_tup + n_dead_tup),2)  > 10
and pg_table_size(schemaname||'.'||relname) *  (n_dead_tup * 100 / (n_live_tup + n_dead_tup))/100 > 1*1024*1024*1024
ORDER BY pg_table_size(schemaname||'.'||relname) *  (n_dead_tup * 100 / (n_live_tup + n_dead_tup))/100   desc,dead_tup_ratio DESC
LIMIT 50;


/*


select pg_size_pretty(pg_table_size('test'));  -- 查询某个表或某个索引的大小
select pg_size_pretty(pg_relation_size('test')); -- 查询某个表或某个索引的大小
select pg_size_pretty(pg_indexes_size('test'));  -- 表上所有索引大小
select pg_size_pretty(pg_total_relation_size('test'));  -- 表+索引大小


*/




\qecho
\qecho <a name="pg_cache_hit"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 缓存命中率</b></font>





-- SELECT pg_stat_reset();
-- SELECT 'psql -d '||datname||' -c ''SELECT pg_stat_reset()''' FROM pg_database WHERE datname not in ('template0','template1');

SELECT * from (SELECT
datname,
blks_read::text blks_read,
blks_hit::text blks_hit,
xact_commit::text,
xact_rollback::text,
 trunc((blks_hit::numeric/(blks_read + blks_hit)) * 100,2)||'%'  cache_hit, 
 trunc((xact_commit::numeric/(xact_commit + xact_rollback)) * 100,2)||'%'  commit_hit,
 stats_reset::VARCHAR stats_reset
FROM pg_stat_database 
where datname not in ('template0','template1') 
and blks_read + blks_hit > 0 
ORDER BY cache_hit) aa
union all
select '------','','','','',
trunc(sum(blks_hit)/(sum(blks_read)+sum(blks_hit))*100,2)||'%' cache_hit,
trunc(sum(xact_commit)/(sum(xact_commit)+sum(xact_rollback))*100,2)||'%'  commit_hit,
''
 from pg_stat_database d 
where d.datname not in ('template0','template1') 
;



\qecho
\qecho <a name="pg_stat_db"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 数据库统计详情(坏块等)</b></font>
select * from pg_stat_database;


\qecho
\qecho <a name="pg_stat_io"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 数据库IO详情（PG16新增）</b></font>
SELECT * FROM pg_stat_io WHERE reads <> 0 OR writes <> 0 OR extends <> 0;



\qecho
\qecho <a name="pg_stat_replication_slots"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 复制槽活动信息（pg14）</b></font>
SELECT * FROM pg_stat_replication_slots ;



\qecho
\qecho <a name="pg_stat_progress_copy"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● copy进度（pg14）</b></font>
SELECT * FROM pg_stat_progress_copy ;



\qecho
\qecho <a name="pg_stat_slru"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 显示访问cached pages的统计信息（PG 13）</b></font>
select * from pg_stat_slru;



\qecho
\qecho <a name="pg_shmem_allocations"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看share buffer的使用情况（PG13）</b></font>
select * from pg_shmem_allocations;



\qecho
\qecho <a name="pg_stat_progress_basebackup"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查询备份进度（PG13）</b></font>
select * from pg_stat_progress_basebackup;



\qecho
\qecho <a name="pg_stat_progress_analyze"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查询analyze的进度（PG13）</b></font>
select * from pg_stat_progress_analyze;


\qecho
\qecho <a name="pg_stat_progress_create_index"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 新建或重建索引的过程跟踪（PG12）</b></font>
select * from pg_stat_progress_create_index;



\qecho
\qecho <a name="pg_stat_progress_cluster"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● cluster的各个阶段（PG12）</b></font>
select * from pg_stat_progress_cluster;


\qecho
\qecho <a name="pg_stat_progress_vacuum"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● vacuum的各个阶段（PG9.6）</b></font>
select * from pg_stat_progress_vacuum;



\qecho
\qecho <a name="pg_backend_memory_contexts"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看当前会话的内存上下文使用情况（PG14）</b></font>

SELECT *  from pg_backend_memory_contexts a order by a.used_bytes desc limit 100;



\qecho
\qecho <a name="pg_stats_ext"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看扩展统计信息定义（PG12）</b></font>

SELECT *  from pg_stats_ext limit 100;



\qecho
\qecho <a name="pg_statistic_ext_data"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看扩展统计信息详情（PG12）</b></font>

SELECT *  from pg_statistic_ext_data limit 100;


\qecho
\qecho <a name="pg_stats_ext_exprs"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 查看扩展统计信息对象中包含的表达式信息（PG14）</b></font>

SELECT *  from pg_stats_ext_exprs limit 100;




\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>



----------------------------------------
------- 其它
----------------------------------------

\qecho <a name="others_info"></a>
\qecho <font size="+2" color="00CCFF"><b>其它</b></font><hr align="left" width="800">


\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 所有角色(用户)</b></font>
select * from pg_roles;

\qecho <p>●  pg_user<p>
select * from pg_user;

\qecho <p>●  pg_shadow<p>
select * from pg_shadow;


\qecho <p>●  用户和角色（\du）<p>
SELECT r.rolname, r.rolsuper, r.rolinherit,
  r.rolcreaterole, r.rolcreatedb, r.rolcanlogin,
  r.rolconnlimit, r.rolvaliduntil,
  ARRAY(SELECT b.rolname
        FROM pg_catalog.pg_auth_members m
        JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
        WHERE m.member = r.oid) as memberof
, r.rolcreaterextgpfd
, r.rolcreatewextgpfd
, r.rolcreaterexthttp
, r.rolreplication
FROM pg_catalog.pg_roles r
ORDER BY 1;

-- 查询用户XX的权限，必须到指定的数据库下执行
-- select * from information_schema.table_privileges where grantee='XX';




\qecho <a name="user_and_role"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 当前库的所有schema</b></font>
select * from information_schema.schemata;
-- SELECT nspname FROM pg_namespace;
-- \dnS

\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 所有语言</b></font>
select * from pg_language;




\qecho <a name="extensions_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 所有可用插件 </b></font>

\qecho <p>● 所有插件（已编译）
select * from pg_available_extensions ;


\qecho <p>● 已安装的插件
SELECT e.extname AS "Name", e.extversion AS "Version", n.nspname AS "Schema", c.description AS "Description"
FROM pg_catalog.pg_extension e LEFT JOIN pg_catalog.pg_namespace n ON n.oid = e.extnamespace LEFT JOIN pg_catalog.pg_description c ON c.objoid = e.oid AND c.classoid = 'pg_catalog.pg_extension'::pg_catalog.regclass
ORDER BY 1;



\qecho <a name="pg_config_info"></a>
\qecho <p><font size="+1" face="Consolas" color="#336699"><b>● 获取已安装的PostgreSQL的信息 </b></font>

SELECT * FROM pg_config ;


\qecho <a name="html_bottom_link"></a>
\qecho <center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>
\qecho <hr><p><p>


