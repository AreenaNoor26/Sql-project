-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 13, 2026 at 03:06 PM
-- Server version: 11.4.9-MariaDB-cll-lve-log
-- PHP Version: 8.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `property_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `tenant_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `property_id`, `tenant_id`, `amount`, `status`, `payment_date`) VALUES
(1, 1, 5, 150000.00, 'success', '2026-01-10 21:54:59'),
(2, 2, 6, 45000.00, 'pending', '2026-01-10 21:54:59'),
(3, 3, 7, 85000.00, 'success', '2026-01-10 21:54:59'),
(4, 4, 8, 250000.00, 'pending', '2026-01-10 21:54:59');

--
-- Triggers `payments`
--
DELIMITER $$
CREATE TRIGGER `trg_after_payment_success` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN
    IF NEW.status = 'success' THEN
        UPDATE properties 
        SET status = 'rented' 
        WHERE property_id = NEW.property_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `prop`
-- (See below for the actual view)
--
CREATE TABLE `prop` (
`property_id` int(11)
,`landlord_id` int(11)
,`property_name` varchar(100)
,`description` text
,`price` decimal(10,2)
,`address` text
,`city` varchar(50)
,`type` varchar(20)
,`status` varchar(15)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL,
  `landlord_id` int(11) DEFAULT NULL,
  `property_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `status` varchar(15) DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`property_id`, `landlord_id`, `property_name`, `description`, `price`, `address`, `city`, `type`, `status`, `created_at`) VALUES
(1, 1, 'Iqra Luxury Flats', NULL, 55000.00, NULL, 'Islamabad', 'apartment', 'available', '2026-01-10 21:50:24'),
(2, 2, 'Gulberg Luxury Villa', 'Fully furnished 5-bedroom villa with garden.', 150000.00, 'Plot 45-B, Gulberg III', 'Lahore', 'house', 'available', '2026-01-10 21:54:32'),
(3, 2, 'E-11 Executive Studio', 'Modern studio near Markaz.', 45000.00, 'Flat 204, Silver Oaks', 'Islamabad', 'apartment', 'available', '2026-01-10 21:54:32'),
(4, 3, 'Clifton Seaview Apartment', '3-bedroom flat with ocean view.', 85000.00, 'Tower C, Marine Drive', 'Karachi', 'apartment', 'available', '2026-01-10 21:54:32'),
(5, 3, 'DHA Phase 6 Bungalow', 'Brand new corner house.', 250000.00, 'Street 12, Phase 6', 'Karachi', 'house', 'available', '2026-01-10 21:54:32'),
(6, 4, 'Bahria Town Shop', 'Commercial space for retail.', 35000.00, 'G-15, Civic Center', 'Rawalpindi', 'shop', 'available', '2026-01-10 21:54:32'),
(7, 4, 'I-8 Family House', 'Well maintained double story house.', 95000.00, 'House 22, St 5', 'Islamabad', 'house', 'available', '2026-01-10 21:54:32');

-- --------------------------------------------------------

--
-- Table structure for table `property_images`
--

CREATE TABLE `property_images` (
  `image_id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `property_images`
--

INSERT INTO `property_images` (`image_id`, `property_id`, `image_url`) VALUES
(1, 1, 'https://images.com/villa_front.jpg'),
(2, 1, 'https://images.com/villa_garden.jpg'),
(3, 2, 'https://images.com/studio_room.jpg'),
(4, 3, 'https://images.com/seaview_flat.jpg'),
(5, 4, 'https://images.com/bungalow_main.jpg'),
(6, 6, 'https://images.com/i8_house.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(10) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_role_id`, `username`, `email`, `phone_no`, `password`, `status`, `created_at`) VALUES
(1, 2, 'areena_noor', 'areena@iqra.edu.pk', NULL, '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:50:03'),
(2, 1, 'admin_user', 'admin@rental.com', '0300-1112223', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(3, 2, 'hasnain_hassan', 'hasnain@example.com', '0312-4445556', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(4, 2, 'areena_noor', 'areena@example.com', '0321-7778889', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(5, 2, 'kashif_ali', 'kashif@pk_rent.com', '0333-9990001', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(6, 3, 'bilal_khan', 'bilal.tenant@gmail.com', '0345-1234567', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(7, 3, 'sarah_ahmed', 'sarah.rent@yahoo.com', '0301-7654321', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(8, 3, 'usman_ghani', 'usman.g@outlook.com', '0315-5554443', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27'),
(9, 3, 'dua_fatima', 'dua.f@gmail.com', '0322-1110009', '1c72b03dea5f88404c3472c79bba1547', 'active', '2026-01-10 21:52:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`role_id`, `role_name`) VALUES
(1, 'admin'),
(2, 'landlord'),
(3, 'tenant');

-- --------------------------------------------------------

--
-- Stand-in structure for view `usr`
-- (See below for the actual view)
--
CREATE TABLE `usr` (
`user_id` int(11)
,`user_role_id` int(11)
,`username` varchar(50)
,`email` varchar(100)
,`phone_no` varchar(15)
,`password` varchar(255)
,`status` varchar(10)
,`created_at` timestamp
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `tenant_id` (`tenant_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`property_id`),
  ADD KEY `landlord_id` (`landlord_id`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `property_id` (`property_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_role_id` (`user_role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --------------------------------------------------------

--
-- Structure for view `prop`
--
DROP TABLE IF EXISTS `prop`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prop`  AS SELECT `properties`.`property_id` AS `property_id`, `properties`.`landlord_id` AS `landlord_id`, `properties`.`property_name` AS `property_name`, `properties`.`description` AS `description`, `properties`.`price` AS `price`, `properties`.`address` AS `address`, `properties`.`city` AS `city`, `properties`.`type` AS `type`, `properties`.`status` AS `status`, `properties`.`created_at` AS `created_at` FROM `properties` ;

-- --------------------------------------------------------

--
-- Structure for view `usr`
--
DROP TABLE IF EXISTS `usr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usr`  AS SELECT `users`.`user_id` AS `user_id`, `users`.`user_role_id` AS `user_role_id`, `users`.`username` AS `username`, `users`.`email` AS `email`, `users`.`phone_no` AS `phone_no`, `users`.`password` AS `password`, `users`.`status` AS `status`, `users`.`created_at` AS `created_at` FROM `users` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
