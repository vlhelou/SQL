use msdb
	
select 
	mp.name
	, msp.subplan_name
	, logdet.start_time
	, line1, line2, line3, line4, line5
	, error_number, error_message
	, command
from sysmaintplan_plans mp
	inner join sysmaintplan_subplans msp ON mp.id = msp.plan_id
	INNER JOIN sysmaintplan_log mpl ON msp.subplan_id = mpl.subplan_id
	inner join sysmaintplan_logdetail logdet on  mpl.task_detail_id = logdet.task_detail_id
where
	logdet.succeeded =  0
order by logdet.start_time desc


