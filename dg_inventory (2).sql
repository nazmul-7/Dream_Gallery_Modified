-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2019 at 09:07 AM
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
(1, 'Clutch Bag', 2, '2019-03-06 06:44:14', '2019-03-06 06:44:14'),
(2, 'Hand Bag', 2, '2019-03-06 06:44:24', '2019-03-06 06:44:24'),
(3, 'Backpack', 2, '2019-03-06 06:44:32', '2019-03-06 06:44:32'),
(4, 'Slipper', 1, '2019-03-06 06:45:32', '2019-03-06 06:45:32'),
(5, 'Flat', 1, '2019-03-06 06:45:43', '2019-03-06 06:45:43'),
(6, 'Heel', 1, '2019-03-06 06:45:50', '2019-03-06 06:45:50'),
(7, 'Face', 4, '2019-03-06 06:46:03', '2019-03-06 06:46:03'),
(8, 'Eyes', 4, '2019-03-06 06:46:11', '2019-03-06 06:46:11'),
(9, 'Lips', 4, '2019-03-06 06:46:20', '2019-03-06 06:46:20');

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
  `zoneId` int(11) NOT NULL,
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `balance` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customerName`, `address`, `contact`, `email`, `zone`, `barcode`, `zoneId`, `opening`, `balance`, `created_at`, `updated_at`) VALUES
(1, 'CASH', NULL, '016', NULL, '', NULL, 0, '0', '0', '2019-03-06 12:40:31', '2019-03-06 12:40:31'),
(2, 'Bokor Talukdar', 'Modina Market,Sylhet', '+8801619672554', NULL, 'Sylhet', NULL, 0, '0', '0', '2019-03-07 07:38:40', '2019-03-07 07:38:40'),
(3, 'Showda Sumi', 'Bashundhra R/A, Dhaka', '+8801712534086', NULL, 'Dhaka', NULL, 0, '0', '0', '2019-03-07 07:39:40', '2019-03-07 07:39:40'),
(4, 'Shahreen Samanta', 'Khulna', '+8801611141115', NULL, 'Khulna', NULL, 0, '0', '0', '2019-03-07 07:54:48', '2019-03-07 07:54:48');

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
(1, 'Shoe', 0, '2019-03-06 06:42:51', '2019-03-06 06:45:19'),
(2, 'Bag', 0, '2019-03-06 06:42:59', '2019-03-06 06:44:51'),
(3, 'Cosmetics', 0, '2019-03-06 06:43:07', '2019-03-06 06:45:06'),
(4, 'Makeup', 0, '2019-03-06 06:43:11', '2019-03-06 06:45:15'),
(5, 'Clothing', 0, '2019-03-06 06:43:17', '2019-03-06 06:44:57');

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
(161, '2014_10_12_000000_create_users_table', 1),
(162, '2014_10_12_100000_create_password_resets_table', 1),
(163, '2018_06_30_123738_create_unit_types_table', 1),
(164, '2018_06_30_134223_create_settings_table', 1),
(165, '2018_07_02_122958_create_groups_table', 1),
(166, '2018_07_03_100018_create_categories_table', 1),
(167, '2018_07_03_155050_create_products_table', 1),
(168, '2018_07_05_111105_create_suppliers_table', 1),
(169, '2018_07_08_093900_create_customers_table', 1),
(170, '2018_07_08_095258_create_zones_table', 1),
(171, '2018_07_08_113758_create_ledger_heads_table', 1),
(172, '2018_07_08_113817_create_vouchers_table', 1),
(173, '2018_07_11_112119_create_invoices_table', 1),
(174, '2018_07_11_113714_create_purchases_table', 1),
(175, '2018_07_12_150021_create_paymentsheets_table', 1),
(176, '2018_07_12_151655_create_sellings_table', 1),
(177, '2018_07_14_154542_create_payments_table', 1),
(178, '2018_10_21_062806_create_bonuses_table', 1),
(179, '2018_12_20_071052_create_memberships_table', 1),
(180, '2019_03_04_091332_create_galleries_table', 1);

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
(1, 1, NULL, 0.00, 'incoming', 'cash', NULL, 'cash', NULL, NULL, NULL, '2019-03-06', '2019-03-06 12:40:30', '2019-03-06 12:41:15'),
(2, 1, 2, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-03-07', '2019-03-07 07:38:40', '2019-03-07 07:38:40'),
(3, 1, 3, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-03-07', '2019-03-07 07:39:40', '2019-03-07 07:39:40'),
(4, 1, 4, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2019-03-07', '2019-03-07 07:54:48', '2019-03-07 07:54:48');

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
(1, 1, 'Ladies Backpack', 'Bag', 'Backpack', 'None Brand', 'PCS', NULL, 'Black', 'DGBP-01', '1200', '500', '101', '/uploads/BWWdPEQ9JTt9lCB5DyDekCwjjKPnecHMXhjEtV6P.jpeg', '0000-00-00', '0', '0', '2019-03-07 01:58:29', '2019-03-07 01:58:29'),
(2, 1, 'Ladies Backpack', 'Bag', 'Backpack', 'None Brand', 'PCS', NULL, 'Pink', 'DGBP-02', '1450', '600', '102', '/uploads/UUd8OUnhryfPZ75xygzTCOx26e04Spsi1f3pRJFU.jpeg', '0000-00-00', '0', '0', '2019-03-07 01:59:38', '2019-03-07 01:59:59'),
(3, 1, 'Ladies Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '35', 'Black', 'DG-01', '650', '350', '103', '/uploads/RPFfvfi06H1RGvncwshMBxVPfOFOpzlXMkPdu1yZ.jpeg', '0000-00-00', '0', '0', '2019-03-07 02:02:38', '2019-03-07 02:02:39'),
(4, 1, 'Ladies Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '36', 'Black', 'DG-01', '650', '350', '104', '/uploads/RPFfvfi06H1RGvncwshMBxVPfOFOpzlXMkPdu1yZ.jpeg', '0000-00-00', '0', '0', '2019-03-07 02:03:10', '2019-03-07 02:03:10'),
(5, 1, 'Ladies Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '37', 'Black', 'DG-01', '650', '350', '105', '/uploads/RPFfvfi06H1RGvncwshMBxVPfOFOpzlXMkPdu1yZ.jpeg', '0000-00-00', '0', '0', '2019-03-07 02:03:17', '2019-03-07 02:03:17'),
(6, 1, 'Ladies Slipper', 'Shoe', 'Slipper', 'DG', 'PAIR', '38', 'Black', 'DG-01', '650', '350', '106', '/uploads/RPFfvfi06H1RGvncwshMBxVPfOFOpzlXMkPdu1yZ.jpeg', '0000-00-00', '0', '0', '2019-03-07 02:03:23', '2019-03-07 02:03:23');

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
(1, 1, 0, 1, 100, NULL, 500.00, '2019-03-07', 0, '2019-03-07 01:58:29', '2019-03-07 01:58:29'),
(2, 1, 0, 2, 100, NULL, 600.00, '2019-03-07', 0, '2019-03-07 01:59:38', '2019-03-07 01:59:38'),
(3, 1, 0, 3, 30, NULL, 350.00, '2019-03-07', 0, '2019-03-07 02:02:39', '2019-03-07 02:02:39'),
(4, 1, 0, 4, 30, NULL, 350.00, '2019-03-07', 0, '2019-03-07 02:03:11', '2019-03-07 02:03:11'),
(5, 1, 0, 5, 30, NULL, 350.00, '2019-03-07', 0, '2019-03-07 02:03:17', '2019-03-07 02:03:17'),
(6, 1, 0, 6, 30, NULL, 350.00, '2019-03-07', 0, '2019-03-07 02:03:23', '2019-03-07 02:03:23');

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
(1, 'BDT', '5', '5', 'Dreams Gallery', NULL, '+8801611141115', '0', 'Shop#904, 9th Floor, Zindabazar, Sylhet', NULL, '2019-03-06 12:40:31', '2019-03-06 12:40:31');

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
(1, 'CASH', NULL, NULL, NULL, '0', '0', '2019-03-06 12:40:31', '2019-03-06 12:40:31');

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
(1, 'PCS', '2019-03-06 06:42:29', '2019-03-06 06:42:29'),
(2, 'PAIR', '2019-03-06 06:42:31', '2019-03-06 06:42:31');

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
(1, 'Bokor Talukdar', 'world_first@yahoo.com', 'bokortalukdar', '$2y$10$rdHGvLN5o4yJmTUaamJqueZgQBoX9nvU5IR8tZVPl4hStd2zEzHXC', 'Admin', 'IwoDsFormYHKF8dDWow6j2bil36c0zflruhYwWZ44BQw6XQxahD93Dz9qRvA', '2018-12-26 12:15:02', '2018-12-26 12:15:02');

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
(1, 'Sylhet', 0, '2019-03-06 06:41:37', '2019-03-06 06:41:37'),
(2, 'Dhaka', 0, '2019-03-06 06:41:41', '2019-03-06 06:41:41'),
(3, 'Chittagong', 0, '2019-03-06 06:41:44', '2019-03-06 06:41:44'),
(4, 'Rangpur', 0, '2019-03-06 06:41:48', '2019-03-06 06:41:48'),
(5, 'Rajshahi', 0, '2019-03-06 06:41:56', '2019-03-06 06:41:56'),
(6, 'Khulna', 0, '2019-03-06 06:41:59', '2019-03-06 06:41:59'),
(7, 'Narayanganj', 0, '2019-03-06 06:42:04', '2019-03-06 06:42:04'),
(8, 'Sunamganj', 0, '2019-03-06 06:42:09', '2019-03-06 06:42:09'),
(9, 'Habiganj', 0, '2019-03-06 06:42:14', '2019-03-06 06:42:14'),
(10, 'Moulovibazar', 0, '2019-03-06 06:42:21', '2019-03-06 06:42:21');

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sellings`
--
ALTER TABLE `sellings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
