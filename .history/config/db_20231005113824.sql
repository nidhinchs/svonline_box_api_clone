-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 05, 2023 at 06:05 AM
-- Server version: 8.0.34-0ubuntu0.20.04.1
-- PHP Version: 7.4.3-4ubuntu2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms`
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

