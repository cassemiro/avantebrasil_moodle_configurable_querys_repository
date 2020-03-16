SELECT cc.id AS idcategoria, cc.name AS categoria, c.id AS idcurso, YEAR(FROM_UNIXTIME(c.timecreated)) as ano, c.fullname AS curso, uid.data AS genero, COUNT(ue.id) AS Enroled
FROM prefix_course AS c 
INNER JOIN prefix_course_categories AS cc ON cc.id = c.category
INNER JOIN prefix_enrol AS en ON en.courseid = c.id AND en.roleid = 5 AND en.enrol = "manual"
INNER JOIN prefix_user_enrolments AS ue ON ue.enrolid = en.id
INNER JOIN prefix_user_info_data AS uid ON uid.userid = ue.userid
INNER JOIN prefix_user_info_field AS uif ON uif.id = uid.fieldid
	and
	uif.shortname = 'genero'
LEFT JOIN prefix_user_lastaccess AS ulast ON 
		ulast.userid = ue.userid AND ulast.courseid = c.id
		WHERE
		ulast.userid IS NOT NULL
		AND DATEDIFF( NOW(),FROM_UNIXTIME(ulast.timeaccess) ) > 30

GROUP BY c.id, uid.data
ORDER BY c.id