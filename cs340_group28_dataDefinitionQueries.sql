-- phpMyAdmin SQL Dump
-- version 5.1.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 11, 2021 at 06:39 PM
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
-- Table structure for table `affiliations`
--

CREATE TABLE `Affiliations` (
  `id` int(11) NOT NULL,
  `galactic_id` int(11) NOT NULL,
  `affiliation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `affiliations`
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
-- Table structure for table `customers`
--

CREATE TABLE `Customers` (
  `galactic_id` int(11) NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `species` varchar(255) DEFAULT NULL,
  `planet` varchar(255) DEFAULT NULL,
  `bounty` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `Customers` (`galactic_id`, `customer_name`, `species`, `planet`, `bounty`) VALUES
(5, 'Greedo', 'Rodia', 'Tatooine', 0),
(7, 'Ponda Baba', 'Aqualish', 'Ando', 0),
(8, 'Cornelius Evazan', 'human', 'Alsakan', 1),
(9, 'Han Solo', 'Human', 'Corellia', 1),
(10, 'Chewbacca', 'Wookiee', 'Kashyyyk', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_order`
--

CREATE TABLE `Customer_Orders` (
  `galactic_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_order`
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
-- Table structure for table `drinks`
--

CREATE TABLE `Drinks` (
  `drink_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `size` int(5) NOT NULL,
  `credits` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drinks`
--

INSERT INTO `Drinks` (`drink_id`, `name`, `size`, `credits`) VALUES
(1, 'Spotchka', 16, 10),
(2, 'Ruby bliel', 8, 12),
(3, 'Blackroot', 12, 9),
(4, 'Blue milk', 16, 13);

-- --------------------------------------------------------

--
-- Table structure for table `drink_order`
--

CREATE TABLE `Drink_Orders` (
  `drink_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drink_order`
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
-- Table structure for table `orders`
--

CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL,
  `balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
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
-- Indexes for table `affiliations`
--
ALTER TABLE `Affiliations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `affiliations_ibfk_1` (`galactic_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`galactic_id`);

--
-- Indexes for table `customer_order`
--
ALTER TABLE `Customer_Orders`
  ADD PRIMARY KEY (`galactic_id`,`order_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `drinks`
--
ALTER TABLE `Drinks`
  ADD PRIMARY KEY (`drink_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `drink_order`
--
ALTER TABLE `Drink_Orders`
  ADD PRIMARY KEY (`drink_id`,`order_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `affiliations`
--
ALTER TABLE `Affiliations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `Customers`
  MODIFY `galactic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `drinks`
--
ALTER TABLE `Drinks`
  MODIFY `drink_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `Orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `affiliations`
--
ALTER TABLE `Affiliations`
  ADD CONSTRAINT `affiliations_ibfk_1` FOREIGN KEY (`galactic_id`) REFERENCES `customers` (`galactic_id`);

--
-- Constraints for table `customer_order`
--
ALTER TABLE `Customer_Orders`
  ADD CONSTRAINT `customer_order_ibfk_1` FOREIGN KEY (`galactic_id`) REFERENCES `customers` (`galactic_id`),
  ADD CONSTRAINT `customer_order_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `drink_order`
--
ALTER TABLE `Drink_Orders`
  ADD CONSTRAINT `drink_order_ibfk_1` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`drink_id`),
  ADD CONSTRAINT `drink_order_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
