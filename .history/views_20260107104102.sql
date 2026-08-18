
DROP TABLE IF EXISTS `courses`;

CREATE  VIEW `courses`  AS SELECT `course`.`course_id` AS `course_id`, `course`.`course_name` AS `course_name`, `course`.`course_desc` AS `course_desc`, (select count(0) from `subject` `p` where `p`.`course_id` = `course`.`course_id`) AS `no_of_subject`, `course`.`is_delete` AS `is_delete`, `course`.`is_active` AS `is_active`, `course`.`created_by` AS `created_by`, `course`.`created_date` AS `created_date`, `course`.`modified_by` AS `modified_by`, `course`.`modified_date` AS `modified_date`, `course`.`ip_address` AS `ip_address` FROM `course` ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_results`
--
DROP TABLE IF EXISTS `quiz_results`;

CREATE  VIEW `quiz_results`  AS SELECT `result`.`result_id` AS `result_id`, `result`.`student_id` AS `student_id`, `student`.`student_name` AS `student_name`, `student`.`student_phone` AS `student_phone`, `student`.`student_email` AS `student_email`, `student`.`student_address` AS `student_address`, `student`.`student_pic` AS `student_pic`, `result`.`total_score` AS `total_score`, `result`.`obtained_score` AS `obtained_score`, `result`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `result`.`total_time` AS `total_time`, `result`.`time_to_complete` AS `time_to_complete`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM ((`quiz_result` `result` join `student` on(`student`.`student_id` = `result`.`student_id`)) join `subject` on(`subject`.`subject_id` = `result`.`subject_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_result_details`
--
DROP TABLE IF EXISTS `quiz_result_details`;

CREATE  VIEW `quiz_result_details`  AS SELECT `result`.`detail_id` AS `detail_id`, `result`.`result_id` AS `result_id`, `result`.`quiz_id` AS `quiz_id`, `quiz`.`subject_id` AS `subject_id`, `quiz`.`question` AS `question`, `quiz`.`question_type` AS `question_type`, `quiz`.`answer` AS `answer`, `quiz`.`option1` AS `option1`, `quiz`.`option2` AS `option2`, `quiz`.`option3` AS `option3`, `quiz`.`option4` AS `option4`, `quiz`.`option5` AS `option5`, `result`.`selected_answer` AS `selected_answer`, `result`.`right_answer` AS `right_answer`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM (`quiz_result_detail` `result` join `quiz` on(`quiz`.`quiz_id` = `result`.`quiz_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_scores`
--
DROP TABLE IF EXISTS `quiz_scores`;

CREATE  VIEW `quiz_scores`  AS SELECT max(`quiz_result`.`obtained_score`) AS `score`, count(0) AS `quiz_attempt_count`, `quiz_result`.`student_id` AS `student_id`, `quiz_result`.`subject_id` AS `subject_id` FROM `quiz_result` GROUP BY `quiz_result`.`student_id`, `quiz_result`.`subject_id` ;

-- --------------------------------------------------------

--
-- Structure for view `subjects`
--
DROP TABLE IF EXISTS `subjects`;

CREATE  VIEW `subjects`  AS SELECT `subject`.`subject_id` AS `subject_id`, `subject`.`course_id` AS `course_id`, `course`.`course_name` AS `course_name`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `subject`.`note_name` AS `note_name`, `subject`.`note_url` AS `note_url`, (select count(0) from `video` `p` where `p`.`subject_id` = `subject`.`subject_id`) AS `video_count`, `subject`.`is_delete` AS `is_delete`, `subject`.`is_active` AS `is_active`, `subject`.`created_by` AS `created_by`, `subject`.`created_date` AS `created_date`, `subject`.`modified_by` AS `modified_by`, `subject`.`modified_date` AS `modified_date`, `subject`.`ip_address` AS `ip_address`, `student`.`student_id` AS `student_id`, (select sum(`video_progress`.`progress`) / (select count(0) from `video` `p` where `p`.`subject_id` = `subject`.`subject_id`) from `video_progress` where `video_progress`.`subject_id` = `subject`.`subject_id` and `video_progress`.`student_id` = `student`.`student_id`) AS `video_progress`, (select `q`.`score` from `quiz_scores` `q` where `q`.`subject_id` = `subject`.`subject_id` and `q`.`student_id` = `student`.`student_id`) AS `score`, (select `q`.`quiz_attempt_count` from `quiz_scores` `q` where `q`.`subject_id` = `subject`.`subject_id` and `q`.`student_id` = `student`.`student_id`) AS `quiz_attempt_count` FROM ((`subject` left join `course` on(`course`.`course_id` = `subject`.`course_id`)) join `student`) ;

-- --------------------------------------------------------

--
-- Structure for view `videos`
--
DROP TABLE IF EXISTS `videos`;

CREATE  VIEW `videos`  AS SELECT `video`.`video_id` AS `video_id`, `video`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `video`.`video_path` AS `video_path`, `video`.`video_name` AS `video_name`, `video`.`video_extension` AS `video_extension`, `video`.`video_desc` AS `video_desc`, `student`.`student_id` AS `student_id`, (select `video_progress`.`progress` from `video_progress` where `student`.`student_id` = `video_progress`.`student_id` and `video_progress`.`type_id` = `video`.`video_id`) AS `progress`, `video`.`is_delete` AS `is_delete`, `video`.`is_active` AS `is_active`, `video`.`created_by` AS `created_by`, `video`.`created_date` AS `created_date`, `video`.`modified_by` AS `modified_by`, `video`.`modified_date` AS `modified_date`, `video`.`ip_address` AS `ip_address` FROM ((`video` join `subject` on(`video`.`subject_id` = `subject`.`subject_id`)) join `student`) ;

-- --------------------------------------------------------

