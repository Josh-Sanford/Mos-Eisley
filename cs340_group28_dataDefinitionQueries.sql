-- phpMyAdmin SQL Dump
-- version 5.1.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 17, 2021 at 01:43 AM
-- Server version: 10.4.21-MariaDB-log
-- PHP Version: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_handelae`
--

-- --------------------------------------------------------

--
-- Table structure for table `Affiliations`
--
DROP TABLE IF EXISTS `Affiliations`;
CREATE TABLE `Affiliations` (
  `id` int(11) NOT NULL,
  `galactic_id` int(11) NOT NULL,
  `affiliation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Affiliations`
--

INSERT INTO `Affiliations` (`id`, `galactic_id`, `affiliation`) VALUES
(5, 10, 'rebel'),
(6, 10, 'smuggler'),
(7, 9, 'rebel'),
(8, 9, 'smuggler'),
(9, 5, 'bounty hunter'),
(10, 8, 'jabba'),
(11, 8, 'empire'),
(12, 7, 'jabba');

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--
DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `galactic_id` int(11) NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `species` varchar(255) DEFAULT NULL,
  `planet` varchar(255) DEFAULT NULL,
  `bounty` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`galactic_id`, `customer_name`, `species`, `planet`, `bounty`) VALUES
(5, 'Greedo', 'Rodia', 'Tatooine', 0),
(7, 'Ponda Baba', 'Aqualish', 'Ando', 0),
(8, 'Cornelius Evazan', 'human', 'Alsakan', 1),
(9, 'Han Solo', 'Human', 'Corellia', 1),
(10, 'Chewbacca', 'Wookiee', 'Kashyyyk', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Customer_Orders`
--
DROP TABLE IF EXISTS `Customer_Orders`;
CREATE TABLE `Customer_Orders` (
  `galactic_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Customer_Orders`
--

INSERT INTO `Customer_Orders` (`galactic_id`, `order_id`) VALUES
(5, 4),
(7, 3),
(8, 3),
(9, 1),
(9, 2),
(10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Drinks`
--
DROP TABLE IF EXISTS `Drinks`;
CREATE TABLE `Drinks` (
  `drink_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `size` int(5) NOT NULL,
  `credits` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Drinks`
--

INSERT INTO `Drinks` (`drink_id`, `name`, `size`, `credits`) VALUES
(1, 'Spotchka', 16, 10),
(2, 'Ruby bliel', 8, 12),
(3, 'Blackroot', 12, 9),
(4, 'Blue milk', 16, 13);

-- --------------------------------------------------------

--
-- Table structure for table `Drink_Orders`
--
DROP TABLE IF EXISTS `Drink_Orders`;
CREATE TABLE `Drink_Orders` (
  `drink_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Drink_Orders`
--

INSERT INTO `Drink_Orders` (`drink_id`, `order_id`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 1),
(3, 3),
(3, 4),
(4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--
DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL,
  `balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`order_id`, `balance`) VALUES
(1, 19),
(2, 22),
(3, 35),
(4, 9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Affiliations`
--
ALTER TABLE `Affiliations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galactic_id` (`galactic_id`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`galactic_id`);

--
-- Indexes for table `Customer_Orders`
--
ALTER TABLE `Customer_Orders`
  ADD PRIMARY KEY (`galactic_id`,`order_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `Drinks`
--
ALTER TABLE `Drinks`
  ADD PRIMARY KEY (`drink_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `Drink_Orders`
--
ALTER TABLE `Drink_Orders`
  ADD PRIMARY KEY (`drink_id`,`order_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Affiliations`
--
ALTER TABLE `Affiliations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `galactic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Drinks`
--
ALTER TABLE `Drinks`
  MODIFY `drink_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Affiliations`
--
ALTER TABLE `Affiliations`
  ADD CONSTRAINT `Affiliations_ibfk_1` FOREIGN KEY (`galactic_id`) REFERENCES `Customers` (`galactic_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Customer_Orders`
--
ALTER TABLE `Customer_Orders`
  ADD CONSTRAINT `Customer_Orders_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Customer_Orders_ibfk_2` FOREIGN KEY (`galactic_id`) REFERENCES `Customers` (`galactic_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Drink_Orders`
--
ALTER TABLE `Drink_Orders`
  ADD CONSTRAINT `Drink_Orders_ibfk_1` FOREIGN KEY (`drink_id`) REFERENCES `Drinks` (`drink_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Drink_Orders_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
