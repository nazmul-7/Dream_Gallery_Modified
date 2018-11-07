-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2018 at 11:54 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.11

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
-- Table structure for table `bonuses`
--

CREATE TABLE `bonuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
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
(1, 'HEEL', 1, '2018-11-04 09:37:58', '2018-11-04 09:37:58'),
(2, 'FLAT', 1, '2018-11-05 10:03:08', '2018-11-05 10:03:08'),
(4, 'BACKPACK', 2, '2018-11-05 10:03:39', '2018-11-05 10:03:39'),
(5, 'SANDAL', 1, '2018-11-05 10:04:02', '2018-11-05 10:04:02'),
(6, 'BRUSHES', 3, '2018-11-05 10:04:21', '2018-11-05 10:04:21'),
(7, 'FACE WASH', 3, '2018-11-05 10:04:35', '2018-11-05 10:04:35'),
(8, 'SHAMPOO', 3, '2018-11-05 10:05:59', '2018-11-05 10:05:59');

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
  `zone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `balance` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customerName`, `address`, `contact`, `email`, `zone`, `barcode`, `opening`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'Zubaer', 'Amberkhana', '01722876856', 'zubaer@gmail.com', 'Sylhet', '2', '500', '0', '2018-11-04 09:38:47', '2018-11-04 09:41:32'),
(2, 'Sayem Ahmed', 'Dakshin Surma,Sylhet', '017121506', 'sayemahmed@gmailcom', 'Sylhet', '1', '0', '0', '2018-11-04 09:39:42', '2018-11-04 09:41:11'),
(3, 'Manzur Kader', 'Savar', '0198765412', 'Manzurkader@gmail.com', 'Dhaka', NULL, '0', '0', '2018-11-04 09:40:48', '2018-11-04 09:40:48'),
(4, 'Sadek', 'fdgdgdfgfd', '01617454445', 'fdsdsf', 'Sylhet', NULL, '1', '0', '2018-11-05 12:36:18', '2018-11-05 12:36:18'),
(5, 'Nabila Chowdhury', NULL, '01611141115', NULL, 'Sylhet', NULL, '5100', '0', '2018-11-07 14:42:20', '2018-11-07 14:42:56');

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
(1, 'SHOE', 20, '2018-11-04 09:37:19', '2018-11-05 10:02:49'),
(2, 'BAG', 0, '2018-11-05 10:02:16', '2018-11-05 10:02:16'),
(3, 'COSMETICS', 10, '2018-11-05 10:02:22', '2018-11-05 10:02:38');

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
(1, 1, 'purchase', 50, 27000.00, 0, 0.00, 0.00, 0, 1, '2018-11-05', '2018-11-05 10:19:17', '2018-11-05 10:19:17'),
(2, 1, 'purchase', 2, 1100.00, 0, 0.00, 0.00, 0, 1, '2018-11-05', '2018-11-05 10:53:57', '2018-11-05 10:53:57'),
(3, 1, 'purchase', 5, 2750.00, 0, 0.00, 0.00, 0, 1, '2018-11-20', '2018-11-05 10:56:08', '2018-11-05 10:56:08'),
(4, 1, 'purchase', 1, 400.00, 0, 0.00, 0.00, 0, 1, '2018-11-05', '2018-11-05 11:03:12', '2018-11-05 11:03:12'),
(5, 1, 'sell', 1, 1500.00, 0, 1500.00, 1500.00, NULL, 0, '2018-11-08', '2018-11-07 13:27:07', '2018-11-07 13:27:07'),
(6, 1, 'sell', 1, 1500.00, 10, 1350.00, 1000.00, 5, 0, '2018-11-08', '2018-11-07 15:02:10', '2018-11-07 15:02:10'),
(7, 1, 'sell', 1, 1500.00, 10, 1350.00, 500.00, 5, 0, '2018-11-08', '2018-11-07 15:03:44', '2018-11-07 15:03:44');

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

--
-- Dumping data for table `ledger_heads`
--

INSERT INTO `ledger_heads` (`id`, `ledgerName`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Bkash Cash Back', 'Income', '2018-11-05 10:23:20', '2018-11-05 10:23:20'),
(2, 'Cash', 'Income', '2018-11-05 10:23:31', '2018-11-05 10:23:31'),
(3, 'Cash', 'Expence', '2018-11-05 10:23:38', '2018-11-05 10:23:38'),
(4, 'Food', 'Expence', '2018-11-05 10:23:43', '2018-11-05 10:23:43'),
(5, 'Bkash', 'Expence', '2018-11-05 10:24:01', '2018-11-05 10:24:01'),
(6, 'Mobile Recharge', 'Expence', '2018-11-05 10:24:33', '2018-11-05 10:24:33');

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
(105, '2014_10_12_000000_create_users_table', 1),
(106, '2014_10_12_100000_create_password_resets_table', 1),
(107, '2018_06_30_123738_create_unit_types_table', 1),
(108, '2018_06_30_134223_create_settings_table', 1),
(109, '2018_07_02_122958_create_groups_table', 1),
(110, '2018_07_03_100018_create_categories_table', 1),
(111, '2018_07_03_155050_create_products_table', 1),
(112, '2018_07_05_111105_create_suppliers_table', 1),
(113, '2018_07_08_093900_create_customers_table', 1),
(114, '2018_07_08_095258_create_zones_table', 1),
(115, '2018_07_08_113758_create_ledger_heads_table', 1),
(116, '2018_07_08_113817_create_vouchers_table', 1),
(117, '2018_07_11_112119_create_invoices_table', 1),
(118, '2018_07_11_113714_create_purchases_table', 1),
(119, '2018_07_12_150021_create_paymentsheets_table', 1),
(120, '2018_07_12_151655_create_sellings_table', 1),
(121, '2018_07_14_154542_create_payments_table', 1),
(122, '2018_10_21_062806_create_bonuses_table', 1);

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
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `paidAmount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `admin_id`, `uid`, `type`, `date`, `paidAmount`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'outgoing', '2018-11-08', 1250.00, '2018-11-07 14:28:33', '2018-11-07 14:28:33'),
(2, 1, 1, 'incoming', '2018-11-08', 125.00, '2018-11-07 14:38:01', '2018-11-07 14:38:01'),
(3, 1, 1, 'incoming', '2018-11-08', 100.00, '2018-11-07 14:38:49', '2018-11-07 14:38:49'),
(4, 1, 5, 'incoming', '2018-11-08', 100.00, '2018-11-07 14:43:25', '2018-11-07 14:43:25'),
(5, 1, 5, 'incoming', '2018-11-08', 1000.00, '2018-11-07 14:44:03', '2018-11-07 14:44:03'),
(6, 1, 5, 'incoming', '2018-11-08', 100.00, '2018-11-07 15:00:42', '2018-11-07 15:00:42'),
(7, 1, 1, 'outgoing', '2018-11-08', 100.00, '2018-11-07 15:06:46', '2018-11-07 15:06:46'),
(8, 1, 1, 'outgoing', '2018-11-08', 900.00, '2018-11-07 15:10:12', '2018-11-07 15:10:12');

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
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `paymentsheets`
--

INSERT INTO `paymentsheets` (`id`, `admin_id`, `uid`, `amount`, `type`, `paymentFor`, `remarks`, `paymentMethod`, `invoice_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, -500.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-11-04 09:38:47', '2018-11-04 09:38:47'),
(2, 1, 2, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-11-04 09:39:42', '2018-11-04 09:39:42'),
(3, 1, 3, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-11-04 09:40:48', '2018-11-04 09:40:48'),
(4, 1, 1, 50000.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, '2018-11-04 09:42:18', '2018-11-04 09:42:18'),
(5, 1, 2, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, '2018-11-04 09:42:48', '2018-11-04 09:42:48'),
(6, 1, 1, 27000.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 1, '2018-11-05', '2018-11-05 10:19:17', '2018-11-05 10:19:17'),
(7, 1, 1, 1100.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 2, '2018-11-05', '2018-11-05 10:53:57', '2018-11-05 10:53:57'),
(8, 1, 1, 2750.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 3, '2018-11-20', '2018-11-05 10:56:08', '2018-11-05 10:56:08'),
(9, 1, 1, 400.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 4, '2018-11-05', '2018-11-05 11:03:12', '2018-11-05 11:03:12'),
(10, 1, 4, 1.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-11-05 12:36:18', '2018-11-05 12:36:18'),
(11, 1, NULL, 1500.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 5, '2018-11-07', '2018-11-07 13:27:07', '2018-11-07 13:27:07'),
(12, 1, 1, -1250.00, 'outgoing', 'supplier', 'Pay to Supplier', 'cash', 0, '2018-11-08', '2018-11-07 14:28:33', '2018-11-07 14:28:33'),
(13, 1, 1, 125.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-11-08', '2018-11-07 14:38:01', '2018-11-07 14:38:01'),
(14, 1, 1, 100.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-11-08', '2018-11-07 14:38:49', '2018-11-07 14:38:49'),
(15, 1, 5, -5100.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-11-07 14:42:20', '2018-11-07 14:42:20'),
(16, 1, 5, 100.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-11-08', '2018-11-07 14:43:25', '2018-11-07 14:43:25'),
(17, 1, 5, 1000.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-11-08', '2018-11-07 14:44:03', '2018-11-07 14:44:03'),
(18, 1, 5, 100.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-11-08', '2018-11-07 15:00:42', '2018-11-07 15:00:42'),
(19, 1, 5, -1350.00, 'due', 'customer', 'Sell To Customer', 'due', 6, '2018-11-08', '2018-11-07 15:02:10', '2018-11-07 15:02:10'),
(20, 1, 5, 1000.00, 'dueIncoming', 'customer', 'Advance Cash on Sale To Customer', 'cash', 6, '2018-11-08', '2018-11-07 15:02:10', '2018-11-07 15:02:10'),
(21, 1, 5, -150.00, 'discount', 'customer', 'Discount To Customer', 'cash', 6, '2018-11-08', '2018-11-07 15:02:10', '2018-11-07 15:02:10'),
(22, 1, 5, -1350.00, 'due', 'customer', 'Sell To Customer', 'due', 7, '2018-11-08', '2018-11-07 15:03:44', '2018-11-07 15:03:44'),
(23, 1, 5, 500.00, 'dueIncoming', 'customer', 'Advance Cash on Sale To Customer', 'cash', 7, '2018-11-08', '2018-11-07 15:03:44', '2018-11-07 15:03:44'),
(24, 1, 5, -150.00, 'discount', 'customer', 'Discount To Customer', 'cash', 7, '2018-11-08', '2018-11-07 15:03:44', '2018-11-07 15:03:44'),
(25, 1, 1, -100.00, 'outgoing', 'supplier', 'Pay to Supplier', 'cash', 0, '2018-11-08', '2018-11-07 15:06:46', '2018-11-07 15:06:46'),
(26, 1, 1, -900.00, 'outgoing', 'supplier', 'Pay to Supplier', 'cash', 0, '2018-11-08', '2018-11-07 15:10:12', '2018-11-07 15:10:12');

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
(1, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Addidas', 'PCS', 'M', 'Black', 'LBCB1', '1500', '550', '1000000001', NULL, '0000-00-00', '0', '0', '2018-11-05 10:09:05', '2018-11-05 10:53:57'),
(2, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Momo', 'PCS', 'L', 'Wine Red', 'LBPR', '1500', '593.5483870967741', '1000000002', NULL, '0000-00-00', '0', '0', '2018-11-05 10:09:48', '2018-11-05 11:03:12'),
(3, 1, 'Ladies Backpack', 'BAG', 'BACKPACK', 'Momo', 'PCS', 'XL', 'Wine Red', 'LBPR', '1500', '580.7692307692307', '1000000003', NULL, '0000-00-00', '0', '0', '2018-11-05 10:10:02', '2018-11-05 10:19:17'),
(4, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '6', 'Red', 'FBSR', '1150', '0', '1000000004', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:13', '2018-11-05 10:11:13'),
(5, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '7', 'Red', 'FBSR', '1150', '0', '1000000005', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:18', '2018-11-05 10:11:18'),
(6, 1, 'Flat belt shoe', 'SHOE', 'HEEL', 'Valintion', 'PAIR', '8', 'Red', 'FBSR', '1150', '0', '1000000006', NULL, '0000-00-00', '0', '0', '2018-11-05 10:11:34', '2018-11-05 10:11:34'),
(7, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '5', 'Black', 'LBS', '1200', '500', '1000000007', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:10', '2018-11-05 10:14:10'),
(8, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '6', 'Black', 'LBS', '1200', '500', '1000000008', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:20', '2018-11-05 10:14:20'),
(9, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '7', 'Black', 'LBS', '1200', '500', '1000000009', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:33', '2018-11-05 10:14:33'),
(10, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '8', 'Black', 'LBS', '1200', '500', '1000000010', NULL, '0000-00-00', '0', '0', '2018-11-05 10:14:49', '2018-11-05 10:14:49'),
(11, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '6', 'Maroon', 'LBSM', '1200', '0', '1000000011', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:18', '2018-11-05 10:15:18'),
(12, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '7', 'Maroon', 'LBSM', '1200', '0', '1000000012', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:23', '2018-11-05 10:15:23'),
(13, 1, 'Heel Leather Belt Shoe', 'SHOE', 'HEEL', 'XOXO', 'PAIR', '8', 'Maroon', 'LBSM', '1200', '0', '1000000013', NULL, '0000-00-00', '0', '0', '2018-11-05 10:15:29', '2018-11-05 10:15:29'),
(14, 1, '12set Brush', 'COSMETICS', 'BRUSHES', 'FOCALLUR', 'BOX', NULL, NULL, 'F12', '600', '0', '1000000014', NULL, '0000-00-00', '0', '0', '2018-11-05 11:04:37', '2018-11-05 11:04:37');

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
  `unitPrice` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `hasReturned` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `admin_id`, `invoice_id`, `product_id`, `quantity`, `unitPrice`, `date`, `hasReturned`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 1, 0, 0.00, '2018-11-24', 0, '2018-11-05 10:09:05', '2018-11-05 10:09:05'),
(2, 1, 0, 2, 5, 850.00, '0000-00-00', 0, '2018-11-05 10:09:48', '2018-11-05 10:09:48'),
(3, 1, 0, 3, 3, 850.00, '0000-00-00', 0, '2018-11-05 10:10:02', '2018-11-05 10:10:02'),
(4, 1, 0, 4, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:11:13', '2018-11-05 10:11:13'),
(5, 1, 0, 5, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:11:18', '2018-11-05 10:11:18'),
(6, 1, 0, 6, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:11:34', '2018-11-05 10:11:34'),
(7, 1, 0, 7, 10, 500.00, '0000-00-00', 0, '2018-11-05 10:14:10', '2018-11-05 10:14:10'),
(8, 1, 0, 8, 10, 500.00, '0000-00-00', 0, '2018-11-05 10:14:20', '2018-11-05 10:14:20'),
(9, 1, 0, 9, 5, 500.00, '0000-00-00', 0, '2018-11-05 10:14:33', '2018-11-05 10:14:33'),
(10, 1, 0, 10, 3, 500.00, '0000-00-00', 0, '2018-11-05 10:14:49', '2018-11-05 10:14:49'),
(11, 1, 0, 11, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:15:18', '2018-11-05 10:15:18'),
(12, 1, 0, 12, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:15:23', '2018-11-05 10:15:23'),
(13, 1, 0, 13, 0, 0.00, '0000-00-00', 0, '2018-11-05 10:15:29', '2018-11-05 10:15:29'),
(14, 1, 1, 1, 20, 550.00, '0000-00-00', 0, '2018-11-05 10:19:17', '2018-11-05 10:19:17'),
(15, 1, 1, 2, 20, 550.00, '0000-00-00', 0, '2018-11-05 10:19:17', '2018-11-05 10:19:17'),
(16, 1, 1, 3, 10, 500.00, '0000-00-00', 0, '2018-11-05 10:19:17', '2018-11-05 10:19:17'),
(17, 1, 2, 1, 2, 550.00, '0000-00-00', 0, '2018-11-05 10:53:57', '2018-11-05 10:53:57'),
(18, 1, 3, 2, 5, 550.00, '0000-00-00', 0, '2018-11-05 10:56:08', '2018-11-05 10:56:08'),
(19, 1, 4, 2, 1, 400.00, '2018-11-05', 0, '2018-11-05 11:03:12', '2018-11-05 11:03:12'),
(20, 1, 0, 14, 0, 0.00, '2018-11-05', 0, '2018-11-05 11:04:37', '2018-11-05 11:04:37');

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
(1, 1, 5, 1, 1, 1500.00, 0.00, 950.00, '2018-11-06', 0, '2018-11-07 13:27:07', '2018-11-07 13:27:07'),
(2, 1, 6, 1, 1, 1500.00, 0.00, 950.00, '2018-11-08', 0, '2018-11-07 15:02:10', '2018-11-07 15:02:10'),
(3, 1, 7, 1, 1, 1500.00, 0.00, 950.00, '2018-11-08', 0, '2018-11-07 15:03:44', '2018-11-07 15:03:44');

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
  `address` text COLLATE utf8mb4_unicode_ci,
  `invoiceNote` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `currencyType`, `referenceBonus`, `refererBonus`, `companyName`, `companyLogo`, `contact`, `address`, `invoiceNote`, `created_at`, `updated_at`) VALUES
(1, 'BDT', '5', '8', 'Dreams Gallery', NULL, '+8801611115116', 'City Center,Sylhet', 'Never Buy Again', NULL, '2018-11-07 16:36:27');

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
(1, 'Vera', 'China RA, No Online, CC', '017987654', 'vera@verachina.com', '50000', '0', '2018-11-04 09:42:18', '2018-11-04 09:42:18'),
(2, 'Vola', 'I habve no road4, no houe, china 33', '0114445556', 'asd@nomail.com', '0', '0', '2018-11-04 09:42:48', '2018-11-04 09:42:48');

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
(1, 'PCS', '2018-11-04 09:36:35', '2018-11-04 09:36:35'),
(2, 'PAIR', '2018-11-04 09:36:40', '2018-11-04 09:36:40'),
(3, 'DOZON', '2018-11-04 09:36:43', '2018-11-04 09:36:43'),
(4, 'BOX', '2018-11-04 09:36:51', '2018-11-04 09:36:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Editor',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `userType`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'zubaer haque', 'zubaer.haque@gmail.com', '$2y$10$7Niqqq0y/8rXbXJ364jUxes7B/ZiucnVpsCDScnVnwfSYXIXA5bxO', 'Admin', '4K3xjHFblMm14iZWw1QJzM3liHhHIGMxOKspgztfgw97H9jgsVmy5mUWFTBk', '2018-11-04 04:53:59', '2018-11-04 04:53:59');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `zoneName`, `created_at`, `updated_at`) VALUES
(1, 'Sylhet', '2018-11-04 09:38:14', '2018-11-04 09:38:14'),
(2, 'Dhaka', '2018-11-04 09:38:17', '2018-11-04 09:38:17'),
(3, 'Chittagong', '2018-11-04 09:38:22', '2018-11-04 09:38:22');

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ledger_heads`
--
ALTER TABLE `ledger_heads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sellings`
--
ALTER TABLE `sellings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
