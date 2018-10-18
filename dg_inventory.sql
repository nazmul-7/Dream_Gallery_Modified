-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2018 at 12:01 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

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
(1, 'Backpack', 2, '2018-09-24 04:31:19', '2018-09-24 04:32:17'),
(3, 'Parse', 2, '2018-09-24 04:31:29', '2018-09-24 04:31:29'),
(4, 'Wallet', 2, '2018-09-24 04:31:36', '2018-09-24 04:31:36'),
(5, 'BB Cream', 3, '2018-09-24 04:31:52', '2018-09-24 04:31:52'),
(6, 'Flat', 1, '2018-09-24 04:32:05', '2018-09-24 04:32:05'),
(7, 'Heel', 1, '2018-09-24 04:32:10', '2018-09-24 04:32:10');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `balance` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customerName`, `address`, `contact`, `email`, `zone`, `opening`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'zubaer haque', '15 sebok, Mirabazaar', '0198765321', 'zubaer.haque@gmail.com', 'Dhaka', '0', '0', '2018-09-24 09:38:18', '2018-09-24 09:38:18'),
(2, 'Sayem Ahmed', 'Dakshin Surma', '017121615', 'sayemahmed1615@gmail.com', 'Sylhet', '1500', '0', '2018-09-25 01:22:06', '2018-09-25 01:22:06'),
(3, 'manzur kader', 'lund university', '011111111', 'zubaerhaque@gmail.com', 'Dhaka', '5000', '0', '2018-09-25 01:25:40', '2018-09-25 01:25:40'),
(4, 'zubaer haqueaaa', '15 sebok, Mirabazaar', '32165749', 'zubaeraaaa.haque@gmail.com', NULL, '0', '0', '2018-10-14 10:01:19', '2018-10-14 10:01:19'),
(5, 'manzur kader', 'lund university', '547468452', 'zussssbaerhaque@gmail.com', 'Sylhet', '3524654', '0', '2018-10-14 10:01:31', '2018-10-14 10:01:31'),
(6, 'manzur kader', 'lund university', '857453120', 'zubaerhaque@gmail.com', 'Dhaka', '6555', '0', '2018-10-14 10:02:30', '2018-10-14 10:02:30');

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
(1, 'Shoe', 0, '2018-09-24 04:31:00', '2018-09-24 04:31:00'),
(2, 'Bag', 0, '2018-09-24 04:31:04', '2018-09-24 04:31:04'),
(3, 'Makeup', 0, '2018-09-24 04:31:08', '2018-09-24 04:31:08');

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
(1, 1, 'purchase', 20, 10900.00, 0, 0.00, 0.00, 0, 5, '2018-09-25', '2018-09-25 05:34:09', '2018-09-25 05:34:09'),
(2, 1, 'sell', 2, 2650.00, 10, 2385.00, 2385.00, 3, 0, '2018-09-25', '2018-09-25 05:35:24', '2018-09-25 05:35:24'),
(3, 1, 'purchase', 5000, 100000.00, 0, 0.00, 0.00, 0, 5, '2018-10-09', '2018-10-10 05:08:27', '2018-10-10 05:08:27'),
(4, 1, 'sell', 1, 1500.00, 0, 1500.00, 1500.00, NULL, 0, NULL, '2018-10-11 05:08:07', '2018-10-11 05:08:07'),
(5, 1, 'purchase', 10, 100.00, 0, 0.00, 0.00, 0, 6, '2018-10-16', '2018-10-15 02:08:19', '2018-10-15 02:08:19'),
(6, 1, 'purchase', 5, 2600.00, 0, 0.00, 0.00, 0, 5, '2018-10-23', '2018-10-15 03:04:02', '2018-10-15 03:04:02'),
(7, 1, 'sell', 3, 3450.00, 0, 3450.00, 3450.00, NULL, 0, NULL, '2018-10-16 05:53:51', '2018-10-16 05:53:51');

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
(1, 'Bkash', 'Income', '2018-09-26 01:44:57', '2018-09-26 01:44:57'),
(2, 'Bkash', 'Expence', '2018-09-26 01:46:05', '2018-09-26 01:46:05'),
(3, 'Cash Back', 'Income', '2018-09-26 01:46:33', '2018-09-26 01:46:33'),
(4, 'Foods and Drinks', 'Expence', '2018-09-26 01:46:58', '2018-09-26 01:46:58'),
(5, 'Courier', 'Expence', '2018-09-26 01:47:07', '2018-09-26 01:47:07');

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
(69, '2014_10_12_000000_create_users_table', 1),
(70, '2014_10_12_100000_create_password_resets_table', 1),
(71, '2018_06_30_123738_create_unit_types_table', 1),
(72, '2018_06_30_134223_create_settings_table', 1),
(73, '2018_07_02_122958_create_groups_table', 1),
(74, '2018_07_03_100018_create_categories_table', 1),
(75, '2018_07_03_155050_create_products_table', 1),
(76, '2018_07_05_111105_create_suppliers_table', 1),
(77, '2018_07_08_093900_create_customers_table', 1),
(78, '2018_07_08_095258_create_zones_table', 1),
(79, '2018_07_08_113758_create_ledger_heads_table', 1),
(80, '2018_07_08_113817_create_vouchers_table', 1),
(81, '2018_07_11_112119_create_invoices_table', 1),
(82, '2018_07_11_113714_create_purchases_table', 1),
(83, '2018_07_12_150021_create_paymentsheets_table', 1),
(84, '2018_07_12_151655_create_sellings_table', 1),
(85, '2018_07_14_154542_create_payments_table', 1);

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
(1, 1, 3, 'incoming', '2018-09-07', 500.00, '2018-09-25 01:36:58', '2018-09-25 01:36:58'),
(2, 1, 5, 'outgoing', '2018-10-17', 5000.00, '2018-10-03 05:01:28', '2018-10-03 05:01:28');

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
(1, 1, 1, 0.00, 'due', 'customer', 'Opening', 'due', NULL, NULL, '2018-09-24 09:38:18', '2018-09-24 09:38:18'),
(2, 1, 3, 0.00, 'due', 'supplier', 'Opening', 'due', NULL, NULL, '2018-09-25 01:17:25', '2018-09-25 01:17:25'),
(3, 1, 4, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, '2018-09-25 01:19:11', '2018-09-25 01:19:11'),
(4, 1, 2, -1500.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-09-25 01:22:06', '2018-09-25 01:22:06'),
(5, 1, 3, -5000.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-09-25 01:25:40', '2018-09-25 01:25:40'),
(6, 1, 3, 500.00, 'dueIncoming', 'customer', 'Paid by Customer', 'cash', 0, '2018-09-07', '2018-09-25 01:36:58', '2018-09-25 01:36:58'),
(7, 1, 5, -500000.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, '2018-09-25 02:06:06', '2018-09-25 02:06:06'),
(8, 1, 5, 10900.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 1, '2018-09-25', '2018-09-25 05:34:09', '2018-09-25 05:34:09'),
(9, 1, 3, 2385.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 2, '2018-09-25', '2018-09-25 05:35:24', '2018-09-25 05:35:24'),
(10, 1, 3, 265.00, 'discount', 'customer', 'Discount To Customer', 'cash', 2, '2018-09-25', '2018-09-25 05:35:24', '2018-09-25 05:35:24'),
(11, 1, NULL, 200.00, 'incoming', 'voucher', 'Voucher : Cash Back', 'Cash Back', NULL, '2018-10-04', '2018-10-03 02:15:25', '2018-10-03 02:15:25'),
(12, 1, 5, -5000.00, 'outgoing', 'supplier', 'Pay to Supplier', 'cash', 0, '2018-10-17', '2018-10-03 05:01:28', '2018-10-03 05:01:28'),
(13, 1, 5, 100000.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 3, '2018-10-09', '2018-10-10 05:08:27', '2018-10-10 05:08:27'),
(14, 1, NULL, 1500.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 4, NULL, '2018-10-11 05:08:07', '2018-10-11 05:08:07'),
(15, 1, 4, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-10-14 10:01:19', '2018-10-14 10:01:19'),
(16, 1, 5, -999999.99, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-10-14 10:01:31', '2018-10-14 10:01:31'),
(17, 1, 6, -6555.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, '2018-10-14 10:02:30', '2018-10-14 10:02:30'),
(18, 1, 6, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, '2018-10-15 02:01:50', '2018-10-15 02:01:50'),
(19, 1, 6, 100.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 5, '2018-10-16', '2018-10-15 02:08:19', '2018-10-15 02:08:19'),
(20, 1, 5, 2600.00, 'due', 'supplier', 'Purchased From Supplier', 'due', 6, '2018-10-23', '2018-10-15 03:04:02', '2018-10-15 03:04:02'),
(21, 1, NULL, 3450.00, 'incoming', 'customer', 'Sell To Customer', 'cash', 7, NULL, '2018-10-16 05:53:51', '2018-10-16 05:53:51');

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
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `admin_id`, `productName`, `groupName`, `catName`, `brand`, `unit`, `size`, `color`, `model`, `sellingPrice`, `averageBuyingPrice`, `barCode`, `productImage`, `opening`, `created_at`, `updated_at`) VALUES
(1, 1, 'Xoxo', 'Shoe', 'Flat', 'Codiciva', 'Pair', '6', 'Red', 'X1', '1500', '308.69565217391306', '1000000001', NULL, '0', '2018-09-24 08:49:42', '2018-10-15 03:04:02'),
(2, 1, 'Xoxo', 'Shoe', 'Flat', 'vALIN', 'Dozon', '6', 'Red', 'X1', '1150', '20.934318227191056', '1000000002', NULL, '0', '2018-09-24 08:53:29', '2018-10-10 05:08:27');

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
  `hasReturned` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `admin_id`, `invoice_id`, `product_id`, `quantity`, `unitPrice`, `hasReturned`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 2, 0, -1.00, 0, '2018-09-24 08:53:29', '2018-09-24 08:53:29'),
(2, 1, 1, 1, 10, 550.00, 0, '2018-09-25 05:34:09', '2018-09-25 05:34:09'),
(3, 1, 1, 2, 10, 540.00, 0, '2018-09-25 05:34:09', '2018-09-25 05:34:09'),
(4, 1, 3, 2, 5000, 20.00, 0, '2018-10-10 05:08:27', '2018-10-10 05:08:27'),
(5, 1, 5, 1, 10, 10.00, 0, '2018-10-15 02:08:19', '2018-10-15 02:08:19'),
(6, 1, 6, 1, 5, 520.00, 0, '2018-10-15 03:04:02', '2018-10-15 03:04:02');

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
  `hasReturned` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellings`
--

INSERT INTO `sellings` (`id`, `admin_id`, `invoice_id`, `product_id`, `quantity`, `unitPrice`, `discount`, `profit`, `hasReturned`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 1, 1500.00, 0.00, 950.00, 0, '2018-09-25 05:35:24', '2018-09-25 05:35:24'),
(2, 1, 2, 2, 1, 1150.00, 0.00, 610.00, 0, '2018-09-25 05:35:24', '2018-09-25 05:35:24'),
(3, 1, 4, 1, 1, 1500.00, 0.00, 950.00, 0, '2018-10-11 05:08:07', '2018-10-11 05:08:07'),
(4, 1, 7, 2, 3, 1150.00, 0.00, 1129.07, 0, '2018-10-16 05:53:51', '2018-10-16 05:53:51');

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
  `invoiceNote` text COLLATE utf8mb4_unicode_ci,
  `contact` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `currencyType`, `referenceBonus`, `refererBonus`, `companyName`, `companyLogo`, `invoiceNote`, `contact`, `address`, `created_at`, `updated_at`) VALUES
(1, 'BDT', '0', '0', 'Dreams gallery', 'asd', 'Dont Come Back', '01732165498', 'City Center', NULL, '2018-10-18 04:00:52');

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
(4, 'Kupaa', 'China', '3216548', 'kupa', '0', '0', '2018-09-25 01:19:11', '2018-09-25 01:19:11'),
(5, 'Z', 'lund university\nlund', '213', 'zubaerhaque@gmail.com', '500000', '0', '2018-09-25 02:06:06', '2018-09-25 02:06:06'),
(6, 'asd', 'Dakshin Surma', '01712211615', 'sayemahmed1615@gmail.com', '0', '0', '2018-10-15 02:01:50', '2018-10-15 02:01:50');

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
(1, 'Pair', '2018-09-24 04:30:41', '2018-09-24 04:30:41'),
(2, 'Dozon', '2018-09-24 04:30:50', '2018-09-24 04:30:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'zubaer haque', 'zubaer.haque@gmail.com', '$2y$10$QAZgT4wpEYvOgTLhZGwYC.AZpqVqvSK5wG3b4WwnAIjmSh9sPtXM6', 'D4bN5zIlyrRshLoqymVoEwkqKO0ENEf1WI6F4JsBiaRBEZFZg5AEwZglxHZB', '2018-09-24 04:30:28', '2018-09-24 04:30:28');

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

--
-- Dumping data for table `vouchers`
--

INSERT INTO `vouchers` (`id`, `admin_id`, `ledgerName`, `type`, `amount`, `date`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 0, 'Cash Back', 'Income', 200, '2018-10-03 18:00:00', 'Card Cash Back', '2018-10-03 02:15:25', '2018-10-03 02:15:25');

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
(1, 'Sylhet', '2018-09-24 04:32:33', '2018-09-24 04:32:33'),
(2, 'Dhaka', '2018-09-24 04:32:37', '2018-09-24 04:32:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_group_id_foreign` (`group_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sellings`
--
ALTER TABLE `sellings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
