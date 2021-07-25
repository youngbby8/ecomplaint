-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 25, 2021 at 06:28 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_complaint`
--

-- --------------------------------------------------------

--
-- Table structure for table `e_callcenter`
--

CREATE TABLE `e_callcenter` (
  `center_id` int(11) NOT NULL,
  `center_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `e_category`
--

CREATE TABLE `e_category` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `e_category`
--

INSERT INTO `e_category` (`id`, `cat_name`) VALUES
(1, 'meter'),
(2, 'service-line');

-- --------------------------------------------------------

--
-- Table structure for table `e_complaint`
--

CREATE TABLE `e_complaint` (
  `comp_id` int(11) NOT NULL,
  `customer` varchar(45) NOT NULL,
  `comp_address` varchar(45) NOT NULL,
  `institution` varchar(45) NOT NULL,
  `category` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(45) NOT NULL,
  `technician` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `e_complaint`
--

INSERT INTO `e_complaint` (`comp_id`, `customer`, `comp_address`, `institution`, `category`, `description`, `date`, `status`, `technician`) VALUES
(1, 'me massoud', 'fuoni, 765 ', 'TANESCO', 'service-line', 'hello world, this is just a very dumb entry so don\'t worry about it , relax! ok?', '2021-07-25 04:07:45', 'solved', 'yosia obeid fabian'),
(2, 'me massoud', 'kwerekwe, zanzibar', 'ZAWA', 'meter', 'making tangy hayafanyi laziness start kidogo', '2021-07-25 04:20:51', 'solved', 'yosia obeid fabian'),
(3, 'me massoud', 'polite zanzibar', 'ZECO', 'service-line', 'kudhfwa;lgmPfdvL/hw\'r8ghawprkgsPIgj\'SPfidgnw;rgqwr', '2021-07-25 06:15:56', 'solved', 'yosia obeid fabian');

-- --------------------------------------------------------

--
-- Table structure for table `e_customer`
--

CREATE TABLE `e_customer` (
  `cust_id` int(11) NOT NULL,
  `cust_name` varchar(45) NOT NULL,
  `phone_no` varchar(45) NOT NULL,
  `cust_address` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `e_institution`
--

CREATE TABLE `e_institution` (
  `id` int(11) NOT NULL,
  `instname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `e_institution`
--

INSERT INTO `e_institution` (`id`, `instname`) VALUES
(1, 'ZECO'),
(2, 'TANESCO'),
(3, 'ZAWA');

-- --------------------------------------------------------

--
-- Table structure for table `e_login`
--

CREATE TABLE `e_login` (
  `id` int(11) NOT NULL,
  `full_name` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL,
  `phone_no` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `role` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `e_login`
--

INSERT INTO `e_login` (`id`, `full_name`, `address`, `phone_no`, `email`, `password`, `role`) VALUES
(1, 'admin', 'kwerekwe,zanzibar', '0779663381', 'admin', 'admin', 'admin'),
(2, 'abdul makers hajji', 'kwamchina, zanzibar', '0778556647', 'majid', 'password', 'call-center'),
(3, 'Moza Muhammed said', 'Meera, zanzibar', '0779445566', 'moza', 'password', 'technician'),
(4, 'yosia obeid fabian', 'kwahani, zanzibar', '0776334455', 'yof', 'password', 'technician'),
(5, 'me massoud', 'fuoni', '0772436578', 'massoud', 'password', 'customer');

-- --------------------------------------------------------

--
-- Table structure for table `e_techcomplaint`
--

CREATE TABLE `e_techcomplaint` (
  `tech_compl_id` int(11) NOT NULL,
  `comp_id` int(11) NOT NULL,
  `tech_id` int(11) NOT NULL,
  `center_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `e_technician`
--

CREATE TABLE `e_technician` (
  `tech_id` int(11) NOT NULL,
  `tech_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `e_callcenter`
--
ALTER TABLE `e_callcenter`
  ADD PRIMARY KEY (`center_id`);

--
-- Indexes for table `e_category`
--
ALTER TABLE `e_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `e_complaint`
--
ALTER TABLE `e_complaint`
  ADD PRIMARY KEY (`comp_id`),
  ADD KEY `cat_id_idx` (`category`);

--
-- Indexes for table `e_customer`
--
ALTER TABLE `e_customer`
  ADD PRIMARY KEY (`cust_id`),
  ADD UNIQUE KEY `e_phoneno_UNIQUE` (`phone_no`);

--
-- Indexes for table `e_institution`
--
ALTER TABLE `e_institution`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `e_login`
--
ALTER TABLE `e_login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `e_techcomplaint`
--
ALTER TABLE `e_techcomplaint`
  ADD PRIMARY KEY (`tech_compl_id`),
  ADD KEY `comp_id_idx` (`comp_id`),
  ADD KEY `tech_id_idx` (`tech_id`),
  ADD KEY `center_id_idx` (`center_id`);

--
-- Indexes for table `e_technician`
--
ALTER TABLE `e_technician`
  ADD PRIMARY KEY (`tech_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `e_callcenter`
--
ALTER TABLE `e_callcenter`
  MODIFY `center_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `e_category`
--
ALTER TABLE `e_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `e_complaint`
--
ALTER TABLE `e_complaint`
  MODIFY `comp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `e_customer`
--
ALTER TABLE `e_customer`
  MODIFY `cust_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `e_institution`
--
ALTER TABLE `e_institution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `e_login`
--
ALTER TABLE `e_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `e_techcomplaint`
--
ALTER TABLE `e_techcomplaint`
  MODIFY `tech_compl_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `e_technician`
--
ALTER TABLE `e_technician`
  MODIFY `tech_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `e_techcomplaint`
--
ALTER TABLE `e_techcomplaint`
  ADD CONSTRAINT `center_id` FOREIGN KEY (`center_id`) REFERENCES `e_callcenter` (`center_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tech_id` FOREIGN KEY (`tech_id`) REFERENCES `e_technician` (`tech_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
