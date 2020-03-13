SELECT cc.id AS idcategoria, cc.name AS categoria, c.id AS idcurso, YEAR(FROM_UNIXTIME(c.timecreated)) as ano, c.fullname AS curso, uid.data AS genero, COUNT(ue.id) AS Enroled
FROM prefix_course AS c 
INNER JOIN prefix_course_categories AS cc ON cc.id = c.category
INNER JOIN prefix_enrol AS en ON en.courseid = c.id
INNER JOIN prefix_user_enrolments AS ue ON ue.enrolid = en.id
INNER JOIN prefix_user_info_data AS uid ON uid.userid = ue.userid
INNER JOIN prefix_user_info_field AS uif ON uif.id = uid.fieldid
	and
	uif.shortname = 'genero'
INNER JOIN prefix_user AS u ON u.id = ue.userid
	AND DATEDIFF( NOW(),FROM_UNIXTIME(u.lastlogin) ) > 30
	
GROUP BY c.id, uid.data
ORDER BY c.id