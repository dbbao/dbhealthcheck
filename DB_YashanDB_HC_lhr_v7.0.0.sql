
SET FEEDBACK OFF
SET HEADING off
SET TIMING off




SPOOL yashandb.html



SELECT '
<html lang="en"><head><title>崖山数据库巡检报告</title> <style type="text/css">
body.awr {font:bold 10pt Consolas;color:black;background:White;}
table  {font:11px Consolas; color:Black; background:#FFFFCC; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px; cellspacing:0px;border:1px solid black;border-collapse:collapse;}
th  {font:bold 11px Consolas;  border:1px solid black;color:White; background:#0066cc; padding:5px; cellspacing:0px;border-collapse:collapse;white-space: nowrap;}
td {font-family:Consolas;  border:1px solid black;white-space: nowrap;}
tr:nth-child(odd) {background:White;}
tr:hover   {background-color: yellow;}
h1.awr     {font:bold 20pt Consolas;color:#336699;background-color:White;margin-top:0pt; margin-bottom:0pt;padding:0px 0px 0px 0px;}
h2.awr     {font:bold 13pt Consolas;color:#336699;background-color:White;margin-top:0pt; margin-bottom:0pt;}
th.awrbg   {font:bold 10pt Consolas; color:White; background:#0066CC;padding:5px;}
th.awrnc   {font:9pt Consolas;color:black;background:White;}
th.awrc    {font:9pt Consolas;color:black;background:#FFFFCC;}
td.awrnc   {font:9pt Consolas;color:black;background:White;vertical-align:middle;padding:4;}
a.info:hover {background:#eee;color:#000000; position:relative;}
a.info span {display: none; }
a.info:hover span {font-size:11px!important; color:#000000; display:block;position:absolute;top:30px;left:40px;width:150px;border:1px solid #ff0000; background:#FFFF00; padding:1px 1px;text-align:left;word-wrap: break-word; white-space: pre-wrap;}
td.awrc    {font:9pt Consolas;color:black;background:#FFFFCC; vertical-align:middle;padding:4;}</style></head>
<body class="awr">
' from v$database;


-- 跑马灯
select '
<Marquee  align="absmiddle" scrolldelay="100" behavior="alternate" direction="left" onmouseover="this.stop()" onmouseout="this.start()" bgcolor="#FFCC00"  height=18 width=100%  vspace="1" hspace="1"><font face="Consolas" color="#008B00" size="2"> <div style="font-weight:lighter">巡检人:小麦苗　QQ:646634621　微信公众号：DB宝　提供OCP、OCM、高可用（rac+dg）、PostgreSQL和MySQL培训和考证服务　BLOG地址: <a target="_blank"  href=https://www.xmmup.com><font size="2">https://www.xmmup.com</font></a> 若需要脚本可私聊我</div></font></Marquee>
' from dual;

-- 标题
select '
<center><font size=+3 color=darkgreen><b>崖山数据库'||DATABASE_NAME||'巡检报告</b></font></center><hr>
<a name=top></a>
<hr>
<div style="font-weight:lighter"><font face="Consolas" color="#336699">Copyright (c) 2015-2100 (https://www.xmmup.com) <a target="_blank" href="https://www.xmmup.com">xmmup</a>. All rights reserved.</font></div>
<p>
<a style="font-weight:lighter">巡 检 人：小麦苗([QQ：646634621]   [微信公众号：DB宝]   [提供OCP、OCM、高可用、MySQL和PostgreSQL最实用的培训和考证服务])</a></br>
<a style="font-weight:lighter">版 本 号：v7.0.0</a></br>
<a style="font-weight:lighter">修改日期：2023-11-21</a></br>
<a style="font-weight:lighter">巡检日期：'||to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')||'</a></br>
<p>
[<a class="noLink" href="#html_bottom_link"  style="font-weight:lighter">转到页底</a>]
<hr>
' from v$database;

-- 目录
select '
<a name="directory"><font size=+2 face="Consolas" color="#336699"><b>目录</b></font></a>
<hr>
<table width="100%" border="1" bordercolor="#000000" cellspacing="0px" style="border-collapse:collapse; margin-top:0.3cm;" align="center">
<tr>
<td style="background-color:#FFCC00" rowspan="2"  nowrap align="center" width="10%"><a class="info" href="#db_info_link"><font size=+0.5 face="Consolas" color="#000000"><b>总体概况</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#version_info"><font size=2.5 face="Consolas" color="#336699">崖山版本信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#dm_license_info"><font size=2.5 face="Consolas" color="#336699">崖山实例信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#db_other_info"><font size=2.5 face="Consolas" color="#336699">数据库服务器信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#db_server_info"><font size=2.5 face="Consolas" color="#336699"><span>其它信息</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#db_base_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#instance_base_info"><font size=2.5 face="Consolas" color="#336699"><span>表空间情况</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#ts_info"><font size=2.5 face="Consolas" color="#336699"> <span>数据文件情况</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#datafile_info"><font size=2.5 face="Consolas" color="#336699"><span>控制文件</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#dba_users_info"><font size=2.5 face="Consolas" color="#336699">Redo日志文件<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#dm_ini_info"><font size=2.5 face="Consolas" color="#336699">临时文件<span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#obj_info"><font size=+0.5 face="Consolas" color="#000000"><b>对象统计</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#obj_count_info"><font size=2.5 face="Consolas" color="#336699">所有用户<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#table_size_top10_info"><font size=2.5 face="Consolas" color="#336699">所有参数<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#table_rows_top10_info"><font size=2.5 face="Consolas" color="#336699">行数最多的表top10<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#table_size_top"><font size=2.5 face="Consolas" color="#336699">最大的表top10<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#user_index_top10_info"><font size=2.5 face="Consolas" color="#336699">用户、索引和表TOP<span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#arch_info"><font size=+0.5 face="Consolas" color="#000000"><b>Undo统计</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#redo_info"><font size=2.5 face="Consolas" color="#336699">Undo段信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#arch_set_info"><font size=2.5 face="Consolas" color="#336699">近一周归档日志切换情况<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#arch_swich_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#arch_7_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#backup_info"><font size=+0.5 face="Consolas" color="#000000"><b>备份情况</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#backup_base_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#backup_db_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#backup_dbfile_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#backup_search_dirs_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#backup_table_info"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#sql_info"><font size=+0.5 face="Consolas" color="#000000"><b>SQL部分</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_long_info"><font size=2.5 face="Consolas" color="#336699">数据库最慢的20条SQL<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_top_mem_info"><font size=2.5 face="Consolas" color="#336699">数据库高内存的20条SQL<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_top_mtab_info"><font size=2.5 face="Consolas" color="#336699">数据库高MTAB的20条SQL</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_top_sort_info"><font size=2.5 face="Consolas" color="#336699">数据库排序页最多的SQL</span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_top_hashjoin_info"><font size=2.5 face="Consolas" color="#336699">数据库HASH连接最多的SQL<span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#job_info"><font size=+0.5 face="Consolas" color="#000000"><b>JOB部分</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#job_info_group"><font size=2.5 face="Consolas" color="#336699">JOB运行情况<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#all_job"><font size=2.5 face="Consolas" color="#336699">所有JOB<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"></span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"></span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#asm_info"><font size=+0.5 face="Consolas" color="#000000"><b>磁盘部分</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#asmgroup_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#asm_disk_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#asm_file_info"><font size=2.5 face="Consolas" color="#336699"> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"></span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#session_info"><font size=+0.5 face="Consolas" color="#000000"><b>会话情况</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#session_info_group"><font size=2.5 face="Consolas" color="#336699">状态汇总<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#deadlock_history"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#lock_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#wait_info"><font size=2.5 face="Consolas" color="#336699">等待事件<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#mem_info"><font size=+0.5 face="Consolas" color="#000000"><b>内存统计</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#db_cache_info"><font size=2.5 face="Consolas" color="#336699">DB_CACHE<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#bufferpool_info"><font size=2.5 face="Consolas" color="#336699">BUFFERPOOL<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#mem_pool_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#others_info"><font size=+0.5 face="Consolas" color="#000000"><b>其它</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#dba_db_links_info"><font size=2.5 face="Consolas" color="#336699">DBA_DB_LINKS<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#identity_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#sql_error_info"><font size=2.5 face="Consolas" color="#336699">错误信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#awr_info"><font size=2.5 face="Consolas" color="#336699">AWR信息<span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#dba_directories_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
</tr>
<tr>
<td style="background-color:#FFCC00" rowspan="1"  nowrap align="center" width="10%"><a class="info" href="#ha_info"><font size=+0.5 face="Consolas" color="#000000"><b>高可用</b><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#ha_rep_info"><font size=2.5 face="Consolas" color="#336699"> <span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
<td nowrap align="center"   style="background-color:#FFFFCC" ><a class="info" href="#"><font size=2.5 face="Consolas" color="#336699"><span> </span></font></a></td>
</tr>
</table>
<br />
<hr>
<br />' 
from dual;




select '<a name="db_info_link"></a><font size="+2" color="00CCFF"><b>总体概况</b></font><hr align="left" width="800">' from dual;


-- 崖山版本信息
select '<a name="version_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 崖山版本信息</b></font>' from dual;


SELECT '<table border=1><tr><th>BANNER'||'</th><th>VERSION_NUMBER'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||BANNER||'</td><td>'||VERSION_NUMBER||'</td></tr>' from V$VERSION 

union all 
select '</table>' from dual;



-- 实例信息
select '<a name="instance_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 实例信息</b></font>'  from dual;

SELECT '<table border=1><tr><th>STATUS'||'</th><th>VERSION'||'</th><th>STARTUP_TIME'||'</th><th>HOST_NAME'||'</th><th>DATA_HOME'||'</th><th>INSTANCE_NUMBER'||'</th><th>INSTANCE_NAME'||'</th><th>PARALLEL'||'</th><th>INSTANCE_ROLE'||'</th><th>IN_REFORM'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||STATUS||'</td><td>'||VERSION||'</td><td>'||STARTUP_TIME||'</td><td>'||HOST_NAME||'</td><td>'||DATA_HOME||'</td><td>'||INSTANCE_NUMBER||'</td><td>'||INSTANCE_NAME||'</td><td>'||PARALLEL||'</td><td>'||INSTANCE_ROLE||'</td><td>'||IN_REFORM||'</td></tr>' from v$instance 

union all 
select '</table>' from dual;





-- 数据库基本信息
select '<a name="db_base_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 数据库基本信息</b></font>' from DUAL;

SELECT '<table border=1><tr><th>DATABASE_ID'||'</th><th>DATABASE_NAME'||'</th><th>CREATE_TIME'||'</th><th>LOG_MODE'||'</th><th>OPEN_MODE'||'</th><th>PROTECTION_MODE'||'</th><th>PROTECTION_LEVEL'||'</th><th>DATABASE_ROLE'||'</th><th>BLOCK_SIZE'||'</th><th>CURRENT_SCN'||'</th><th>STATUS'||'</th><th>RCY_POINT'||'</th><th>FLUSH_POINT'||'</th><th>RESET_POINT'||'</th><th>PLATFORM_NAME'||'</th><th>HOST_NAME'||'</th><th>RESTORE_TIME'||'</th><th>SWITCHOVER_STATUS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||DATABASE_ID||'</td><td>'||DATABASE_NAME||'</td><td>'||CREATE_TIME||'</td><td>'||LOG_MODE||'</td><td>'||OPEN_MODE||'</td><td>'||PROTECTION_MODE||'</td><td>'||PROTECTION_LEVEL||'</td><td>'||DATABASE_ROLE||'</td><td>'||BLOCK_SIZE||'</td><td>'||CURRENT_SCN||'</td><td>'||STATUS||'</td><td>'||RCY_POINT||'</td><td>'||FLUSH_POINT||'</td><td>'||RESET_POINT||'</td><td>'||PLATFORM_NAME||'</td><td>'||HOST_NAME||'</td><td>'||RESTORE_TIME||'</td><td>'||SWITCHOVER_STATUS||'</td></tr>' from V$DATABASE 

union all 
select '</table>' from dual;


select '<p><font size="+1" face="Consolas" color="#336699"><b>● 数据库其它信息</b></font>' from DUAL;
SELECT '<table border=1><tr><th>项目'||'</th><th>值'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||项目||'</td><td>'||值||'</td></tr>' from 
(

SELECT '字符集' 项目, USERENV('LANGUAGE') 值  FROM DUAL
UNION ALL 
SELECT '数据库大小', sum(bytes)/1024/1024||' MB' dbsize_MB FROM DBA_SEGMENTS

) 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>' from DUAL;



-- 表空间情况
select '<a name="ts_info"></a><font size="+2" color="00CCFF"><b>表空间情况</b></font><hr align="left" width="800">' from DUAL;

select '<a name="ts_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 表空间情况</b></font>' from DUAL;

SELECT '<table border=1><tr><th>ID'||'</th><th>TABLESPACE_NAME'||'</th><th>MAX_SIZE_MB'||'</th><th>TOTAL_SIZE_MB'||'</th><th>TS_USED_SIZE_MB'||'</th><th>STATUS'||'</th><th>CONTENTS'||'</th><th>LOGGING'||'</th><th>ALLOCATION_TYPE'||'</th><th>BLOCK_SIZE'||'</th><th>SEGMENT_SPACE_MANAGEMENT'||'</th><th>ENCRYPTED'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||ID||'</td><td>'||TABLESPACE_NAME||'</td><td>'||MAX_SIZE_MB||'</td><td>'||TOTAL_SIZE_MB||'</td><td>'||TS_USED_SIZE_MB||'</td><td>'||STATUS||'</td><td>'||CONTENTS||'</td><td>'||LOGGING||'</td><td>'||ALLOCATION_TYPE||'</td><td>'||BLOCK_SIZE||'</td><td>'||SEGMENT_SPACE_MANAGEMENT||'</td><td>'||ENCRYPTED||'</td></tr>' from 
(

SELECT ID,dt.TABLESPACE_NAME,
MAX_SIZE/1024/1024 MAX_SIZE_MB,TOTAL_BYTES/1024/1024 TOTAL_SIZE_MB,ts_used_size_MB,
STATUS,CONTENTS,LOGGING,ALLOCATION_TYPE,BLOCK_SIZE,
SEGMENT_SPACE_MANAGEMENT,ENCRYPTED 
FROM DBA_TABLESPACES dt 
LEFT JOIN (SELECT tablespace_name,sum(bytes)/1024/1024  ts_used_size_MB
FROM DBA_SEGMENTS d 
GROUP BY d.tablespace_name) eg
ON dt.TABLESPACE_NAME=eg.TABLESPACE_NAME


) 

union all 
select '</table>' from dual;



select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>' from DUAL;


-- 数据文件
select '<a name="datafile_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 数据文件情况</b></font>' from DUAL;

SELECT '<table border=1><tr><th>FILE_NAME'||'</th><th>FILE_ID'||'</th><th>TABLESPACE_NAME'||'</th><th>BYTES'||'</th><th>BLOCKS'||'</th><th>STATUS'||'</th><th>MAXBYTES'||'</th><th>MAXBLOCKS'||'</th><th>AUTO_EXTEND'||'</th><th>NEXT_SIZE'||'</th><th>USER_BYTES'||'</th><th>USER_BLOCKS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||FILE_NAME||'</td><td>'||FILE_ID||'</td><td>'||TABLESPACE_NAME||'</td><td>'||BYTES||'</td><td>'||BLOCKS||'</td><td>'||STATUS||'</td><td>'||MAXBYTES||'</td><td>'||MAXBLOCKS||'</td><td>'||AUTO_EXTEND||'</td><td>'||NEXT_SIZE||'</td><td>'||USER_BYTES||'</td><td>'||USER_BLOCKS||'</td></tr>' from DBA_DATA_FILES 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;


-- 控制文件
select '<a name="control_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 控制文件情况</b></font>' from DUAL;

SELECT '<table border=1><tr><th>ID'||'</th><th>NAME'||'</th><th>BLOCK_SIZE'||'</th><th>FILE_SIZE_BLKS'||'</th><th>BYTES'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||ID||'</td><td>'||NAME||'</td><td>'||BLOCK_SIZE||'</td><td>'||FILE_SIZE_BLKS||'</td><td>'||BYTES||'</td></tr>' from V$CONTROLFILE 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- Redo日志文件
select '<a name="redo_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● Redo日志文件情况</b></font>' from DUAL;

SELECT '<table border=1><tr><th>THREAD#'||'</th><th>ID'||'</th><th>NAME'||'</th><th>BLOCK_SIZE'||'</th><th>BLOCK_COUNT'||'</th><th>USED_BLOCKS'||'</th><th>SEQUENCE#'||'</th><th>STATUS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||THREAD#||'</td><td>'||ID||'</td><td>'||NAME||'</td><td>'||BLOCK_SIZE||'</td><td>'||BLOCK_COUNT||'</td><td>'||USED_BLOCKS||'</td><td>'||SEQUENCE#||'</td><td>'||STATUS||'</td></tr>' from V$LOGFILE 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;


-- 临时文件信息
select '<a name="tempfile_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 临时文件信息</b></font>' from dual;
SELECT '<table border=1><tr><th>FILE_ID'||'</th><th>FILE_NAME'||'</th><th>STATUS'||'</th><th>SIZE_MB'||'</th><th>AUTOEXTENSIBLE'||'</th><th>TABLESPACE_NAME'||'</th><th>MAXSIZE_MB'||'</th><th>INCREMENT_BY'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||FILE_ID||'</td><td>'||FILE_NAME||'</td><td>'||STATUS||'</td><td>'||SIZE_MB||'</td><td>'||AUTOEXTENSIBLE||'</td><td>'||TABLESPACE_NAME||'</td><td>'||MAXSIZE_MB||'</td><td>'||INCREMENT_BY||'</td></tr>' from (SELECT FILE_ID,FILE_NAME,STATUS,BYTES/1024/1024 SIZE_MB,AUTOEXTENSIBLE,TABLESPACE_NAME,MAXBYTES/1024/1024 MAXSIZE_MB,INCREMENT_BY FROM DBA_TEMP_FILES) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- 所有用户
select '<a name="dba_users_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 所有用户</b></font>' from dual;
SELECT '<table border=1><tr><th>USERNAME'||'</th><th>USER_ID'||'</th><th>PASSWORD'||'</th><th>ACCOUNT_STATUS'||'</th><th>LOCK_DATE'||'</th><th>EXPIRY_DATE'||'</th><th>DEFAULT_TABLESPACE'||'</th><th>CREATED'||'</th><th>AUTHENTICATION_TYPE'||'</th><th>LAST_LOGIN'||'</th><th>PASSWORD_CHANGE_DATE'||'</th><th>DATABASE_MAINTAINED'||'</th><th>PROFILE'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||USERNAME||'</td><td>'||USER_ID||'</td><td>'||PASSWORD||'</td><td>'||ACCOUNT_STATUS||'</td><td>'||LOCK_DATE||'</td><td>'||EXPIRY_DATE||'</td><td>'||DEFAULT_TABLESPACE||'</td><td>'||CREATED||'</td><td>'||AUTHENTICATION_TYPE||'</td><td>'||LAST_LOGIN||'</td><td>'||PASSWORD_CHANGE_DATE||'</td><td>'||DATABASE_MAINTAINED||'</td><td>'||PROFILE||'</td></tr>' from DBA_USERS 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;



-- 所有用户角色
select '<a name="dba_users_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 所有用户角色</b></font>' from dual;
SELECT '<table border=1><tr><th>GRANTEE'||'</th><th>PRIVILEGE'||'</th><th>PRIVILEGE_TYPE'||'</th><th>ADMIN_OPTION'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||GRANTEE||'</td><td>'||PRIVILEGE||'</td><td>'||PRIVILEGE_TYPE||'</td><td>'||ADMIN_OPTION||'</td></tr>' from 
(SELECT *
FROM   (SELECT GRANTEE,
               GRANTED_ROLE PRIVILEGE,
               'ROLE_PRIVS' PRIVILEGE_TYPE,
               CASE ADMIN_OPTION
                   WHEN 'Y' THEN
                    'YES'
                   ELSE
                    'NO'
               END ADMIN_OPTION
        FROM   DBA_ROLE_PRIVS
        UNION
        SELECT GRANTEE,
               PRIVILEGE,
               'SYS_PRIVS' PRIVILEGE_TYPE,
               ADMIN_OPTION
        FROM   DBA_SYS_PRIVS
        UNION
        SELECT GRANTEE,
               PRIVILEGE || ' ON ' || OWNER || '.' || TABLE_NAME PRIVILEGE,
               'TABLE_PRIVS' PRIVILEGE_TYPE,
               GRANTABLE
        FROM   DBA_TAB_PRIVS) T
WHERE  T.GRANTEE IN
       (SELECT USERNAME
        FROM   ALL_USERS A
        WHERE  A.USERNAME NOT IN ('SYS', 'SYSDBA', 'SYSSSO', 'SYSAUDITOR'))
ORDER  BY GRANTEE,
          PRIVILEGE_TYPE,
          PRIVILEGE) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- 所有参数
select '<a name="dm_ini_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 所有参数</b></font>[<a class="noLink" href="#obj_info">下一项</a>]'  from dual;

SELECT '<table border=1><tr><th>NAME'||'</th><th>VALUE'||'</th><th>DEFAULT_VALUE'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||NAME||'</td><td>'||VALUE||'</td><td>'||DEFAULT_VALUE||'</td></tr>' from V$PARAMETER 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;


select '<a name="obj_info"></a>' from dual;
select '<a name="obj_info"></a><font size="+2" color="00CCFF"><b>推荐参数</b></font>[<a class="noLink" href="#dm_ini_info">上一项</a>]<hr align="left" width="800">' from dual;

EXEC DBMS_PARAM.OPTIMIZE();

SELECT '<table border=1><tr><th>RECOMMEND_SETTINGS'||'</th></tr>' from dual

union all 
SELECT '<tr><td><textarea style="width:600px;font-family:Consolas;font-size:12px;overflow:auto" rows="40"> '||RECOMMEND_SETTINGS  from (SELECT DBMS_PARAM.SHOW_RECOMMEND() AS recommend_settings FROM dual) 

union all 
select '</textarea></td></tr></table>' from dual;



select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;








-- 对象统计
select '<a name="obj_info"></a>' from dual;
select '<a name="obj_info"></a><font size="+2" color="00CCFF"><b>对象统计</b></font>[<a class="noLink" href="#dm_ini_info">上一项</a>]<hr align="left" width="800">' from dual;

SELECT '<table border=1><tr><th>OWNER'||'</th><th>OBJECT_TYPE'||'</th><th>CNT'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||OWNER||'</td><td>'||OBJECT_TYPE||'</td><td>'||CNT||'</td></tr>' from (
SELECT d.owner,
       d.object_type,
       COUNT(*) cnt
FROM   dba_objects d
WHERE  d.owner NOT IN ('SYS', 'SYSDBA', 'SYSSSO', 'CTISYS', 'SYSAUDITOR')
GROUP  BY d.owner,d.object_type
) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




select '<a name="table_size_top10_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 最大的表top10</b></font>' from dual;
SELECT '<table border=1><tr><th>OWNER'||'</th><th>SEGMENT_NAME'||'</th><th>TABLESPACE_NAME'||'</th><th>SIZE_MB'||'</th><th>NUM_ROWS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||OWNER||'</td><td>'||SEGMENT_NAME||'</td><td>'||TABLESPACE_NAME||'</td><td>'||SIZE_MB||'</td><td>'||NUM_ROWS||'</td></tr>' from (
SELECT * FROM (
SELECT  d.owner,
       d.segment_name,
       d.tablespace_name,
       SUM(d.bytes) / 1024 / 1024 size_mb,
       (select num_rows from dba_tables nb where table_name=d.segment_name and nb.owner=d.owner) num_rows
FROM   dba_segments d
GROUP  BY d.owner,
          d.segment_name,
          d.tablespace_name
ORDER  BY size_mb DESC)
WHERE rownum<=10
) 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;





select '<a name="table_rows_top10_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 行数最多的表top10</b></font>' from dual;

SELECT '<table border=1><tr><th>OWNER'||'</th><th>TABLE_NAME'||'</th><th>TABLESPACE_NAME'||'</th><th>STATUS'||'</th><th>NUM_ROWS'||'</th><th>SIZE_MB'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||OWNER||'</td><td>'||TABLE_NAME||'</td><td>'||TABLESPACE_NAME||'</td><td>'||STATUS||'</td><td>'||NUM_ROWS||'</td><td>'||SIZE_MB||'</td></tr>' from 
(

SELECT * FROM (SELECT  owner,
       table_name,
       tablespace_name,
       status,
       num_rows,
       (select sum(bytes)/1024/1024 from dba_segments nb where segment_name=dt.table_name and nb.owner=dt.owner) size_mb
FROM   dba_tables dt
WHERE  owner NOT IN ('SYS', 'SYSAUDITOR', 'SYSSSO', 'CTISYS')
and dt.num_rows >=10
ORDER  BY num_rows DESC)
WHERE rownum<=10
) 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- Undo统计
select '<a name="undo_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● Undo统计</b></font>' from dual;
SELECT '<table border=1><tr><th>ID'||'</th><th>BLK_REUSE'||'</th><th>BALANCE_TIME'||'</th><th>BALANCE'||'</th><th>BALANCE_BLK'||'</th><th>RECYCLE_TIME'||'</th><th>RECYCLE_LIST'||'</th><th>RECYCLE_LIST_BLK'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||ID||'</td><td>'||BLK_REUSE||'</td><td>'||BALANCE_TIME||'</td><td>'||BALANCE||'</td><td>'||BALANCE_BLK||'</td><td>'||RECYCLE_TIME||'</td><td>'||RECYCLE_LIST||'</td><td>'||RECYCLE_LIST_BLK||'</td></tr>' from
 (
SELECT ID,BLK_REUSE,BALANCE_TIME,BALANCE,BALANCE_BLK,RECYCLE_TIME,RECYCLE_LIST,RECYCLE_LIST_BLK FROM V$UNDOSTAT
) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- Undo段信息
select '<a name="undo_segment_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● Undo段信息</b></font>' from dual;
SELECT '<table border=1><tr><th>ID'||'</th><th>USED_TIME'||'</th><th>FIRST_UBAFIL'||'</th><th>FIRST_UBABLK'||'</th><th>LAST_UBAFIL'||'</th><th>LAST_UBABLK'||'</th><th>UFB_COUNT'||'</th><th>FIRST_UFBFIL'||'</th><th>FIRST_UFBBLK'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||ID||'</td><td>'||USED_TIME||'</td><td>'||FIRST_UBAFIL||'</td><td>'||FIRST_UBABLK||'</td><td>'||LAST_UBAFIL||'</td><td>'||LAST_UBABLK||'</td><td>'||UFB_COUNT||'</td><td>'||FIRST_UFBFIL||'</td><td>'||FIRST_UFBBLK||'</td></tr>' from 
(SELECT ID,USED_TIME,FIRST_UBAFIL,FIRST_UBABLK,LAST_UBAFIL,LAST_UBABLK,UFB_COUNT,FIRST_UFBFIL,FIRST_UFBBLK FROM V$UNDO_SEGMENTS) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;







-- 归档情况
select '<a name="arch_swich_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 近一周归档日志切换情况</b></font>' from dual;
SELECT '<table border=1><tr><th>DAY'||'</th><th>H00'||'</th><th>H01'||'</th><th>H02'||'</th><th>H03'||'</th><th>H04'||'</th><th>H05'||'</th><th>H06'||'</th><th>H07'||'</th><th>H08'||'</th><th>H09'||'</th><th>H10'||'</th><th>H11'||'</th><th>H12'||'</th><th>H13'||'</th><th>H14'||'</th><th>H15'||'</th><th>H16'||'</th><th>H17'||'</th><th>H18'||'</th><th>H19'||'</th><th>H20'||'</th><th>H21'||'</th><th>H22'||'</th><th>H23'||'</th><th>TOTAL'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||DAY||'</td><td>'||H00||'</td><td>'||H01||'</td><td>'||H02||'</td><td>'||H03||'</td><td>'||H04||'</td><td>'||H05||'</td><td>'||H06||'</td><td>'||H07||'</td><td>'||H08||'</td><td>'||H09||'</td><td>'||H10||'</td><td>'||H11||'</td><td>'||H12||'</td><td>'||H13||'</td><td>'||H14||'</td><td>'||H15||'</td><td>'||H16||'</td><td>'||H17||'</td><td>'||H18||'</td><td>'||H19||'</td><td>'||H20||'</td><td>'||H21||'</td><td>'||H22||'</td><td>'||H23||'</td><td>'||TOTAL||'</td></tr>' from
(

SELECT LEFT(FIRST_TIME, 10) DAY                            ,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '00', 1, 0)) H00,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '01', 1, 0)) H01,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '02', 1, 0)) H02,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '03', 1, 0)) H03,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '04', 1, 0)) H04,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '05', 1, 0)) H05,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '06', 1, 0)) H06,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '07', 1, 0)) H07,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '08', 1, 0)) H08,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '09', 1, 0)) H09,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '10', 1, 0)) H10,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '11', 1, 0)) H11,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '12', 1, 0)) H12,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '13', 1, 0)) H13,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '14', 1, 0)) H14,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '15', 1, 0)) H15,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '16', 1, 0)) H16,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '17', 1, 0)) H17,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '18', 1, 0)) H18,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '19', 1, 0)) H19,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '20', 1, 0)) H20,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '21', 1, 0)) H21,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '22', 1, 0)) H22,
        SUM(DECODE(SUBSTR(FIRST_TIME, 12, 2), '23', 1, 0)) H23,
        COUNT(*) TOTAL
FROM  V$ARCHIVED_LOG
WHERE FIRST_TIME>=(SYSDATE-7)
GROUP BY LEFT(FIRST_TIME, 10)
ORDER BY LEFT(FIRST_TIME, 10) desc

) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;







-- 会话情况

select '<a name="session_info"></a><font size="+2" color="00CCFF"><b>会话情况</b></font><hr align="left" width="800">' from DUAL;


select '<a name="session_info_group"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 状态汇总</b></font>' from DUAL;
SELECT '<table border=1><tr><th>STATUS'||'</th><th>CNT'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||STATUS||'</td><td>'||CNT||'</td></tr>' from (select count(*) cnt,status from v$session group by status) 

union all 
select '</table>'   from dual;





select '<p><font size="+1" face="Consolas" color="#336699"><b>● 客户端汇总</b></font>' from DUAL;
SELECT '<table border=1><tr><th>STATUS'||'</th><th>USERNAME'||'</th><th>CLI_OSUSER'||'</th><th>CLI_HOSTNAME'||'</th><th>CLI_PROGRAM'||'</th><th>IP_ADDRESS'||'</th><th>CNT'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||STATUS||'</td><td>'||USERNAME||'</td><td>'||CLI_OSUSER||'</td><td>'||CLI_HOSTNAME||'</td><td>'||CLI_PROGRAM||'</td><td>'||IP_ADDRESS||'</td><td>'||CNT||'</td></tr>' from (
SELECT COUNT(*) cnt,
       a.ip_address,
	   a.cli_program,
       a.cli_hostname,
       a.cli_osuser,
	   a.USERNAME,
	   a.status
FROM   v$session a
GROUP  BY a.ip_address,
	   a.cli_program,
       a.cli_hostname,
       a.cli_osuser,
	   a.USERNAME,
	   a.status
ORDER  BY COUNT(*) desc
) 

union all 
select '</table>'   from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;



-- 等待事件
select '<a name="wait_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 等待事件</b></font>' from DUAL;
SELECT '<table border=1><tr><th>EVENT'||'</th><th>TOTAL_WAITS'||'</th><th>TOTAL_TIMEOUTS'||'</th><th>TIME_WAITED'||'</th><th>AVERAGE_WAIT'||'</th><th>TIME_WAITED_MICRO'||'</th><th>TOTAL_WAITS_FG'||'</th><th>TOTAL_TIMEOUTS_FG'||'</th><th>TIME_WAITED_FG'||'</th><th>AVERAGE_WAIT_FG'||'</th><th>TIME_WAITED_MICRO_FG'||'</th><th>EVENT_ID'||'</th><th>WAIT_CLASS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||EVENT||'</td><td>'||TOTAL_WAITS||'</td><td>'||TOTAL_TIMEOUTS||'</td><td>'||TIME_WAITED||'</td><td>'||AVERAGE_WAIT||'</td><td>'||TIME_WAITED_MICRO||'</td><td>'||TOTAL_WAITS_FG||'</td><td>'||TOTAL_TIMEOUTS_FG||'</td><td>'||TIME_WAITED_FG||'</td><td>'||AVERAGE_WAIT_FG||'</td><td>'||TIME_WAITED_MICRO_FG||'</td><td>'||EVENT_ID||'</td><td>'||WAIT_CLASS||'</td></tr>' from 
(
SELECT * FROM (SELECT  * FROM V$SYSTEM_EVENT ORDER BY TOTAL_WAITS DESC) WHERE rownum<=20
) 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-- 其它
select '<a name="others_info"></a><font size="+2" color="00CCFF"><b>其它</b></font><hr align="left" width="800">' from DUAL;

-- dblink
select '<a name="dba_db_links_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● DBA_DB_LINKS</b></font>' from DUAL;
SELECT '<table border=1><tr><th>OWNER'||'</th><th>DB_LINK'||'</th><th>USERNAME'||'</th><th>PASSWORD'||'</th><th>CREDENTIAL_NAME'||'</th><th>CREDENTIAL_OWNER'||'</th><th>HOST'||'</th><th>CREATED'||'</th><th>HIDDEN'||'</th><th>SHARD_INTERNAL'||'</th><th>VALID'||'</th><th>INTRA_CDB'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||OWNER||'</td><td>'||DB_LINK||'</td><td>'||USERNAME||'</td><td>'||PASSWORD||'</td><td>'||CREDENTIAL_NAME||'</td><td>'||CREDENTIAL_OWNER||'</td><td>'||HOST||'</td><td>'||CREATED||'</td><td>'||HIDDEN||'</td><td>'||SHARD_INTERNAL||'</td><td>'||VALID||'</td><td>'||INTRA_CDB||'</td></tr>' from DBA_DB_LINKS 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




-------- AWR
select '<a name="awr_info"></a><font size="+2" color="00CCFF"><b>AWR</b></font><hr align="left" width="800">' from DUAL;
select '<a name="awr_config_info"></a>' from dual;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● AWR配置信息</b></font>' from DUAL;

SELECT '<table border=1><tr><th>DBID'||'</th><th>SNAP_INTERVAL'||'</th><th>RETENTION'||'</th><th>MOST_RECENT_SNAP_ID'||'</th><th>MOST_RECENT_SNAP_TIME'||'</th><th>STATUS_FLAG'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||DBID||'</td><td>'||SNAP_INTERVAL||'</td><td>'||RETENTION||'</td><td>'||MOST_RECENT_SNAP_ID||'</td><td>'||MOST_RECENT_SNAP_TIME||'</td><td>'||STATUS_FLAG||'</td></tr>' from sys.WRM$_WR_CONTROL 

union all 
select '</table>' from dual;

select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




select '<a name="all_awr_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 近10条AWR快照</b></font>' from DUAL;
SELECT '<table border=1><tr><th>SNAP_ID'||'</th><th>DBID'||'</th><th>INSTANCE_NUMBER'||'</th><th>STARTUP_TIME'||'</th><th>BEGIN_INTERVAL_TIME'||'</th><th>END_INTERVAL_TIME'||'</th><th>FLUSH_ELAPSED'||'</th><th>SNAP_LEVEL'||'</th><th>STATUS'||'</th><th>ERROR_COUNT'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||SNAP_ID||'</td><td>'||DBID||'</td><td>'||INSTANCE_NUMBER||'</td><td>'||STARTUP_TIME||'</td><td>'||BEGIN_INTERVAL_TIME||'</td><td>'||END_INTERVAL_TIME||'</td><td>'||FLUSH_ELAPSED||'</td><td>'||SNAP_LEVEL||'</td><td>'||STATUS||'</td><td>'||ERROR_COUNT||'</td></tr>' from (
SELECT * FROM (SELECT   * FROM SYS.WRM$_SNAPSHOT D WHERE D.END_INTERVAL_TIME>=SYSDATE-7 ORDER BY D.SNAP_ID DESC) WHERE ROWNUM<=50
)
 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;




--  该视图里定义当前YashanDB数据库的所有故障信息
-- SELECT * FROM V$DIAG_FAULT;
select '<a name="diag_fault_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● YashanDB数据库的所有故障信息</b></font>' from DUAL;
SELECT '<table border=1><tr><th>TYPE'||'</th><th>CODE'||'</th><th>DESCRIPTION'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||TYPE||'</td><td>'||CODE||'</td><td>'||DESCRIPTION||'</td></tr>' from (SELECT * FROM V$DIAG_FAULT) 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;

-- 错误记录
select '<a name="diag_fault_info"></a>' from DUAL;
select '<p><font size="+1" face="Consolas" color="#336699"><b>● 错误记录</b></font>' from DUAL;
SELECT '<table border=1><tr><th>INCIDENT_ID'||'</th><th>SESSION_ID'||'</th><th>ERROR_NUMBER'||'</th><th>ERROR_ARGUMENT'||'</th><th>ERROR_COMMENTS'||'</th></tr>' from dual

union all 
SELECT '<tr><td>'||INCIDENT_ID||'</td><td>'||SESSION_ID||'</td><td>'||ERROR_NUMBER||'</td><td>'||ERROR_ARGUMENT||'</td><td>'||ERROR_COMMENTS||'</td></tr>' from (
SELECT * FROM (SELECT incident_id, session_id, error_number, error_argument, error_comments FROM V$DIAG_INCIDENT) WHERE rownum<=100) 

union all 
select '</table>' from dual;


select '<center>[<a class="noLink" href="#directory">回到目录</a>]</center><p>'  from dual;





select '<a name="html_bottom_link"></a>' from dual;
select '<hr><p><p>'  from dual ;


SPOOL OFF
exit


/* 系统健康检查

BEGIN
   DBMS_HM.RUN_CHECK('DB Structure Integrity Check', null, NULL);
--   DBMS_HM.RUN_CHECK('Data Block Integrity Check', null, NULL);
--   DBMS_HM.RUN_CHECK('Single Datafile Check', null, NULL);
--   DBMS_HM.RUN_CHECK('Redo Integrity Check', null, NULL);
--   DBMS_HM.RUN_CHECK('Redo File Check', null, NULL);
--   DBMS_HM.RUN_CHECK('Archived Log Check', null, NULL);
END;


SELECT * FROM V$HM_CHECK;


SELECT c.name check_name, p.name parameter_name, p.description
FROM V$HM_CHECK_PARAM p, V$HM_CHECK c
WHERE p.check_id = c.id ORDER BY c.name;



SELECT DBMS_HM.GET_RUN_REPORT('xmmup_run') FROM DUAL;


SELECT run_id, name, check_name, run_mode FROM V$HM_RUN;

SELECT finding_id, description FROM V$HM_FINDING;



*/



