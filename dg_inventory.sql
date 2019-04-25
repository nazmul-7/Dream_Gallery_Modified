-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2019 at 02:56 PM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dg_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `bonuses`
--

CREATE TABLE `bonuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `date` date NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bonusBy` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `catName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `catName`, `group_id`, `created_at`, `updated_at`) VALUES
(1, 'Hair Care', 1, '2019-04-15 01:57:31', '2019-04-15 01:57:31'),
(2, 'Skin Care', 1, '2019-04-15 01:57:36', '2019-04-15 01:57:36'),
(3, 'Eye Care', 1, '2019-04-18 07:59:11', '2019-04-18 07:59:11'),
(4, 'Trimmer', 2, '2019-04-19 08:16:14', '2019-04-19 08:16:14'),
(5, 'Facial Sheet Mask', 1, '2019-04-20 00:06:10', '2019-04-20 00:06:10'),
(6, 'Foot Care', 1, '2019-04-20 01:16:08', '2019-04-20 01:16:08'),
(7, 'Eyes', 3, '2019-04-20 06:39:38', '2019-04-20 06:39:38'),
(8, 'Lips', 3, '2019-04-20 06:39:43', '2019-04-20 06:39:43'),
(9, 'Face', 3, '2019-04-20 06:39:54', '2019-04-20 06:39:54'),
(10, 'Remover', 3, '2019-04-21 07:18:44', '2019-04-21 07:18:44'),
(11, 'Others', 3, '2019-04-22 02:06:52', '2019-04-22 02:06:52'),
(12, 'Small Notebooks', 4, '2019-04-22 08:55:43', '2019-04-22 08:55:43'),
(13, 'Large Notebook', 4, '2019-04-22 08:55:59', '2019-04-22 08:55:59'),
(14, 'Slipper', 5, '2019-04-23 22:58:50', '2019-04-23 22:58:50'),
(15, 'Body Care', 1, '2019-04-24 08:34:37', '2019-04-24 08:34:37');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zoneId` int(11) NOT NULL DEFAULT '1',
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `balance` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customerName`, `address`, `contact`, `email`, `zone`, `barcode`, `zoneId`, `opening`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'CASH', NULL, '016', NULL, '', NULL, 1, '0', '0', '2019-04-15 07:55:08', '2019-04-15 07:55:08'),
(2, 'Shahreen Samanta', 'Chowhatta, Sylhet', '01679314890', NULL, 'Sylhet', '005', 1, '0', '0', '2019-04-18 11:39:49', '2019-04-18 05:44:50'),
(3, 'Aksa Billah', '47 Neptune Heights, Siddeshwari Road, Ramna Thana, Dhaka', '01768969242', NULL, 'Dhaka', '0015', 2, '0', '0', '2019-04-18 11:41:25', '2019-04-24 00:32:54'),
(4, 'Safina Mollah', '1/11 Setara Tower, Mirpur Pallabi, Dhaka', '01996361709', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-20 08:09:00', '2019-04-20 08:09:00'),
(5, 'Arifa', '88, Distalari Road, Gandaria, Doyagonj, Beside (Kodom/Gaibi) Mosque, Dhaka', '01749652878', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-20 08:23:03', '2019-04-20 08:23:03'),
(6, 'Nowshin Nawar', '203 Chondrika Air Force Officers Quaters, Dhaka Cantonment, Dhaka', '01616061118', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-22 06:15:43', '2019-04-22 06:15:43'),
(7, 'Tazkiya Mollik Ananya', 'Esatern Pathachaya, Flat No - 401, Building No - 3, Opposite of BRB Gastrology Hospital, West Panthapath, Dhaka', '01741222962', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-22 06:31:41', '2019-04-25 05:54:46'),
(8, 'Faiza Hossain', 'U/55, Nurjahan Road, Mohammedpur, Dhaka', '01636788204', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-23 06:53:04', '2019-04-23 06:53:04'),
(9, 'Sayma', '427 Shaheen Bag, Tegaon, Dhaka', '01911303391', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-23 06:59:09', '2019-04-23 06:59:09'),
(10, 'Esrat Jahan', '6/1, Nowabpur Road, Dhaka', '01858763835', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-23 07:05:54', '2019-04-23 07:05:54'),
(11, 'Kazi Sami', 'D-2 Kuddus Villa, Sunargaon R/A, Cinema Hall, Botessewar, Sylhet', '01716355694', NULL, 'Sylhet', NULL, 1, '0', '0', '2019-04-23 07:08:42', '2019-04-23 07:08:42'),
(12, 'Miftahul Zannat', 'Hoilsun School Road, Dattapara, College Road, Tongi', '01909972812', NULL, 'Tongi', NULL, 4, '0', '0', '2019-04-23 07:13:49', '2019-04-23 07:13:49'),
(13, 'Samiha Rahman', '13/A, 3A Babbar Road, Mohammedpur, Beside Islami Bank Training Center, Dhaka', '01796776692', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-23 07:37:58', '2019-04-23 07:37:58'),
(14, 'Nujhat Nower', 'North South University, Dhaka', '01729900743', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 06:50:17', '2019-04-24 06:50:17'),
(15, 'Marina', '247/1 Ibrahimpur Monipur School Branch 2 Samne Basha, Dhaka', '01936165893', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 07:41:25', '2019-04-24 07:41:25'),
(16, 'Mahaz Karim', 'Pallabi Extension, Mirpur 11.5, Block- F, House - 16, My Pride, flat- A3 , 3rd Floor, Dhaka', '01711704297', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 07:57:01', '2019-04-24 07:57:01'),
(17, 'Ratna Chowdhury', 'House No - 91, Road No - 14, Block - G, Bashundhara, Dhaka', '01913044296', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 08:17:42', '2019-04-24 08:17:42'),
(18, 'Faria Rahman', 'Jigatola Tali Office Road, Apartment Name - Parijat Bonolota, House No - 7 , Dhaka', '01670247160', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 08:36:10', '2019-04-24 08:36:10'),
(19, 'Suraiya Kobir', 'House No - 300/301, Akkash Dream, Senpara Porbota, Alhela Hospital er Pichone, Mirpur 10, Dhaka', '01632250786', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 08:41:41', '2019-04-24 08:41:41'),
(20, 'Lazina Islam', 'K46, Joar Shahara Bazar Lichu Bagan, Opposite gate of Baridhara DOHS, Dhaka', '01757039204', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 08:44:50', '2019-04-24 08:44:50'),
(21, 'Nahida Alam Mim', 'House No - 7, Road No - 9/A, Sector - 7, Uttara, Dhaka', '01753253876', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-24 08:53:43', '2019-04-24 08:53:43'),
(22, 'Muntaha', '42/2 Al Modina Toer, 4th Floor, Nabab Salimullah Road, Chashara, Narayanganj', '01817501534', NULL, 'Narayanganj', NULL, 5, '0', '0', '2019-04-24 09:31:37', '2019-04-24 09:31:37'),
(23, 'Runa Islam', 'Building No - 10/1, Rahima Manjil, 2nd Floor (C-2), Tenarimor, Zigatola, Dhaka', '01792512982', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 06:23:36', '2019-04-25 06:23:36'),
(24, 'Farhana Rahman', '170 East Rayer Bazar, West Dhanmondi, Dhaka', '01788594364', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 06:46:04', '2019-04-25 06:46:04'),
(25, 'Lamiya Zannat', 'House No - 27, Road No - 18, Sector - 11, Uttara, Dhaka', '01778114499', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 08:03:16', '2019-04-25 08:03:16'),
(26, 'Samira', 'Chairman Bari, South Patenga, Chittagong', '01730598572', NULL, 'Chittagong', NULL, 7, '0', '0', '2019-04-25 08:15:00', '2019-04-25 05:54:18'),
(27, 'Priety Kabir', '53, West Rajbazar, Tejgaon, Dhaka', '01689924673', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 08:23:17', '2019-04-25 08:23:17'),
(28, 'Summia', '468, South Manda, Dhaka', '01935582528', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 08:32:10', '2019-04-25 08:32:10'),
(29, 'Farhana Islam', 'Apt - Park View, House 16, Dhanmondi 9A, Dhaka', '01822988932', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 09:50:49', '2019-04-25 09:50:49'),
(37, 'Maiesha', 'S/1, Noorjahan Road, Mohammedpur, Dhaka', '01628030677', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 11:28:15', '2019-04-25 11:28:15'),
(38, 'Tamanna Wahid', '3rd Floor, Uday Tower, Gulshan 01, Dhaka', '01670383580', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 11:30:45', '2019-04-25 11:30:45'),
(39, 'Nishat', 'House No- 319, Road No- 03, Block- F, Bashundhara R/A, Dhaka', '01811999571', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 11:35:17', '2019-04-25 11:35:17'),
(40, 'Nehla Jannat', 'House No - 17, Road No - 96, Apt - E2, Prashad Baivab, Gulshan 2, Dhaka', '01781184528', NULL, 'Dhaka', NULL, 2, '0', '0', '2019-04-25 11:48:31', '2019-04-25 11:48:31');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` int(10) UNSIGNED NOT NULL,
  `imageUrl` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `groupName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `groupName`, `discount`, `created_at`, `updated_at`) VALUES
(1, 'Cosmetics', 0, '2019-04-15 01:56:54', '2019-04-15 01:56:54'),
(2, 'Electronics', 0, '2019-04-19 08:14:47', '2019-04-19 08:14:47'),
(3, 'Makeup', 0, '2019-04-20 06:39:28', '2019-04-20 06:39:28'),
(4, 'Notebooks', 0, '2019-04-22 08:55:27', '2019-04-22 08:55:27'),
(5, 'Shoe', 0, '2019-04-23 22:58:31', '2019-04-23 22:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'purchase',
  `totalQuantity` int(11) NOT NULL,
  `totalPrice` double(8,2) NOT NULL,
  `discount` int(11) NOT NULL DEFAULT '0',
  `sellingPrice` double(8,2) NOT NULL DEFAULT '0.00',
  `paidAmount` double(8,2) NOT NULL DEFAULT '0.00',
  `customer_id` int(11) DEFAULT '0',
  `supplier_id` int(11) DEFAULT '0',
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `admin_id`, `type`, `totalQuantity`, `totalPrice`, `discount`, `sellingPrice`, `paidAmount`, `customer_id`, `supplier_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, 'purchase', 6, 1260.00, 0, 0.00, 0.00, 0, 1, '2019-04-15', '2019-04-15 03:46:53', '2019-04-15 03:46:53'),
(2, 1, 'sell', 1, 400.00, 0, 400.00, 400.00, 1, 0, '2019-04-16', '2019-04-16 04:07:18', '2019-04-16 04:07:18'),
(3, 1, 'sell', 2, 500.00, 40, 300.00, 300.00, 1, 0, '2019-04-20', '2019-04-20 01:45:38', '2019-04-20 01:45:38'),
(4, 1, 'sell', 1, 300.00, 0, 300.00, 300.00, 1, 0, '2019-04-20', '2019-04-20 01:49:25', '2019-04-20 01:49:25'),
(5, 1, 'sell', 1, 250.00, 0, 250.00, 0.00, 4, 0, '2019-04-20', '2019-04-20 02:09:39', '2019-04-20 02:09:39'),
(8, 1, 'sell', 20, 1080.00, 3, 1050.00, 0.00, 5, 0, '2019-04-20', '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(9, 1, 'sell', 1, 180.00, 0, 180.00, 180.00, 1, 0, '2019-04-20', '2019-04-20 03:09:43', '2019-04-20 03:09:43'),
(10, 1, 'sell', 1, 40.00, 0, 40.00, 40.00, 1, 0, '2019-04-20', '2019-04-20 06:06:57', '2019-04-20 06:06:57'),
(11, 1, 'sell', 3, 125.00, 0, 125.00, 125.00, 1, 0, '2019-04-20', '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(12, 1, 'sell', 1, 280.00, 0, 280.00, 280.00, 1, 0, '2019-04-21', '2019-04-21 00:37:47', '2019-04-21 00:37:47'),
(13, 1, 'sell', 1, 280.00, 0, 280.00, 280.00, 1, 0, '2019-04-21', '2019-04-21 02:16:24', '2019-04-21 02:16:24'),
(14, 1, 'sell', 2, 200.00, 0, 200.00, 200.00, 1, 0, '2019-04-21', '2019-04-21 02:17:31', '2019-04-21 02:17:31'),
(15, 1, 'purchase', 13, 1235.00, 0, 0.00, 0.00, 0, 1, '2019-04-21', '2019-04-21 05:20:37', '2019-04-21 05:20:37'),
(16, 1, 'sell', 2, 660.00, 9, 600.00, 600.00, 1, 0, '2019-04-21', '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(17, 1, 'sell', 8, 1200.00, 4, 1150.00, 1150.00, 6, 0, '2019-04-22', '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(18, 1, 'sell', 3, 450.00, 0, 450.00, 450.00, 7, 0, '2019-04-22', '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(19, 1, 'sell', 2, 780.00, 10, 700.00, 700.00, 1, 0, '2019-04-22', '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(20, 1, 'sell', 2, 300.00, 0, 300.00, 300.00, 1, 0, '2019-04-22', '2019-04-22 05:01:25', '2019-04-22 05:01:25'),
(22, 1, 'sell', 2, 500.00, 0, 500.00, 500.00, 8, 0, '2019-04-23', '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(24, 1, 'sell', 2, 300.00, 0, 300.00, 0.00, 9, 0, '2019-04-23', '2019-04-23 00:59:38', '2019-04-23 00:59:38'),
(25, 1, 'sell', 1, 250.00, 0, 250.00, 0.00, 10, 0, '2019-04-23', '2019-04-23 01:06:27', '2019-04-23 01:06:27'),
(26, 1, 'sell', 2, 300.00, 0, 300.00, 300.00, 11, 0, '2019-04-23', '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(27, 1, 'sell', 1, 200.00, 0, 200.00, 200.00, 1, 0, '2019-04-23', '2019-04-23 01:22:18', '2019-04-23 01:22:18'),
(28, 1, 'sell', 1, 25.00, 0, 25.00, 25.00, 1, 0, '2019-04-23', '2019-04-23 01:23:35', '2019-04-23 01:23:35'),
(29, 1, 'sell', 3, 450.00, 0, 450.00, 450.00, 12, 0, '2019-04-23', '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(30, 1, 'sell', 4, 180.00, 0, 180.00, 0.00, 13, 0, '2019-04-23', '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(31, 1, 'sell', 2, 300.00, 0, 300.00, 300.00, 1, 0, '2019-04-23', '2019-04-23 02:04:04', '2019-04-23 02:04:04'),
(32, 1, 'sell', 1, 150.00, 0, 150.00, 150.00, 1, 0, '2019-04-23', '2019-04-23 02:05:25', '2019-04-23 02:05:25'),
(33, 1, 'sell', 4, 375.00, 1, 370.00, 370.00, 1, 0, '2019-04-23', '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(34, 1, 'sell', 4, 300.00, 0, 300.00, 300.00, 1, 0, '2019-04-23', '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(36, 1, 'sell', 1, 280.00, 21, 220.00, 220.00, 1, 0, '2019-04-23', '2019-04-23 07:00:40', '2019-04-23 07:00:40'),
(40, 1, 'sell', 6, 260.00, 4, 250.00, 250.00, 1, 0, '2019-04-24', '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(41, 1, 'sell', 1, 650.00, 0, 650.00, 650.00, 14, 0, '2019-04-24', '2019-04-24 01:05:54', '2019-04-24 01:05:54'),
(42, 1, 'sell', 1, 650.00, 0, 650.00, 650.00, 15, 0, '2019-04-24', '2019-04-24 01:41:43', '2019-04-24 01:41:43'),
(43, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 16, 0, '2019-04-24', '2019-04-24 01:59:55', '2019-04-24 01:59:55'),
(45, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 18, 0, '2019-04-24', '2019-04-24 02:36:48', '2019-04-24 02:36:48'),
(46, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 19, 0, '2019-04-24', '2019-04-24 02:42:22', '2019-04-24 02:42:22'),
(47, 1, 'sell', 5, 750.00, 0, 750.00, 750.00, 20, 0, '2019-04-24', '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(48, 1, 'sell', 1, 650.00, 0, 650.00, 650.00, 21, 0, '2019-04-24', '2019-04-24 02:54:06', '2019-04-24 02:54:06'),
(49, 1, 'sell', 4, 2800.00, 0, 2800.00, 2800.00, 17, 0, '2019-04-24', '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(51, 1, 'sell', 7, 450.00, 11, 400.00, 0.00, 22, 0, '2019-04-24', '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(52, 1, 'sell', 2, 325.00, 2, 320.00, 320.00, 1, 0, '2019-04-24', '2019-04-24 04:16:20', '2019-04-24 04:16:20'),
(53, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 1, 0, '2019-04-24', '2019-04-24 05:23:58', '2019-04-24 05:23:58'),
(54, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 1, 0, '2019-04-24', '2019-04-24 05:39:46', '2019-04-24 05:39:46'),
(55, 1, 'sell', 1, 200.00, 0, 200.00, 200.00, 1, 0, '2019-04-24', '2019-04-24 05:40:39', '2019-04-24 05:40:39'),
(56, 1, 'sell', 1, 250.00, 0, 250.00, 250.00, 1, 0, '2019-04-24', '2019-04-24 06:17:26', '2019-04-24 06:17:26'),
(57, 1, 'sell', 1, 280.00, 0, 280.00, 280.00, 1, 0, '2019-04-24', '2019-04-24 06:19:15', '2019-04-24 06:19:15'),
(58, 1, 'purchase', 1, 300.00, 0, 0.00, 0.00, 0, 1, '2019-04-24', '2019-04-24 07:39:54', '2019-04-24 07:39:54'),
(59, 1, 'sell', 2, 400.00, 5, 380.00, 380.00, 1, 0, '2019-04-24', '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(60, 1, 'sell', 1, 150.00, 0, 150.00, 150.00, 1, 0, '2019-04-25', '2019-04-25 00:09:38', '2019-04-25 00:09:38'),
(62, 1, 'sell', 1, 650.00, 0, 650.00, 650.00, 23, 0, '2019-04-25', '2019-04-25 00:36:47', '2019-04-25 00:36:47'),
(63, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 24, 0, '2019-04-25', '2019-04-25 00:47:16', '2019-04-25 00:47:16'),
(64, 1, 'sell', 4, 325.00, 8, 300.00, 300.00, 1, 0, '2019-04-25', '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(65, 1, 'sell', 1, 200.00, 0, 200.00, 200.00, 1, 0, '2019-04-25', '2019-04-25 01:38:07', '2019-04-25 01:38:07'),
(66, 1, 'sell', 6, 260.00, 4, 250.00, 250.00, 1, 0, '2019-04-25', '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(67, 1, 'sell', 1, 150.00, 0, 150.00, 150.00, 25, 0, '2019-04-25', '2019-04-25 02:03:49', '2019-04-25 02:03:49'),
(68, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 27, 0, '2019-04-25', '2019-04-25 02:23:41', '2019-04-25 02:23:41'),
(69, 1, 'sell', 18, 2490.00, 2, 2450.00, 0.00, 28, 0, '2019-04-25', '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(70, 1, 'sell', 2, 75.00, 0, 75.00, 75.00, 1, 0, '2019-04-25', '2019-04-25 03:03:36', '2019-04-25 03:03:36'),
(71, 1, 'sell', 4, 390.00, 0, 390.00, 390.00, 1, 0, '2019-04-25', '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(72, 1, 'sell', 4, 1350.00, 0, 1350.00, 1350.00, 1, 0, '2019-04-25', '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(73, 1, 'sell', 1, 150.00, 0, 150.00, 150.00, 29, 0, '2019-04-25', '2019-04-25 03:51:43', '2019-04-25 03:51:43'),
(74, 1, 'sell', 1, 150.00, 0, 150.00, 150.00, 1, 0, '2019-04-25', '2019-04-25 05:11:06', '2019-04-25 05:11:06'),
(75, 1, 'sell', 3, 450.00, 0, 450.00, 450.00, 37, 0, '2019-04-25', '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(76, 1, 'sell', 1, 700.00, 0, 700.00, 700.00, 38, 0, '2019-04-25', '2019-04-25 05:31:06', '2019-04-25 05:31:06'),
(77, 1, 'sell', 2, 350.00, 0, 350.00, 350.00, 39, 0, '2019-04-25', '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(78, 1, 'sell', 3, 600.00, 0, 600.00, 600.00, 1, 0, '2019-04-25', '2019-04-25 05:37:18', '2019-04-25 05:37:18'),
(79, 1, 'sell', 2, 400.00, 0, 400.00, 400.00, 1, 0, '2019-04-25', '2019-04-25 05:42:57', '2019-04-25 05:42:57'),
(80, 1, 'sell', 2, 1350.00, 0, 1350.00, 1350.00, 40, 0, '2019-04-25', '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(81, 1, 'sell', 1, 300.00, 0, 300.00, 300.00, 1, 0, '2019-04-25', '2019-04-25 06:05:43', '2019-04-25 06:05:43'),
(82, 1, 'purchase', 3, 285.00, 0, 0.00, 0.00, 0, 1, '2019-04-25', '2019-04-25 06:42:44', '2019-04-25 06:42:44');

-- --------------------------------------------------------

--
-- Table structure for table `ledger_heads`
--

CREATE TABLE `ledger_heads` (
  `id` int(10) UNSIGNED NOT NULL,
  `ledgerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(201, '2014_10_12_000000_create_users_table', 1),
(202, '2014_10_12_100000_create_password_resets_table', 1),
(203, '2018_06_30_123738_create_unit_types_table', 1),
(204, '2018_06_30_134223_create_settings_table', 1),
(205, '2018_07_02_122958_create_groups_table', 1),
(206, '2018_07_03_100018_create_categories_table', 1),
(207, '2018_07_03_155050_create_products_table', 1),
(208, '2018_07_05_111105_create_suppliers_table', 1),
(209, '2018_07_08_093900_create_customers_table', 1),
(210, '2018_07_08_095258_create_zones_table', 1),
(211, '2018_07_08_113758_create_ledger_heads_table', 1),
(212, '2018_07_08_113817_create_vouchers_table', 1),
(213, '2018_07_11_112119_create_invoices_table', 1),
(214, '2018_07_11_113714_create_purchases_table', 1),
(215, '2018_07_12_150021_create_paymentsheets_table', 1),
(216, '2018_07_12_151655_create_sellings_table', 1),
(217, '2018_07_14_154542_create_payments_table', 1),
(218, '2018_10_21_062806_create_bonuses_table', 1),
(219, '2018_12_20_071052_create_memberships_table', 1),
(220, '2019_03_04_091332_create_galleries_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `paidAmount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `admin_id`, `uid`, `invoice_id`, `type`, `date`, `paidAmount`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, 'outgoing', '2019-04-15', 1260.00, '2019-04-15 03:46:53', '2019-04-15 03:46:53'),
(2, 1, 1, 2, 'incoming', '2019-04-16', 400.00, '2019-04-16 04:07:18', '2019-04-16 04:07:18'),
(3, 1, 1, 3, 'incoming', '2019-04-20', 300.00, '2019-04-20 01:45:38', '2019-04-20 01:45:38'),
(4, 1, 1, 4, 'incoming', '2019-04-20', 300.00, '2019-04-20 01:49:25', '2019-04-20 01:49:25'),
(5, 1, 4, 5, 'incoming', '2019-04-20', 0.00, '2019-04-20 02:09:39', '2019-04-20 02:09:39'),
(8, 1, 5, 8, 'incoming', '2019-04-20', 0.00, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(9, 1, 1, 9, 'incoming', '2019-04-20', 180.00, '2019-04-20 03:09:43', '2019-04-20 03:09:43'),
(10, 1, 1, 10, 'incoming', '2019-04-20', 40.00, '2019-04-20 06:06:57', '2019-04-20 06:06:57'),
(11, 1, 1, 11, 'incoming', '2019-04-20', 125.00, '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(12, 1, 1, 12, 'incoming', '2019-04-21', 280.00, '2019-04-21 00:37:47', '2019-04-21 00:37:47'),
(13, 1, 1, 13, 'incoming', '2019-04-21', 280.00, '2019-04-21 02:16:24', '2019-04-21 02:16:24'),
(14, 1, 1, 14, 'incoming', '2019-04-21', 200.00, '2019-04-21 02:17:31', '2019-04-21 02:17:31'),
(15, 1, 1, 0, 'outgoing', '2019-04-21', 1235.00, '2019-04-21 05:20:37', '2019-04-21 05:20:37'),
(16, 1, 1, 16, 'incoming', '2019-04-21', 600.00, '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(17, 1, 6, 17, 'incoming', '2019-04-22', 1150.00, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(18, 1, 7, 18, 'incoming', '2019-04-22', 450.00, '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(19, 1, 1, 19, 'incoming', '2019-04-22', 700.00, '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(20, 1, 1, 20, 'incoming', '2019-04-22', 300.00, '2019-04-22 05:01:25', '2019-04-22 05:01:25'),
(21, 1, 8, 22, 'incoming', '2019-04-23', 500.00, '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(22, 1, 8, 23, 'incoming', '2019-04-23', 500.00, '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(23, 1, 9, 24, 'incoming', '2019-04-23', 0.00, '2019-04-23 00:59:38', '2019-04-23 00:59:38'),
(24, 1, 10, 25, 'incoming', '2019-04-23', 0.00, '2019-04-23 01:06:27', '2019-04-23 01:06:27'),
(25, 1, 11, 26, 'incoming', '2019-04-23', 300.00, '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(26, 1, 1, 27, 'incoming', '2019-04-23', 200.00, '2019-04-23 01:22:18', '2019-04-23 01:22:18'),
(27, 1, 1, 28, 'incoming', '2019-04-23', 25.00, '2019-04-23 01:23:35', '2019-04-23 01:23:35'),
(28, 1, 12, 29, 'incoming', '2019-04-23', 450.00, '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(29, 1, 13, 30, 'incoming', '2019-04-23', 0.00, '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(30, 1, 1, 31, 'incoming', '2019-04-23', 300.00, '2019-04-23 02:04:05', '2019-04-23 02:04:05'),
(31, 1, 1, 32, 'incoming', '2019-04-23', 150.00, '2019-04-23 02:05:25', '2019-04-23 02:05:25'),
(32, 1, 1, 33, 'incoming', '2019-04-23', 370.00, '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(33, 1, 1, 34, 'incoming', '2019-04-23', 300.00, '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(35, 1, 1, 36, 'incoming', '2019-04-23', 220.00, '2019-04-23 07:00:40', '2019-04-23 07:00:40'),
(39, 1, 1, 40, 'incoming', '2019-04-24', 250.00, '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(40, 1, 14, 41, 'incoming', '2019-04-24', 650.00, '2019-04-24 01:05:54', '2019-04-24 01:05:54'),
(41, 1, 15, 42, 'incoming', '2019-04-24', 650.00, '2019-04-24 01:41:43', '2019-04-24 01:41:43'),
(42, 1, 16, 43, 'incoming', '2019-04-24', 700.00, '2019-04-24 01:59:55', '2019-04-24 01:59:55'),
(44, 1, 18, 45, 'incoming', '2019-04-24', 700.00, '2019-04-24 02:36:48', '2019-04-24 02:36:48'),
(45, 1, 19, 46, 'incoming', '2019-04-24', 700.00, '2019-04-24 02:42:22', '2019-04-24 02:42:22'),
(46, 1, 20, 47, 'incoming', '2019-04-24', 750.00, '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(47, 1, 21, 48, 'incoming', '2019-04-24', 650.00, '2019-04-24 02:54:06', '2019-04-24 02:54:06'),
(48, 1, 17, 49, 'incoming', '2019-04-24', 2800.00, '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(50, 1, 22, 51, 'incoming', '2019-04-24', 0.00, '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(51, 1, 22, 0, 'incoming', '2019-04-24', 400.00, '2019-04-24 03:59:42', '2019-04-24 03:59:42'),
(52, 1, 5, 0, 'incoming', '2019-04-24', 1050.00, '2019-04-24 03:59:53', '2019-04-24 03:59:53'),
(53, 1, 4, 0, 'incoming', '2019-04-24', 250.00, '2019-04-24 04:00:02', '2019-04-24 04:00:02'),
(54, 1, 9, 0, 'incoming', '2019-04-24', 300.00, '2019-04-24 04:00:27', '2019-04-24 04:00:27'),
(55, 1, 10, 0, 'incoming', '2019-04-24', 250.00, '2019-04-24 04:00:40', '2019-04-24 04:00:40'),
(56, 1, 13, 0, 'incoming', '2019-04-24', 180.00, '2019-04-24 04:00:48', '2019-04-24 04:00:48'),
(57, 1, 1, 52, 'incoming', '2019-04-24', 320.00, '2019-04-24 04:16:20', '2019-04-24 04:16:20'),
(58, 1, 1, 53, 'incoming', '2019-04-24', 700.00, '2019-04-24 05:23:58', '2019-04-24 05:23:58'),
(59, 1, 1, 54, 'incoming', '2019-04-24', 700.00, '2019-04-24 05:39:46', '2019-04-24 05:39:46'),
(60, 1, 1, 55, 'incoming', '2019-04-24', 200.00, '2019-04-24 05:40:39', '2019-04-24 05:40:39'),
(61, 1, 1, 56, 'incoming', '2019-04-24', 250.00, '2019-04-24 06:17:26', '2019-04-24 06:17:26'),
(62, 1, 1, 57, 'incoming', '2019-04-24', 280.00, '2019-04-24 06:19:15', '2019-04-24 06:19:15'),
(63, 1, 1, 0, 'outgoing', '2019-04-24', 300.00, '2019-04-24 07:39:54', '2019-04-24 07:39:54'),
(64, 1, 1, 59, 'incoming', '2019-04-24', 380.00, '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(65, 1, 1, 60, 'incoming', '2019-04-25', 150.00, '2019-04-25 00:09:38', '2019-04-25 00:09:38'),
(67, 1, 23, 62, 'incoming', '2019-04-25', 650.00, '2019-04-25 00:36:47', '2019-04-25 00:36:47'),
(68, 1, 24, 63, 'incoming', '2019-04-25', 700.00, '2019-04-25 00:47:16', '2019-04-25 00:47:16'),
(69, 1, 1, 64, 'incoming', '2019-04-25', 300.00, '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(70, 1, 1, 65, 'incoming', '2019-04-25', 200.00, '2019-04-25 01:38:07', '2019-04-25 01:38:07'),
(71, 1, 1, 66, 'incoming', '2019-04-25', 250.00, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(72, 1, 25, 67, 'incoming', '2019-04-25', 150.00, '2019-04-25 02:03:49', '2019-04-25 02:03:49'),
(73, 1, 27, 68, 'incoming', '2019-04-25', 700.00, '2019-04-25 02:23:41', '2019-04-25 02:23:41'),
(74, 1, 28, 69, 'incoming', '2019-04-25', 0.00, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(75, 1, 1, 70, 'incoming', '2019-04-25', 75.00, '2019-04-25 03:03:37', '2019-04-25 03:03:37'),
(76, 1, 1, 71, 'incoming', '2019-04-25', 390.00, '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(77, 1, 1, 72, 'incoming', '2019-04-25', 1350.00, '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(78, 1, 29, 73, 'incoming', '2019-04-25', 150.00, '2019-04-25 03:51:43', '2019-04-25 03:51:43'),
(79, 1, 1, 74, 'incoming', '2019-04-25', 150.00, '2019-04-25 05:11:06', '2019-04-25 05:11:06'),
(80, 1, 37, 75, 'incoming', '2019-04-25', 450.00, '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(81, 1, 38, 76, 'incoming', '2019-04-25', 700.00, '2019-04-25 05:31:06', '2019-04-25 05:31:06'),
(82, 1, 39, 77, 'incoming', '2019-04-25', 350.00, '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(83, 1, 1, 78, 'incoming', '2019-04-25', 600.00, '2019-04-25 05:37:18', '2019-04-25 05:37:18'),
(84, 1, 1, 79, 'incoming', '2019-04-25', 400.00, '2019-04-25 05:42:57', '2019-04-25 05:42:57'),
(85, 1, 40, 80, 'incoming', '2019-04-25', 1350.00, '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(86, 1, 1, 81, 'incoming', '2019-04-25', 300.00, '2019-04-25 06:05:43', '2019-04-25 06:05:43'),
(87, 1, 1, 0, 'outgoing', '2019-04-25', 285.00, '2019-04-25 06:42:44', '2019-04-25 06:42:44');

-- --------------------------------------------------------

--
-- Table structure for table `paymentsheets`
--

CREATE TABLE `paymentsheets` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'incoming',
  `paymentFor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `remarks` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentMethod` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'cash',
  `invoice_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `voucher_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `paymentsheets`
--

INSERT INTO `paymentsheets` (`id`, `admin_id`, `uid`, `amount`, `type`, `paymentFor`, `remarks`, `paymentMethod`, `invoice_id`, `payment_id`, `voucher_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 0.00, 'incoming', 'cash', NULL, 'cash', NULL, NULL, NULL, '2019-04-15', '2019-04-15 07:55:08', '2019-04-15 07:56:03'),
(2, 1, 1, -1260.00, 'outgoing', 'supplier', 'Purchased From Cash', 'cash', 1, NULL, NULL, '2019-04-15', '2019-04-15 03:46:53', '2019-04-15 03:46:53'),
(3, 1, 1, 400.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 2, NULL, NULL, '2019-04-16', '2019-04-16 04:07:19', '2019-04-16 04:07:19'),
(4, 1, 2, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-18', '2019-04-18 11:39:49', '2019-04-18 11:39:49'),
(5, 1, 3, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-18', '2019-04-18 11:41:25', '2019-04-18 11:41:25'),
(6, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 3, NULL, NULL, '2019-04-20', '2019-04-20 01:45:39', '2019-04-20 01:45:39'),
(7, 1, 1, -200.00, 'discount', 'customer', 'Discount To Customer', 'cash', 3, NULL, NULL, '2019-04-20', '2019-04-20 01:45:39', '2019-04-20 01:45:39'),
(8, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 4, NULL, NULL, '2019-04-20', '2019-04-20 01:49:25', '2019-04-20 01:49:25'),
(9, 1, 2, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, NULL, NULL, '2019-04-20 02:08:29', '2019-04-20 02:08:29'),
(10, 1, 4, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-20', '2019-04-20 08:09:00', '2019-04-20 08:09:00'),
(11, 1, 4, -250.00, 'due', 'customer', 'Sell To Customer', 'due', 5, NULL, NULL, '2019-04-20', '2019-04-20 02:09:39', '2019-04-20 02:09:39'),
(12, 1, 5, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-20', '2019-04-20 08:23:03', '2019-04-20 08:23:03'),
(18, 1, 5, -1050.00, 'due', 'customer', 'Sell To Customer', 'due', 8, NULL, NULL, '2019-04-20', '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(19, 1, 5, -32.40, 'discount', 'customer', 'Discount To Customer', 'cash', 8, NULL, NULL, '2019-04-20', '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(20, 1, 1, 180.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 9, NULL, NULL, '2019-04-20', '2019-04-20 03:09:43', '2019-04-20 03:09:43'),
(21, 1, 1, 40.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 10, NULL, NULL, '2019-04-20', '2019-04-20 06:06:57', '2019-04-20 06:06:57'),
(22, 1, 1, 125.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 11, NULL, NULL, '2019-04-20', '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(23, 1, 1, 280.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 12, NULL, NULL, '2019-04-21', '2019-04-21 00:37:47', '2019-04-21 00:37:47'),
(24, 1, 1, 280.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 13, NULL, NULL, '2019-04-21', '2019-04-21 02:16:24', '2019-04-21 02:16:24'),
(25, 1, 1, 200.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 14, NULL, NULL, '2019-04-21', '2019-04-21 02:17:31', '2019-04-21 02:17:31'),
(26, 1, 1, -1235.00, 'outgoing', 'supplier', 'Purchased From Cash', 'cash', 15, NULL, NULL, '2019-04-21', '2019-04-21 05:20:37', '2019-04-21 05:20:37'),
(27, 1, 1, 600.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 16, NULL, NULL, '2019-04-21', '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(28, 1, 1, -59.40, 'discount', 'customer', 'Discount To Customer', 'cash', 16, NULL, NULL, '2019-04-21', '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(29, 1, 6, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-22', '2019-04-22 06:15:43', '2019-04-22 06:15:43'),
(30, 1, 6, -1150.00, 'due', 'customer', 'Sell To Customer', 'cash', 17, NULL, NULL, '2019-04-22', '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(31, 1, 6, 1150.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 17, NULL, NULL, '2019-04-22', '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(32, 1, 6, -48.00, 'discount', 'customer', 'Discount To Customer', 'cash', 17, NULL, NULL, '2019-04-22', '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(33, 1, 7, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-22', '2019-04-22 06:31:41', '2019-04-22 06:31:41'),
(34, 1, 7, -450.00, 'due', 'customer', 'Sell To Customer', 'cash', 18, NULL, NULL, '2019-04-22', '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(35, 1, 7, 450.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 18, NULL, NULL, '2019-04-22', '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(36, 1, 1, 700.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 19, NULL, NULL, '2019-04-22', '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(37, 1, 1, -78.00, 'discount', 'customer', 'Discount To Customer', 'cash', 19, NULL, NULL, '2019-04-22', '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(38, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 20, NULL, NULL, '2019-04-22', '2019-04-22 05:01:25', '2019-04-22 05:01:25'),
(39, 1, 2, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, NULL, NULL, '2019-04-22 06:04:35', '2019-04-22 06:04:35'),
(41, 1, 8, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 06:53:04', '2019-04-23 06:53:04'),
(42, 1, 8, -500.00, 'due', 'customer', 'Sell To Customer', 'cash', 22, NULL, NULL, '2019-04-23', '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(43, 1, 8, 500.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 22, NULL, NULL, '2019-04-23', '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(46, 1, 9, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 06:59:10', '2019-04-23 06:59:10'),
(47, 1, 9, -300.00, 'due', 'customer', 'Sell To Customer', 'due', 24, NULL, NULL, '2019-04-23', '2019-04-23 00:59:38', '2019-04-23 00:59:38'),
(48, 1, 10, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 07:05:54', '2019-04-23 07:05:54'),
(49, 1, 10, -250.00, 'due', 'customer', 'Sell To Customer', 'due', 25, NULL, NULL, '2019-04-23', '2019-04-23 01:06:27', '2019-04-23 01:06:27'),
(50, 1, 11, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 07:08:42', '2019-04-23 07:08:42'),
(51, 1, 11, -300.00, 'due', 'customer', 'Sell To Customer', 'cash', 26, NULL, NULL, '2019-04-23', '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(52, 1, 11, 300.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 26, NULL, NULL, '2019-04-23', '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(53, 1, 12, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 07:13:49', '2019-04-23 07:13:49'),
(54, 1, 1, 200.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 27, NULL, NULL, '2019-04-23', '2019-04-23 01:22:18', '2019-04-23 01:22:18'),
(55, 1, 1, 25.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 28, NULL, NULL, '2019-04-23', '2019-04-23 01:23:35', '2019-04-23 01:23:35'),
(56, 1, 12, -450.00, 'due', 'customer', 'Sell To Customer', 'cash', 29, NULL, NULL, '2019-04-23', '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(57, 1, 12, 450.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 29, NULL, NULL, '2019-04-23', '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(58, 1, 13, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-23', '2019-04-23 07:37:58', '2019-04-23 07:37:58'),
(59, 1, 13, -180.00, 'due', 'customer', 'Sell To Customer', 'due', 30, NULL, NULL, '2019-04-23', '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(60, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 31, NULL, NULL, '2019-04-23', '2019-04-23 02:04:05', '2019-04-23 02:04:05'),
(61, 1, 1, 150.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 32, NULL, NULL, '2019-04-23', '2019-04-23 02:05:25', '2019-04-23 02:05:25'),
(62, 1, 1, 370.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 33, NULL, NULL, '2019-04-23', '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(63, 1, 1, -3.75, 'discount', 'customer', 'Discount To Customer', 'cash', 33, NULL, NULL, '2019-04-23', '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(64, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 34, NULL, NULL, '2019-04-23', '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(66, 1, 1, 220.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 36, NULL, NULL, '2019-04-23', '2019-04-23 07:00:40', '2019-04-23 07:00:40'),
(67, 1, 1, -58.80, 'discount', 'customer', 'Discount To Customer', 'cash', 36, NULL, NULL, '2019-04-23', '2019-04-23 07:00:40', '2019-04-23 07:00:40'),
(75, 1, 1, 250.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 40, NULL, NULL, '2019-04-24', '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(76, 1, 1, -10.40, 'discount', 'customer', 'Discount To Customer', 'cash', 40, NULL, NULL, '2019-04-24', '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(77, 1, 14, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 06:50:17', '2019-04-24 06:50:17'),
(78, 1, 14, -650.00, 'due', 'customer', 'Sell To Customer', 'cash', 41, NULL, NULL, '2019-04-24', '2019-04-24 01:05:54', '2019-04-24 01:05:54'),
(79, 1, 14, 650.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 41, NULL, NULL, '2019-04-24', '2019-04-24 01:05:54', '2019-04-24 01:05:54'),
(80, 1, 15, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 07:41:25', '2019-04-24 07:41:25'),
(81, 1, 15, -650.00, 'due', 'customer', 'Sell To Customer', 'cash', 42, NULL, NULL, '2019-04-24', '2019-04-24 01:41:43', '2019-04-24 01:41:43'),
(82, 1, 15, 650.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 42, NULL, NULL, '2019-04-24', '2019-04-24 01:41:43', '2019-04-24 01:41:43'),
(83, 1, 16, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 07:57:01', '2019-04-24 07:57:01'),
(84, 1, 16, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 43, NULL, NULL, '2019-04-24', '2019-04-24 01:59:55', '2019-04-24 01:59:55'),
(85, 1, 16, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 43, NULL, NULL, '2019-04-24', '2019-04-24 01:59:55', '2019-04-24 01:59:55'),
(86, 1, 17, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 08:17:42', '2019-04-24 08:17:42'),
(89, 1, 18, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 08:36:10', '2019-04-24 08:36:10'),
(90, 1, 18, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 45, NULL, NULL, '2019-04-24', '2019-04-24 02:36:48', '2019-04-24 02:36:48'),
(91, 1, 18, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 45, NULL, NULL, '2019-04-24', '2019-04-24 02:36:48', '2019-04-24 02:36:48'),
(92, 1, 19, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 08:41:41', '2019-04-24 08:41:41'),
(93, 1, 19, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 46, NULL, NULL, '2019-04-24', '2019-04-24 02:42:22', '2019-04-24 02:42:22'),
(94, 1, 19, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 46, NULL, NULL, '2019-04-24', '2019-04-24 02:42:22', '2019-04-24 02:42:22'),
(95, 1, 20, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 08:44:50', '2019-04-24 08:44:50'),
(96, 1, 20, -750.00, 'due', 'customer', 'Sell To Customer', 'cash', 47, NULL, NULL, '2019-04-24', '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(97, 1, 20, 750.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 47, NULL, NULL, '2019-04-24', '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(98, 1, 21, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 08:53:43', '2019-04-24 08:53:43'),
(99, 1, 21, -650.00, 'due', 'customer', 'Sell To Customer', 'cash', 48, NULL, NULL, '2019-04-24', '2019-04-24 02:54:06', '2019-04-24 02:54:06'),
(100, 1, 21, 650.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 48, NULL, NULL, '2019-04-24', '2019-04-24 02:54:06', '2019-04-24 02:54:06'),
(101, 1, 17, -2800.00, 'due', 'customer', 'Sell To Customer', 'cash', 49, NULL, NULL, '2019-04-24', '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(102, 1, 17, 2800.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 49, NULL, NULL, '2019-04-24', '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(103, 1, 22, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-24', '2019-04-24 09:31:37', '2019-04-24 09:31:37'),
(107, 1, 22, -400.00, 'due', 'customer', 'Sell To Customer', 'due', 51, NULL, NULL, '2019-04-24', '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(108, 1, 22, -49.50, 'discount', 'customer', 'Discount To Customer', 'cash', 51, NULL, NULL, '2019-04-24', '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(109, 1, 22, 400.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 51, NULL, '2019-04-24', '2019-04-24 03:59:42', '2019-04-24 03:59:42'),
(110, 1, 5, 1050.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 52, NULL, '2019-04-24', '2019-04-24 03:59:53', '2019-04-24 03:59:53'),
(111, 1, 4, 250.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 53, NULL, '2019-04-24', '2019-04-24 04:00:02', '2019-04-24 04:00:02'),
(112, 1, 9, 300.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 54, NULL, '2019-04-24', '2019-04-24 04:00:27', '2019-04-24 04:00:27'),
(113, 1, 10, 250.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 55, NULL, '2019-04-24', '2019-04-24 04:00:40', '2019-04-24 04:00:40'),
(114, 1, 13, 180.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, 56, NULL, '2019-04-24', '2019-04-24 04:00:48', '2019-04-24 04:00:48'),
(115, 1, 1, 320.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 52, NULL, NULL, '2019-04-24', '2019-04-24 04:16:20', '2019-04-24 04:16:20'),
(116, 1, 1, -6.50, 'discount', 'customer', 'Discount To Customer', 'cash', 52, NULL, NULL, '2019-04-24', '2019-04-24 04:16:20', '2019-04-24 04:16:20'),
(117, 1, 1, 700.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 53, NULL, NULL, '2019-04-24', '2019-04-24 05:23:58', '2019-04-24 05:23:58'),
(118, 1, 1, 700.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 54, NULL, NULL, '2019-04-24', '2019-04-24 05:39:46', '2019-04-24 05:39:46'),
(119, 1, 1, 200.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 55, NULL, NULL, '2019-04-24', '2019-04-24 05:40:39', '2019-04-24 05:40:39'),
(120, 1, 1, 250.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 56, NULL, NULL, '2019-04-24', '2019-04-24 06:17:26', '2019-04-24 06:17:26'),
(121, 1, 1, 280.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 57, NULL, NULL, '2019-04-24', '2019-04-24 06:19:15', '2019-04-24 06:19:15'),
(122, 1, 1, -300.00, 'outgoing', 'supplier', 'Purchased From Cash', 'cash', 58, NULL, NULL, '2019-04-24', '2019-04-24 07:39:54', '2019-04-24 07:39:54'),
(123, 1, 1, 380.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 59, NULL, NULL, '2019-04-24', '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(124, 1, 1, -20.00, 'discount', 'customer', 'Discount To Customer', 'cash', 59, NULL, NULL, '2019-04-24', '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(125, 1, 1, 150.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 60, NULL, NULL, '2019-04-25', '2019-04-25 00:09:38', '2019-04-25 00:09:38'),
(127, 1, 23, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 06:23:36', '2019-04-25 06:23:36'),
(128, 1, 23, -650.00, 'due', 'customer', 'Sell To Customer', 'cash', 62, NULL, NULL, '2019-04-25', '2019-04-25 00:36:47', '2019-04-25 00:36:47'),
(129, 1, 23, 650.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 62, NULL, NULL, '2019-04-25', '2019-04-25 00:36:47', '2019-04-25 00:36:47'),
(130, 1, 24, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 06:46:05', '2019-04-25 06:46:05'),
(131, 1, 24, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 63, NULL, NULL, '2019-04-25', '2019-04-25 00:47:16', '2019-04-25 00:47:16'),
(132, 1, 24, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 63, NULL, NULL, '2019-04-25', '2019-04-25 00:47:16', '2019-04-25 00:47:16'),
(133, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 64, NULL, NULL, '2019-04-25', '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(134, 1, 1, -26.00, 'discount', 'customer', 'Discount To Customer', 'cash', 64, NULL, NULL, '2019-04-25', '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(135, 1, 1, 200.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 65, NULL, NULL, '2019-04-25', '2019-04-25 01:38:07', '2019-04-25 01:38:07'),
(136, 1, 1, 250.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 66, NULL, NULL, '2019-04-25', '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(137, 1, 1, -10.40, 'discount', 'customer', 'Discount To Customer', 'cash', 66, NULL, NULL, '2019-04-25', '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(138, 1, 25, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 08:03:16', '2019-04-25 08:03:16'),
(139, 1, 25, -150.00, 'due', 'customer', 'Sell To Customer', 'cash', 67, NULL, NULL, '2019-04-25', '2019-04-25 02:03:49', '2019-04-25 02:03:49'),
(140, 1, 25, 150.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 67, NULL, NULL, '2019-04-25', '2019-04-25 02:03:49', '2019-04-25 02:03:49'),
(141, 1, 26, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 08:15:01', '2019-04-25 08:15:01'),
(142, 1, 27, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 08:23:17', '2019-04-25 08:23:17'),
(143, 1, 27, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 68, NULL, NULL, '2019-04-25', '2019-04-25 02:23:41', '2019-04-25 02:23:41'),
(144, 1, 27, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 68, NULL, NULL, '2019-04-25', '2019-04-25 02:23:41', '2019-04-25 02:23:41'),
(145, 1, 28, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 08:32:10', '2019-04-25 08:32:10'),
(146, 1, 28, -2450.00, 'due', 'customer', 'Sell To Customer', 'due', 69, NULL, NULL, '2019-04-25', '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(147, 1, 28, -49.80, 'discount', 'customer', 'Discount To Customer', 'cash', 69, NULL, NULL, '2019-04-25', '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(148, 1, 1, 75.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 70, NULL, NULL, '2019-04-25', '2019-04-25 03:03:37', '2019-04-25 03:03:37'),
(149, 1, 1, 390.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 71, NULL, NULL, '2019-04-25', '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(150, 1, 1, 1350.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 72, NULL, NULL, '2019-04-25', '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(151, 1, 29, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 09:50:49', '2019-04-25 09:50:49'),
(152, 1, 29, -150.00, 'due', 'customer', 'Sell To Customer', 'cash', 73, NULL, NULL, '2019-04-25', '2019-04-25 03:51:43', '2019-04-25 03:51:43'),
(153, 1, 29, 150.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 73, NULL, NULL, '2019-04-25', '2019-04-25 03:51:44', '2019-04-25 03:51:44'),
(154, 1, 30, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 10:03:26', '2019-04-25 10:03:26'),
(155, 1, 31, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 10:12:23', '2019-04-25 10:12:23'),
(156, 1, 32, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 10:21:58', '2019-04-25 10:21:58'),
(157, 1, 33, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 10:43:00', '2019-04-25 10:43:00'),
(158, 1, 36, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 10:44:55', '2019-04-25 10:44:55'),
(159, 1, 1, 150.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 74, NULL, NULL, '2019-04-25', '2019-04-25 05:11:06', '2019-04-25 05:11:06'),
(160, 1, 37, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 11:28:15', '2019-04-25 11:28:15'),
(161, 1, 37, -450.00, 'due', 'customer', 'Sell To Customer', 'cash', 75, NULL, NULL, '2019-04-25', '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(162, 1, 37, 450.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 75, NULL, NULL, '2019-04-25', '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(163, 1, 38, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 11:30:45', '2019-04-25 11:30:45'),
(164, 1, 38, -700.00, 'due', 'customer', 'Sell To Customer', 'cash', 76, NULL, NULL, '2019-04-25', '2019-04-25 05:31:06', '2019-04-25 05:31:06'),
(165, 1, 38, 700.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 76, NULL, NULL, '2019-04-25', '2019-04-25 05:31:06', '2019-04-25 05:31:06'),
(166, 1, 39, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 11:35:17', '2019-04-25 11:35:17'),
(167, 1, 39, -350.00, 'due', 'customer', 'Sell To Customer', 'cash', 77, NULL, NULL, '2019-04-25', '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(168, 1, 39, 350.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 77, NULL, NULL, '2019-04-25', '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(169, 1, 1, 600.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 78, NULL, NULL, '2019-04-25', '2019-04-25 05:37:18', '2019-04-25 05:37:18'),
(170, 1, 1, 400.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 79, NULL, NULL, '2019-04-25', '2019-04-25 05:42:57', '2019-04-25 05:42:57'),
(171, 1, 40, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-04-25', '2019-04-25 11:48:31', '2019-04-25 11:48:31'),
(172, 1, 40, -1350.00, 'due', 'customer', 'Sell To Customer', 'cash', 80, NULL, NULL, '2019-04-25', '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(173, 1, 40, 1350.00, 'dueIncoming', 'customer', 'Sell To Customer', 'cash', 80, NULL, NULL, '2019-04-25', '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(174, 1, 1, 300.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 81, NULL, NULL, '2019-04-25', '2019-04-25 06:05:43', '2019-04-25 06:05:43'),
(175, 1, 1, -285.00, 'outgoing', 'supplier', 'Purchased From Cash', 'cash', 82, NULL, NULL, '2019-04-25', '2019-04-25 06:42:44', '2019-04-25 06:42:44');

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
  `model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
(1, 1, 'Tea Tea Shampoo', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40321', '400', '310', '5060120166425', '/uploads/lRHKptOXyZyTZuD8VmAgNQ4hjDCiL0fED17ou2s4.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:00:39', '2019-04-15 02:00:39'),
(2, 1, 'Tea Tree Conditioner', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40322', '380', '310', '5060120166432', '/uploads/UGVtdfeEb0oWiXmNfRFjGXZubMWYS72EJdPfkHdX.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:16:06', '2019-04-15 02:16:06'),
(3, 1, 'Biotin Shampoo', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40271', '400', '310', '5060120165763', '/uploads/Llu1jg2GwDXINFBJD6GzjqlMIZF21fRmK1PD0PRW.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:17:34', '2019-04-15 02:17:34'),
(4, 1, 'Biotin Conditoner', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40272', '380', '310', '5060120165770', '/uploads/Llu1jg2GwDXINFBJD6GzjqlMIZF21fRmK1PD0PRW.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:18:15', '2019-04-15 02:18:31'),
(5, 1, 'Keratin Classic Shampoo', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40273', '400', '310', '5060120165787', '/uploads/jNPhHVbQ7dn5Jr36kt7Mk6U9uPBPA5LvEG90U4OZ.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:19:46', '2019-04-15 02:19:46'),
(6, 1, 'Keratin Classic Conditioner', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40274', '380', '310', '5060120165794', '/uploads/QUXHVAZU0JjeQ9gbY9iy9UEvZD4k8H9YyQykFkHD.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:22:45', '2019-04-15 02:22:46'),
(7, 1, 'Argan Oil Shampoo', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40183', '350', '270', '5060120164063', '/uploads/VE9JLRUrVlUghGODNxt5hUqskLj1s2pLFuemVvs6.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:27:30', '2019-04-15 02:27:30'),
(8, 1, 'Argan Oil Conditioner', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40184', '350', '270', '5060120164087', '/uploads/uU5c0RmwmOVmYYNKlxmRfjX3DHiyBJyayDSzThYd.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:28:21', '2019-04-15 02:28:21'),
(9, 1, 'Argan Oil Hair Treatment Oil 100ml', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40167', '380', '260', '5060120163714', '/uploads/D4GQOjpvJPm5ZIdn5rpVvl3etwIDBjKAkAYQW82Z.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:36:21', '2019-04-15 02:36:21'),
(10, 1, 'Argan Oil Hair Treatment Oil 50ml', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40167', '200', '165', '5060120164049', '/uploads/D4GQOjpvJPm5ZIdn5rpVvl3etwIDBjKAkAYQW82Z.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:38:25', '2019-04-15 02:38:25'),
(11, 1, 'Argan Oil Night Repair Serum 30ml', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40204', '250', '160', '5060120164551', '/uploads/mw5RblqZhEAeLjTXnm216DWNtz4gDtxBWcaFZDwS.jpeg', '0000-00-00', '0', '0', '2019-04-15 02:41:00', '2019-04-15 02:41:00'),
(12, 1, 'Tea Tree Oil 10 ml', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40146', '180', '135', '5060120168757', NULL, '0000-00-00', '0', '0', '2019-04-15 03:32:10', '2019-04-15 03:32:10'),
(13, 1, 'Tea Tree Oil 30ml', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40146', '350', '260', '40146', NULL, '0000-00-00', '0', '0', '2019-04-15 03:32:59', '2019-04-15 03:32:59'),
(14, 1, 'Tea Tree Faical Scrub', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40157', '280', '240', '5060120163363', '/uploads/jmm2Tw9Gam0YCShEeg8dP0h7l6YzsoKjFboni2JD.jpeg', '0000-00-00', '0', '0', '2019-04-15 03:34:13', '2019-04-15 03:34:13'),
(15, 1, 'Charcoal Scrub', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40538', '280', '240', '5060120167606', '/uploads/SfTmvmRTdEvuPwdHH9AKPt3VJjttu9kNpDhwMMDW.jpeg', '0000-00-00', '0', '0', '2019-04-15 03:36:16', '2019-04-15 03:36:16'),
(16, 1, 'Tea Tree Facial Wipes', 'Cosmetics', 'Skin Care', 'Xpel', 'PCS', NULL, NULL, '40158', '300', '210', '5060120163387', '/uploads/stueW7l2HqtU3hauGNwGn47LbfWKxmTgkny13iPM.jpeg', '0000-00-00', '0', '0', '2019-04-15 03:42:45', '2019-04-15 03:46:53'),
(17, 1, 'Argan Oil Heat Defence Spray', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40198', '350', '250', '5060120164346', '/uploads/4pSDovzQWlA0Xksz3qqv7jyeqyNzwCUrevbYc1tC.jpeg', '0000-00-00', '0', '0', '2019-04-15 03:55:02', '2019-04-15 03:55:03'),
(18, 1, 'Argan Oil Hair Mask', 'Cosmetics', 'Hair Care', 'Xpel', 'PCS', NULL, NULL, '40186', '350', '260', '5060120164131', '/uploads/SJjwxEThpwUVj1aH87R7ldf5i7uJ9eUNFULdb6K5.jpeg', '0000-00-00', '0', '0', '2019-04-15 03:55:55', '2019-04-15 03:55:55'),
(19, 1, 'Lanbena Vitamin C Serum', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '120', '6970470530281', NULL, '0000-00-00', '0', '0', '2019-04-18 05:53:52', '2019-04-18 05:53:52'),
(20, 1, 'Lanbena Blueberry Serum', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '120', '6970470534333', NULL, '0000-00-00', '0', '0', '2019-04-18 05:57:48', '2019-04-18 05:57:48'),
(21, 1, 'Lanbena Hyaluronic Acid Serum', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '120', '6970470530274', NULL, '0000-00-00', '0', '0', '2019-04-18 06:03:32', '2019-04-18 06:03:32'),
(22, 1, 'Lanbena Pore Treatment Serum', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '130', '6970470534463', NULL, '0000-00-00', '0', '0', '2019-04-18 06:05:32', '2019-04-18 06:05:32'),
(23, 1, 'Lanbena Hair Growth Essential Oil', 'Cosmetics', 'Hair Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '350', '150', '6970470530380', NULL, '0000-00-00', '0', '0', '2019-04-18 06:06:25', '2019-04-18 06:16:42'),
(24, 1, 'Lanbena Deep Blackhead Softener', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '110', '6970470530199', NULL, '0000-00-00', '0', '0', '2019-04-18 06:16:23', '2019-04-18 06:16:23'),
(25, 1, 'Lanbena Scar Romoval Gel', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '350', '180', '6970470534098', NULL, '0000-00-00', '0', '0', '2019-04-18 06:20:18', '2019-04-18 06:20:18'),
(27, 1, 'Lanbena Nail Rpair Essence', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '250', '110', '6970470534067', NULL, '0000-00-00', '0', '0', '2019-04-18 06:24:13', '2019-04-18 06:24:13'),
(28, 1, 'Lanbena Skin Care Gel', 'Cosmetics', 'Skin Care', 'Lanbena', 'PCS', NULL, NULL, NULL, '150', '300', '6970470530298', NULL, '0000-00-00', '0', '0', '2019-04-18 06:28:44', '2019-04-18 06:28:44'),
(29, 1, 'Rorec White Rice Serum', 'Cosmetics', 'Skin Care', 'Rorec', 'PCS', NULL, NULL, NULL, '250', '90', '6947790796307', NULL, '0000-00-00', '0', '0', '2019-04-18 06:38:59', '2019-04-18 06:38:59'),
(30, 1, 'One Spring Serum', 'Cosmetics', 'Skin Care', 'One Spring', 'PCS', NULL, NULL, NULL, '250', '90', '6947790786841', NULL, '0000-00-00', '0', '0', '2019-04-18 06:42:34', '2019-04-18 06:42:34'),
(31, 1, 'Bioaqua 24K Gold Serum', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '300', '150', '6947790780887', NULL, '0000-00-00', '0', '0', '2019-04-18 06:48:59', '2019-04-18 06:48:59'),
(32, 1, 'Egg Skin Care Facial Cleanser', 'Cosmetics', 'Skin Care', 'Egg Skin Care', 'PCS', NULL, NULL, NULL, '350', '190', '6922201302896', NULL, '0000-00-00', '0', '0', '2019-04-18 07:14:54', '2019-04-18 07:14:54'),
(33, 1, 'Bioaqua Vitamin C Toner', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '350', '150', '6941349302032', NULL, '0000-00-00', '0', '0', '2019-04-18 07:41:04', '2019-04-18 07:41:04'),
(34, 1, 'Bioaqua Aloe Vera Toner', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '350', '150', '6947790782843', NULL, '0000-00-00', '0', '0', '2019-04-18 07:44:45', '2019-04-18 07:44:45'),
(35, 1, 'Bioaqua V7 Toning Toner', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '350', '160', '6947790789491', NULL, '0000-00-00', '0', '0', '2019-04-18 07:47:10', '2019-04-18 07:47:10'),
(37, 1, 'Bioaqua Baby Skin Moisturizing Toner', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '350', '150', '6947790799995', NULL, '0000-00-00', '0', '0', '2019-04-18 07:57:44', '2019-04-18 07:57:44'),
(38, 1, 'Rorec White Rice Toner', 'Cosmetics', 'Skin Care', 'Rorec', NULL, NULL, NULL, NULL, '350', '150', '6947790795973', NULL, '0000-00-00', '0', '0', '2019-04-18 08:00:16', '2019-04-18 08:00:16'),
(39, 1, 'Bioaqua Vitamin C Eye Mask', 'Cosmetics', 'Eye Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '350', '140', '6947790784991', NULL, '0000-00-00', '0', '0', '2019-04-18 08:02:30', '2019-04-18 08:02:30'),
(40, 1, 'Peel Off Black Mask', 'Cosmetics', 'Skin Care', 'Meinaier', 'PCS', NULL, NULL, NULL, '300', '150', '6925267300523', NULL, '0000-00-00', '0', '0', '2019-04-18 08:04:35', '2019-04-18 08:04:35'),
(41, 1, 'Riwa Ladies Beauty Trimmer', 'Electronics', 'Trimmer', 'Riwa', 'PCS', NULL, NULL, 'RF-770A', '1650', '1100', '6925959402467', NULL, '0000-00-00', '0', '0', '2019-04-19 08:18:06', '2019-04-19 08:18:06'),
(42, 1, 'Bioaqua Sunscreen Combo Pack', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '550', '260', '6947790775999', NULL, '0000-00-00', '0', '0', '2019-04-19 23:49:59', '2019-04-19 23:49:59'),
(43, 1, 'Bioaqua Wonder Eye Cream', 'Cosmetics', 'Eye Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '250', '150', '6947790784250', NULL, '0000-00-00', '0', '0', '2019-04-19 23:55:05', '2019-04-19 23:55:05'),
(44, 1, 'Bioaqua BB Cream', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '220', '100', '6947790786940', NULL, '0000-00-00', '0', '0', '2019-04-19 23:56:09', '2019-04-19 23:56:09'),
(45, 1, 'Bioaqua Deep Cleansing Water', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '300', '200', '6947790780375', NULL, '0000-00-00', '0', '0', '2019-04-19 23:58:00', '2019-04-19 23:58:00'),
(46, 1, 'Bioaqua Baby Skin Cleansing Milk', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '250', '150', '6947790799988', NULL, '0000-00-00', '0', '0', '2019-04-19 23:58:52', '2019-04-19 23:58:52'),
(47, 1, 'Laikou Brightening Black Mask', 'Cosmetics', 'Facial Sheet Mask', 'Laikou', 'PCS', NULL, NULL, NULL, '50', '25', '6925464082109', NULL, '0000-00-00', '0', '0', '2019-04-20 00:07:08', '2019-04-20 00:07:08'),
(48, 1, 'Rorec Blueberry Mask', 'Cosmetics', 'Facial Sheet Mask', 'Rorec', 'PCS', NULL, NULL, NULL, '50', '25', '6947790784830', NULL, '0000-00-00', '0', '0', '2019-04-20 00:11:07', '2019-04-20 00:11:07'),
(49, 1, 'Rorec Pomegranate Mask', 'Cosmetics', 'Facial Sheet Mask', 'Rorec', 'PCS', NULL, NULL, NULL, '50', '25', '6947790794020', NULL, '0000-00-00', '0', '0', '2019-04-20 00:15:12', '2019-04-20 00:15:12'),
(50, 1, 'Rorec Cucumber Mask', 'Cosmetics', 'Facial Sheet Mask', 'Rorec', 'PCS', NULL, NULL, NULL, '50', '25', '6947790789569', NULL, '0000-00-00', '0', '0', '2019-04-20 00:15:44', '2019-04-20 00:15:44'),
(51, 1, 'Rorec Aloe Vera Mask', 'Cosmetics', 'Facial Sheet Mask', 'Rorec', 'PCS', NULL, NULL, NULL, '50', '25', '6947790784847', NULL, '0000-00-00', '0', '0', '2019-04-20 00:17:57', '2019-04-20 00:17:57'),
(52, 1, 'Rorec Honey Mask', 'Cosmetics', 'Facial Sheet Mask', 'Rorec', 'PCS', NULL, NULL, NULL, '50', '25', '6947790794013', NULL, '0000-00-00', '0', '0', '2019-04-20 00:19:58', '2019-04-20 00:19:58'),
(53, 1, 'Tonymoly Lemon Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Tonymoly', NULL, NULL, NULL, NULL, '150', '50', '8806358581800', NULL, '0000-00-00', '0', '0', '2019-04-20 00:22:35', '2019-04-20 00:22:35'),
(54, 1, 'Tonymoly Tea Tree Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Tonymoly', NULL, NULL, NULL, NULL, '150', '50', '8806358581879', NULL, '0000-00-00', '0', '0', '2019-04-20 00:23:02', '2019-04-20 00:23:02'),
(55, 1, 'Tonymoly Aloe Vera Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Tonymoly', NULL, NULL, NULL, NULL, '150', '50', '8806358581831', NULL, '0000-00-00', '0', '0', '2019-04-20 00:23:46', '2019-04-20 00:23:46'),
(56, 1, 'Bioaqua Peel Off Black Mask Mini Pack', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '25', '8', '6947790790848', NULL, '0000-00-00', '0', '0', '2019-04-20 00:26:22', '2019-04-20 00:26:22'),
(57, 1, 'Bioaqua V7 Orange Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', '6947790789255', NULL, '0000-00-00', '0', '0', '2019-04-20 00:28:33', '2019-04-20 00:28:33'),
(58, 1, 'Bioaqua V7 Strawberry Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', '6947790789279', NULL, '0000-00-00', '0', '0', '2019-04-20 00:34:59', '2019-04-20 00:34:59'),
(59, 1, 'Bioaqua V7 Kiwi Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', '6947790789262', NULL, '0000-00-00', '0', '0', '2019-04-20 00:36:53', '2019-04-20 00:36:53'),
(60, 1, 'Bioaqua Egg Sheet Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '50', '25', '6947790792538', NULL, '0000-00-00', '0', '0', '2019-04-20 00:40:15', '2019-04-20 00:40:15'),
(61, 1, 'Bioaqua 3 Step Nose Strips', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '50', '25', '6947790797953', NULL, '0000-00-00', '0', '0', '2019-04-20 00:41:32', '2019-04-20 00:41:32'),
(62, 1, 'Bioaqua Maxican Daisy Deep Moisturising Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '50', '25', '6947790781204', NULL, '0000-00-00', '0', '0', '2019-04-20 00:45:01', '2019-04-20 00:45:01'),
(63, 1, 'Bioaqua Pure Skin Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', 'pureskin', NULL, '0000-00-00', '0', '0', '2019-04-20 00:45:19', '2019-04-20 00:45:19'),
(64, 1, 'Bioaqua Lip Care Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '25', '15', '6947790781099', NULL, '0000-00-00', '0', '0', '2019-04-20 00:50:08', '2019-04-20 00:50:08'),
(65, 1, 'Bioaqua Baby Skin Mask (Yellow)', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', '6947790791449', NULL, '0000-00-00', '0', '0', '2019-04-20 00:51:56', '2019-04-20 00:51:56'),
(66, 1, 'Bioaqua Ice Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '50', '25', '6947790744919', NULL, '0000-00-00', '0', '0', '2019-04-20 00:56:02', '2019-04-20 00:56:02'),
(67, 1, 'Bioaqua Lemon Mask', 'Cosmetics', 'Facial Sheet Mask', 'Bioaqua', 'PCS', NULL, NULL, NULL, '40', '20', '6947790782713', NULL, '0000-00-00', '0', '0', '2019-04-20 00:57:43', '2019-04-20 00:57:43'),
(68, 1, 'Lanbena Hyaluronic Acid Serum Mask', 'Cosmetics', 'Facial Sheet Mask', 'Lanbena', 'PCS', NULL, NULL, NULL, '60', '35', '6970470534388', NULL, '0000-00-00', '0', '0', '2019-04-20 01:04:23', '2019-04-20 01:04:23'),
(69, 1, 'Lanbena Vitamin C Serum Mask', 'Cosmetics', 'Facial Sheet Mask', 'Lanbena', 'PCS', NULL, NULL, NULL, '60', '35', '6970470534401', NULL, '0000-00-00', '0', '0', '2019-04-20 01:04:46', '2019-04-20 01:04:46'),
(70, 1, 'Lanbena Blueberry Serum Mask', 'Cosmetics', 'Facial Sheet Mask', 'Lanbena', 'PCS', NULL, NULL, NULL, '60', '35', '6970470534371', NULL, '0000-00-00', '0', '0', '2019-04-20 01:09:34', '2019-04-20 01:09:34'),
(71, 1, 'Lanbena 24K Gold Serum Mask', 'Cosmetics', 'Facial Sheet Mask', 'Lanbena', 'PCS', NULL, NULL, NULL, '60', '35', '6970470534395', NULL, '0000-00-00', '0', '0', '2019-04-20 01:11:02', '2019-04-20 01:11:02'),
(72, 1, 'Bioaqua Foot Mask', 'Cosmetics', 'Foot Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '100', '50', '6947790748955', NULL, '0000-00-00', '0', '0', '2019-04-20 01:17:40', '2019-04-20 01:17:40'),
(73, 1, 'Focallure Twilight Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-40#3', '550', '400', '6927545996022', NULL, '0000-00-00', '0', '0', '2019-04-20 06:46:06', '2019-04-20 06:46:06'),
(74, 1, 'Focallure Everchanging Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-49E', '400', '300', '6927545996336', NULL, '0000-00-00', '0', '0', '2019-04-20 06:49:37', '2019-04-20 06:49:52'),
(75, 1, 'Focallure Endless Possibilites Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-82', '1250', '800', '6927545998408', NULL, '0000-00-00', '0', '0', '2019-04-20 06:53:35', '2019-04-20 06:53:35'),
(76, 1, 'Focallure Pro Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-48', '550', '380', '6927545996329', NULL, '0000-00-00', '0', '0', '2019-04-20 06:56:04', '2019-04-20 06:58:30'),
(77, 1, 'Focallure Honey Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-40 #4', '600', '500', '6927545996879', NULL, '0000-00-00', '0', '0', '2019-04-20 06:57:57', '2019-04-20 06:57:57'),
(78, 1, 'Focallure Burning Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-50 #2', '450', '350', '6927545996039', NULL, '0000-00-00', '0', '0', '2019-04-20 07:00:48', '2019-04-20 07:00:48'),
(79, 1, 'Focallure SO HOT Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-50 #3', '450', '350', '6927545997944', NULL, '0000-00-00', '0', '0', '2019-04-20 07:01:24', '2019-04-20 07:01:24'),
(80, 1, 'Focallure 9- PAN Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA - 62 #3', '350', '300', '6927545998385', NULL, '0000-00-00', '0', '0', '2019-04-20 07:04:04', '2019-04-20 07:04:04'),
(81, 1, 'Focallure 9- PAN Eyeshadow Palette', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA - 62 #1', '350', '300', '6927545998361', NULL, '0000-00-00', '0', '0', '2019-04-20 07:05:01', '2019-04-20 07:05:01'),
(82, 1, 'Focallure Foundation', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-30', '280', '160', '3001', NULL, '0000-00-00', '0', '0', '2019-04-20 07:11:07', '2019-04-20 07:11:07'),
(83, 1, 'Focallure Foundation', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-30', '280', '160', '3002', NULL, '0000-00-00', '0', '0', '2019-04-20 07:32:09', '2019-04-20 07:32:09'),
(84, 1, 'Focallure Foundation', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-30', '280', '160', '3003', NULL, '0000-00-00', '0', '0', '2019-04-20 07:32:31', '2019-04-20 07:32:31'),
(85, 1, 'Focallure Foundation', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-30', '280', '160', '3004', NULL, '0000-00-00', '0', '0', '2019-04-20 07:32:43', '2019-04-20 07:32:43'),
(86, 1, 'Focallure Loose Powder', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-15', '220', '120', '1501', NULL, '0000-00-00', '0', '0', '2019-04-20 07:53:49', '2019-04-20 07:53:49'),
(89, 1, 'Focallure Loose Powder', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-15', '220', '120', '1502', NULL, '0000-00-00', '0', '0', '2019-04-20 07:53:57', '2019-04-20 07:53:57'),
(90, 1, 'Focallure Volume & Length Mascara', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-11', '180', '120', '6927545913104', NULL, '0000-00-00', '0', '0', '2019-04-20 08:16:32', '2019-04-20 08:16:32'),
(91, 1, 'Focallure Bomb Mascara', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-11', '200', '110', '6927545996275', NULL, '0000-00-00', '0', '0', '2019-04-20 08:18:00', '2019-04-20 08:18:00'),
(92, 1, 'Focallure Intense Eyeliner', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, NULL, 'FA-13', '200', '120', '6927545913128', NULL, '0000-00-00', '0', '0', '2019-04-21 00:00:47', '2019-04-21 00:04:55'),
(93, 1, 'Focallure Eyebrows Pen', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-18', '200', '105', '1801', NULL, '0000-00-00', '0', '0', '2019-04-21 00:11:03', '2019-04-21 00:11:03'),
(94, 1, 'Focallure Eyebrows Pen', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-18', '200', '105', '1802', NULL, '0000-00-00', '0', '0', '2019-04-21 00:11:19', '2019-04-21 00:11:19'),
(95, 1, 'Focallure Eyebrows Pen', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-18', '200', '105', '1803', NULL, '0000-00-00', '0', '0', '2019-04-21 00:11:29', '2019-04-21 00:11:29'),
(96, 1, 'Focallure Liquid Eyeshadow', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-56', '250', '140', '6927545996596', NULL, '0000-00-00', '0', '0', '2019-04-21 00:26:36', '2019-04-21 00:26:36'),
(97, 1, 'Focallure Liquid Eyeshadow', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 06', 'FA-56', '250', '140', '6927545996640', NULL, '0000-00-00', '0', '0', '2019-04-21 00:27:33', '2019-04-21 00:27:33'),
(98, 1, 'Focallure Liquid Eyeshadow', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 08', 'FA-56', '250', '140', '6927545996664', NULL, '0000-00-00', '0', '0', '2019-04-21 00:27:41', '2019-04-21 00:27:42'),
(99, 1, 'Focallure Liquid Eyeshadow', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 09', 'FA-56', '250', '140', '6927545996671', NULL, '0000-00-00', '0', '0', '2019-04-21 00:27:52', '2019-04-21 00:27:52'),
(100, 1, 'Focallure Liquid Eyeshadow', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 14', 'FA-56', '250', '140', '6927545997043', NULL, '0000-00-00', '0', '0', '2019-04-21 00:28:10', '2019-04-21 00:28:10'),
(101, 1, 'Focallure Single Blush', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'B05', 'FA-25', '200', '100', '2505', NULL, '0000-00-00', '0', '0', '2019-04-21 00:32:54', '2019-04-21 00:32:54'),
(102, 1, 'Focallure Single Blush', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'B07', 'FA-25', '200', '100', '2507', NULL, '0000-00-00', '0', '0', '2019-04-21 00:33:07', '2019-04-21 00:33:07'),
(103, 1, 'Focallure Single Blush', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'B09', 'FA-25', '200', '100', '2509', NULL, '0000-00-00', '0', '0', '2019-04-21 00:33:16', '2019-04-21 00:33:16'),
(104, 1, 'Focallure Contour Stick', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, '03 COFFEE', 'FA-01', '250', '130', '1003', NULL, '0000-00-00', '0', '0', '2019-04-21 00:50:01', '2019-04-21 00:50:01'),
(105, 1, 'Focallure Highlighter Stick', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, '01 SILVER', 'FA-01', '250', '130', '1001', NULL, '0000-00-00', '0', '0', '2019-04-21 00:51:05', '2019-04-21 00:51:05'),
(106, 1, 'Focallure Highlighter Stick', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, '02 GOLD', 'FA-01', '250', '130', '1002', NULL, '0000-00-00', '0', '0', '2019-04-21 00:51:21', '2019-04-21 00:51:21'),
(107, 1, 'Focallure Matte Primer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, NULL, 'FA-53', '350', '210', '6927545996046', NULL, '0000-00-00', '0', '0', '2019-04-21 01:06:18', '2019-04-21 01:06:18'),
(108, 1, 'Focallure Beam Highlighter', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-42', '300', '170', '4203', NULL, '0000-00-00', '0', '0', '2019-04-21 01:09:33', '2019-04-21 01:09:33'),
(109, 1, 'Focallure Beam Highlighter', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-42', '300', '170', '4204', NULL, '0000-00-00', '0', '0', '2019-04-21 01:09:44', '2019-04-21 01:09:44'),
(110, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 48', 'FA-24', '150', '95', '2448', NULL, '0000-00-00', '0', '0', '2019-04-21 02:14:42', '2019-04-21 05:20:37'),
(111, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-24', '150', '95', '2401', NULL, '0000-00-00', '0', '0', '2019-04-21 05:12:41', '2019-04-22 06:05:15'),
(112, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-24', '150', '95', '2402', NULL, '0000-00-00', '0', '0', '2019-04-21 05:12:53', '2019-04-21 05:12:53'),
(113, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-24', '150', '95', '2403', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:05', '2019-04-21 05:13:05'),
(114, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-24', '150', '95', '2404', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:14', '2019-04-25 06:42:44'),
(115, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 05', 'FA-24', '150', '95', '2405', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:24', '2019-04-21 05:13:24'),
(116, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 06', 'FA-24', '150', '95', '2406', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:38', '2019-04-21 05:13:38'),
(117, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 07', 'FA-24', '150', '95', '2407', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:47', '2019-04-21 05:13:47'),
(118, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 08', 'FA-24', '150', '95', '2408', NULL, '0000-00-00', '0', '0', '2019-04-21 05:13:56', '2019-04-21 05:13:56'),
(119, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 09', 'FA-24', '150', '95', '2409', NULL, '0000-00-00', '0', '0', '2019-04-21 05:14:10', '2019-04-21 05:14:10'),
(120, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 10', 'FA-24', '150', '95', '2410', NULL, '0000-00-00', '0', '0', '2019-04-21 05:14:21', '2019-04-21 05:14:21'),
(121, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 11', 'FA-24', '150', '95', '2411', NULL, '0000-00-00', '0', '0', '2019-04-21 05:14:32', '2019-04-21 05:14:33'),
(122, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 12', 'FA-24', '150', '95', '2412', NULL, '0000-00-00', '0', '0', '2019-04-21 05:14:43', '2019-04-21 05:14:43'),
(123, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 13', 'FA-24', '150', '95', '2413', NULL, '0000-00-00', '0', '0', '2019-04-21 05:15:22', '2019-04-25 06:42:44'),
(124, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 14', 'FA-24', '150', '95', '2414', NULL, '0000-00-00', '0', '0', '2019-04-21 05:15:34', '2019-04-25 06:42:44'),
(125, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 22', 'FA-24', '150', '95', '2422', NULL, '0000-00-00', '0', '0', '2019-04-21 05:15:47', '2019-04-21 05:15:47'),
(126, 1, 'Focallure Liquid Matte Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 24', 'FA-24', '150', '95', '2424', NULL, '0000-00-00', '0', '0', '2019-04-21 05:15:56', '2019-04-21 05:15:56'),
(127, 1, 'Focallure Pressed Powder', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-16', '300', '130', '1601', NULL, '0000-00-00', '0', '0', '2019-04-21 05:27:58', '2019-04-21 05:27:58'),
(128, 1, 'Focallure Pressed Powder', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-16', '300', '130', '1602', NULL, '0000-00-00', '0', '0', '2019-04-21 05:28:07', '2019-04-21 05:28:07'),
(129, 1, 'Focallure Eye Brows Gel Cream', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 02', 'FA-23', '200', '100', '2302', NULL, '0000-00-00', '0', '0', '2019-04-21 05:44:24', '2019-04-21 05:44:24'),
(130, 1, 'Focallure Eye Brows Gel Cream', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-23', '200', '100', '2303', NULL, '0000-00-00', '0', '0', '2019-04-21 05:44:32', '2019-04-21 05:44:32'),
(132, 1, 'Focallure Eye Brows Gel Cream', 'Makeup', 'Eyes', 'Focallure', 'PCS', NULL, 'Shade 05', 'FA-23', '200', '100', '2305', NULL, '0000-00-00', '0', '0', '2019-04-21 05:45:25', '2019-04-21 05:45:25'),
(133, 1, 'Focallure Liquid Long Lasting Concealer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 01', 'FA-52', '250', '130', '5201', NULL, '0000-00-00', '0', '0', '2019-04-21 06:01:59', '2019-04-21 06:01:59'),
(134, 1, 'Focallure Liquid Long Lasting Concealer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-52', '250', '130', '5203', NULL, '0000-00-00', '0', '0', '2019-04-21 06:02:18', '2019-04-21 06:02:18'),
(135, 1, 'Focallure Liquid Long Lasting Concealer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-52', '250', '130', '5204', NULL, '0000-00-00', '0', '0', '2019-04-21 06:02:28', '2019-04-21 06:02:28'),
(136, 1, 'Focallure Liquid Long Lasting Concealer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 05', 'FA-52', '250', '130', '5205', NULL, '0000-00-00', '0', '0', '2019-04-21 06:02:54', '2019-04-21 06:02:54'),
(137, 1, 'Focallure Liquid Long Lasting Concealer', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 07', 'FA-52', '250', '130', '5207', NULL, '0000-00-00', '0', '0', '2019-04-21 06:03:06', '2019-04-21 06:03:06'),
(138, 1, 'Focallure Stick Concealer', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-10', '200', '120', '6927545913098', NULL, '0000-00-00', '0', '0', '2019-04-21 06:28:32', '2019-04-21 06:28:32'),
(140, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 03', 'FA-57', '200', '110', '5703', NULL, '0000-00-00', '0', '0', '2019-04-21 06:33:39', '2019-04-21 06:33:39'),
(141, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-57', '200', '110', '5704', NULL, '0000-00-00', '0', '0', '2019-04-21 06:33:54', '2019-04-21 06:33:54'),
(142, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 07', 'FA-57', '200', '110', '5707', NULL, '0000-00-00', '0', '0', '2019-04-21 06:34:11', '2019-04-21 06:34:11'),
(143, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 08', 'FA-57', '200', '110', '5708', NULL, '0000-00-00', '0', '0', '2019-04-21 06:34:21', '2019-04-21 06:34:21'),
(144, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 10', 'FA-57', '200', '110', '5710', NULL, '0000-00-00', '0', '0', '2019-04-21 06:34:39', '2019-04-21 06:34:39'),
(146, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 11', 'FA-57', '200', '110', '5711', NULL, '0000-00-00', '0', '0', '2019-04-21 06:35:09', '2019-04-21 06:35:09'),
(147, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 12', 'FA-57', '200', '110', '5712', NULL, '0000-00-00', '0', '0', '2019-04-21 06:35:27', '2019-04-21 06:35:27'),
(148, 1, 'Focallure Creamy Matte Liquid Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 14', 'FA-57', '200', '110', '5714', NULL, '0000-00-00', '0', '0', '2019-04-21 06:35:50', '2019-04-21 06:35:50'),
(149, 1, 'The Original Beauty Blender', 'Makeup', 'Face', 'Allure', 'PCS', NULL, NULL, NULL, '200', '90', '713757273701', NULL, '0000-00-00', '0', '0', '2019-04-21 07:17:31', '2019-04-21 07:17:31'),
(150, 1, 'Imagic Makeup Remover', 'Makeup', 'Remover', 'Imagic', 'PCS', NULL, NULL, 'FA-113', '450', '250', '11003', NULL, '0000-00-00', '0', '0', '2019-04-21 07:20:20', '2019-04-21 07:20:20'),
(151, 1, 'Miss Rose Makeup Fixer', 'Makeup', 'Face', 'Miss Rose', 'PCS', NULL, NULL, NULL, '350', '200', '6953743340077', NULL, '0000-00-00', '0', '0', '2019-04-22 01:57:32', '2019-04-22 01:57:32'),
(152, 1, 'Beauty Artisan Cotton Mini Pack', 'Makeup', 'Remover', 'Beauty Artisan', 'PCS', NULL, NULL, NULL, '120', '80', '6947920710807', NULL, '0000-00-00', '0', '0', '2019-04-22 02:00:04', '2019-04-22 02:00:04'),
(153, 1, 'Beauty Artisan Round Cotton 60pcs', 'Makeup', 'Remover', 'Beauty Artisan', 'PCS', NULL, NULL, NULL, '150', '100', '6922608605453', NULL, '0000-00-00', '0', '0', '2019-04-22 02:01:33', '2019-04-22 02:01:33'),
(154, 1, 'Beauty Artisan Cotton 200PCS', 'Makeup', 'Remover', 'Beauty Artisan', 'PCS', NULL, NULL, NULL, '350', '200', '6922608610358', NULL, '0000-00-00', '0', '0', '2019-04-22 02:02:33', '2019-04-22 02:02:33'),
(155, 1, 'Bioaqua Makeup Remover', 'Makeup', 'Remover', 'Bioaqua', 'PCS', NULL, NULL, NULL, '300', '200', '6947790788067', NULL, '0000-00-00', '0', '0', '2019-04-22 02:04:00', '2019-04-22 02:04:00'),
(156, 1, 'Maybelline Baby Skin Primer', 'Makeup', 'Face', 'Maybelline', 'PCS', NULL, NULL, NULL, '850', '600', '041554415131', NULL, '0000-00-00', '0', '0', '2019-04-22 02:05:25', '2019-04-22 02:05:25'),
(157, 1, 'Focallure 10 PCS Brush Set', 'Makeup', 'Others', 'Focallure', 'PCS', NULL, NULL, 'FA-70#B', '900', '700', '6927545997937', NULL, '0000-00-00', '0', '0', '2019-04-22 02:09:59', '2019-04-22 02:09:59'),
(158, 1, 'Imagic 12 PCS Lip Liner Set', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, NULL, 'LP-203', '450', '280', '2030', NULL, '0000-00-00', '0', '0', '2019-04-22 02:33:42', '2019-04-22 02:33:43'),
(159, 1, 'Bioaqua Pure Skin Acne Cream', 'Cosmetics', 'Skin Care', 'Bioaqua', 'PCS', NULL, NULL, NULL, '300', '150', '15009', NULL, '0000-00-00', '0', '0', '2019-04-22 02:38:13', '2019-04-22 02:38:13'),
(160, 1, 'Focallure Foundation', 'Makeup', 'Face', 'Focallure', 'PCS', NULL, 'Shade 06', 'FA-30', '280', '160', '3006', NULL, '0000-00-00', '0', '0', '2019-04-22 05:55:35', '2019-04-22 05:55:35'),
(161, 1, 'Focallure Bullet Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 04', 'FA-34', '180', '110', '3404', NULL, '0000-00-00', '0', '0', '2019-04-22 06:31:24', '2019-04-22 06:31:24'),
(162, 1, 'Focallure Bullet Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 05', 'FA-34', '180', '110', '3405', NULL, '0000-00-00', '0', '0', '2019-04-22 06:31:34', '2019-04-22 06:32:02'),
(163, 1, 'Focallure Bullet Lipstick', 'Makeup', 'Lips', 'Focallure', 'PCS', NULL, 'Shade 06', 'FA-34', '180', '110', '3406', NULL, '0000-00-00', '0', '0', '2019-04-22 06:31:44', '2019-04-22 06:31:45'),
(164, 1, 'Focallure Bullet Lipstick', 'Makeup', '', 'Focallure', 'PCS', NULL, 'Shade 09', 'FA-34', '180', '110', '3409', NULL, '0000-00-00', '0', '0', '2019-04-22 06:32:24', '2019-04-22 06:32:24'),
(165, 1, 'Focallure Bullet Lipstick', 'Makeup', '', 'Focallure', 'PCS', NULL, 'Shade 12', 'FA-34', '180', '110', '3412', NULL, '0000-00-00', '0', '0', '2019-04-22 06:32:38', '2019-04-22 06:32:38'),
(166, 1, 'Focallure Bullet Lipstick', 'Makeup', '', 'Focallure', 'PCS', NULL, 'Shade 14', 'FA-34', '180', '110', '3414', NULL, '0000-00-00', '0', '0', '2019-04-22 06:32:54', '2019-04-22 06:32:54'),
(167, 1, 'Focallure Bullet Lipstick', 'Makeup', '', 'Focallure', 'PCS', NULL, 'Shade 17', 'FA-34', '180', '110', '3417', NULL, '0000-00-00', '0', '0', '2019-04-22 06:33:06', '2019-04-22 06:33:06'),
(168, 1, 'Focallure Bullet Lipstick', 'Makeup', '', 'Focallure', 'PCS', NULL, 'Shade 18', 'FA-34', '180', '110', '3418', NULL, '0000-00-00', '0', '0', '2019-04-22 06:33:37', '2019-04-22 06:33:37'),
(169, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Floral Blossom Girl', '150', '120', '1000000169', NULL, '0000-00-00', '0', '0', '2019-04-22 08:59:03', '2019-04-22 08:59:03'),
(170, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Death Note', '150', '120', '1000000170', NULL, '0000-00-00', '0', '0', '2019-04-22 08:59:46', '2019-04-22 08:59:46'),
(171, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Girl Boss', '150', '120', '1000000171', NULL, '0000-00-00', '0', '0', '2019-04-22 09:00:40', '2019-04-22 09:00:40'),
(172, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'PUBG', '150', '120', '1000000172', NULL, '0000-00-00', '0', '0', '2019-04-22 09:01:04', '2019-04-22 09:01:04'),
(173, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Harry Potter', '150', '120', '1000000173', NULL, '0000-00-00', '0', '0', '2019-04-22 09:01:35', '2019-04-22 09:01:35'),
(174, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Kylie Lips', '150', '120', '1000000174', NULL, '0000-00-00', '0', '0', '2019-04-22 09:02:27', '2019-04-22 09:02:28'),
(175, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'OMG', '150', '120', '1000000175', NULL, '0000-00-00', '0', '0', '2019-04-22 09:02:43', '2019-04-22 09:02:43'),
(176, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Friends', '150', '120', '1000000176', NULL, '0000-00-00', '0', '0', '2019-04-22 09:02:57', '2019-04-22 09:02:57'),
(177, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'BTS', '150', '120', '1000000177', NULL, '0000-00-00', '0', '0', '2019-04-22 09:03:12', '2019-04-22 09:03:12'),
(178, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Caderno Luxury Series', '150', '120', '1000000178', NULL, '0000-00-00', '0', '0', '2019-04-22 09:03:42', '2019-04-22 09:03:42'),
(179, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Trust No Aunty', '150', '120', '1000000179', NULL, '0000-00-00', '0', '0', '2019-04-22 09:04:02', '2019-04-22 09:04:02'),
(180, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Manchester United', '150', '120', '1000000180', NULL, '0000-00-00', '0', '0', '2019-04-22 09:04:31', '2019-04-22 09:04:31'),
(181, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Hasbiaallah', '150', '120', '1000000181', NULL, '0000-00-00', '0', '0', '2019-04-22 09:06:09', '2019-04-22 09:06:09'),
(182, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Alhamdulillah For Everything', '150', '120', '1000000182', NULL, '0000-00-00', '0', '0', '2019-04-22 09:06:36', '2019-04-22 09:06:36'),
(183, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Ghoul', '150', '120', '1000000183', NULL, '0000-00-00', '0', '0', '2019-04-22 09:06:57', '2019-04-22 09:06:57'),
(184, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Manchester City', '150', '120', '1000000184', NULL, '0000-00-00', '0', '0', '2019-04-22 09:07:17', '2019-04-22 09:07:17'),
(185, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Messi', '150', '120', '1000000185', NULL, '0000-00-00', '0', '0', '2019-04-22 09:07:35', '2019-04-22 09:07:35'),
(186, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Slay', '150', '120', '1000000186', NULL, '0000-00-00', '0', '0', '2019-04-22 09:08:02', '2019-04-22 09:08:02'),
(187, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'CR7', '150', '120', '1000000187', NULL, '0000-00-00', '0', '0', '2019-04-22 09:08:56', '2019-04-22 09:08:56'),
(188, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Van Gough Series (Almond Blossom)', '150', '120', '1000000188', NULL, '0000-00-00', '0', '0', '2019-04-22 09:09:16', '2019-04-22 09:09:16'),
(189, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Chelsea FC', '150', '120', '1000000189', NULL, '0000-00-00', '0', '0', '2019-04-22 09:09:48', '2019-04-22 09:09:48'),
(190, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Who Run The World', '150', '120', '1000000190', NULL, '0000-00-00', '0', '0', '2019-04-22 09:10:28', '2019-04-22 09:10:28'),
(191, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Liverpool FC', '150', '120', '1000000191', NULL, '0000-00-00', '0', '0', '2019-04-22 09:11:03', '2019-04-22 09:11:03'),
(192, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Blossom Series Black', '150', '120', '1000000192', NULL, '0000-00-00', '0', '0', '2019-04-22 09:11:30', '2019-04-22 09:11:30'),
(193, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Lipstick', '150', '120', '1000000193', NULL, '0000-00-00', '0', '0', '2019-04-22 09:12:09', '2019-04-22 09:12:09'),
(194, 1, 'Caderno Notebook', 'Notebooks', 'Small Notebooks', 'Caderno Bangladesh', 'PCS', '5.5″ x 8.5″', NULL, 'Banana', '150', '120', '1000000194', NULL, '0000-00-00', '0', '0', '2019-04-22 09:12:19', '2019-04-22 09:12:19'),
(195, 1, 'Caderno Notebook', 'Notebooks', 'Large Notebook', 'Caderno Bangladesh', 'PCS', '8″ x 10.5', NULL, 'Breaking Bad', '250', '200', '1000000195', NULL, '0000-00-00', '0', '0', '2019-04-22 09:23:50', '2019-04-22 09:23:50'),
(196, 1, 'Caderno Notebook', 'Notebooks', 'Large Notebook', 'Caderno Bangladesh', 'PCS', '8″ x 10.5', NULL, 'Game of thrones', '250', '200', '1000000196', NULL, '0000-00-00', '0', '0', '2019-04-22 09:24:22', '2019-04-22 09:24:22'),
(197, 1, 'Caderno Notebook', 'Notebooks', 'Large Notebook', 'Caderno Bangladesh', 'PCS', '8″ x 10.5', NULL, 'BATMAN', '250', '200', '1000000197', NULL, '0000-00-00', '0', '0', '2019-04-22 09:24:44', '2019-04-22 09:24:44'),
(198, 1, 'Caderno Notebook', 'Notebooks', 'Large Notebook', 'Caderno Bangladesh', 'PCS', '8″ x 10.5', NULL, 'Sharlock', '250', '200', '1000000198', NULL, '0000-00-00', '0', '0', '2019-04-22 09:25:31', '2019-04-22 09:25:31'),
(199, 1, 'Caderno Notebook', 'Notebooks', 'Large Notebook', 'Caderno Bangladesh', 'PCS', '8″ x 10.5', NULL, 'How I met your mother', '250', '200', '1000000199', NULL, '0000-00-00', '0', '0', '2019-04-22 09:25:43', '2019-04-22 09:25:43'),
(200, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Denim', 'M1', '650', '300', '1036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:02:45', '2019-04-23 23:02:45'),
(201, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Black', 'M1', '650', '300', '2035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:03:28', '2019-04-23 23:03:28'),
(202, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Black', 'M1', '650', '300', '2036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:04:22', '2019-04-23 23:04:22'),
(203, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Black', 'M1', '650', '300', '2038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:05:27', '2019-04-23 23:05:27'),
(204, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Black', 'M1', '650', '300', '2039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:06:01', '2019-04-23 23:06:01'),
(205, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Black', 'M1', '650', '300', '2040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:06:34', '2019-04-23 23:06:34'),
(206, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Yellow', 'M1', '650', '300', '3035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:07:13', '2019-04-23 23:07:13'),
(207, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Yellow', 'M1', '650', '300', '3036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:07:56', '2019-04-23 23:07:56'),
(208, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Yellow', 'M1', '650', '300', '3037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:08:11', '2019-04-24 07:39:54'),
(209, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Yellow', 'M1', '650', '300', '3038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:08:25', '2019-04-23 23:08:25'),
(210, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Yellow', 'M1', '650', '300', '3039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:09:03', '2019-04-23 23:09:03'),
(211, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Yellow', 'M1', '650', '300', '3040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:09:47', '2019-04-23 23:09:47'),
(212, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'White', 'M1', '650', '300', '4035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:10:23', '2019-04-23 23:10:39'),
(213, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'White', 'M1', '650', '300', '4036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:11:03', '2019-04-23 23:11:03'),
(214, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'White', 'M1', '650', '300', '4037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:12:03', '2019-04-23 23:12:03'),
(215, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'White', 'M1', '650', '300', '4038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:12:45', '2019-04-23 23:12:45'),
(216, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'White', 'M1', '650', '300', '4039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:13:07', '2019-04-23 23:13:07'),
(217, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'White', 'M1', '650', '300', '4040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:13:30', '2019-04-23 23:13:30'),
(218, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Light Pink', 'M1', '650', '300', '5035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:14:16', '2019-04-23 23:14:16'),
(219, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Light Pink', 'M1', '650', '300', '5036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:14:59', '2019-04-23 23:14:59'),
(220, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Light Pink', 'M1', '650', '300', '5037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:15:24', '2019-04-23 23:15:24'),
(221, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Light Pink', 'M1', '650', '300', '5039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:16:24', '2019-04-23 23:16:36'),
(222, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Light Pink', 'M1', '650', '300', '5040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:16:57', '2019-04-23 23:16:57'),
(223, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Denim', 'M2', '700', '300', '6035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:23:58', '2019-04-23 23:23:58'),
(224, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Denim', 'M2', '700', '300', '6036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:24:38', '2019-04-23 23:24:38'),
(225, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Denim', 'M2', '700', '300', '6037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:25:31', '2019-04-23 23:25:31'),
(226, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Denim', 'M2', '700', '300', '6038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:25:40', '2019-04-23 23:25:40'),
(227, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Denim', 'M2', '700', '300', '6039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:26:29', '2019-04-23 23:26:29'),
(228, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Denim', 'M2', '700', '300', '6040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:26:37', '2019-04-23 23:26:37'),
(229, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Black', 'M2', '700', '300', '7035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:27:33', '2019-04-23 23:27:33'),
(230, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Black', 'M2', '700', '300', '7036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:28:11', '2019-04-23 23:28:11'),
(231, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Black', 'M2', '700', '300', '7039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:29:20', '2019-04-23 23:29:20'),
(232, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Black', 'M2', '700', '300', '7040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:29:48', '2019-04-23 23:29:48'),
(233, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Yellow', 'M2', '700', '300', '8035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:30:22', '2019-04-23 23:30:22'),
(234, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Yellow', 'M2', '700', '300', '8037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:30:57', '2019-04-23 23:30:57'),
(235, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Yellow', 'M2', '700', '300', '8038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:31:16', '2019-04-23 23:31:16'),
(236, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Yellow', 'M2', '700', '300', '8039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:31:44', '2019-04-23 23:31:44'),
(237, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Yellow', 'M2', '700', '300', '8040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:31:52', '2019-04-23 23:31:52'),
(238, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'White', 'M2', '700', '300', '9035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:32:20', '2019-04-23 23:32:20'),
(239, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'White', 'M2', '700', '300', '9036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:32:55', '2019-04-23 23:32:55'),
(240, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'White', 'M2', '700', '300', '9037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:33:04', '2019-04-23 23:33:04'),
(241, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'White', 'M2', '700', '300', '9038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:33:17', '2019-04-23 23:33:17'),
(242, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'White', 'M2', '700', '300', '9039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:33:47', '2019-04-23 23:33:47'),
(243, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'White', 'M2', '700', '300', '9040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:34:10', '2019-04-23 23:34:10'),
(244, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Light Pink', 'M2', '700', '300', '10035', NULL, '0000-00-00', '0', '0', '2019-04-23 23:34:50', '2019-04-23 23:34:50');
INSERT INTO `products` (`id`, `admin_id`, `productName`, `groupName`, `catName`, `brand`, `unit`, `size`, `color`, `model`, `sellingPrice`, `averageBuyingPrice`, `barCode`, `productImage`, `date`, `openingQuantity`, `openingUnitPrice`, `created_at`, `updated_at`) VALUES
(245, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Light Pink', 'M2', '700', '300', '10036', NULL, '0000-00-00', '0', '0', '2019-04-23 23:35:14', '2019-04-23 23:35:14'),
(246, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Light Pink', 'M2', '700', '300', '10037', NULL, '0000-00-00', '0', '0', '2019-04-23 23:35:27', '2019-04-23 23:35:27'),
(247, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Light Pink', 'M2', '700', '300', '10038', NULL, '0000-00-00', '0', '0', '2019-04-23 23:35:44', '2019-04-23 23:35:44'),
(248, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '39', 'Light Pink', 'M2', '700', '300', '10039', NULL, '0000-00-00', '0', '0', '2019-04-23 23:36:13', '2019-04-23 23:36:13'),
(249, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Light Pink', 'M2', '700', '300', '10040', NULL, '0000-00-00', '0', '0', '2019-04-23 23:36:35', '2019-04-23 23:36:35'),
(250, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Denim', 'M1', '650', '300', '1035', NULL, '0000-00-00', '0', '0', '2019-04-24 03:20:54', '2019-04-24 03:20:54'),
(251, 1, 'Ladies Fashionable Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '40', 'Denim', 'M1', '650', '300', '1040', NULL, '0000-00-00', '0', '0', '2019-04-24 03:21:16', '2019-04-24 03:21:16'),
(252, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 02', 'LP-202', '200', '130', '20202', NULL, '0000-00-00', '0', '0', '2019-04-24 08:02:43', '2019-04-24 08:02:43'),
(253, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 05', 'LP-202', '200', '130', '20205', NULL, '0000-00-00', '0', '0', '2019-04-24 08:03:00', '2019-04-24 08:03:00'),
(254, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 10', 'LP-202', '200', '130', '20210', NULL, '0000-00-00', '0', '0', '2019-04-24 08:03:16', '2019-04-24 08:03:16'),
(255, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 11', 'LP-202', '200', '130', '20211', NULL, '0000-00-00', '0', '0', '2019-04-24 08:03:37', '2019-04-24 08:03:37'),
(256, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 12', 'LP-202', '200', '130', '20212', NULL, '0000-00-00', '0', '0', '2019-04-24 08:03:49', '2019-04-24 08:03:49'),
(257, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 17', 'LP-202', '200', '130', '20217', NULL, '0000-00-00', '0', '0', '2019-04-24 08:04:05', '2019-04-24 08:04:05'),
(258, 1, 'Imagic Liquid Matte Lipstick', 'Makeup', 'Lips', 'Imagic', 'PCS', NULL, 'Shade 18', 'LP-202', '200', '130', '20218', NULL, '0000-00-00', '0', '0', '2019-04-24 08:04:28', '2019-04-24 08:04:28'),
(259, 1, 'NSPA Shower Scrub', 'Cosmetics', 'Body Care', 'NSPA', 'PCS', NULL, NULL, '5060080912919', '750', '700', '5060080912919', NULL, '0000-00-00', '0', '0', '2019-04-24 08:35:35', '2019-04-24 08:35:35');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `profit` int(11) DEFAULT NULL,
  `unitPrice` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `hasReturned` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `admin_id`, `invoice_id`, `product_id`, `quantity`, `profit`, `unitPrice`, `date`, `hasReturned`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 1, 14, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:00:39', '2019-04-15 02:00:39'),
(2, 1, 0, 2, 13, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:16:06', '2019-04-15 02:16:06'),
(3, 1, 0, 3, 12, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:17:34', '2019-04-15 02:17:34'),
(4, 1, 0, 4, 12, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:18:15', '2019-04-15 02:18:15'),
(5, 1, 0, 5, 14, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:19:46', '2019-04-15 02:19:46'),
(6, 1, 0, 6, 10, NULL, 310.00, '2019-04-15', 0, '2019-04-15 02:22:46', '2019-04-15 02:22:46'),
(7, 1, 0, 7, 10, NULL, 270.00, '2019-04-15', 0, '2019-04-15 02:27:30', '2019-04-15 02:27:30'),
(8, 1, 0, 8, 8, NULL, 270.00, '2019-04-15', 0, '2019-04-15 02:28:21', '2019-04-15 02:28:21'),
(9, 1, 0, 9, 11, NULL, 260.00, '2019-04-15', 0, '2019-04-15 02:36:21', '2019-04-15 02:36:21'),
(10, 1, 0, 10, 11, NULL, 165.00, '2019-04-15', 0, '2019-04-15 02:38:25', '2019-04-15 02:38:25'),
(11, 1, 0, 11, 20, NULL, 160.00, '2019-04-15', 0, '2019-04-15 02:41:00', '2019-04-15 02:41:00'),
(12, 1, 0, 12, 4, NULL, 135.00, '2019-04-15', 0, '2019-04-15 03:32:10', '2019-04-15 03:32:10'),
(13, 1, 0, 13, 21, NULL, 260.00, '2019-04-15', 0, '2019-04-15 03:32:59', '2019-04-15 03:32:59'),
(14, 1, 0, 14, 2, NULL, 240.00, '2019-04-15', 0, '2019-04-15 03:34:13', '2019-04-15 03:34:13'),
(15, 1, 0, 15, 2, NULL, 240.00, '2019-04-15', 0, '2019-04-15 03:36:16', '2019-04-15 03:36:16'),
(16, 1, 0, 16, 22, NULL, 210.00, '2019-04-15', 0, '2019-04-15 03:42:45', '2019-04-15 03:42:45'),
(17, 1, 1, 16, 6, NULL, 210.00, '2019-04-15', 0, '2019-04-15 03:46:53', '2019-04-15 03:46:53'),
(18, 1, 0, 17, 3, NULL, 250.00, '2019-04-15', 0, '2019-04-15 03:55:03', '2019-04-15 03:55:03'),
(19, 1, 0, 18, 3, NULL, 260.00, '2019-04-15', 0, '2019-04-15 03:55:55', '2019-04-15 03:55:55'),
(20, 1, 0, 19, 37, NULL, 120.00, '2019-04-18', 0, '2019-04-18 05:53:52', '2019-04-18 05:53:52'),
(21, 1, 0, 20, 23, NULL, 120.00, '2019-04-18', 0, '2019-04-18 05:57:48', '2019-04-18 05:57:48'),
(22, 1, 0, 21, 24, NULL, 120.00, '2019-04-18', 0, '2019-04-18 06:03:32', '2019-04-18 06:03:32'),
(23, 1, 0, 22, 5, NULL, 130.00, '2019-04-18', 0, '2019-04-18 06:05:32', '2019-04-18 06:05:32'),
(24, 1, 0, 23, 7, NULL, 150.00, '2019-04-18', 0, '2019-04-18 06:06:25', '2019-04-18 06:06:25'),
(25, 1, 0, 24, 11, NULL, 110.00, '2019-04-18', 0, '2019-04-18 06:16:23', '2019-04-18 06:16:23'),
(26, 1, 0, 25, 13, NULL, 180.00, '2019-04-18', 0, '2019-04-18 06:20:18', '2019-04-18 06:20:18'),
(27, 1, 0, 26, 4, NULL, 110.00, '2019-04-18', 0, '2019-04-18 06:21:50', '2019-04-18 06:21:50'),
(28, 1, 0, 27, 4, NULL, 110.00, '2019-04-18', 0, '2019-04-18 06:24:13', '2019-04-18 06:24:13'),
(29, 1, 0, 28, 5, NULL, 300.00, '2019-04-18', 0, '2019-04-18 06:28:44', '2019-04-18 06:28:44'),
(30, 1, 0, 29, 32, NULL, 90.00, '2019-04-18', 0, '2019-04-18 06:38:59', '2019-04-18 06:38:59'),
(31, 1, 0, 30, 19, NULL, 90.00, '2019-04-18', 0, '2019-04-18 06:42:34', '2019-04-18 06:42:34'),
(32, 1, 0, 31, 23, NULL, 150.00, '2019-04-18', 0, '2019-04-18 06:48:59', '2019-04-18 06:48:59'),
(33, 1, 0, 32, 16, NULL, 190.00, '2019-04-18', 0, '2019-04-18 07:14:54', '2019-04-18 07:14:54'),
(34, 1, 0, 33, 22, NULL, 150.00, '2019-04-18', 0, '2019-04-18 07:41:04', '2019-04-18 07:41:04'),
(35, 1, 0, 34, 20, NULL, 150.00, '2019-04-18', 0, '2019-04-18 07:44:45', '2019-04-18 07:44:45'),
(36, 1, 0, 35, 10, NULL, 160.00, '2019-04-18', 0, '2019-04-18 07:47:10', '2019-04-18 07:47:10'),
(37, 1, 0, 36, 5, NULL, 150.00, '2019-04-18', 0, '2019-04-18 07:51:45', '2019-04-18 07:51:45'),
(38, 1, 0, 37, 11, NULL, 150.00, '2019-04-18', 0, '2019-04-18 07:57:44', '2019-04-18 07:57:44'),
(39, 1, 0, 38, 6, NULL, 150.00, '2019-04-18', 0, '2019-04-18 08:00:16', '2019-04-18 08:00:16'),
(40, 1, 0, 39, 18, NULL, 140.00, '2019-04-18', 0, '2019-04-18 08:02:30', '2019-04-18 08:02:30'),
(41, 1, 0, 40, 15, NULL, 150.00, '2019-04-18', 0, '2019-04-18 08:04:35', '2019-04-18 08:04:35'),
(42, 1, 0, 41, 9, NULL, 1100.00, '2019-04-19', 0, '2019-04-19 08:18:06', '2019-04-19 08:18:06'),
(43, 1, 0, 42, 21, NULL, 260.00, '2019-04-20', 0, '2019-04-19 23:49:59', '2019-04-19 23:49:59'),
(44, 1, 0, 43, 4, NULL, 150.00, '2019-04-20', 0, '2019-04-19 23:55:05', '2019-04-19 23:55:05'),
(45, 1, 0, 44, 14, NULL, 100.00, '2019-04-20', 0, '2019-04-19 23:56:09', '2019-04-19 23:56:09'),
(46, 1, 0, 45, 7, NULL, 200.00, '2019-04-20', 0, '2019-04-19 23:58:00', '2019-04-19 23:58:00'),
(47, 1, 0, 46, 4, NULL, 150.00, '2019-04-20', 0, '2019-04-19 23:58:52', '2019-04-19 23:58:52'),
(48, 1, 0, 47, 261, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:07:08', '2019-04-20 00:07:08'),
(49, 1, 0, 48, 49, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:11:07', '2019-04-20 00:11:07'),
(50, 1, 0, 49, 152, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:15:12', '2019-04-20 00:15:12'),
(51, 1, 0, 50, 75, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:15:44', '2019-04-20 00:15:44'),
(52, 1, 0, 51, 154, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:17:57', '2019-04-20 00:17:57'),
(53, 1, 0, 52, 51, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:19:58', '2019-04-20 00:19:58'),
(54, 1, 0, 53, 7, NULL, 50.00, '2019-04-20', 0, '2019-04-20 00:22:35', '2019-04-20 00:22:35'),
(55, 1, 0, 54, 13, NULL, 50.00, '2019-04-20', 0, '2019-04-20 00:23:02', '2019-04-20 00:23:02'),
(56, 1, 0, 55, 7, NULL, 50.00, '2019-04-20', 0, '2019-04-20 00:23:47', '2019-04-20 00:23:47'),
(57, 1, 0, 56, 121, NULL, 8.00, '2019-04-20', 0, '2019-04-20 00:26:22', '2019-04-20 00:26:22'),
(58, 1, 0, 57, 91, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:28:33', '2019-04-20 00:28:33'),
(59, 1, 0, 58, 50, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:34:59', '2019-04-20 00:34:59'),
(60, 1, 0, 59, 92, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:36:53', '2019-04-20 00:36:53'),
(61, 1, 0, 60, 47, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:40:15', '2019-04-20 00:40:15'),
(62, 1, 0, 61, 116, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:41:32', '2019-04-20 00:41:32'),
(63, 1, 0, 62, 37, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:45:01', '2019-04-20 00:45:01'),
(64, 1, 0, 63, 100, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:45:19', '2019-04-20 00:45:19'),
(65, 1, 0, 64, 73, NULL, 15.00, '2019-04-20', 0, '2019-04-20 00:50:08', '2019-04-20 00:50:08'),
(66, 1, 0, 65, 14, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:51:56', '2019-04-20 00:51:56'),
(67, 1, 0, 66, 190, NULL, 25.00, '2019-04-20', 0, '2019-04-20 00:56:02', '2019-04-20 00:56:02'),
(68, 1, 0, 67, 77, NULL, 20.00, '2019-04-20', 0, '2019-04-20 00:57:43', '2019-04-20 00:57:43'),
(69, 1, 0, 68, 33, NULL, 35.00, '2019-04-20', 0, '2019-04-20 01:04:23', '2019-04-20 01:04:23'),
(70, 1, 0, 69, 21, NULL, 35.00, '2019-04-20', 0, '2019-04-20 01:04:46', '2019-04-20 01:04:46'),
(71, 1, 0, 70, 33, NULL, 35.00, '2019-04-20', 0, '2019-04-20 01:09:34', '2019-04-20 01:09:34'),
(72, 1, 0, 71, 30, NULL, 35.00, '2019-04-20', 0, '2019-04-20 01:11:02', '2019-04-20 01:11:02'),
(73, 1, 0, 72, 14, NULL, 50.00, '2019-04-20', 0, '2019-04-20 01:17:40', '2019-04-20 01:17:40'),
(74, 1, 0, 73, 8, NULL, 400.00, '2019-04-20', 0, '2019-04-20 06:46:07', '2019-04-20 06:46:07'),
(75, 1, 0, 74, 9, NULL, 300.00, '2019-04-20', 0, '2019-04-20 06:49:37', '2019-04-20 06:49:37'),
(76, 1, 0, 75, 6, NULL, 800.00, '2019-04-20', 0, '2019-04-20 06:53:35', '2019-04-20 06:53:35'),
(77, 1, 0, 76, 4, NULL, 380.00, '2019-04-20', 0, '2019-04-20 06:56:04', '2019-04-20 06:56:04'),
(78, 1, 0, 77, 29, NULL, 500.00, '2019-04-20', 0, '2019-04-20 06:57:57', '2019-04-20 06:57:57'),
(79, 1, 0, 78, 10, NULL, 350.00, '2019-04-20', 0, '2019-04-20 07:00:48', '2019-04-20 07:00:48'),
(80, 1, 0, 79, 6, NULL, 350.00, '2019-04-20', 0, '2019-04-20 07:01:24', '2019-04-20 07:01:24'),
(81, 1, 0, 80, 6, NULL, 300.00, '2019-04-20', 0, '2019-04-20 07:04:04', '2019-04-20 07:04:04'),
(82, 1, 0, 81, 11, NULL, 300.00, '2019-04-20', 0, '2019-04-20 07:05:01', '2019-04-20 07:05:01'),
(83, 1, 0, 82, 16, NULL, 160.00, '2019-04-20', 0, '2019-04-20 07:11:07', '2019-04-20 07:11:07'),
(84, 1, 0, 83, 20, NULL, 160.00, '2019-04-20', 0, '2019-04-20 07:32:09', '2019-04-20 07:32:09'),
(85, 1, 0, 84, 4, NULL, 160.00, '2019-04-20', 0, '2019-04-20 07:32:31', '2019-04-20 07:32:31'),
(86, 1, 0, 85, 1, NULL, 160.00, '2019-04-20', 0, '2019-04-20 07:32:43', '2019-04-20 07:32:43'),
(87, 1, 0, 86, 0, NULL, 0.00, '2019-04-20', 0, '2019-04-20 07:32:56', '2019-04-20 07:32:56'),
(88, 1, 0, 87, 19, NULL, 160.00, '2019-04-20', 0, '2019-04-20 07:33:09', '2019-04-20 07:33:09'),
(89, 1, 0, 88, 10, NULL, 120.00, '2019-04-20', 0, '2019-04-20 07:53:49', '2019-04-20 07:53:49'),
(90, 1, 0, 89, 17, NULL, 120.00, '2019-04-20', 0, '2019-04-20 07:53:57', '2019-04-20 07:53:57'),
(91, 1, 0, 90, 10, NULL, 120.00, '2019-04-20', 0, '2019-04-20 08:16:32', '2019-04-20 08:16:32'),
(92, 1, 0, 91, 14, NULL, 110.00, '2019-04-20', 0, '2019-04-20 08:18:00', '2019-04-20 08:18:00'),
(93, 1, 0, 92, 13, NULL, 120.00, '2019-04-21', 0, '2019-04-21 00:00:47', '2019-04-21 00:00:47'),
(94, 1, 0, 93, 15, NULL, 105.00, '2019-04-21', 0, '2019-04-21 00:11:03', '2019-04-21 00:11:03'),
(95, 1, 0, 94, 11, NULL, 105.00, '2019-04-21', 0, '2019-04-21 00:11:19', '2019-04-21 00:11:19'),
(96, 1, 0, 95, 14, NULL, 105.00, '2019-04-21', 0, '2019-04-21 00:11:29', '2019-04-21 00:11:29'),
(97, 1, 0, 96, 1, NULL, 140.00, '2019-04-21', 0, '2019-04-21 00:26:36', '2019-04-21 00:26:36'),
(98, 1, 0, 97, 3, NULL, 140.00, '2019-04-21', 0, '2019-04-21 00:27:33', '2019-04-21 00:27:33'),
(99, 1, 0, 98, 2, NULL, 140.00, '2019-04-21', 0, '2019-04-21 00:27:42', '2019-04-21 00:27:42'),
(100, 1, 0, 99, 1, NULL, 140.00, '2019-04-21', 0, '2019-04-21 00:27:52', '2019-04-21 00:27:52'),
(101, 1, 0, 100, 4, NULL, 140.00, '2019-04-21', 0, '2019-04-21 00:28:10', '2019-04-21 00:28:10'),
(102, 1, 0, 101, 2, NULL, 100.00, '2019-04-21', 0, '2019-04-21 00:32:54', '2019-04-21 00:32:54'),
(103, 1, 0, 102, 13, NULL, 100.00, '2019-04-21', 0, '2019-04-21 00:33:07', '2019-04-21 00:33:07'),
(104, 1, 0, 103, 8, NULL, 100.00, '2019-04-21', 0, '2019-04-21 00:33:16', '2019-04-21 00:33:16'),
(105, 1, 0, 104, 4, NULL, 130.00, '2019-04-21', 0, '2019-04-21 00:50:01', '2019-04-21 00:50:01'),
(106, 1, 0, 105, 5, NULL, 130.00, '2019-04-21', 0, '2019-04-21 00:51:05', '2019-04-21 00:51:05'),
(107, 1, 0, 106, 8, NULL, 130.00, '2019-04-21', 0, '2019-04-21 00:51:21', '2019-04-21 00:51:21'),
(108, 1, 0, 107, 5, NULL, 210.00, '2019-04-21', 0, '2019-04-21 01:06:18', '2019-04-21 01:06:18'),
(109, 1, 0, 108, 1, NULL, 170.00, '2019-04-21', 0, '2019-04-21 01:09:33', '2019-04-21 01:09:33'),
(110, 1, 0, 109, 11, NULL, 170.00, '2019-04-21', 0, '2019-04-21 01:09:44', '2019-04-21 01:09:44'),
(111, 1, 0, 110, 5, NULL, 95.00, '2019-04-21', 0, '2019-04-21 02:14:42', '2019-04-21 02:14:42'),
(112, 1, 0, 111, 4, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:12:41', '2019-04-21 05:12:41'),
(113, 1, 0, 112, 29, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:12:53', '2019-04-21 05:12:53'),
(114, 1, 0, 113, 39, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:05', '2019-04-21 05:13:05'),
(115, 1, 0, 114, 20, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:15', '2019-04-21 05:13:15'),
(116, 1, 0, 115, 42, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:24', '2019-04-21 05:13:24'),
(117, 1, 0, 116, 14, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:38', '2019-04-21 05:13:38'),
(118, 1, 0, 117, 7, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:47', '2019-04-21 05:13:47'),
(119, 1, 0, 118, 10, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:13:56', '2019-04-21 05:13:56'),
(120, 1, 0, 119, 11, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:14:10', '2019-04-21 05:14:10'),
(121, 1, 0, 120, 6, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:14:21', '2019-04-21 05:14:21'),
(122, 1, 0, 121, 12, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:14:33', '2019-04-21 05:14:33'),
(123, 1, 0, 122, 35, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:14:43', '2019-04-21 05:14:43'),
(124, 1, 0, 123, 25, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:15:22', '2019-04-21 05:15:22'),
(125, 1, 0, 124, 19, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:15:34', '2019-04-21 05:15:34'),
(126, 1, 0, 125, 14, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:15:47', '2019-04-21 05:15:47'),
(127, 1, 0, 126, 9, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:15:56', '2019-04-21 05:15:56'),
(128, 1, 15, 110, 13, NULL, 95.00, '2019-04-21', 0, '2019-04-21 05:20:37', '2019-04-21 05:20:37'),
(129, 1, 0, 127, 11, NULL, 130.00, '2019-04-21', 0, '2019-04-21 05:27:58', '2019-04-21 05:27:58'),
(130, 1, 0, 128, 19, NULL, 130.00, '2019-04-21', 0, '2019-04-21 05:28:07', '2019-04-21 05:28:07'),
(131, 1, 0, 129, 4, NULL, 100.00, '2019-04-21', 0, '2019-04-21 05:44:24', '2019-04-21 05:44:24'),
(132, 1, 0, 130, 12, NULL, 100.00, '2019-04-21', 0, '2019-04-21 05:44:32', '2019-04-21 05:44:32'),
(133, 1, 0, 131, 13, NULL, 100.00, '2019-04-21', 0, '2019-04-21 05:44:54', '2019-04-21 05:44:54'),
(134, 1, 0, 132, 14, NULL, 100.00, '2019-04-21', 0, '2019-04-21 05:45:25', '2019-04-21 05:45:25'),
(135, 1, 0, 133, 5, NULL, 130.00, '2019-04-21', 0, '2019-04-21 06:01:59', '2019-04-21 06:01:59'),
(136, 1, 0, 134, 8, NULL, 130.00, '2019-04-21', 0, '2019-04-21 06:02:18', '2019-04-21 06:02:18'),
(137, 1, 0, 135, 10, NULL, 130.00, '2019-04-21', 0, '2019-04-21 06:02:28', '2019-04-21 06:02:28'),
(138, 1, 0, 136, 16, NULL, 130.00, '2019-04-21', 0, '2019-04-21 06:02:54', '2019-04-21 06:02:54'),
(139, 1, 0, 137, 6, NULL, 130.00, '2019-04-21', 0, '2019-04-21 06:03:06', '2019-04-21 06:03:06'),
(140, 1, 0, 138, 11, NULL, 120.00, '2019-04-21', 0, '2019-04-21 06:28:33', '2019-04-21 06:28:33'),
(141, 1, 0, 139, 0, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:33:12', '2019-04-21 06:33:12'),
(142, 1, 0, 140, 4, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:33:39', '2019-04-21 06:33:39'),
(143, 1, 0, 141, 6, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:33:54', '2019-04-21 06:33:54'),
(144, 1, 0, 142, 1, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:34:11', '2019-04-21 06:34:11'),
(145, 1, 0, 143, 12, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:34:21', '2019-04-21 06:34:21'),
(146, 1, 0, 144, 15, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:34:39', '2019-04-21 06:34:39'),
(147, 1, 0, 145, 18, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:34:55', '2019-04-21 06:34:55'),
(148, 1, 0, 146, 19, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:35:09', '2019-04-21 06:35:09'),
(149, 1, 0, 147, 16, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:35:27', '2019-04-21 06:35:27'),
(150, 1, 0, 148, 12, NULL, 110.00, '2019-04-21', 0, '2019-04-21 06:35:50', '2019-04-21 06:35:50'),
(151, 1, 0, 149, 8, NULL, 90.00, '2019-04-21', 0, '2019-04-21 07:17:31', '2019-04-21 07:17:31'),
(152, 1, 0, 150, 21, NULL, 250.00, '2019-04-21', 0, '2019-04-21 07:20:20', '2019-04-21 07:20:20'),
(153, 1, 0, 151, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 01:57:33', '2019-04-22 01:57:33'),
(154, 1, 0, 152, 5, NULL, 80.00, '2019-04-22', 0, '2019-04-22 02:00:05', '2019-04-22 02:00:05'),
(155, 1, 0, 153, 4, NULL, 100.00, '2019-04-22', 0, '2019-04-22 02:01:33', '2019-04-22 02:01:33'),
(156, 1, 0, 154, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 02:02:33', '2019-04-22 02:02:33'),
(157, 1, 0, 155, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 02:04:00', '2019-04-22 02:04:00'),
(158, 1, 0, 156, 5, NULL, 600.00, '2019-04-22', 0, '2019-04-22 02:05:25', '2019-04-22 02:05:25'),
(159, 1, 0, 157, 16, NULL, 700.00, '2019-04-22', 0, '2019-04-22 02:09:59', '2019-04-22 02:09:59'),
(160, 1, 0, 158, 7, NULL, 280.00, '2019-04-22', 0, '2019-04-22 02:33:43', '2019-04-22 02:33:43'),
(161, 1, 0, 159, 14, NULL, 150.00, '2019-04-22', 0, '2019-04-22 02:38:13', '2019-04-22 02:38:13'),
(162, 1, 0, 160, 19, NULL, 160.00, '2019-04-22', 0, '2019-04-22 05:55:35', '2019-04-22 05:55:35'),
(164, 1, 0, 161, 3, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:31:24', '2019-04-22 06:31:24'),
(165, 1, 0, 162, 23, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:31:34', '2019-04-22 06:31:34'),
(166, 1, 0, 163, 1, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:31:45', '2019-04-22 06:31:45'),
(167, 1, 0, 164, 15, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:32:24', '2019-04-22 06:32:24'),
(168, 1, 0, 165, 2, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:32:38', '2019-04-22 06:32:38'),
(169, 1, 0, 166, 14, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:32:54', '2019-04-22 06:32:54'),
(170, 1, 0, 167, 10, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:33:06', '2019-04-22 06:33:06'),
(171, 1, 0, 168, 15, NULL, 110.00, '2019-04-22', 0, '2019-04-22 06:33:37', '2019-04-22 06:33:37'),
(172, 1, 0, 169, 38, NULL, 120.00, '2019-04-22', 0, '2019-04-22 08:59:03', '2019-04-22 08:59:03'),
(173, 1, 0, 170, 12, NULL, 120.00, '2019-04-22', 0, '2019-04-22 08:59:46', '2019-04-22 08:59:46'),
(174, 1, 0, 171, 21, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:00:40', '2019-04-22 09:00:40'),
(175, 1, 0, 172, 7, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:01:05', '2019-04-22 09:01:05'),
(176, 1, 0, 173, 29, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:01:35', '2019-04-22 09:01:35'),
(177, 1, 0, 174, 17, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:02:28', '2019-04-22 09:02:28'),
(178, 1, 0, 175, 32, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:02:43', '2019-04-22 09:02:43'),
(179, 1, 0, 176, 17, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:02:57', '2019-04-22 09:02:57'),
(180, 1, 0, 177, 7, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:03:12', '2019-04-22 09:03:12'),
(181, 1, 0, 178, 7, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:03:42', '2019-04-22 09:03:42'),
(182, 1, 0, 179, 9, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:04:02', '2019-04-22 09:04:02'),
(183, 1, 0, 180, 5, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:04:31', '2019-04-22 09:04:31'),
(184, 1, 0, 181, 7, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:06:09', '2019-04-22 09:06:09'),
(185, 1, 0, 182, 9, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:06:36', '2019-04-22 09:06:36'),
(186, 1, 0, 183, 6, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:06:57', '2019-04-22 09:06:57'),
(187, 1, 0, 184, 5, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:07:17', '2019-04-22 09:07:17'),
(188, 1, 0, 185, 4, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:07:35', '2019-04-22 09:07:35'),
(189, 1, 0, 186, 4, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:08:02', '2019-04-22 09:08:02'),
(190, 1, 0, 187, 4, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:08:56', '2019-04-22 09:08:56'),
(191, 1, 0, 188, 4, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:09:16', '2019-04-22 09:09:16'),
(192, 1, 0, 189, 5, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:09:48', '2019-04-22 09:09:48'),
(193, 1, 0, 190, 1, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:10:28', '2019-04-22 09:10:28'),
(194, 1, 0, 191, 2, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:11:03', '2019-04-22 09:11:03'),
(195, 1, 0, 192, 1, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:11:30', '2019-04-22 09:11:30'),
(196, 1, 0, 193, 3, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:12:09', '2019-04-22 09:12:09'),
(197, 1, 0, 194, 10, NULL, 120.00, '2019-04-22', 0, '2019-04-22 09:12:19', '2019-04-22 09:12:19'),
(198, 1, 0, 195, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 09:23:50', '2019-04-22 09:23:50'),
(199, 1, 0, 196, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 09:24:22', '2019-04-22 09:24:22'),
(200, 1, 0, 197, 4, NULL, 200.00, '2019-04-22', 0, '2019-04-22 09:24:44', '2019-04-22 09:24:44'),
(201, 1, 0, 198, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 09:25:31', '2019-04-22 09:25:31'),
(202, 1, 0, 199, 2, NULL, 200.00, '2019-04-22', 0, '2019-04-22 09:25:43', '2019-04-22 09:25:43'),
(203, 1, 0, 200, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:02:45', '2019-04-23 23:02:45'),
(204, 1, 0, 201, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:03:28', '2019-04-23 23:03:28'),
(205, 1, 0, 202, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:04:22', '2019-04-23 23:04:22'),
(206, 1, 0, 203, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:05:27', '2019-04-23 23:05:27'),
(207, 1, 0, 204, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:06:01', '2019-04-23 23:06:01'),
(208, 1, 0, 205, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:06:34', '2019-04-23 23:06:34'),
(209, 1, 0, 206, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:07:13', '2019-04-23 23:07:13'),
(210, 1, 0, 207, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:07:56', '2019-04-23 23:07:56'),
(211, 1, 0, 208, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:08:11', '2019-04-23 23:08:11'),
(212, 1, 0, 209, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:08:25', '2019-04-23 23:08:25'),
(213, 1, 0, 210, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:09:03', '2019-04-23 23:09:03'),
(214, 1, 0, 211, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:09:47', '2019-04-23 23:09:47'),
(215, 1, 0, 212, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:10:23', '2019-04-23 23:10:23'),
(216, 1, 0, 213, 9, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:11:03', '2019-04-23 23:11:03'),
(217, 1, 0, 214, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:12:03', '2019-04-23 23:12:03'),
(218, 1, 0, 215, 7, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:12:45', '2019-04-23 23:12:45'),
(219, 1, 0, 216, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:13:07', '2019-04-23 23:13:07'),
(220, 1, 0, 217, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:13:30', '2019-04-23 23:13:30'),
(221, 1, 0, 218, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:14:17', '2019-04-23 23:14:17'),
(222, 1, 0, 219, 6, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:14:59', '2019-04-23 23:14:59'),
(223, 1, 0, 220, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:15:24', '2019-04-23 23:15:24'),
(224, 1, 0, 221, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:16:24', '2019-04-23 23:16:24'),
(225, 1, 0, 222, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:16:57', '2019-04-23 23:16:57'),
(226, 1, 0, 223, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:23:58', '2019-04-23 23:23:58'),
(227, 1, 0, 224, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:24:38', '2019-04-23 23:24:38'),
(228, 1, 0, 225, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:25:31', '2019-04-23 23:25:31'),
(229, 1, 0, 226, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:25:40', '2019-04-23 23:25:40'),
(230, 1, 0, 227, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:26:29', '2019-04-23 23:26:29'),
(231, 1, 0, 228, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:26:37', '2019-04-23 23:26:37'),
(232, 1, 0, 229, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:27:33', '2019-04-23 23:27:33'),
(233, 1, 0, 230, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:28:11', '2019-04-23 23:28:11'),
(234, 1, 0, 231, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:29:20', '2019-04-23 23:29:20'),
(235, 1, 0, 232, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:29:49', '2019-04-23 23:29:49'),
(236, 1, 0, 233, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:30:22', '2019-04-23 23:30:22'),
(237, 1, 0, 234, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:30:57', '2019-04-23 23:30:57'),
(238, 1, 0, 235, 3, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:31:16', '2019-04-23 23:31:16'),
(239, 1, 0, 236, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:31:44', '2019-04-23 23:31:44'),
(240, 1, 0, 237, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:31:52', '2019-04-23 23:31:52'),
(241, 1, 0, 238, 8, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:32:20', '2019-04-23 23:32:20'),
(242, 1, 0, 239, 6, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:32:55', '2019-04-23 23:32:55'),
(243, 1, 0, 240, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:33:04', '2019-04-23 23:33:04'),
(244, 1, 0, 241, 4, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:33:17', '2019-04-23 23:33:17'),
(245, 1, 0, 242, 6, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:33:47', '2019-04-23 23:33:47'),
(246, 1, 0, 243, 8, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:34:10', '2019-04-23 23:34:10'),
(247, 1, 0, 244, 10, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:34:50', '2019-04-23 23:34:50'),
(248, 1, 0, 245, 5, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:35:14', '2019-04-23 23:35:14'),
(249, 1, 0, 246, 2, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:35:28', '2019-04-23 23:35:28'),
(250, 1, 0, 247, 6, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:35:44', '2019-04-23 23:35:44'),
(251, 1, 0, 248, 9, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:36:13', '2019-04-23 23:36:13'),
(252, 1, 0, 249, 8, NULL, 300.00, '2019-04-24', 0, '2019-04-23 23:36:35', '2019-04-23 23:36:35'),
(253, 1, 0, 250, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-24 03:20:54', '2019-04-24 03:20:54'),
(254, 1, 0, 251, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-24 03:21:16', '2019-04-24 03:21:16'),
(255, 1, 58, 208, 1, NULL, 300.00, '2019-04-24', 0, '2019-04-24 07:39:54', '2019-04-24 07:39:54'),
(256, 1, 0, 252, 11, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:02:43', '2019-04-24 08:02:43'),
(257, 1, 0, 253, 4, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:03:00', '2019-04-24 08:03:00'),
(258, 1, 0, 254, 9, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:03:16', '2019-04-24 08:03:16'),
(259, 1, 0, 255, 19, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:03:37', '2019-04-24 08:03:37'),
(260, 1, 0, 256, 2, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:03:49', '2019-04-24 08:03:49'),
(261, 1, 0, 257, 1, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:04:06', '2019-04-24 08:04:06'),
(262, 1, 0, 258, 10, NULL, 130.00, '2019-04-24', 0, '2019-04-24 08:04:28', '2019-04-24 08:04:28'),
(263, 1, 0, 259, 1, NULL, 700.00, '2019-04-24', 0, '2019-04-24 08:35:35', '2019-04-24 08:35:35'),
(264, 1, 82, 114, 1, NULL, 95.00, '2019-04-25', 0, '2019-04-25 06:42:44', '2019-04-25 06:42:44'),
(265, 1, 82, 123, 1, NULL, 95.00, '2019-04-25', 0, '2019-04-25 06:42:44', '2019-04-25 06:42:44'),
(266, 1, 82, 124, 1, NULL, 95.00, '2019-04-25', 0, '2019-04-25 06:42:44', '2019-04-25 06:42:44');

-- --------------------------------------------------------

--
-- Table structure for table `sellings`
--

CREATE TABLE `sellings` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unitPrice` double(8,2) DEFAULT NULL,
  `discount` double(8,2) DEFAULT NULL,
  `profit` double(8,2) DEFAULT NULL,
  `date` date NOT NULL,
  `hasReturned` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellings`
--

INSERT INTO `sellings` (`id`, `admin_id`, `invoice_id`, `product_id`, `quantity`, `unitPrice`, `discount`, `profit`, `date`, `hasReturned`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 1, 400.00, 0.00, 90.00, '2019-04-16', 0, '2019-04-16 04:07:19', '2019-04-16 04:07:19'),
(2, 1, 3, 20, 1, 250.00, 0.00, 130.00, '2019-04-20', 0, '2019-04-20 01:45:39', '2019-04-20 01:45:39'),
(3, 1, 3, 19, 1, 250.00, 0.00, 130.00, '2019-04-20', 0, '2019-04-20 01:45:39', '2019-04-20 01:45:39'),
(4, 1, 4, 16, 1, 300.00, 0.00, 90.00, '2019-04-20', 0, '2019-04-20 01:49:25', '2019-04-20 01:49:25'),
(5, 1, 5, 19, 1, 250.00, 0.00, 130.00, '2019-04-20', 0, '2019-04-20 02:09:39', '2019-04-20 02:09:39'),
(16, 1, 8, 47, 4, 50.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(17, 1, 8, 62, 4, 50.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(18, 1, 8, 69, 4, 60.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(19, 1, 8, 71, 4, 60.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(20, 1, 8, 66, 4, 50.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 02:29:30', '2019-04-20 02:29:30'),
(21, 1, 9, 12, 1, 180.00, 0.00, 45.00, '2019-04-20', 0, '2019-04-20 03:09:43', '2019-04-20 03:09:43'),
(22, 1, 10, 57, 1, 40.00, 0.00, 20.00, '2019-04-20', 0, '2019-04-20 06:06:57', '2019-04-20 06:06:57'),
(23, 1, 11, 56, 1, 25.00, 0.00, 17.00, '2019-04-20', 0, '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(24, 1, 11, 62, 1, 50.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(25, 1, 11, 47, 1, 50.00, 0.00, 25.00, '2019-04-20', 0, '2019-04-20 06:07:22', '2019-04-20 06:07:22'),
(26, 1, 12, 82, 1, 280.00, 0.00, 120.00, '2019-04-21', 0, '2019-04-21 00:37:47', '2019-04-21 00:37:47'),
(27, 1, 13, 14, 1, 280.00, 0.00, 40.00, '2019-04-21', 0, '2019-04-21 02:16:24', '2019-04-21 02:16:24'),
(28, 1, 14, 60, 1, 50.00, 0.00, 25.00, '2019-04-21', 0, '2019-04-21 02:17:31', '2019-04-21 02:17:31'),
(29, 1, 14, 110, 1, 150.00, 0.00, 55.00, '2019-04-21', 0, '2019-04-21 02:17:31', '2019-04-21 02:17:31'),
(30, 1, 16, 9, 1, 380.00, 0.00, 120.00, '2019-04-21', 0, '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(31, 1, 16, 85, 1, 280.00, 0.00, 120.00, '2019-04-21', 0, '2019-04-21 07:54:18', '2019-04-21 07:54:18'),
(32, 1, 17, 114, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(33, 1, 17, 115, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(34, 1, 17, 116, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(35, 1, 17, 117, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(36, 1, 17, 118, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(37, 1, 17, 122, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(38, 1, 17, 123, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(39, 1, 17, 124, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:17:13', '2019-04-22 00:17:13'),
(40, 1, 18, 114, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(41, 1, 18, 117, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(42, 1, 18, 124, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 00:32:42', '2019-04-22 00:32:42'),
(43, 1, 19, 5, 1, 400.00, 0.00, 90.00, '2019-04-22', 0, '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(44, 1, 19, 6, 1, 380.00, 0.00, 70.00, '2019-04-22', 0, '2019-04-22 00:54:37', '2019-04-22 00:54:37'),
(45, 1, 20, 114, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 05:01:25', '2019-04-22 05:01:25'),
(46, 1, 20, 111, 1, 150.00, 0.00, 55.00, '2019-04-22', 0, '2019-04-22 05:01:25', '2019-04-22 05:01:25'),
(47, 1, 22, 19, 2, 250.00, 0.00, 130.00, '2019-04-23', 0, '2019-04-23 00:53:49', '2019-04-23 00:53:49'),
(49, 1, 24, 115, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 00:59:38', '2019-04-23 00:59:38'),
(50, 1, 24, 117, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 00:59:38', '2019-04-23 00:59:38'),
(51, 1, 25, 19, 1, 250.00, 0.00, 130.00, '2019-04-23', 0, '2019-04-23 01:06:27', '2019-04-23 01:06:27'),
(52, 1, 26, 110, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(53, 1, 26, 115, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 01:09:11', '2019-04-23 01:09:11'),
(54, 1, 27, 149, 1, 200.00, 0.00, 110.00, '2019-04-23', 0, '2019-04-23 01:22:18', '2019-04-23 01:22:18'),
(55, 1, 28, 56, 1, 25.00, 0.00, 17.00, '2019-04-23', 0, '2019-04-23 01:23:35', '2019-04-23 01:23:35'),
(56, 1, 29, 114, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(57, 1, 29, 111, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(58, 1, 29, 122, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 01:34:18', '2019-04-23 01:34:18'),
(59, 1, 30, 58, 1, 40.00, 0.00, 20.00, '2019-04-23', 0, '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(60, 1, 30, 62, 1, 50.00, 0.00, 25.00, '2019-04-23', 0, '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(61, 1, 30, 66, 1, 50.00, 0.00, 25.00, '2019-04-23', 0, '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(62, 1, 30, 63, 1, 40.00, 0.00, 20.00, '2019-04-23', 0, '2019-04-23 01:41:20', '2019-04-23 01:41:20'),
(63, 1, 31, 175, 1, 150.00, 0.00, 30.00, '2019-04-23', 0, '2019-04-23 02:04:05', '2019-04-23 02:04:05'),
(64, 1, 31, 116, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 02:04:05', '2019-04-23 02:04:05'),
(65, 1, 32, 124, 1, 150.00, 0.00, 55.00, '2019-04-23', 0, '2019-04-23 02:05:25', '2019-04-23 02:05:25'),
(66, 1, 33, 104, 1, 250.00, 0.00, 120.00, '2019-04-23', 0, '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(67, 1, 33, 56, 1, 25.00, 0.00, 17.00, '2019-04-23', 0, '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(68, 1, 33, 61, 2, 50.00, 0.00, 25.00, '2019-04-23', 0, '2019-04-23 03:00:42', '2019-04-23 03:00:42'),
(69, 1, 34, 53, 1, 150.00, 0.00, 100.00, '2019-04-23', 0, '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(70, 1, 34, 61, 2, 50.00, 0.00, 25.00, '2019-04-23', 0, '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(71, 1, 34, 60, 1, 50.00, 0.00, 25.00, '2019-04-23', 0, '2019-04-23 03:01:37', '2019-04-23 03:01:37'),
(73, 1, 36, 84, 1, 280.00, 0.00, 120.00, '2019-04-23', 0, '2019-04-23 07:00:40', '2019-04-23 07:00:40'),
(77, 1, 40, 63, 4, 40.00, 0.00, 20.00, '2019-04-24', 0, '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(78, 1, 40, 47, 2, 50.00, 0.00, 25.00, '2019-04-24', 0, '2019-04-24 00:36:42', '2019-04-24 00:36:42'),
(79, 1, 41, 220, 1, 650.00, 0.00, 350.00, '2019-04-24', 0, '2019-04-24 01:05:54', '2019-04-24 01:05:54'),
(80, 1, 42, 222, 1, 650.00, 0.00, 350.00, '2019-04-24', 0, '2019-04-24 01:41:43', '2019-04-24 01:41:43'),
(81, 1, 43, 228, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 01:59:55', '2019-04-24 01:59:55'),
(86, 1, 45, 236, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 02:36:48', '2019-04-24 02:36:48'),
(87, 1, 46, 225, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 02:42:22', '2019-04-24 02:42:22'),
(88, 1, 47, 115, 1, 150.00, 0.00, 55.00, '2019-04-24', 0, '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(89, 1, 47, 117, 1, 150.00, 0.00, 55.00, '2019-04-24', 0, '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(90, 1, 47, 116, 1, 150.00, 0.00, 55.00, '2019-04-24', 0, '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(91, 1, 47, 122, 1, 150.00, 0.00, 55.00, '2019-04-24', 0, '2019-04-24 02:49:32', '2019-04-24 02:49:32'),
(92, 1, 47, 124, 1, 150.00, 0.00, 55.00, '2019-04-24', 0, '2019-04-24 02:49:33', '2019-04-24 02:49:33'),
(93, 1, 48, 211, 1, 650.00, 0.00, 350.00, '2019-04-24', 0, '2019-04-24 02:54:06', '2019-04-24 02:54:06'),
(94, 1, 49, 227, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(95, 1, 49, 231, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(96, 1, 49, 236, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(97, 1, 49, 248, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 03:03:04', '2019-04-24 03:03:04'),
(102, 1, 51, 53, 1, 150.00, 0.00, 100.00, '2019-04-24', 0, '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(103, 1, 51, 47, 2, 50.00, 0.00, 25.00, '2019-04-24', 0, '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(104, 1, 51, 48, 2, 50.00, 0.00, 25.00, '2019-04-24', 0, '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(105, 1, 51, 52, 2, 50.00, 0.00, 25.00, '2019-04-24', 0, '2019-04-24 03:35:12', '2019-04-24 03:35:12'),
(106, 1, 52, 40, 1, 300.00, 0.00, 150.00, '2019-04-24', 0, '2019-04-24 04:16:20', '2019-04-24 04:16:20'),
(107, 1, 52, 56, 1, 25.00, 0.00, 17.00, '2019-04-24', 0, '2019-04-24 04:16:21', '2019-04-24 04:16:21'),
(108, 1, 53, 242, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 05:23:58', '2019-04-24 05:23:58'),
(109, 1, 54, 227, 1, 700.00, 0.00, 400.00, '2019-04-24', 0, '2019-04-24 05:39:46', '2019-04-24 05:39:46'),
(110, 1, 55, 142, 1, 200.00, 0.00, 90.00, '2019-04-24', 0, '2019-04-24 05:40:39', '2019-04-24 05:40:39'),
(111, 1, 56, 19, 1, 250.00, 0.00, 130.00, '2019-04-24', 0, '2019-04-24 06:17:26', '2019-04-24 06:17:26'),
(112, 1, 57, 15, 1, 280.00, 0.00, 40.00, '2019-04-24', 0, '2019-04-24 06:19:15', '2019-04-24 06:19:15'),
(113, 1, 59, 92, 1, 200.00, 0.00, 80.00, '2019-04-24', 0, '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(114, 1, 59, 91, 1, 200.00, 0.00, 90.00, '2019-04-24', 0, '2019-04-24 08:19:51', '2019-04-24 08:19:51'),
(115, 1, 60, 176, 1, 150.00, 0.00, 30.00, '2019-04-25', 0, '2019-04-25 00:09:38', '2019-04-25 00:09:38'),
(117, 1, 62, 211, 1, 650.00, 0.00, 350.00, '2019-04-25', 0, '2019-04-25 00:36:47', '2019-04-25 00:36:47'),
(118, 1, 63, 223, 1, 700.00, 0.00, 400.00, '2019-04-25', 0, '2019-04-25 00:47:16', '2019-04-25 00:47:16'),
(119, 1, 64, 19, 1, 250.00, 0.00, 130.00, '2019-04-25', 0, '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(120, 1, 64, 56, 3, 25.00, 0.00, 17.00, '2019-04-25', 0, '2019-04-25 01:32:46', '2019-04-25 01:32:46'),
(121, 1, 65, 254, 1, 200.00, 0.00, 70.00, '2019-04-25', 0, '2019-04-25 01:38:07', '2019-04-25 01:38:07'),
(122, 1, 66, 66, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(123, 1, 66, 63, 1, 40.00, 0.00, 20.00, '2019-04-25', 0, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(124, 1, 66, 59, 1, 40.00, 0.00, 20.00, '2019-04-25', 0, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(125, 1, 66, 57, 1, 40.00, 0.00, 20.00, '2019-04-25', 0, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(126, 1, 66, 67, 1, 40.00, 0.00, 20.00, '2019-04-25', 0, '2019-04-25 01:41:18', '2019-04-25 01:41:18'),
(127, 1, 67, 172, 1, 150.00, 0.00, 30.00, '2019-04-25', 0, '2019-04-25 02:03:49', '2019-04-25 02:03:49'),
(128, 1, 68, 244, 1, 700.00, 0.00, 400.00, '2019-04-25', 0, '2019-04-25 02:23:41', '2019-04-25 02:23:41'),
(129, 1, 69, 250, 1, 650.00, 0.00, 350.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(130, 1, 69, 77, 1, 600.00, 0.00, 100.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(131, 1, 69, 19, 1, 250.00, 0.00, 130.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(132, 1, 69, 20, 1, 250.00, 0.00, 130.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(133, 1, 69, 68, 1, 60.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(134, 1, 69, 69, 1, 60.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(135, 1, 69, 71, 1, 60.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(136, 1, 69, 70, 1, 60.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(137, 1, 69, 50, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(138, 1, 69, 51, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(139, 1, 69, 48, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(140, 1, 69, 49, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(141, 1, 69, 52, 2, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 02:35:37', '2019-04-25 02:35:37'),
(142, 1, 70, 56, 1, 25.00, 0.00, 17.00, '2019-04-25', 0, '2019-04-25 03:03:37', '2019-04-25 03:03:37'),
(143, 1, 70, 52, 1, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 03:03:37', '2019-04-25 03:03:37'),
(144, 1, 71, 114, 2, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(145, 1, 71, 61, 1, 50.00, 0.00, 25.00, '2019-04-25', 0, '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(146, 1, 71, 67, 1, 40.00, 0.00, 20.00, '2019-04-25', 0, '2019-04-25 03:05:14', '2019-04-25 03:05:14'),
(147, 1, 72, 73, 1, 550.00, 0.00, 150.00, '2019-04-25', 0, '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(148, 1, 72, 97, 1, 250.00, 0.00, 110.00, '2019-04-25', 0, '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(149, 1, 72, 99, 1, 250.00, 0.00, 110.00, '2019-04-25', 0, '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(150, 1, 72, 40, 1, 300.00, 0.00, 150.00, '2019-04-25', 0, '2019-04-25 03:09:35', '2019-04-25 03:09:35'),
(151, 1, 73, 190, 1, 150.00, 0.00, 30.00, '2019-04-25', 0, '2019-04-25 03:51:44', '2019-04-25 03:51:44'),
(152, 1, 74, 123, 1, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 05:11:06', '2019-04-25 05:11:06'),
(153, 1, 75, 111, 1, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(154, 1, 75, 115, 1, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(155, 1, 75, 122, 1, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 05:28:49', '2019-04-25 05:28:49'),
(156, 1, 76, 224, 1, 700.00, 0.00, 400.00, '2019-04-25', 0, '2019-04-25 05:31:06', '2019-04-25 05:31:06'),
(157, 1, 77, 252, 1, 200.00, 0.00, 70.00, '2019-04-25', 0, '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(158, 1, 77, 117, 1, 150.00, 0.00, 55.00, '2019-04-25', 0, '2019-04-25 05:36:13', '2019-04-25 05:36:13'),
(159, 1, 78, 10, 3, 200.00, 0.00, 35.00, '2019-04-25', 0, '2019-04-25 05:37:18', '2019-04-25 05:37:18'),
(160, 1, 79, 255, 1, 200.00, 0.00, 70.00, '2019-04-25', 0, '2019-04-25 05:42:57', '2019-04-25 05:42:57'),
(161, 1, 79, 256, 1, 200.00, 0.00, 70.00, '2019-04-25', 0, '2019-04-25 05:42:57', '2019-04-25 05:42:57'),
(162, 1, 80, 225, 1, 700.00, 0.00, 400.00, '2019-04-25', 0, '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(163, 1, 80, 203, 1, 650.00, 0.00, 350.00, '2019-04-25', 0, '2019-04-25 05:49:17', '2019-04-25 05:49:17'),
(164, 1, 81, 108, 1, 300.00, 0.00, 130.00, '2019-04-25', 0, '2019-04-25 06:05:43', '2019-04-25 06:05:43');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `currencyType` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'BDT',
  `referenceBonus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `refererBonus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `companyName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyLogo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `openingCash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `invoiceNote` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `currencyType`, `referenceBonus`, `refererBonus`, `companyName`, `companyLogo`, `contact`, `openingCash`, `address`, `invoiceNote`, `created_at`, `updated_at`) VALUES
(1, 'BDT', '5', '5', 'Dreams Gallery', NULL, '+8801611141115', '0', 'Shop # 904, City Centre, Zindabazar, Sylhet', NULL, '2019-04-15 07:55:09', '2019-04-15 07:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplierName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `balance` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplierName`, `address`, `contact`, `email`, `opening`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'CASH', NULL, NULL, NULL, '0', '0', '2019-04-15 07:55:08', '2019-04-15 07:55:08'),
(2, 'nazmul', 'ldfdfdfdd', '01681189844', 'nazmu', '0', '0', '2019-04-22 06:04:35', '2019-04-22 06:04:35');

-- --------------------------------------------------------

--
-- Table structure for table `unit_types`
--

CREATE TABLE `unit_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `unitName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_types`
--

INSERT INTO `unit_types` (`id`, `unitName`, `created_at`, `updated_at`) VALUES
(1, 'PCS', '2019-04-15 01:56:25', '2019-04-15 01:56:25'),
(2, 'PAIR', '2019-04-23 06:47:37', '2019-04-23 06:47:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Editor',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `userType`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Bokor Talukdar', 'world_first@yahoo.com', 'bokortalukdar', '$2y$10$rdHGvLN5o4yJmTUaamJqueZgQBoX9nvU5IR8tZVPl4hStd2zEzHXC', 'Admin', 'xQIbxc7cTPojTMRYbSzMgR4zen3vfAhPlcLizdCNbsFVg671XNED6AP3yH1L', '2018-12-26 12:15:02', '2018-12-26 12:15:02');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `ledgerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` int(10) UNSIGNED NOT NULL,
  `zoneName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `zoneName`, `delivery`, `created_at`, `updated_at`) VALUES
(1, 'Sylhet', 50, '2019-04-15 01:56:31', '2019-04-20 01:16:35'),
(2, 'Dhaka', 100, '2019-04-15 01:56:33', '2019-04-20 01:16:30'),
(4, 'Tongi', 100, '2019-04-23 01:11:18', '2019-04-23 01:11:27'),
(5, 'Narayanganj', 100, '2019-04-24 03:30:16', '2019-04-24 03:30:20'),
(7, 'Chittagong', 100, '2019-04-25 02:15:47', '2019-04-25 02:15:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bonuses`
--
ALTER TABLE `bonuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_catname_unique` (`catName`),
  ADD KEY `categories_group_id_foreign` (`group_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_contact_unique` (`contact`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `groups_groupname_unique` (`groupName`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ledger_heads`
--
ALTER TABLE `ledger_heads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sellings`
--
ALTER TABLE `sellings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_contact_unique` (`contact`);

--
-- Indexes for table `unit_types`
--
ALTER TABLE `unit_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unit_types_unitname_unique` (`unitName`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zones_zonename_unique` (`zoneName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bonuses`
--
ALTER TABLE `bonuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `ledger_heads`
--
ALTER TABLE `ledger_heads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT for table `sellings`
--
ALTER TABLE `sellings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `unit_types`
--
ALTER TABLE `unit_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
