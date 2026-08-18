-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db-svonline-do-user-9870855-0.b.db.ondigitalocean.com:25060
-- Generation Time: Jan 06, 2026 at 06:39 AM
-- Server version: 8.0.35
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `svonline_local`
--

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE "create_stmt" ()   BEGIN
    SELECT TABLE_NAME, CREATE_STATEMENT
    FROM (
        SELECT TABLE_NAME, 
               (SELECT CONCAT('CREATE TABLE ', TABLE_NAME, ' (', GROUP_CONCAT(COLUMN_NAME, ' ', COLUMN_TYPE, 
               IF(IS_NULLABLE = 'NO', ' NOT NULL', ''), 
               IF(COLUMN_DEFAULT IS NOT NULL, CONCAT(' DEFAULT ', COLUMN_DEFAULT), ''), 
               IF(EXTRA != '', CONCAT(' ', EXTRA), ''), 
               ' ', 
               IF(COLUMN_KEY = 'PRI', 'PRIMARY KEY', '')
               SEPARATOR ', '), 
               ');') 
               FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_SCHEMA = 'svonline_local' 
               AND TABLE_NAME = t.TABLE_NAME) AS CREATE_STATEMENT
        FROM INFORMATION_SCHEMA.TABLES t
        WHERE TABLE_SCHEMA = 'svonline_local' 
        
    ) AS temp;
END$$

CREATE DEFINER="doadmin"@"%" PROCEDURE "GetCreateTableStatements" ()   BEGIN
    SELECT TABLE_NAME, CREATE_STATEMENT
    FROM (
        SELECT TABLE_NAME, 
               (SELECT CONCAT('CREATE TABLE ', TABLE_NAME, ' (', GROUP_CONCAT(COLUMN_NAME, ' ', COLUMN_TYPE, 
               IF(IS_NULLABLE = 'NO', ' NOT NULL', ''), 
               IF(COLUMN_DEFAULT IS NOT NULL, CONCAT(' DEFAULT ', COLUMN_DEFAULT), ''), 
               IF(EXTRA != '', CONCAT(' ', EXTRA), ''), 
               ' ', 
               IF(COLUMN_KEY = 'PRI', 'PRIMARY KEY', '')
               SEPARATOR ', '), 
               ');') 
               FROM INFORMATION_SCHEMA.COLUMNS 
               WHERE TABLE_SCHEMA = 'svonline_local' 
               AND TABLE_NAME = t.TABLE_NAME) AS CREATE_STATEMENT
        FROM INFORMATION_SCHEMA.TABLES t
        WHERE TABLE_SCHEMA = 'svonline_local' 
        AND TABLE_NAME IN ('subject', 'video', 'quiz_scores')
    ) AS temp;
END$$

DELIMITER ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_desc`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 'General Awareness', 'A course covering general knowledge topics and current affairs.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(2, 'English', 'A course focused on improving English language skills including grammar, vocabulary, and comprehension.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(3, 'Mathematics', 'A course covering various mathematical concepts including algebra, calculus, and geometry.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(4, 'History', 'A course exploring significant historical events, figures, and periods.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(5, 'MPSC', 'A course designed for preparation for Maharashtra Public Service Commission exams.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(11, 'LAW', 'Civil Procedure Code', 0, 1, 1, '2023-05-15 13:01:03', NULL, NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `franchise`
--

INSERT INTO `franchise` (`f_id`, `box_id`, `f_name`, `f_phone`, `f_email`, `f_address`, `f_state`, `f_city`, `f_token`, `f_username`, `f_password`, `unique_id`, `is_active`, `is_delete`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, '1', 'sv_franchise', NULL, NULL, NULL, NULL, NULL, NULL, 'fra1', 'fra1', NULL, NULL, NULL, NULL, '2023-01-21 22:50:05', NULL, '2023-01-21 22:50:05', NULL);

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
  `tim` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`note_id`, `subject_id`, `note_name`, `note_path`, `note_desc`, `note_extension`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 11, 'Algebra Basics Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Algebra Basics.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(2, 11, 'Advanced Algebra Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Algebra.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(3, 12, 'Calculus Introduction Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Calculus Introduction.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(4, 12, 'Advanced Calculus Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Calculus.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(5, 13, 'Geometry Basics Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Geometry Basics.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(6, 13, 'Advanced Geometry Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Geometry.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(7, 14, 'Statistics Introduction Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Statistics Introduction.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(8, 14, 'Advanced Statistics Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Statistics.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(9, 15, 'Trigonometry Basics Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Trigonometry Basics.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(10, 15, 'Advanced Trigonometry Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Trigonometry.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(11, 16, 'Ancient Civilizations Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Ancient Civilizations.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(12, 16, 'Classical History Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Classical History.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(13, 17, 'Medieval Europe Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Medieval Europe.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(14, 17, 'Medieval Asia Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Medieval Asia.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(15, 18, 'World Wars Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on World Wars.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(16, 18, 'Cold War Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Cold War.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(17, 19, 'Current Trends Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Current Trends.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(18, 19, 'Recent Developments Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Recent Developments.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(19, 20, 'Ancient India Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Ancient India.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(20, 20, 'Modern India Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Modern India.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(21, 21, 'Current Events Overview Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Current Events Overview.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(22, 21, 'Detailed Analysis Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Detailed Analysis of Current Affairs.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(23, 22, 'Basic Knowledge Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Basic Knowledge.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(24, 22, 'Advanced Knowledge Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Knowledge.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(25, 23, 'Preparation Tips Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Preparation Tips.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(26, 23, 'Strategy and Planning Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Strategy and Planning.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(27, 24, 'Test Overview Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Test Overview.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(28, 24, 'Test Strategies Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Test Strategies.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(29, 25, 'Mock Test Basics Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Mock Test Basics.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(30, 25, 'Advanced Mock Tests Note', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Note on Advanced Mock Tests.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(31, 1, 'Introduction to Subject 1', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 1.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(32, 1, 'Advanced Topics Subject 1', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 1.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(33, 2, 'Introduction to Subject 2', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 2.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(34, 2, 'Advanced Topics Subject 2', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 2.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(35, 3, 'Introduction to Subject 3', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 3.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(36, 3, 'Advanced Topics Subject 3', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 3.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(37, 4, 'Introduction to Subject 4', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 4.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(38, 4, 'Advanced Topics Subject 4', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 4.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(39, 5, 'Introduction to Subject 5', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 5.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(40, 5, 'Advanced Topics Subject 5', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 5.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(41, 6, 'Introduction to Subject 6', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 6.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(42, 6, 'Advanced Topics Subject 6', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 6.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(43, 7, 'Introduction to Subject 7', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 7.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(44, 7, 'Advanced Topics Subject 7', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 7.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(45, 8, 'Introduction to Subject 8', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 8.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(46, 8, 'Advanced Topics Subject 8', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 8.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(47, 9, 'Introduction to Subject 9', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 9.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(48, 9, 'Advanced Topics Subject 9', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 9.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(49, 10, 'Introduction to Subject 10', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Introduction notes for Subject 10.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(50, 10, 'Advanced Topics Subject 10', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1729229254405.pdf', 'Advanced topics notes for Subject 10.', 'pdf', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(100, 9, 'CPC Notes', '', 'Civil Procedure Code', 'pdf', 0, 1, NULL, '2023-05-19 10:45:25', NULL, '2023-05-19 13:07:08', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`quiz_id`, `subject_id`, `question`, `question_type`, `answer`, `option1`, `option2`, `option3`, `option4`, `option5`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 1, 'What is the capital of France?', 1, 'Paris', 'Paris', 'London', 'Berlin', 'Rome', 'Madrid', 0, 1, 123, '2024-08-13 10:00:00', 123, '2024-08-13 10:05:00', '192.168.1.1'),
(3, 1, 'Who wrote the play Romeo and Juliet?', 1, 'William Shakespeare', 'William Shakespeare', 'Charles Dickens', 'Mark Twain', 'Leo Tolstoy', 'Jane Austen', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(4, 1, 'What is the largest ocean on Earth?', 1, 'Pacific Ocean', 'Pacific Ocean', 'Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Southern Ocean', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(5, 1, 'Who was the first President of the United States?', 1, 'George Washington', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'John Adams', 'James Madison', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(6, 1, 'What is the chemical symbol for gold?', 1, 'Au', 'Au', 'Ag', 'Pb', 'Fe', 'Hg', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(7, 1, 'Which country is known as the Land of the Rising Sun?', 1, 'Japan', 'Japan', 'China', 'South Korea', 'Thailand', 'Vietnam', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(8, 1, 'What is the hardest natural substance on Earth?', 1, 'Diamond', 'Diamond', 'Gold', 'Iron', 'Platinum', 'Ruby', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(9, 1, 'Who painted the Mona Lisa?', 1, 'Leonardo da Vinci', 'Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Claude Monet', 'Rembrandt', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(10, 1, 'What is the largest planet in our Solar System?', 1, 'Jupiter', 'Jupiter', 'Saturn', 'Uranus', 'Neptune', 'Earth', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(11, 1, 'What is the main ingredient in guacamole?', 1, 'Avocado', 'Avocado', 'Tomato', 'Pepper', 'Onion', 'Garlic', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(12, 1, 'Who is known as the Father of Computers?', 1, 'Charles Babbage', 'Charles Babbage', 'Alan Turing', 'Bill Gates', 'Steve Jobs', 'Ada Lovelace', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(13, 1, 'What is the smallest prime number?', 1, '2', '2', '1', '3', '5', '7', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(14, 1, 'Which ocean is located between Africa and Australia?', 1, 'Indian Ocean', 'Indian Ocean', 'Atlantic Ocean', 'Pacific Ocean', 'Arctic Ocean', 'Southern Ocean', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(15, 1, 'What is the capital of Australia?', 1, 'Canberra', 'Canberra', 'Sydney', 'Melbourne', 'Brisbane', 'Perth', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(16, 1, 'Which famous scientist developed the theory of relativity?', 1, 'Albert Einstein', 'Albert Einstein', 'Isaac Newton', 'Niels Bohr', 'Galileo Galilei', 'Michael Faraday', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(17, 1, 'What is the most spoken language in the world?', 1, 'Mandarin Chinese', 'Mandarin Chinese', 'English', 'Spanish', 'Hindi', 'Arabic', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(18, 1, 'Which planet is closest to the Sun?', 1, 'Mercury', 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(19, 1, 'What is the longest river in the world?', 1, 'Nile', 'Nile', 'Amazon', 'Yangtze', 'Mississippi', 'Ganges', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(20, 1, 'What is the capital of Canada?', 1, 'Ottawa', 'Ottawa', 'Toronto', 'Vancouver', 'Montreal', 'Calgary', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(21, 1, 'Who was the first man to walk on the Moon?', 1, 'Neil Armstrong', 'Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'Michael Collins', 'Alan Shepard', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(22, 1, 'What is the largest desert in the world?', 1, 'Sahara', 'Sahara', 'Arctic', 'Antarctic', 'Gobi', 'Karakum', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(23, 1, 'What is the chemical symbol for silver?', 1, 'Ag', 'Ag', 'Au', 'Pb', 'Fe', 'Hg', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(24, 1, 'Who is the author of \"To Kill a Mockingbird\"?', 1, 'Harper Lee', 'Harper Lee', 'J.K. Rowling', 'Ernest Hemingway', 'F. Scott Fitzgerald', 'John Steinbeck', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(25, 1, 'What is the smallest country in the world?', 1, 'Vatican City', 'Vatican City', 'Monaco', 'Nauru', 'Tuvalu', 'San Marino', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(51, 2, 'What is the square root of 64?', 1, '8', '6', '7', '8', '9', 'N/A', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', '192.168.1.1'),
(52, 2, 'What is the value of π (pi) to two decimal places?', 1, '3.14', '3.14', '3.15', '3.13', '3.16', 'N/A', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', '192.168.1.1'),
(53, 2, 'What is the area of a circle with radius 5?', 1, '78.54', '78.54', '72.30', '85.40', '80.00', 'N/A', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', '192.168.1.1'),
(54, 2, 'Solve for x: 2x + 5 = 15', 1, '5', '5', '6', '4', '7', 'N/A', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', '192.168.1.1'),
(55, 2, 'What is the derivative of x^2?', 1, '2x', '2x', 'x', 'x^2', '2', 'N/A', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', '192.168.1.1'),
(101, 1, 'What is the capital of Italy?', 1, 'Rome', 'Rome', 'Paris', 'Berlin', 'Madrid', 'Lisbon', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL'),
(201, 1, 'Which planet is known as the Red Planet?', 1, 'Mars', 'Mars', 'Venus', 'Jupiter', 'Saturn', 'Mercury', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', 'NULL');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `quiz_result`
--

INSERT INTO `quiz_result` (`result_id`, `student_id`, `total_score`, `obtained_score`, `subject_id`, `total_time`, `time_to_complete`, `is_active`, `is_delete`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 5, 1, 1, 1, '00:20:00', '00:00:13', 1, 1, 5, '2024-08-13 16:55:17', NULL, '2024-08-13 11:25:17', NULL),
(2, 1, 20, 0, 1, '00:20:00', '00:00:02', 1, 1, 1, '2024-09-06 16:08:05', NULL, '2024-09-06 10:38:06', NULL),
(3, 1, 20, 2, 1, '00:20:00', '00:00:16', 1, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(4, 1, 20, 0, 2, '00:20:00', '00:20:00', 1, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(5, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(6, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(7, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(8, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(9, 1, 20, 1, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(10, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(11, 1, 20, 2, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(12, 1, 20, 2, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(13, 1, 20, 1, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(14, 1, 20, 0, 8, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(15, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(16, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(17, 1, 20, 1, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(18, 1, 20, 1, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(19, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(20, 1, 20, 0, 6, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(21, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(22, 1, 20, 1, 1, '00:20:00', '00:00:12', 1, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(23, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(24, 1, 20, 1, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(25, 1, 20, 0, 8, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(26, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(27, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(28, 1, 20, 0, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(29, 1, 20, 1, 7, '00:20:00', '00:00:00', 1, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(30, 1, 20, 1, 7, '00:20:00', '00:19:59', 1, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(31, 1, 20, 1, 7, '00:20:00', '00:20:00', 1, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(32, 1, 20, 0, 7, '00:20:00', '00:19:58', 1, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(33, 1, 20, 0, 7, '00:20:00', '00:20:00', 1, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(34, 1, 20, 0, 6, '00:20:00', '00:19:59', 1, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(35, 1, 20, 1, 1, '00:20:00', '00:20:00', 1, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(36, 1, 20, 0, 6, '00:20:00', '00:00:03', 1, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(37, 1, 20, 1, 6, '00:20:00', '00:00:19', 1, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(38, 1, 20, 0, 1, '00:20:00', '00:00:05', 1, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(39, 1, 20, 2, 1, '00:20:00', '00:00:51', 1, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(40, 1, 20, 1, 1, '00:20:00', '00:00:06', 1, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(41, 1, 20, 1, 1, '00:20:00', '00:00:06', 1, 1, 1, '2025-02-07 18:17:15', NULL, '2025-02-07 12:47:15', NULL),
(42, 1, 20, 1, 1, '00:20:00', '00:20:00', 1, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(43, 1, 20, 1, 1, '00:20:00', '00:00:09', 1, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:58', NULL),
(44, 1, 20, 2, 2, '00:20:00', '00:00:06', 1, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(45, 1, 20, 1, 2, '00:20:00', '00:00:04', 1, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(46, 1, 20, 1, 2, '00:20:00', '00:00:04', 1, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(47, 1, 20, 2, 2, '00:20:00', '00:00:06', 1, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(48, 1, 20, 1, 12, '00:20:00', '00:00:09', 1, 1, 1, '2025-02-11 08:55:54', NULL, '2025-02-11 03:25:55', NULL),
(49, 1, 20, 1, 2, '00:20:00', '00:00:03', 1, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(50, 1, 20, 2, 1, '00:20:00', '00:00:07', 1, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:55', NULL),
(51, 1, 20, 2, 1, '00:20:00', '00:00:06', 1, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(52, 1, 20, 3, 6, '00:20:00', '00:00:10', 1, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(53, 1, 20, 2, 8, '00:20:00', '00:00:07', 1, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(54, 1, 20, 1, 12, '00:20:00', '00:00:03', 1, 1, 1, '2025-02-11 17:30:57', NULL, '2025-02-11 12:00:57', NULL),
(55, 1, 20, 1, 1, '00:20:00', '00:00:48', 1, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(56, 1, 5, 1, 2, '00:20:00', '00:00:28', 1, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(57, 1, 20, 0, 1, '00:20:00', '00:08:57', 1, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(58, 1, 20, 2, 1, '00:20:00', '00:00:13', 1, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(59, 1, 20, 2, 1, '00:20:00', '00:00:04', 1, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `quiz_results`
-- (See below for the actual view)
--
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

--
-- Dumping data for table `quiz_result_detail`
--

INSERT INTO `quiz_result_detail` (`detail_id`, `result_id`, `quiz_id`, `selected_answer`, `right_answer`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 1, 1, 'Paris', 'Paris', 0, 1, 5, '2024-08-13 16:55:17', NULL, '2024-08-13 11:25:17', NULL),
(2, 2, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(3, 2, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(4, 2, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(5, 2, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(6, 2, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(7, 2, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(8, 2, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(9, 2, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(10, 2, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(11, 2, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(12, 2, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(13, 2, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(14, 2, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(15, 2, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(16, 2, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(17, 2, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(18, 2, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(19, 2, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(20, 2, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(21, 2, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 16:08:06', NULL, '2024-09-06 10:38:06', NULL),
(22, 3, 23, 'Ag', 'Ag', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(23, 3, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(24, 3, 20, 'Ottawa', 'Ottawa', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(25, 3, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(26, 3, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(27, 3, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(28, 3, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(29, 3, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(30, 3, 13, NULL, '2', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(31, 3, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(32, 3, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(33, 3, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(34, 3, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(35, 3, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(36, 3, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(37, 3, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(38, 3, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(39, 3, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(40, 3, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(41, 3, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 16:09:24', NULL, '2024-09-06 10:39:24', NULL),
(42, 4, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(43, 4, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(44, 4, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(45, 4, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(46, 4, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(47, 4, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(48, 4, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(49, 4, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(50, 4, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(51, 4, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(52, 4, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(53, 4, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(54, 4, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(55, 4, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(56, 4, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(57, 4, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(58, 4, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(59, 4, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(60, 4, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(61, 4, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 17:01:34', NULL, '2024-09-06 11:31:34', NULL),
(62, 5, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(63, 5, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(64, 5, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(65, 5, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(66, 5, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(67, 5, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(68, 5, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(69, 5, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(70, 5, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(71, 5, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(72, 5, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(73, 5, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(74, 5, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(75, 5, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(76, 5, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(77, 5, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(78, 5, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(79, 5, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(80, 5, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(81, 5, 13, NULL, '2', 0, 1, 1, '2024-09-06 17:08:31', NULL, '2024-09-06 11:38:31', NULL),
(82, 6, 22, NULL, 'Arctic', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(83, 6, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(84, 6, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(85, 6, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(86, 6, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(87, 6, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(88, 6, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(89, 6, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(90, 6, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(91, 6, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(92, 6, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(93, 6, 13, NULL, '2', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(94, 6, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(95, 6, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(96, 6, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(97, 6, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(98, 6, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(99, 6, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(100, 6, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(101, 6, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 17:09:16', NULL, '2024-09-06 11:39:16', NULL),
(102, 7, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(103, 7, 18, 'Venus', 'Mercury', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(104, 7, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(105, 7, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(106, 7, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(107, 7, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(108, 7, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(109, 7, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(110, 7, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(111, 7, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(112, 7, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(113, 7, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(114, 7, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(115, 7, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(116, 7, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(117, 7, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(118, 7, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(119, 7, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(120, 7, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(121, 7, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 17:14:52', NULL, '2024-09-06 11:44:52', NULL),
(122, 8, 23, 'Au', 'Ag', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(123, 8, 13, NULL, '2', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(124, 8, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(125, 8, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(126, 8, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(127, 8, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(128, 8, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(129, 8, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(130, 8, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(131, 8, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(132, 8, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(133, 8, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(134, 8, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(135, 8, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(136, 8, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(137, 8, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(138, 8, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(139, 8, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(140, 8, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(141, 8, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 17:19:27', NULL, '2024-09-06 11:49:27', NULL),
(142, 9, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(143, 9, 13, '2', '2', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(144, 9, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(145, 9, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(146, 9, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(147, 9, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(148, 9, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(149, 9, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(150, 9, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(151, 9, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(152, 9, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(153, 9, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(154, 9, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(155, 9, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(156, 9, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(157, 9, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(158, 9, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(159, 9, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(160, 9, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(161, 9, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 18:08:37', NULL, '2024-09-06 12:38:37', NULL),
(162, 10, 19, 'Mississippi', 'Nile', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(163, 10, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(164, 10, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(165, 10, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(166, 10, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(167, 10, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(168, 10, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(169, 10, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(170, 10, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(171, 10, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(172, 10, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(173, 10, 13, NULL, '2', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(174, 10, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(175, 10, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(176, 10, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(177, 10, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(178, 10, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(179, 10, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(180, 10, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(181, 10, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 18:11:32', NULL, '2024-09-06 12:41:32', NULL),
(182, 11, 19, 'Nile', 'Nile', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(183, 11, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(184, 11, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(185, 11, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(186, 11, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(187, 11, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(188, 11, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(189, 11, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(190, 11, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(191, 11, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(192, 11, 13, '2', '2', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(193, 11, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(194, 11, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(195, 11, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(196, 11, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(197, 11, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(198, 11, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(199, 11, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(200, 11, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(201, 11, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 18:12:34', NULL, '2024-09-06 12:42:34', NULL),
(202, 12, 23, 'Ag', 'Ag', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(203, 12, 4, 'Indian Ocean', 'Pacific Ocean', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(204, 12, 18, 'Venus', 'Mercury', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(205, 12, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(206, 12, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(207, 12, 3, 'Mark Twain', 'William Shakespeare', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(208, 12, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(209, 12, 16, 'Albert Einstein', 'Albert Einstein', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(210, 12, 15, 'Sydney', 'Canberra', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(211, 12, 201, 'Jupiter', 'Mars', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(212, 12, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(213, 12, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(214, 12, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(215, 12, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(216, 12, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(217, 12, 13, NULL, '2', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(218, 12, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(219, 12, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(220, 12, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(221, 12, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 18:16:47', NULL, '2024-09-06 12:46:47', NULL),
(222, 13, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(223, 13, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(224, 13, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(225, 13, 19, 'Amazon', 'Nile', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(226, 13, 7, 'China', 'Japan', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(227, 13, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(228, 13, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(229, 13, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(230, 13, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(231, 13, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(232, 13, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(233, 13, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(234, 13, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(235, 13, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(236, 13, 9, 'Pablo Picasso', 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(237, 13, 24, 'Harper Lee', 'Harper Lee', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(238, 13, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(239, 13, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(240, 13, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(241, 13, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 18:46:12', NULL, '2024-09-06 13:16:12', NULL),
(242, 14, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(243, 14, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(244, 14, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(245, 14, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(246, 14, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(247, 14, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(248, 14, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(249, 14, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(250, 14, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(251, 14, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(252, 14, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(253, 14, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(254, 14, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(255, 14, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(256, 14, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(257, 14, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(258, 14, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(259, 14, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(260, 14, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(261, 14, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:09:02', NULL, '2024-09-06 13:39:02', NULL),
(262, 15, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(263, 15, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(264, 15, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(265, 15, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(266, 15, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(267, 15, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(268, 15, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(269, 15, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(270, 15, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(271, 15, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(272, 15, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(273, 15, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(274, 15, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(275, 15, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(276, 15, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(277, 15, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(278, 15, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(279, 15, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(280, 15, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(281, 15, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:23:22', NULL, '2024-09-06 13:53:22', NULL),
(282, 16, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(283, 16, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(284, 16, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(285, 16, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(286, 16, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(287, 16, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(288, 16, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(289, 16, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(290, 16, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(291, 16, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(292, 16, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(293, 16, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(294, 16, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(295, 16, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(296, 16, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(297, 16, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(298, 16, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(299, 16, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(300, 16, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(301, 16, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:23:39', NULL, '2024-09-06 13:53:39', NULL),
(302, 17, 10, 'Jupiter', 'Jupiter', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(303, 17, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(304, 17, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(305, 17, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(306, 17, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(307, 17, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(308, 17, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(309, 17, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(310, 17, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(311, 17, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(312, 17, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(313, 17, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(314, 17, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(315, 17, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(316, 17, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(317, 17, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(318, 17, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(319, 17, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(320, 17, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(321, 17, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:41:17', NULL, '2024-09-06 14:11:17', NULL),
(322, 18, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(323, 18, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(324, 18, 15, 'Canberra', 'Canberra', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(325, 18, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(326, 18, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(327, 18, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(328, 18, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(329, 18, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(330, 18, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(331, 18, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(332, 18, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(333, 18, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(334, 18, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(335, 18, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(336, 18, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(337, 18, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(338, 18, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(339, 18, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(340, 18, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(341, 18, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:42:43', NULL, '2024-09-06 14:12:43', NULL),
(342, 19, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(343, 19, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(344, 19, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(345, 19, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(346, 19, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(347, 19, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(348, 19, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(349, 19, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(350, 19, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(351, 19, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(352, 19, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(353, 19, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(354, 19, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(355, 19, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(356, 19, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(357, 19, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(358, 19, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(359, 19, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(360, 19, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(361, 19, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:44:09', NULL, '2024-09-06 14:14:09', NULL),
(362, 20, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(363, 20, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(364, 20, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(365, 20, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(366, 20, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(367, 20, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(368, 20, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(369, 20, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(370, 20, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(371, 20, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(372, 20, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(373, 20, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(374, 20, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(375, 20, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(376, 20, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(377, 20, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(378, 20, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(379, 20, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(380, 20, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(381, 20, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:47:39', NULL, '2024-09-06 14:17:39', NULL),
(382, 21, 11, 'Tomato', 'Avocado', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(383, 21, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(384, 21, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(385, 21, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(386, 21, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(387, 21, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(388, 21, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(389, 21, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(390, 21, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(391, 21, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(392, 21, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(393, 21, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(394, 21, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(395, 21, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(396, 21, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(397, 21, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(398, 21, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(399, 21, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(400, 21, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(401, 21, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:50:04', NULL, '2024-09-06 14:20:04', NULL),
(402, 22, 14, 'Indian Ocean', 'Indian Ocean', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(403, 22, 15, 'Sydney', 'Canberra', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(404, 22, 13, '3', '2', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(405, 22, 101, 'Berlin', 'Rome', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(406, 22, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(407, 22, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(408, 22, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(409, 22, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(410, 22, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(411, 22, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(412, 22, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(413, 22, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(414, 22, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(415, 22, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(416, 22, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(417, 22, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(418, 22, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(419, 22, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(420, 22, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(421, 22, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 19:50:48', NULL, '2024-09-06 14:20:48', NULL),
(422, 23, 13, NULL, '2', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(423, 23, 11, 'Tomato', 'Avocado', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(424, 23, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(425, 23, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(426, 23, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(427, 23, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(428, 23, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(429, 23, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(430, 23, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(431, 23, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(432, 23, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(433, 23, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(434, 23, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(435, 23, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(436, 23, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(437, 23, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(438, 23, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(439, 23, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(440, 23, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(441, 23, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 19:53:31', NULL, '2024-09-06 14:23:31', NULL),
(442, 24, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(443, 24, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(444, 24, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(445, 24, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(446, 24, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(447, 24, 13, NULL, '2', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(448, 24, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(449, 24, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(450, 24, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(451, 24, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(452, 24, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(453, 24, 101, NULL, 'Rome', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(454, 24, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(455, 24, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(456, 24, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(457, 24, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(458, 24, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(459, 24, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(460, 24, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(461, 24, 12, 'Charles Babbage', 'Charles Babbage', 0, 1, 1, '2024-09-06 20:33:51', NULL, '2024-09-06 15:03:51', NULL),
(462, 25, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(463, 25, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(464, 25, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(465, 25, 13, NULL, '2', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(466, 25, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(467, 25, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(468, 25, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(469, 25, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(470, 25, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(471, 25, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(472, 25, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(473, 25, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(474, 25, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(475, 25, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(476, 25, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(477, 25, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(478, 25, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(479, 25, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(480, 25, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(481, 25, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-06 20:36:47', NULL, '2024-09-06 15:06:47', NULL),
(482, 26, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(483, 26, 7, NULL, 'Japan', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(484, 26, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(485, 26, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(486, 26, 6, NULL, 'Au', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(487, 26, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(488, 26, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(489, 26, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(490, 26, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(491, 26, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(492, 26, 13, NULL, '2', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(493, 26, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(494, 26, 201, NULL, 'Mars', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(495, 26, 23, NULL, 'Ag', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(496, 26, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(497, 26, 19, NULL, 'Nile', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(498, 26, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(499, 26, 1, NULL, 'Paris', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(500, 26, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(501, 26, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-06 20:38:46', NULL, '2024-09-06 15:08:46', NULL),
(502, 27, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(503, 27, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(504, 27, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(505, 27, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL);
INSERT INTO `quiz_result_detail` (`detail_id`, `result_id`, `quiz_id`, `selected_answer`, `right_answer`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(506, 27, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(507, 27, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(508, 27, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(509, 27, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(510, 27, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(511, 27, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(512, 27, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(513, 27, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(514, 27, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(515, 27, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(516, 27, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(517, 27, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(518, 27, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(519, 27, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(520, 27, 13, NULL, '2', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(521, 27, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:40:45', NULL, '2024-09-07 04:10:45', NULL),
(522, 28, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(523, 28, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(524, 28, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(525, 28, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(526, 28, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(527, 28, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(528, 28, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(529, 28, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(530, 28, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(531, 28, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(532, 28, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(533, 28, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(534, 28, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(535, 28, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(536, 28, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(537, 28, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(538, 28, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(539, 28, 13, NULL, '2', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(540, 28, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(541, 28, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 09:42:17', NULL, '2024-09-07 04:12:17', NULL),
(542, 29, 22, 'Sahara', 'Sahara', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(543, 29, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(544, 29, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(545, 29, 6, 'Ag', 'Au', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(546, 29, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(547, 29, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(548, 29, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(549, 29, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(550, 29, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(551, 29, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(552, 29, 13, NULL, '2', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(553, 29, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(554, 29, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(555, 29, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(556, 29, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(557, 29, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(558, 29, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(559, 29, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(560, 29, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(561, 29, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:42:56', NULL, '2024-09-07 04:12:56', NULL),
(562, 30, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(563, 30, 22, 'Sahara', 'Sahara', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(564, 30, 6, 'Ag', 'Au', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(565, 30, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(566, 30, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(567, 30, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(568, 30, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(569, 30, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(570, 30, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(571, 30, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(572, 30, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(573, 30, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(574, 30, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(575, 30, 13, NULL, '2', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(576, 30, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(577, 30, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(578, 30, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(579, 30, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(580, 30, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(581, 30, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 09:44:18', NULL, '2024-09-07 04:14:18', NULL),
(582, 31, 6, 'Ag', 'Au', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(583, 31, 22, 'Sahara', 'Sahara', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(584, 31, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(585, 31, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(586, 31, 13, NULL, '2', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(587, 31, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(588, 31, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(589, 31, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(590, 31, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(591, 31, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(592, 31, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(593, 31, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(594, 31, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(595, 31, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(596, 31, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(597, 31, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(598, 31, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(599, 31, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(600, 31, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(601, 31, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:50:46', NULL, '2024-09-07 04:20:46', NULL),
(602, 32, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(603, 32, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(604, 32, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(605, 32, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(606, 32, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(607, 32, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(608, 32, 101, NULL, 'Rome', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(609, 32, 19, NULL, 'Nile', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(610, 32, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(611, 32, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(612, 32, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(613, 32, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(614, 32, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(615, 32, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(616, 32, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(617, 32, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(618, 32, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(619, 32, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(620, 32, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(621, 32, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:51:06', NULL, '2024-09-07 04:21:06', NULL),
(622, 33, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(623, 33, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(624, 33, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(625, 33, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(626, 33, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(627, 33, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(628, 33, 101, NULL, 'Rome', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(629, 33, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(630, 33, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(631, 33, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(632, 33, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(633, 33, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(634, 33, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(635, 33, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(636, 33, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(637, 33, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(638, 33, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(639, 33, 19, NULL, 'Nile', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(640, 33, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(641, 33, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 09:52:14', NULL, '2024-09-07 04:22:14', NULL),
(642, 34, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(643, 34, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(644, 34, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(645, 34, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(646, 34, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(647, 34, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(648, 34, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(649, 34, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(650, 34, 101, NULL, 'Rome', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(651, 34, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(652, 34, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(653, 34, 13, NULL, '2', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(654, 34, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(655, 34, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(656, 34, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(657, 34, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(658, 34, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(659, 34, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(660, 34, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(661, 34, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-07 17:38:10', NULL, '2024-09-07 12:08:10', NULL),
(662, 35, 19, NULL, 'Nile', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(663, 35, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(664, 35, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(665, 35, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(666, 35, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(667, 35, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(668, 35, 101, NULL, 'Rome', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(669, 35, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(670, 35, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(671, 35, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(672, 35, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(673, 35, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(674, 35, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(675, 35, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(676, 35, 13, NULL, '2', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(677, 35, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(678, 35, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(679, 35, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(680, 35, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(681, 35, 10, 'Jupiter', 'Jupiter', 0, 1, 1, '2024-09-07 18:01:53', NULL, '2024-09-07 12:31:53', NULL),
(682, 36, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(683, 36, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(684, 36, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(685, 36, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(686, 36, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(687, 36, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(688, 36, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(689, 36, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(690, 36, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(691, 36, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(692, 36, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(693, 36, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(694, 36, 13, NULL, '2', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(695, 36, 19, NULL, 'Nile', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(696, 36, 6, NULL, 'Au', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(697, 36, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(698, 36, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(699, 36, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(700, 36, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(701, 36, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 18:31:22', NULL, '2024-09-07 13:01:22', NULL),
(702, 37, 23, NULL, 'Ag', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(703, 37, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(704, 37, 24, 'Harper Lee', 'Harper Lee', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(705, 37, 1, NULL, 'Paris', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(706, 37, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(707, 37, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(708, 37, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(709, 37, 201, NULL, 'Mars', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(710, 37, 19, NULL, 'Nile', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(711, 37, 10, NULL, 'Jupiter', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(712, 37, 20, NULL, 'Ottawa', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(713, 37, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(714, 37, 7, NULL, 'Japan', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(715, 37, 14, NULL, 'Indian Ocean', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(716, 37, 13, NULL, '2', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(717, 37, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(718, 37, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(719, 37, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(720, 37, 25, NULL, 'Vatican City', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(721, 37, 101, NULL, 'Rome', 0, 1, 1, '2024-09-07 19:08:18', NULL, '2024-09-07 13:38:18', NULL),
(722, 38, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(723, 38, 12, NULL, 'Charles Babbage', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(724, 38, 7, NULL, 'Japan', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(725, 38, 24, NULL, 'Harper Lee', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(726, 38, 18, NULL, 'Mercury', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(727, 38, 15, NULL, 'Canberra', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(728, 38, 6, NULL, 'Au', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(729, 38, 16, NULL, 'Albert Einstein', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(730, 38, 201, NULL, 'Mars', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(731, 38, 5, NULL, 'George Washington', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(732, 38, 22, NULL, 'Sahara', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(733, 38, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(734, 38, 101, NULL, 'Rome', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(735, 38, 11, NULL, 'Avocado', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(736, 38, 3, NULL, 'William Shakespeare', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(737, 38, 23, NULL, 'Ag', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(738, 38, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(739, 38, 8, NULL, 'Diamond', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(740, 38, 13, NULL, '2', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(741, 38, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2024-09-09 09:39:10', NULL, '2024-09-09 04:09:10', NULL),
(742, 39, 4, 'Indian Ocean', 'Pacific Ocean', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(743, 39, 6, 'Au', 'Au', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(744, 39, 201, NULL, 'Mars', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(745, 39, 8, NULL, 'Diamond', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(746, 39, 17, 'English', 'Mandarin Chinese', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(747, 39, 5, 'George Washington', 'George Washington', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(748, 39, 18, NULL, 'Mercury', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(749, 39, 15, NULL, 'Canberra', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(750, 39, 13, NULL, '2', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(751, 39, 20, NULL, 'Ottawa', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(752, 39, 10, NULL, 'Jupiter', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(753, 39, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(754, 39, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(755, 39, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(756, 39, 7, 'South Korea', 'Japan', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(757, 39, 25, NULL, 'Vatican City', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(758, 39, 101, NULL, 'Rome', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(759, 39, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(760, 39, 1, NULL, 'Paris', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(761, 39, 16, 'Niels Bohr', 'Albert Einstein', 0, 1, 1, '2025-01-29 11:59:34', NULL, '2025-01-29 06:29:34', NULL),
(762, 40, 24, 'Harper Lee', 'Harper Lee', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(763, 40, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(764, 40, 13, '1', '2', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(765, 40, 1, NULL, 'Paris', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(766, 40, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(767, 40, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(768, 40, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(769, 40, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(770, 40, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(771, 40, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(772, 40, 6, NULL, 'Au', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(773, 40, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(774, 40, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(775, 40, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(776, 40, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(777, 40, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(778, 40, 19, NULL, 'Nile', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(779, 40, 101, NULL, 'Rome', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(780, 40, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(781, 40, 201, NULL, 'Mars', 0, 1, 1, '2025-02-07 17:49:43', NULL, '2025-02-07 12:19:43', NULL),
(782, 41, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(783, 41, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(784, 41, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(785, 41, 19, NULL, 'Nile', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(786, 41, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(787, 41, 6, NULL, 'Au', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(788, 41, 23, NULL, 'Ag', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(789, 41, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(790, 41, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(791, 41, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(792, 41, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(793, 41, 15, 'Canberra', 'Canberra', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(794, 41, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(795, 41, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(796, 41, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(797, 41, 7, NULL, 'Japan', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(798, 41, 201, NULL, 'Mars', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(799, 41, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(800, 41, 1, NULL, 'Paris', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(801, 41, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-07 18:17:16', NULL, '2025-02-07 12:47:16', NULL),
(802, 42, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(803, 42, 1, NULL, 'Paris', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(804, 42, 201, NULL, 'Mars', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(805, 42, 7, NULL, 'Japan', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(806, 42, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(807, 42, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(808, 42, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(809, 42, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(810, 42, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(811, 42, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(812, 42, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(813, 42, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(814, 42, 23, NULL, 'Ag', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(815, 42, 6, NULL, 'Au', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(816, 42, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(817, 42, 19, NULL, 'Nile', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(818, 42, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(819, 42, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(820, 42, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(821, 42, 15, 'Canberra', 'Canberra', 0, 1, 1, '2025-02-07 18:44:21', NULL, '2025-02-07 13:14:21', NULL),
(822, 43, 14, 'Indian Ocean', 'Indian Ocean', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(823, 43, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(824, 43, 1, NULL, 'Paris', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(825, 43, 19, NULL, 'Nile', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(826, 43, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(827, 43, 4, 'Indian Ocean', 'Pacific Ocean', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(828, 43, 7, NULL, 'Japan', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(829, 43, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(830, 43, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(831, 43, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(832, 43, 13, NULL, '2', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(833, 43, 23, NULL, 'Ag', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(834, 43, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(835, 43, 101, NULL, 'Rome', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(836, 43, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(837, 43, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(838, 43, 201, NULL, 'Mars', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(839, 43, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(840, 43, 6, NULL, 'Au', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(841, 43, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-10 18:31:58', NULL, '2025-02-10 13:01:59', NULL),
(842, 44, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(843, 44, 13, NULL, '2', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(844, 44, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(845, 44, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(846, 44, 7, NULL, 'Japan', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(847, 44, 6, 'Au', 'Au', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(848, 44, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(849, 44, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(850, 44, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(851, 44, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(852, 44, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(853, 44, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(854, 44, 25, 'Vatican City', 'Vatican City', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(855, 44, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(856, 44, 1, NULL, 'Paris', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(857, 44, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(858, 44, 101, NULL, 'Rome', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(859, 44, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(860, 44, 201, NULL, 'Mars', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(861, 44, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-10 19:49:53', NULL, '2025-02-10 14:19:53', NULL),
(862, 45, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(863, 45, 13, NULL, '2', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(864, 45, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(865, 45, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(866, 45, 25, 'Vatican City', 'Vatican City', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(867, 45, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(868, 45, 101, NULL, 'Rome', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(869, 45, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(870, 45, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(871, 45, 6, NULL, 'Au', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(872, 45, 7, NULL, 'Japan', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(873, 45, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(874, 45, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(875, 45, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(876, 45, 23, NULL, 'Ag', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(877, 45, 1, NULL, 'Paris', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(878, 45, 19, NULL, 'Nile', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(879, 45, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(880, 45, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(881, 45, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-10 19:57:55', NULL, '2025-02-10 14:27:55', NULL),
(882, 46, 10, 'Jupiter', 'Jupiter', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(883, 46, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(884, 46, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(885, 46, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(886, 46, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(887, 46, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(888, 46, 19, NULL, 'Nile', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(889, 46, 23, NULL, 'Ag', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(890, 46, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(891, 46, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(892, 46, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(893, 46, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(894, 46, 101, NULL, 'Rome', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(895, 46, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(896, 46, 6, NULL, 'Au', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(897, 46, 7, NULL, 'Japan', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(898, 46, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(899, 46, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(900, 46, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(901, 46, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-10 19:58:22', NULL, '2025-02-10 14:28:22', NULL),
(902, 47, 101, 'Rome', 'Rome', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(903, 47, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(904, 47, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(905, 47, 7, NULL, 'Japan', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(906, 47, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(907, 47, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(908, 47, 18, 'Mercury', 'Mercury', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(909, 47, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(910, 47, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(911, 47, 19, NULL, 'Nile', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(912, 47, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(913, 47, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(914, 47, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(915, 47, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(916, 47, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(917, 47, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(918, 47, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(919, 47, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(920, 47, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(921, 47, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-11 08:54:51', NULL, '2025-02-11 03:24:51', NULL),
(922, 48, 3, 'Charles Dickens', 'William Shakespeare', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(923, 48, 1, 'London', 'Paris', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(924, 48, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(925, 48, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(926, 48, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(927, 48, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(928, 48, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(929, 48, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(930, 48, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(931, 48, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(932, 48, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(933, 48, 21, 'Neil Armstrong', 'Neil Armstrong', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(934, 48, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(935, 48, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(936, 48, 101, NULL, 'Rome', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(937, 48, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(938, 48, 13, NULL, '2', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(939, 48, 6, NULL, 'Au', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(940, 48, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(941, 48, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 08:55:55', NULL, '2025-02-11 03:25:55', NULL),
(942, 49, 9, 'Leonardo da Vinci', 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(943, 49, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(944, 49, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(945, 49, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(946, 49, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(947, 49, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(948, 49, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(949, 49, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(950, 49, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(951, 49, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(952, 49, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(953, 49, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(954, 49, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(955, 49, 6, NULL, 'Au', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(956, 49, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(957, 49, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(958, 49, 7, NULL, 'Japan', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(959, 49, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(960, 49, 13, NULL, '2', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(961, 49, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-11 11:22:44', NULL, '2025-02-11 05:52:44', NULL),
(962, 50, 7, 'Japan', 'Japan', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(963, 50, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(964, 50, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(965, 50, 20, 'Ottawa', 'Ottawa', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(966, 50, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(967, 50, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(968, 50, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(969, 50, 19, NULL, 'Nile', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(970, 50, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(971, 50, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(972, 50, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(973, 50, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(974, 50, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(975, 50, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(976, 50, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(977, 50, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(978, 50, 6, NULL, 'Au', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(979, 50, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(980, 50, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(981, 50, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 11:38:55', NULL, '2025-02-11 06:08:56', NULL),
(982, 51, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(983, 51, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(984, 51, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(985, 51, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(986, 51, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(987, 51, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(988, 51, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(989, 51, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(990, 51, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(991, 51, 101, NULL, 'Rome', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(992, 51, 7, 'Japan', 'Japan', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(993, 51, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(994, 51, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(995, 51, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(996, 51, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(997, 51, 13, NULL, '2', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(998, 51, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(999, 51, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(1000, 51, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(1001, 51, 19, 'Nile', 'Nile', 0, 1, 1, '2025-02-11 11:47:19', NULL, '2025-02-11 06:17:19', NULL),
(1002, 52, 6, 'Au', 'Au', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1003, 52, 20, 'Ottawa', 'Ottawa', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1004, 52, 7, 'Japan', 'Japan', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1005, 52, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1006, 52, 15, 'Sydney', 'Canberra', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL);
INSERT INTO `quiz_result_detail` (`detail_id`, `result_id`, `quiz_id`, `selected_answer`, `right_answer`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1007, 52, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1008, 52, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1009, 52, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1010, 52, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1011, 52, 19, NULL, 'Nile', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1012, 52, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1013, 52, 13, NULL, '2', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1014, 52, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1015, 52, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1016, 52, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1017, 52, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1018, 52, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1019, 52, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1020, 52, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1021, 52, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-11 12:01:47', NULL, '2025-02-11 06:31:47', NULL),
(1022, 53, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1023, 53, 23, 'Ag', 'Ag', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1024, 53, 6, NULL, 'Au', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1025, 53, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1026, 53, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1027, 53, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1028, 53, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1029, 53, 5, 'Thomas Jefferson', 'George Washington', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1030, 53, 9, 'Leonardo da Vinci', 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1031, 53, 101, NULL, 'Rome', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1032, 53, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1033, 53, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1034, 53, 7, NULL, 'Japan', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1035, 53, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1036, 53, 19, NULL, 'Nile', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1037, 53, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1038, 53, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1039, 53, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1040, 53, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1041, 53, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-11 12:02:21', NULL, '2025-02-11 06:32:21', NULL),
(1042, 54, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1043, 54, 6, NULL, 'Au', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1044, 54, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1045, 54, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1046, 54, 13, NULL, '2', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1047, 54, 23, NULL, 'Ag', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1048, 54, 101, NULL, 'Rome', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1049, 54, 25, 'Vatican City', 'Vatican City', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1050, 54, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1051, 54, 201, NULL, 'Mars', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1052, 54, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1053, 54, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1054, 54, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1055, 54, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1056, 54, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1057, 54, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1058, 54, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1059, 54, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1060, 54, 1, NULL, 'Paris', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1061, 54, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-11 17:30:58', NULL, '2025-02-11 12:00:58', NULL),
(1062, 55, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1063, 55, 7, NULL, 'Japan', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1064, 55, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1065, 55, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1066, 55, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1067, 55, 6, 'Ag', 'Au', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1068, 55, 14, 'Indian Ocean', 'Indian Ocean', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1069, 55, 3, 'Charles Dickens', 'William Shakespeare', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1070, 55, 19, 'Amazon', 'Nile', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1071, 55, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1072, 55, 201, NULL, 'Mars', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1073, 55, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1074, 55, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1075, 55, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1076, 55, 1, NULL, 'Paris', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1077, 55, 23, NULL, 'Ag', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1078, 55, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1079, 55, 101, 'Berlin', 'Rome', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1080, 55, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1081, 55, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-21 17:49:12', NULL, '2025-02-21 12:19:12', NULL),
(1082, 56, 51, 'N/A', '8', 0, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(1083, 56, 53, '78.54', '78.54', 0, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(1084, 56, 55, 'x^2', '2x', 0, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(1085, 56, 54, NULL, '5', 0, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(1086, 56, 52, NULL, '3.14', 0, 1, 1, '2025-02-21 17:58:20', NULL, '2025-02-21 12:28:20', NULL),
(1087, 57, 13, NULL, '2', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1088, 57, 7, NULL, 'Japan', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1089, 57, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1090, 57, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1091, 57, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1092, 57, 6, NULL, 'Au', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1093, 57, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1094, 57, 8, NULL, 'Diamond', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1095, 57, 101, NULL, 'Rome', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1096, 57, 19, 'Amazon', 'Nile', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1097, 57, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1098, 57, 23, NULL, 'Ag', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1099, 57, 201, NULL, 'Mars', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1100, 57, 1, NULL, 'Paris', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1101, 57, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1102, 57, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1103, 57, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1104, 57, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1105, 57, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1106, 57, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-22 16:56:34', NULL, '2025-02-22 11:26:34', NULL),
(1107, 58, 201, 'Mars', 'Mars', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1108, 58, 15, 'Sydney', 'Canberra', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1109, 58, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1110, 58, 22, 'Arctic', 'Sahara', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1111, 58, 18, 'Mercury', 'Mercury', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1112, 58, 7, 'China', 'Japan', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1113, 58, 101, 'Paris', 'Rome', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1114, 58, 1, 'London', 'Paris', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1115, 58, 9, 'Vincent van Gogh', 'Leonardo da Vinci', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1116, 58, 19, NULL, 'Nile', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1117, 58, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1118, 58, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1119, 58, 3, NULL, 'William Shakespeare', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1120, 58, 6, NULL, 'Au', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1121, 58, 13, NULL, '2', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1122, 58, 14, NULL, 'Indian Ocean', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1123, 58, 10, NULL, 'Jupiter', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1124, 58, 12, NULL, 'Charles Babbage', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1125, 58, 25, NULL, 'Vatican City', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1126, 58, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-22 17:06:03', NULL, '2025-02-22 11:36:03', NULL),
(1127, 59, 1, 'Paris', 'Paris', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1128, 59, 3, 'William Shakespeare', 'William Shakespeare', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1129, 59, 9, NULL, 'Leonardo da Vinci', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1130, 59, 24, NULL, 'Harper Lee', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1131, 59, 17, NULL, 'Mandarin Chinese', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1132, 59, 19, NULL, 'Nile', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1133, 59, 101, NULL, 'Rome', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1134, 59, 11, NULL, 'Avocado', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1135, 59, 16, NULL, 'Albert Einstein', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1136, 59, 7, NULL, 'Japan', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1137, 59, 20, NULL, 'Ottawa', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1138, 59, 13, NULL, '2', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1139, 59, 18, NULL, 'Mercury', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1140, 59, 5, NULL, 'George Washington', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1141, 59, 22, NULL, 'Sahara', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1142, 59, 15, NULL, 'Canberra', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1143, 59, 21, NULL, 'Neil Armstrong', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1144, 59, 4, NULL, 'Pacific Ocean', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1145, 59, 6, NULL, 'Au', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL),
(1146, 59, 23, NULL, 'Ag', 0, 1, 1, '2025-02-24 16:13:51', NULL, '2025-02-24 10:43:51', NULL);

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

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `student_name`, `student_phone`, `student_email`, `student_address`, `student_pic`, `student_username`, `student_password`, `start_date`, `end_date`, `is_externally_added`, `login_flag`, `unique_id`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 'test', '9999999999', 'test@gmail.com', NULL, NULL, 'test', '21232f297a57a5a743894a0e4a801fc3', '2024-08-01', '2025-12-01', 0, 0, 'RKQ1.211119.001', NULL, NULL, NULL, NULL, NULL, '2024-08-13 05:01:00', NULL),
(4, 'test2', '9999999998', NULL, NULL, NULL, 'test1', '21232f297a57a5a743894a0e4a801fc3', '2024-08-01', '2024-12-31', 0, 0, 'RSR1.210722.013.A2', NULL, NULL, NULL, NULL, NULL, '2024-08-13 05:52:51', NULL),
(5, 'test3', '9999999997', NULL, NULL, NULL, 'test3', '098f6bcd4621d373cade4e832627b4f6', '2024-08-01', '2024-12-31', 0, 0, '03D502E0-045E-0571-D306-710700080009', NULL, NULL, NULL, NULL, NULL, '2024-08-13 05:52:51', NULL),
(100, 'Test', '7303555512', NULL, NULL, NULL, 'test', 'test', '2023-03-01', '2026-04-30', 0, 0, 'undefined', NULL, NULL, NULL, NULL, NULL, '2023-02-21 22:52:48', NULL);

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

--
-- Dumping data for table `student_log`
--

INSERT INTO `student_log` (`log_id`, `student_id`, `log_action`, `log_description`, `log_date`, `is_active`, `is_delete`) VALUES
(1, 1, 'logout', NULL, '2025-02-11 11:34:19', NULL, NULL),
(2, 1, 'logout', NULL, '2025-02-11 11:56:51', NULL, NULL),
(3, 1, 'logout', NULL, '2025-02-11 12:25:36', NULL, NULL),
(4, 1, 'logout', NULL, '2025-02-11 17:31:08', NULL, NULL),
(5, 1, 'logout', NULL, '2025-02-11 17:33:02', NULL, NULL),
(6, 1, 'logout', NULL, '2025-02-11 18:02:31', NULL, NULL),
(7, 1, 'logout', NULL, '2025-02-18 09:25:16', NULL, NULL),
(8, 1, 'logout', NULL, '2025-02-18 17:03:02', NULL, NULL),
(9, 1, 'logout', NULL, '2025-02-19 16:19:44', NULL, NULL),
(10, 1, 'logout', NULL, '2025-02-19 17:43:14', NULL, NULL),
(11, 1, 'logout', NULL, '2025-02-21 12:16:30', NULL, NULL);

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

--
-- Dumping data for table `student_progress`
--

INSERT INTO `student_progress` (`progress_id`, `box_id`, `student_id`, `subject_id`, `type`, `type_id`, `progress`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 10:19:23', NULL, NULL, NULL),
(2, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 10:19:24', NULL, NULL, NULL),
(3, 1, 1, 6, 1, 11, 2.8777, 1, 1, 1, '2024-09-07 10:19:29', NULL, NULL, NULL),
(4, 1, 1, 6, 1, 11, 10.0719, 1, 1, 1, '2024-09-07 10:19:42', NULL, NULL, NULL),
(5, 1, 1, 6, 1, 11, 14.3885, 1, 1, 1, '2024-09-07 10:19:49', NULL, NULL, NULL),
(6, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 10:23:18', NULL, NULL, NULL),
(7, 1, 1, 6, 1, 11, 2.8777, 1, 1, 1, '2024-09-07 10:23:24', NULL, NULL, NULL),
(8, 1, 1, 6, 1, 11, 22.3022, 1, 1, 1, '2024-09-07 10:23:51', NULL, NULL, NULL),
(9, 1, 1, 6, 1, 11, 36.6906, 1, 1, 1, '2024-09-07 10:24:15', NULL, NULL, NULL),
(10, 1, 1, 6, 1, 11, 58.9928, 1, 1, 1, '2024-09-07 10:24:49', NULL, NULL, NULL),
(11, 1, 1, 6, 1, 11, 60.4317, 1, 1, 1, '2024-09-07 10:24:59', NULL, NULL, NULL),
(12, 1, 1, 6, 1, 11, 61.8705, 1, 1, 1, '2024-09-07 10:26:01', NULL, NULL, NULL),
(13, 1, 1, 6, 1, 11, 62.5899, 1, 1, 1, '2024-09-07 10:26:34', NULL, NULL, NULL),
(14, 1, 1, 6, 1, 11, 62.5899, 1, 1, 1, '2024-09-07 10:26:36', NULL, NULL, NULL),
(15, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 10:28:39', NULL, NULL, NULL),
(16, 1, 1, 6, 1, 11, 0.719424, 1, 1, 1, '2024-09-07 10:28:41', NULL, NULL, NULL),
(17, 1, 1, 6, 1, 11, 2.15827, 1, 1, 1, '2024-09-07 10:28:45', NULL, NULL, NULL),
(18, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 17:43:02', NULL, NULL, NULL),
(19, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 17:43:03', NULL, NULL, NULL),
(20, 1, 0, 1, 1, 2, 0, 1, 1, 0, '2024-09-07 18:01:38', NULL, NULL, NULL),
(21, 1, 0, 1, 1, 2, 6.66667, 1, 1, 0, '2024-09-07 18:01:41', NULL, NULL, NULL),
(22, 1, 1, 7, 1, 13, 0, 1, 1, 1, '2024-09-07 18:34:21', NULL, NULL, NULL),
(23, 1, 1, 7, 1, 13, 12.9496, 1, 1, 1, '2024-09-07 18:34:40', NULL, NULL, NULL),
(24, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 18:55:33', NULL, NULL, NULL),
(25, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 18:55:34', NULL, NULL, NULL),
(26, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 18:55:41', NULL, NULL, NULL),
(27, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 18:57:00', NULL, NULL, NULL),
(28, 1, 1, 6, 1, 11, 10.0719, 1, 1, 1, '2024-09-07 18:57:15', NULL, NULL, NULL),
(29, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 18:57:17', NULL, NULL, NULL),
(30, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 18:59:37', NULL, NULL, NULL),
(31, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 18:59:37', NULL, NULL, NULL),
(32, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 18:59:37', NULL, NULL, NULL),
(33, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 18:59:37', NULL, NULL, NULL),
(34, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 18:59:37', NULL, NULL, NULL),
(35, 1, 1, 6, 1, 11, 100, 1, 1, 1, '2024-09-07 19:00:31', NULL, NULL, NULL),
(36, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 19:00:32', NULL, NULL, NULL),
(37, 1, 1, 6, 1, 11, 35.9712, 1, 1, 1, '2024-09-07 19:01:23', NULL, NULL, NULL),
(38, 1, 1, 6, 1, 11, 0, 1, 1, 1, '2024-09-07 19:10:34', NULL, NULL, NULL),
(39, 1, 1, 6, 1, 11, 3.59712, 1, 1, 1, '2024-09-07 19:10:40', NULL, NULL, NULL),
(40, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:35:49', NULL, NULL, NULL),
(41, 1, 1, 1, 1, 2, 13.3333, 1, 1, 1, '2024-09-09 09:35:52', NULL, NULL, NULL),
(42, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:35:57', NULL, NULL, NULL),
(43, 1, 1, 1, 1, 2, 20, 1, 1, 1, '2024-09-09 09:36:01', NULL, NULL, NULL),
(44, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:36:09', NULL, NULL, NULL),
(45, 1, 1, 1, 1, 2, 60, 1, 1, 1, '2024-09-09 09:36:19', NULL, NULL, NULL),
(46, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:37:58', NULL, NULL, NULL),
(47, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:37:59', NULL, NULL, NULL),
(48, 1, 1, 1, 1, 2, 6.66667, 1, 1, 1, '2024-09-09 09:38:01', NULL, NULL, NULL),
(49, 1, 1, 1, 1, 2, 6.66667, 1, 1, 1, '2024-09-09 09:38:10', NULL, NULL, NULL),
(50, 1, 1, 1, 1, 2, 20, 1, 1, 1, '2024-09-09 09:38:13', NULL, NULL, NULL),
(51, 1, 1, 1, 1, 2, 93.3333, 1, 1, 1, '2024-09-09 09:38:26', NULL, NULL, NULL),
(52, 1, 1, 1, 1, 2, 93.3333, 1, 1, 1, '2024-09-09 09:38:26', NULL, NULL, NULL),
(53, 1, 1, 1, 1, 2, 100, 1, 1, 1, '2024-09-09 09:38:26', NULL, NULL, NULL),
(54, 1, 1, 1, 1, 2, 100, 1, 1, 1, '2024-09-09 09:38:26', NULL, NULL, NULL),
(55, 1, 1, 1, 1, 2, 100, 1, 1, 1, '2024-09-09 09:38:26', NULL, NULL, NULL),
(56, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:38:38', NULL, NULL, NULL),
(57, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:38:38', NULL, NULL, NULL),
(58, 1, 1, 1, 1, 2, 60, 1, 1, 1, '2024-09-09 09:38:49', NULL, NULL, NULL),
(59, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:38:50', NULL, NULL, NULL),
(60, 1, 1, 1, 1, 2, 0, 1, 1, 1, '2024-09-09 09:38:51', NULL, NULL, NULL),
(61, 1, 1, 1, 1, 2, 13.3333, 1, 1, 1, '2024-09-09 09:38:54', NULL, NULL, NULL);

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

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`subject_id`, `course_id`, `subject_name`, `subject_desc`, `note_name`, `note_url`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 1, 'Current Affairs', 'Topics related to current events and news.', 'Current Affairs Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik_test/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:02:00', NULL),
(2, 1, 'World Geography', 'Geographical knowledge of various countries.', 'World Geography Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(3, 1, 'Economics', 'Basic economic concepts and theories.', 'Economics Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(4, 1, 'History', 'Historical events and significant figures.', 'History Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(5, 1, 'Science', 'Fundamental scientific principles and discoveries.', 'Science Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(6, 2, 'Grammar', 'English grammar rules and exercises.', 'Grammar Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(7, 2, 'Vocabulary', 'Building and expanding English vocabulary.', 'Vocabulary Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(8, 2, 'Reading Comprehension', 'Improving reading and understanding skills.', 'Reading Comprehension Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(9, 2, 'Writing Skills', 'Techniques and exercises for better writing.', 'Writing Skills Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(10, 2, 'Literature', 'Study of various literary works and genres.', 'Literature Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(11, 3, 'Algebra', 'Concepts and problems related to algebra.', 'Algebra Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(12, 3, 'Calculus', 'Introduction to differential and integral calculus.', 'Calculus Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(13, 3, 'Geometry', 'Study of shapes, sizes, and properties of space.', 'Geometry Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(14, 3, 'Statistics', 'Basics of data analysis and probability.', 'Statistics Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(15, 3, 'Trigonometry', 'Concepts and problems related to trigonometric functions.', 'Trigonometry Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(16, 4, 'Ancient Civilizations', 'Study of early human societies and their cultures.', 'Ancient Civilizations Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(17, 4, 'Medieval History', 'Historical events from the medieval period.', 'Medieval History Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(18, 4, 'Modern History', 'Significant events from the modern era.', 'Modern History Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(19, 4, 'Historical Figures', 'Detailed study of important historical figures.', 'Historical Figures Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723032377958.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(20, 4, 'World Wars', 'In-depth look at the events and consequences of the World Wars.', 'World Wars Notes', 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/pdf/1723528427419.pdf', 0, 1, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL);

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

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`video_id`, `subject_id`, `video_path`, `video_name`, `video_extension`, `video_desc`, `is_delete`, `is_active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `ip_address`) VALUES
(1, 101, '/videos/video1.mp4', 'Introduction to Math', '.mp4', 'This is a math introduction video.', 0, 1, 123, '2024-08-13 10:00:00', 123, '2024-08-13 10:05:00', '192.168.1.1'),
(2, 1, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Current Affairs Update', 'mp4', 'Recent updates on current affairs.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(3, 2, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Geography Basics', 'mp4', 'Introduction to world geography.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(4, 2, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Geography Advanced', 'mp4', 'Detailed look at geographical features.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(5, 3, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Economics 101', 'mp4', 'Basic concepts in economics.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(6, 3, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Economics', 'mp4', 'Advanced topics in economics.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(7, 4, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'History Overview', 'mp4', 'Overview of historical events.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(8, 4, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Detailed History', 'mp4', 'In-depth look at significant historical events.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(9, 5, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Basic Science', 'mp4', 'Introduction to fundamental scientific concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(10, 5, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Science', 'mp4', 'Exploring advanced scientific principles.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(11, 6, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Grammar Basics', 'mp4', 'Introduction to English grammar.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(12, 6, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Grammar Advanced', 'mp4', 'Advanced grammar rules and exercises.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(13, 7, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Vocabulary Building', 'mp4', 'Techniques for expanding vocabulary.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(14, 7, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Vocabulary Practice', 'mp4', 'Exercises to practice vocabulary.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(15, 8, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Reading Skills', 'mp4', 'Improving reading and comprehension skills.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(16, 8, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Reading', 'mp4', 'Advanced techniques for reading comprehension.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(17, 9, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Writing Basics', 'mp4', 'Introduction to writing skills.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(18, 9, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Writing', 'mp4', 'Advanced writing techniques and exercises.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(19, 10, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Literary Analysis', 'mp4', 'Analyzing various literary works.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(20, 10, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Literature', 'mp4', 'Advanced study of literary genres.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(21, 11, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Algebra Basics', 'mp4', 'Introduction to algebraic concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(22, 11, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Algebra', 'mp4', 'Advanced algebraic techniques and exercises.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(23, 12, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Calculus Introduction', 'mp4', 'Basics of calculus.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(24, 12, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Calculus', 'mp4', 'Advanced topics in calculus.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(25, 13, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Geometry Basics', 'mp4', 'Introduction to geometric concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(26, 13, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Geometry', 'mp4', 'Advanced geometric principles.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(27, 14, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Statistics Introduction', 'mp4', 'Basics of statistics.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(28, 14, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Statistics', 'mp4', 'Advanced topics in statistics.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(29, 15, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Trigonometry Basics', 'mp4', 'Introduction to trigonometric functions.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(30, 15, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Trigonometry', 'mp4', 'Advanced trigonometric concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(31, 16, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Ancient Civilizations', 'mp4', 'Introduction to ancient civilizations.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(32, 16, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Classical History', 'mp4', 'Overview of classical history.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(33, 17, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Medieval Europe', 'mp4', 'History of medieval Europe.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(34, 17, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Medieval Asia', 'mp4', 'History of medieval Asia.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(35, 18, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'World Wars', 'mp4', 'Overview of the World Wars.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(36, 18, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Cold War', 'mp4', 'Insights into the Cold War era.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(37, 19, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Current Trends', 'mp4', 'Trends in contemporary history.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(38, 19, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Recent Developments', 'mp4', 'Recent developments in contemporary history.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(39, 20, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Ancient India', 'mp4', 'Introduction to ancient Indian history.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(40, 20, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Modern India', 'mp4', 'Modern Indian history overview.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(41, 21, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'World Geography', 'mp4', 'Introduction to world geography.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(42, 21, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Geographic Concepts', 'mp4', 'Concepts in geography.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(43, 22, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Psychology Basics', 'mp4', 'Introduction to psychology.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(44, 22, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Psychology', 'mp4', 'Advanced topics in psychology.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(45, 23, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Biology Introduction', 'mp4', 'Introduction to biology.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(46, 23, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Biology', 'mp4', 'Advanced biological concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(47, 24, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1722928435109.mp4', 'Chemistry Basics', 'mp4', 'Introduction to chemistry.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL),
(48, 24, 'https://svcloud123.blr1.digitaloceanspaces.com/vedik/mp4/1723032377894.mp4', 'Advanced Chemistry', 'mp4', 'Advanced chemistry concepts.', NULL, NULL, NULL, '2024-08-13 10:00:00', NULL, '2024-08-13 10:05:00', NULL);

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
  MODIFY `course_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `f_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hbt`
--
ALTER TABLE `hbt`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `note`
--
ALTER TABLE `note`
  MODIFY `note_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `quiz_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT for table `quiz_result`
--
ALTER TABLE `quiz_result`
  MODIFY `result_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `quiz_result_detail`
--
ALTER TABLE `quiz_result_detail`
  MODIFY `detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1147;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `student_attendance`
--
ALTER TABLE `student_attendance`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_log`
--
ALTER TABLE `student_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `student_progress`
--
ALTER TABLE `student_progress`
  MODIFY `progress_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
