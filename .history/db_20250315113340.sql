CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `course_desc` varchar(1000) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `course_update_log` (
  `update_id` int NOT NULL,
  `course_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `error` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` int DEFAULT NULL
) ;

CREATE TABLE `db_log` (
  `log_id` int NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `primary_key` varchar(150) NOT NULL,
  `primary_key_value` int NOT NULL,
  `trigger_type` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `box_id` int NOT NULL
);

CREATE TABLE `franchise` (
  `f_id` int NOT NULL,
  `box_id` varchar(11) NOT NULL,
  `f_name` varchar(150) NOT NULL,
  `f_phone` varchar(20) DEFAULT NULL,
  `f_email` varchar(150) DEFAULT NULL,
  `f_address` varchar(1500) DEFAULT NULL,
  `f_state` varchar(150) DEFAULT NULL,
  `f_city` varchar(150) DEFAULT NULL,
  `f_token` varchar(1500) DEFAULT NULL,
  `f_username` varchar(150) NOT NULL,
  `f_password` varchar(150) NOT NULL,
  `unique_id` varchar(150) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` int DEFAULT NULL
);

CREATE TABLE `hbt` (
  `id` int NOT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `cpu_usage` varchar(50) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `device_name` varchar(50) DEFAULT NULL,
  `storage_space` varchar(50) DEFAULT NULL,
  `tim` varchar(50) DEFAULT NULL
) ;

CREATE TABLE `note` (
  `note_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `note_name` varchar(500) NOT NULL,
  `note_path` varchar(1500) NOT NULL,
  `note_desc` varchar(1500) DEFAULT NULL,
  `note_extension` varchar(50) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `quiz` (
  `quiz_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `question` varchar(500) NOT NULL,
  `question_type` int DEFAULT NULL COMMENT '1 - single choice\r\n2 - multiple choice',
  `answer` varchar(500) DEFAULT NULL,
  `option1` varchar(500) DEFAULT NULL,
  `option2` varchar(500) DEFAULT NULL,
  `option3` varchar(500) DEFAULT NULL,
  `option4` varchar(500) DEFAULT NULL,
  `option5` varchar(500) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `quiz_result` (
  `result_id` int NOT NULL,
  `student_id` int NOT NULL,
  `total_score` float DEFAULT NULL,
  `obtained_score` float DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `total_time` time DEFAULT NULL,
  `time_to_complete` time DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `quiz_results` (
`result_id` int
,`student_id` int
,`student_name` varchar(150)
,`student_phone` varchar(20)
,`student_email` varchar(500)
,`student_address` varchar(500)
,`student_pic` varchar(1500)
,`total_score` float
,`obtained_score` float
,`subject_id` int
,`subject_name` varchar(150)
,`subject_desc` varchar(1000)
,`total_time` time
,`time_to_complete` time
,`is_active` int
,`is_delete` int
,`created_by` int
,`created_date` datetime
,`modified_by` int
,`modified_date` datetime
,`ip_address` varchar(32)
);

CREATE TABLE `quiz_result_detail` (
  `detail_id` int NOT NULL,
  `result_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `selected_answer` varchar(1500) DEFAULT NULL,
  `right_answer` varchar(1500) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` int DEFAULT NULL
);


CREATE TABLE `subject` (
  `subject_id` int NOT NULL,
  `course_id` int NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `subject_desc` varchar(1000) DEFAULT NULL,
  `note_name` varchar(150) NOT NULL,
  `note_url` varchar(1500) NOT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `user_type` varchar(50) NOT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
);

CREATE TABLE `video` (
  `video_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `video_path` varchar(1000) DEFAULT NULL,
  `video_name` varchar(500) DEFAULT NULL,
  `video_extension` varchar(50) DEFAULT NULL,
  `video_desc` varchar(1000) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
);

DROP TABLE IF EXISTS `quiz_results`;

CREATE  VIEW `quiz_results`  AS SELECT `result`.`result_id` AS `result_id`, `result`.`student_id` AS `student_id`, `student`.`student_name` AS `student_name`, `student`.`student_phone` AS `student_phone`, `student`.`student_email` AS `student_email`, `student`.`student_address` AS `student_address`, `student`.`student_pic` AS `student_pic`, `result`.`total_score` AS `total_score`, `result`.`obtained_score` AS `obtained_score`, `result`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `result`.`total_time` AS `total_time`, `result`.`time_to_complete` AS `time_to_complete`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM ((`quiz_result` `result` join `student` on((`student`.`student_id` = `result`.`student_id`))) join `subject` on((`subject`.`subject_id` = `result`.`subject_id`))) ;

DROP TABLE IF EXISTS `quiz_results`;

CREATE  VIEW `quiz_results`  AS SELECT `result`.`result_id` AS `result_id`, `result`.`student_id` AS `student_id`, `student`.`student_name` AS `student_name`, `student`.`student_phone` AS `student_phone`, `student`.`student_email` AS `student_email`, `student`.`student_address` AS `student_address`, `student`.`student_pic` AS `student_pic`, `result`.`total_score` AS `total_score`, `result`.`obtained_score` AS `obtained_score`, `result`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `result`.`total_time` AS `total_time`, `result`.`time_to_complete` AS `time_to_complete`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM ((`quiz_result` `result` join `student` on((`student`.`student_id` = `result`.`student_id`))) join `subject` on((`subject`.`subject_id` = `result`.`subject_id`))) ;

DROP TABLE IF EXISTS `quiz_scores`;

CREATE  VIEW `quiz_scores`  AS SELECT max(`quiz_result`.`obtained_score`) AS `score`, count(0) AS `quiz_attempt_count`, `quiz_result`.`student_id` AS `student_id`, `quiz_result`.`subject_id` AS `subject_id` FROM `quiz_result` GROUP BY `quiz_result`.`student_id`, `quiz_result`.`subject_id` ;


ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

 ALTER TABLE `course_update_log`
  ADD PRIMARY KEY (`update_id`); 


