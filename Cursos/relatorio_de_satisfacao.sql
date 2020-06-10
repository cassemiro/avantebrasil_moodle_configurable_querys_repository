SELECT c.fullname AS curso, SUBSTRING_INDEX(qq.content, '.', -1) AS topico, ROUND(AVG(qrr.rank),2) AS media FROM prefix_questionnaire_question AS qq
INNER JOIN prefix_questionnaire_survey AS qs ON qs.id = qq.survey_id
INNER JOIN prefix_course AS c ON c.id = qs.courseid
INNER JOIN prefix_questionnaire_question_type AS qqt ON qqt.response_table = 'response_rank'
INNER JOIN prefix_questionnaire_response_rank AS qrr ON qrr.question_id = qq.id
WHERE
	qq.type_id < 99
%%FILTER_COURSES:c.id%%
GROUP BY qq.id
ORDER BY topico