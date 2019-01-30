-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 30, 2019 at 04:03 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `productName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `groupName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sellingPrice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `averageBuyingPrice` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `barCode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `productImage` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `openingQuantity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `openingUnitPrice` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `admin_id`, `productName`, `groupName`, `catName`, `brand`, `unit`, `size`, `color`, `model`, `sellingPrice`, `averageBuyingPrice`, `barCode`, `productImage`, `date`, `openingQuantity`, `openingUnitPrice`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Addidas', 'PCS', 'M', 'Black', 'LBCB1', '1500', '129.83', '1', NULL, '0000-00-00', '0', '0', '2018-11-05 10:09:05', '2019-01-30 08:10:18'),
(2, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Momo', 'PCS', 'L', 'Wine Red', 'LBPR', '1500', '593.5483870967741', '1000000002', NULL, '0000-00-00', '0', '0', '2018-11-05 10:09:48', '2018-11-05 11:03:12'),
(3, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Momo', 'PCS', 'XL', 'Wine Red', 'LBPR', '1500', '580.7692307692307', '1000000003', NULL, '0000-00-00', '0', '0', '2018-11-05 10:10:02', '2018-11-05 10:19:17'),
(4, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '6', 'Red', 'FBSR', '1150', '50', '2', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:13', '2019-01-30 08:10:18'),
(5, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '7', 'Red', 'FBSR', '1150', '0', '1000000005', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:18', '2018-11-05 10:11:18'),
(6, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '8', 'Red', 'FBSR', '1150', '0', '1000000006', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:34', '2018-11-05 10:11:34'),
(7, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '5', 'Black', 'LBS', '1200', '90.91', '3', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:10', '2019-01-30 08:10:18'),
(8, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '6', 'Black', 'LBS', '1200', '500', '1000000008', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:20', '2018-11-05 10:14:20'),
(9, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '7', 'Black', 'LBS', '1200', '500', '1000000009', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:33', '2018-11-05 10:14:33'),
(10, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '8', 'Black', 'LBS', '1200', '500', '1000000010', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:49', '2018-11-05 10:14:49'),
(11, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '6', 'Maroon', 'LBSM', '1200', '0', '1000000011', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:18', '2018-11-05 10:15:18'),
(12, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '7', 'Maroon', 'LBSM', '1200', '0', '1000000012', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:23', '2018-11-05 10:15:23'),
(13, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '8', 'Maroon', 'LBSM', '1200', '0', '1000000013', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:29', '2018-11-05 10:15:29'),
(14, 1, '12set Brush', 'COSMETICS', 'BRUSHES', 'FOCALLUR', 'BOX', NULL, NULL, 'F12', '600', '50', '4', NULL, '0000-00-00', '0', '0', '2018-11-05 11:04:37', '2019-01-30 08:10:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
