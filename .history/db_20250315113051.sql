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


