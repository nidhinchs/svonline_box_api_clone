
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


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
);

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
) ;

CREATE TABLE `hbt` (
  `id` int NOT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `cpu_usage` varchar(50) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `device_name` varchar(50) DEFAULT NULL,
  `storage_space` varchar(50) DEFAULT NULL,
  `tim` varchar(50) DEFAULT NULL
);

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
) ;

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
`created_by` int
,`created_date` datetime
,`ip_address` varchar(32)
,`is_active` int
,`is_delete` int
,`modified_by` int
,`modified_date` datetime
,`obtained_score` float
,`result_id` int
,`student_address` varchar(500)
,`student_email` varchar(500)
,`student_id` int
,`student_name` varchar(150)
,`student_phone` varchar(20)
,`student_pic` varchar(1500)
,`subject_desc` varchar(1000)
,`subject_id` int
,`subject_name` varchar(150)
,`time_to_complete` time
,`total_score` float
,`total_time` time
);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_result_detail`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `quiz_result_details`
-- (See below for the actual view)
--
CREATE TABLE `quiz_result_details` (
`answer` varchar(500)
,`created_by` int
,`created_date` datetime
,`detail_id` int
,`ip_address` int
,`is_active` int
,`is_delete` int
,`modified_by` int
,`modified_date` datetime
,`option1` varchar(500)
,`option2` varchar(500)
,`option3` varchar(500)
,`option4` varchar(500)
,`option5` varchar(500)
,`question` varchar(500)
,`question_type` int
,`quiz_id` int
,`result_id` int
,`right_answer` varchar(1500)
,`selected_answer` varchar(1500)
,`subject_id` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `quiz_scores`
-- (See below for the actual view)
--
CREATE TABLE `quiz_scores` (
`quiz_attempt_count` bigint
,`score` float
,`student_id` int
,`subject_id` int
);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `student_name` varchar(150) NOT NULL,
  `student_phone` varchar(20) NOT NULL,
  `student_email` varchar(500) DEFAULT NULL,
  `student_address` varchar(500) DEFAULT NULL,
  `student_pic` varchar(1500) DEFAULT NULL,
  `student_username` varchar(50) DEFAULT NULL,
  `student_password` varchar(50) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_externally_added` tinyint NOT NULL DEFAULT '0',
  `login_flag` int NOT NULL DEFAULT '0',
  `unique_id` varchar(250) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance`
--

CREATE TABLE `student_attendance` (
  `attendance_id` int NOT NULL,
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `attendance_date` date NOT NULL,
  `attendance_status` varchar(50) DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `ip_address` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_log`
--

CREATE TABLE `student_log` (
  `log_id` int NOT NULL,
  `student_id` int NOT NULL,
  `log_action` varchar(100) NOT NULL,
  `log_description` varchar(1000) DEFAULT NULL,
  `log_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT NULL,
  `is_delete` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_progress`
--

CREATE TABLE `student_progress` (
  `progress_id` int NOT NULL,
  `box_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `type` int DEFAULT NULL COMMENT '1 - video\r\n2 - note\r\n3 - quiz',
  `type_id` int DEFAULT NULL,
  `progress` float DEFAULT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `ip_address` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure for view `quiz_results`
--
DROP TABLE IF EXISTS `quiz_results`;

CREATE ALGORITHM=UNDEFINED DEFINER=`doadmin`@`%` SQL SECURITY DEFINER VIEW `quiz_results`  AS SELECT `result`.`result_id` AS `result_id`, `result`.`student_id` AS `student_id`, `student`.`student_name` AS `student_name`, `student`.`student_phone` AS `student_phone`, `student`.`student_email` AS `student_email`, `student`.`student_address` AS `student_address`, `student`.`student_pic` AS `student_pic`, `result`.`total_score` AS `total_score`, `result`.`obtained_score` AS `obtained_score`, `result`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `result`.`total_time` AS `total_time`, `result`.`time_to_complete` AS `time_to_complete`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM ((`quiz_result` `result` join `student` on((`student`.`student_id` = `result`.`student_id`))) join `subject` on((`subject`.`subject_id` = `result`.`subject_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_result_details`
--
DROP TABLE IF EXISTS `quiz_result_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`doadmin`@`%` SQL SECURITY DEFINER VIEW `quiz_result_details`  AS SELECT `result`.`detail_id` AS `detail_id`, `result`.`result_id` AS `result_id`, `result`.`quiz_id` AS `quiz_id`, `quiz`.`subject_id` AS `subject_id`, `quiz`.`question` AS `question`, `quiz`.`question_type` AS `question_type`, `quiz`.`answer` AS `answer`, `quiz`.`option1` AS `option1`, `quiz`.`option2` AS `option2`, `quiz`.`option3` AS `option3`, `quiz`.`option4` AS `option4`, `quiz`.`option5` AS `option5`, `result`.`selected_answer` AS `selected_answer`, `result`.`right_answer` AS `right_answer`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM (`quiz_result_detail` `result` join `quiz` on((`quiz`.`quiz_id` = `result`.`quiz_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_scores`
--
DROP TABLE IF EXISTS `quiz_scores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`doadmin`@`%` SQL SECURITY DEFINER VIEW `quiz_scores`  AS SELECT max(`quiz_result`.`obtained_score`) AS `score`, count(0) AS `quiz_attempt_count`, `quiz_result`.`student_id` AS `student_id`, `quiz_result`.`subject_id` AS `subject_id` FROM `quiz_result` GROUP BY `quiz_result`.`student_id`, `quiz_result`.`subject_id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `course_update_log`
--
ALTER TABLE `course_update_log`
  ADD PRIMARY KEY (`update_id`);

--
-- Indexes for table `db_log`
--
ALTER TABLE `db_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `franchise`
--
ALTER TABLE `franchise`
  ADD PRIMARY KEY (`f_id`);

--
-- Indexes for table `hbt`
--
ALTER TABLE `hbt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quiz_id`);

--
-- Indexes for table `quiz_result`
--
ALTER TABLE `quiz_result`
  ADD PRIMARY KEY (`result_id`);

--
-- Indexes for table `quiz_result_detail`
--
ALTER TABLE `quiz_result_detail`
  ADD PRIMARY KEY (`detail_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_attendance`
--
ALTER TABLE `student_attendance`
  ADD PRIMARY KEY (`attendance_id`);

--
-- Indexes for table `student_log`
--
ALTER TABLE `student_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD PRIMARY KEY (`progress_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `course_update_log`
--
ALTER TABLE `course_update_log`
  MODIFY `update_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `db_log`
--
ALTER TABLE `db_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franchise`
--
ALTER TABLE `franchise`
  MODIFY `f_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hbt`
--
ALTER TABLE `hbt`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `note`
--
ALTER TABLE `note`
  MODIFY `note_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quiz_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_result`
--
ALTER TABLE `quiz_result`
  MODIFY `result_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_result_detail`
--
ALTER TABLE `quiz_result_detail`
  MODIFY `detail_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_attendance`
--
ALTER TABLE `student_attendance`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_log`
--
ALTER TABLE `student_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_progress`
--
ALTER TABLE `student_progress`
  MODIFY `progress_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
