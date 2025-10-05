/*
    Script to run Pre-Execution Checks on L2.pd_attribution table and store the results
*/


-- Create a view to remove the manual_entries
create or replace view l1.pd_attribution_mssp_prechecks as
select * from l2.pd_attribution where st in ('Member') and sid in ('1','2','3') and sstp in ('CommonSpirit ACO I - Enhanced', 'CommonSpirit ACO II - Enhanced', 'CommonSpirit ACO III - Basic Level B');

create or replace table l1.dap_attribution_prechecks_results (rule_name varchar,sstp varchar, number_of_records integer, number_of_patients integer,rule_status varchar);

-- 'empi should not be null'
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'empi should not be null',sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where nullif(empi,'') is null group by all order by 3 desc;

-- atrdt  is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'atrdt should not be null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where atrdt is null group by all order by 3 desc;

-- atrsd  is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'atrsd should not be null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where atrsd is null group by all order by 3 desc;

-- atrsd not first day of the month
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'atrsd not first day of the month', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where atrsd != date_trunc('month',atrsd) group by all order by 3 desc;

--atred is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'atred should not be null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where atred is null group by all order by 3 desc;

-- acoid or acon is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'acoid or acon is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (acoid is null or acoid='' or acon is null or acon='') group by all order by 3 desc;

-- orgid or orgn is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'orgid or orgn is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (orgid is null or orgid='' or orgn is null or orgn='') group by all order by 3 desc;

--orgid is not -1
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'orgid is not -1', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where orgid = '-1' and (orgn is null or orgn = '') group by all order by 3 desc;

--prid or prnm is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prid or prnm is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (prid is null or prid='' or prnm is null or prnm='') group by all order by 3 desc;

--plid or plnm is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'plid or plnm is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (plid is null or plid='' or plnm is null or plnm='') group by all order by 3 desc;

--rid or rn is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'rid or rn is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  (rn is null or rn='' or rid is null or rid='') group by all order by 3 desc;

--clvl1_id,clvl1_name is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl1_id,clvl1_name is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (clvl1_name is null or clvl1_name ='' or clvl1_id is null or clvl1_id='' or clvl1_name is null or clvl1_name='') group by all order by 3 desc;

--clvl2_id,clvl2_name is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl2_id,clvl2_name is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (clvl2_name is null or clvl2_name ='' or clvl2_id is null or clvl2_id='' or clvl2_name is null or clvl2_name='') group by all order by 3 desc;

--clvl3_id,clvl3_name is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl3_id,clvl3_name is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (clvl3_name is null or clvl3_name ='' or clvl3_id is null or clvl3_id='' or clvl3_name is null or clvl3_name='') group by all order by 3 desc;

--clvl4_id,clvl4_name is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl4_id,clvl4_name is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (clvl4_name is null or clvl4_name ='' or clvl4_id is null or clvl4_id='' or clvl4_name is null or clvl4_name='') group by all order by 3 desc;

--slnpi,sln is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'slnpi,sln is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (slnpi is null or slnpi='' or sln is null or sln='' or slid is null or slid = '') group by all order by 3 desc;

--pcpnpi,pcpn is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpnpi,pcpn is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (pcpnpi is null or pcpnpi='' or pcpn is null or pcpn='') group by all order by 3 desc;

--sno is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'sno is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (sno is null or sno='' ) group by all order by 3 desc;

--prvid is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prvid is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (prvid is null or prvid='') group by all order by 3 desc;

--id is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'id is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (id is null or id='') group by all order by 3 desc;

--fn is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'fn is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (fn is null or fn='' or fn is null or fn='') group by all order by 3 desc;

--ln is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'ln is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where ("ln" is null or "ln"='') group by all order by 3 desc;

--dob is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'dob is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (dob is null) group by all order by 3 desc;

--gn is null
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'gn is null', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where (gn is null or gn='') group by all order by 3 desc;




-- 1:1 Mapping Check

--acoid,acon 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'acoid,acon 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where acoid in (select  acoid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct acon)>1) group by all order by 3 desc;

--orgid,orgnm 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'acoid,acon 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where orgid in (select  orgid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct orgn)>1) group by all order by 3 desc;

--prid,prnm 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prid,prnm 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where prid in (select prid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct prnm)>1) group by all order by 3 desc;

--prid,prnm 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prid,prnm 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where prid in (select prid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct prnm)>1) group by all order by 3 desc;

--plid,plnm 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'plid,plnm 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where prid in (select plid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct plnm)>1) group by all order by 3 desc;

--rid,rn 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'rid,rn 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where rid in (select rid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct rn)>1) group by all order by 3 desc;

--clvl1_id,clvl1_name 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl1_id,clvl1_name 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl1_id in (select clvl1_id from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct clvl1_name)>1) group by all order by 3 desc;

--clvl2_id,clvl2_name 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl2_id,clvl2_name 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl2_id in (select clvl2_id from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct clvl2_name)>1) group by all order by 3 desc;

--clvl3_id,clvl3_name 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl3_id,clvl3_name 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl3_id in (select clvl3_id from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct clvl3_name)>1) group by all order by 3 desc;

--slid,sln 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'slid,sln 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where slid in (select slid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct sln)>1) group by all order by 3 desc;

--slid,sln 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'slid,sln 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where slid in (select slid from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct sln)>1) group by all order by 3 desc;

--pcpnpi,pcpn 1-1 mapping check
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpnpi,pcpn 1-1 mapping check', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where pcpnpi in (select pcpnpi from l1.pd_attribution_mssp_prechecks group by 1 having count(distinct pcpn)>1) group by all order by 3 desc;


--whitespace check

--acoid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'acoid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where acoid like '% ' or acoid like ' %' group by all order by 3 desc;

--acon has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'acon has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where acon like '% ' or acon like ' %' group by all order by 3 desc;

--orgid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'orgid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where orgid like '% ' or orgid like ' %' group by all order by 3 desc;

--orgid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'orgid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where orgid like '% ' or orgid like ' %' group by all order by 3 desc;

--prid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where prid like '% ' or prid like ' %' group by all order by 3 desc;

--prnm has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'prnm has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where prnm like '% ' or prnm like ' %' group by all order by 3 desc;


--plid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'plid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where plid like '% ' or plid like ' %' group by all order by 3 desc;

--plnm has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'plnm has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where plnm like '% ' or plnm like ' %' group by all order by 3 desc;

--rid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'rid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where rid like '% ' or rid like ' %' group by all order by 3 desc;

--rn has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'rn has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where rn like '% ' or rn like ' %' group by all order by 3 desc;

--clvl1_id has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl1_id has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl1_id like '% ' or clvl1_id like ' %' group by all order by 3 desc;

--clvl1_name has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl1_name has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl1_name like '% ' or clvl1_name like ' %' group by all order by 3 desc;

--clvl2_name has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl2_name has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl2_name like '% ' or clvl2_name like ' %' group by all order by 3 desc;

--clvl3_name has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl3_name has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl3_name like '% ' or clvl3_name like ' %' group by all order by 3 desc;

--clvl3_name has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl3_name has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl3_name like '% ' or clvl3_name like ' %' group by all order by 3 desc;

--clvl1_npi has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'clvl1_npi has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where clvl1_npi like '% ' or clvl1_npi like ' %' group by all order by 3 desc;

--slid has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'slid has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where slid like '% ' or slid like ' %' group by all order by 3 desc;

--sln has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'sln has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where slid like '% ' or slid like ' %' group by all order by 3 desc;

--slnpi has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'slnpi has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where slnpi like '% ' or slnpi like ' %' group by all order by 3 desc;

--pcpn has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpn has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where pcpn like '% ' or pcpn like ' %' group by all order by 3 desc;

--pcpnpi has '%'?
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpnpi has '%'?', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where pcpnpi like '% ' or pcpnpi like ' %' group by all order by 3 desc;

-- Column Values Check

--lob not in ('Commercial','Medicare','Medicaid','Medicare Advantage')
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'lob is not Commercial,Medicare,Medicaid,Medicare Advantage', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where lob not in ('Commercial','Medicare','Medicaid','Medicare Advantage') group by all order by 3 desc; 

-- pcpnpi not in l2.pd_npi
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpnpi not in l2.pd_npi', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  pcpnpi not in (select distinct npi from l2.pd_npi) group by all order by 3 desc;

-- empi not in l2.empi
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'pcpnpi not in l2.pd_npi', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  empi not in (select distinct empi from l2.empi) group by all order by 3 desc;

--Genders in pd_attribution are not in M, F, O and U
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'Genders in pd_attribution are not in M, F, O and U', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  upper(nullif(gn,'')) not in ('M','F','O','U') group by all order by 3 desc;

-- dob in pd_attribution is less than or equal to 1900-01-01
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'dob in pd_attribution is less than or equal to 1900-01-01', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  dob <= '1900-01-01' group by all order by 3 desc;

-- dob in pd_attribution is less than or equal to 1900-01-01
insert into l1.dap_attribution_prechecks_results (rule_name,sstp, number_of_records, number_of_patients, rule_status)
select 'dob in pd_attribution is greater than todays date', sstp,count(distinct sno) as number_of_records, count(distinct empi) as number_of_patients,'Fail' from l1.pd_attribution_mssp_prechecks where  dob > current_date() group by all order by 3 desc;