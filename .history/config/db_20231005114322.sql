

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
) ;

-- --------------------------------------------------------

--
-- Table structure for table `course_update_log`
--

CREATE TABLE `course_update_log` (
  `update_id` int NOT NULL,
  `course_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `error` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` int DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table `db_log`
--

CREATE TABLE `db_log` (
  `log_id` int NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `primary_key` varchar(150) NOT NULL,
  `primary_key_value` int NOT NULL,
  `trigger_type` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `box_id` int NOT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table `franchise`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `hbt`
--

CREATE TABLE `hbt` (
  `id` int NOT NULL,
  `temperature` varchar(50) DEFAULT NULL,
  `cpu_usage` varchar(50) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `device_name` varchar(50) DEFAULT NULL,
  `storage_space` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `quiz_result`
--

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
) ;

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
) ;

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance`
--

CREATE TABLE `student_attendance` (
  `sa_id` int NOT NULL,
  `student_id` int NOT NULL,
  `arriving_time` datetime DEFAULT NULL,
  `leaving_time` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(32) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `student_log`
--

CREATE TABLE `student_log` (
  `log_id` int NOT NULL,
  `student_id` int NOT NULL,
  `log_name` varchar(50) NOT NULL,
  `log_time` datetime DEFAULT NULL,
  `log_value` varchar(500) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_date` datetime DEFAULT CURRENT_TIMESTAMP
) ;

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
) ;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `subject_id` int NOT NULL,
  `course_id` int NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `subject_desc` varchar(1500) DEFAULT NULL,
  `note_name` varchar(150) NOT NULL,
  `note_url` varchar(1500) NOT NULL,
  `is_delete` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `ip_address` varchar(32) DEFAULT NULL
) ;

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
) ;



//* viewa*/

DROP TABLE IF EXISTS `courses`;

CREATE  VIEW `courses`  AS SELECT `course`.`course_id` AS `course_id`, `course`.`course_name` AS `course_name`, `course`.`course_desc` AS `course_desc`, (select count(0) from `subject` `p` where `p`.`course_id` = `course`.`course_id`) AS `no_of_subject`, `course`.`is_delete` AS `is_delete`, `course`.`is_active` AS `is_active`, `course`.`created_by` AS `created_by`, `course`.`created_date` AS `created_date`, `course`.`modified_by` AS `modified_by`, `course`.`modified_date` AS `modified_date`, `course`.`ip_address` AS `ip_address` FROM `course`  ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_results`
--
DROP TABLE IF EXISTS `quiz_results`;

CREATE  VIEW `quiz_results`  AS SELECT `result`.`result_id` AS `result_id`, `result`.`student_id` AS `student_id`, `student`.`student_name` AS `student_name`, `student`.`student_phone` AS `student_phone`, `student`.`student_email` AS `student_email`, `student`.`student_address` AS `student_address`, `student`.`student_pic` AS `student_pic`, `result`.`total_score` AS `total_score`, `result`.`obtained_score` AS `obtained_score`, `result`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `result`.`total_time` AS `total_time`, `result`.`time_to_complete` AS `time_to_complete`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM ((`quiz_result` `result` join `student` on(`student`.`student_id` = `result`.`student_id`)) join `subject` on(`subject`.`subject_id` = `result`.`subject_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_result_details`
--
DROP TABLE IF EXISTS `quiz_result_details`;

CREATE  VIEW `quiz_result_details`  AS SELECT `result`.`detail_id` AS `detail_id`, `result`.`result_id` AS `result_id`, `result`.`quiz_id` AS `quiz_id`, `quiz`.`subject_id` AS `subject_id`, `quiz`.`question` AS `question`, `quiz`.`question_type` AS `question_type`, `quiz`.`answer` AS `answer`, `quiz`.`option1` AS `option1`, `quiz`.`option2` AS `option2`, `quiz`.`option3` AS `option3`, `quiz`.`option4` AS `option4`, `quiz`.`option5` AS `option5`, `result`.`selected_answer` AS `selected_answer`, `result`.`right_answer` AS `right_answer`, `result`.`is_active` AS `is_active`, `result`.`is_delete` AS `is_delete`, `result`.`created_by` AS `created_by`, `result`.`created_date` AS `created_date`, `result`.`modified_by` AS `modified_by`, `result`.`modified_date` AS `modified_date`, `result`.`ip_address` AS `ip_address` FROM (`quiz_result_detail` `result` join `quiz` on(`quiz`.`quiz_id` = `result`.`quiz_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `quiz_scores`
--
DROP TABLE IF EXISTS `quiz_scores`;

CREATE  VIEW `quiz_scores`  AS SELECT max(`quiz_result`.`obtained_score`) AS `score`, count(0) AS `quiz_attempt_count`, `quiz_result`.`student_id` AS `student_id`, `quiz_result`.`subject_id` AS `subject_id` FROM `quiz_result` GROUP BY `quiz_result`.`student_id`, `quiz_result`.`subject_id``  ;

-- --------------------------------------------------------

--
-- Structure for view `subjects`
--
DROP TABLE IF EXISTS `subjects`;

CREATE  VIEW `subjects`  AS SELECT `subject`.`subject_id` AS `subject_id`, `subject`.`course_id` AS `course_id`, `course`.`course_name` AS `course_name`, `subject`.`subject_name` AS `subject_name`, `subject`.`subject_desc` AS `subject_desc`, `subject`.`note_name` AS `note_name`, `subject`.`note_url` AS `note_url`, (select count(0) from `video` `p` where `p`.`subject_id` = `subject`.`subject_id`) AS `video_count`, `subject`.`is_delete` AS `is_delete`, `subject`.`is_active` AS `is_active`, `subject`.`created_by` AS `created_by`, `subject`.`created_date` AS `created_date`, `subject`.`modified_by` AS `modified_by`, `subject`.`modified_date` AS `modified_date`, `subject`.`ip_address` AS `ip_address`, `student`.`student_id` AS `student_id`, (select sum(`video_progress`.`progress`) / (select count(0) from `video` `p` where `p`.`subject_id` = `subject`.`subject_id`) from `video_progress` where `video_progress`.`subject_id` = `subject`.`subject_id` and `video_progress`.`student_id` = `student`.`student_id`) AS `video_progress`, (select `q`.`score` from `quiz_scores` `q` where `q`.`subject_id` = `subject`.`subject_id` and `q`.`student_id` = `student`.`student_id`) AS `score`, (select `q`.`quiz_attempt_count` from `quiz_scores` `q` where `q`.`subject_id` = `subject`.`subject_id` and `q`.`student_id` = `student`.`student_id`) AS `quiz_attempt_count` FROM ((`subject` left join `course` on(`course`.`course_id` = `subject`.`course_id`)) join `student`)  ;

-- --------------------------------------------------------

--
-- Structure for view `videos`
--
DROP TABLE IF EXISTS `videos`;

CREATE  VIEW `videos`  AS SELECT `video`.`video_id` AS `video_id`, `video`.`subject_id` AS `subject_id`, `subject`.`subject_name` AS `subject_name`, `video`.`video_path` AS `video_path`, `video`.`video_name` AS `video_name`, `video`.`video_extension` AS `video_extension`, `video`.`video_desc` AS `video_desc`, `student`.`student_id` AS `student_id`, (select `video_progress`.`progress` from `video_progress` where `student`.`student_id` = `video_progress`.`student_id` and `video_progress`.`type_id` = `video`.`video_id`) AS `progress`, `video`.`is_delete` AS `is_delete`, `video`.`is_active` AS `is_active`, `video`.`created_by` AS `created_by`, `video`.`created_date` AS `created_date`, `video`.`modified_by` AS `modified_by`, `video`.`modified_date` AS `modified_date`, `video`.`ip_address` AS `ip_address` FROM ((`video` join `subject` on(`video`.`subject_id` = `subject`.`subject_id`)) join `student`)  ;

-- --------------------------------------------------------

--
-- Structure for view `video_progress`
--
DROP TABLE IF EXISTS `video_progress`;

CREATE  VIEW `video_progress`  AS SELECT max(`p`.`progress`) AS `progress`, `p`.`type_id` AS `type_id`, `p`.`subject_id` AS `subject_id`, `p`.`student_id` AS `student_id`, (select count(0) from `video` where `video`.`subject_id` = `p`.`subject_id` and `video`.`is_delete` = 0 and `video`.`is_active` = 1) AS `total_video` FROM `student_progress` AS `p` WHERE `p`.`type` = 1 GROUP BY `p`.`type_id`, `p`.`student_id``student_id`  ;

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
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `box_id` (`box_id`);

--
-- Indexes for table `hbt`
--
ALTER TABLE `hbt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `note_id` (`note_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `subject_id_2` (`subject_id`);

--
-- Indexes for table `quiz_result`
--
ALTER TABLE `quiz_result`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `quiz_result_detail`
--
ALTER TABLE `quiz_result_detail`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `result_id` (`result_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `unique_user` (`student_username`);

--
-- Indexes for table `student_attendance`
--
ALTER TABLE `student_attendance`
  ADD PRIMARY KEY (`sa_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `student_log`
--
ALTER TABLE `student_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD KEY `box_id` (`box_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_phone` (`user_phone`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `course_update_log`
--
ALTER TABLE `course_update_log`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `db_log`
--
ALTER TABLE `db_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franchise`
--
ALTER TABLE `franchise`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `hbt`
--
ALTER TABLE `hbt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `note`
--
ALTER TABLE `note`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `quiz_result`
--
ALTER TABLE `quiz_result`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `quiz_result_detail`
--
ALTER TABLE `quiz_result_detail`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student_attendance`
--
ALTER TABLE `student_attendance`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student_log`
--
ALTER TABLE `student_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `student_progress`
--
ALTER TABLE `student_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `note_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
