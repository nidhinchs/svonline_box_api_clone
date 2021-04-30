
CREATE TABLE `categories` (
  `category_id` int(10) NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(10, 'Internet Of Thing'),
(44, 'Machine Learning'),
(46, 'Cloud'),
(50, 'Big data'),
(51, 'Networking');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `project_id` int(10) NOT NULL,
  `project_name` varchar(50) NOT NULL,
  `project_cat` varchar(50) NOT NULL,
  `project_startdate` date NOT NULL,
  `project_enddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`project_id`, `project_name`, `project_cat`, `project_startdate`, `project_enddate`) VALUES
(8, 'Smart City', 'IOT', '2020-07-25', '2020-08-01'),
(9, 'Smart Village', 'IOT', '2020-07-24', '2020-07-30'),
(10, 'Face Recognization', 'Machine Learning', '2020-07-31', '2020-08-08'),
(11, 'Face Recognization', 'Machine Learning', '2020-07-31', '2020-08-08'),
(12, 'Pattern Finding', 'Machine Learning', '2020-07-24', '2020-08-01'),
(13, 'Smart Car', 'Internet Of Things', '2020-08-01', '2020-08-07'),
(16, 'Pattern recognization', 'Big data', '2020-07-25', '2020-07-30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`project_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `project_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
