-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2018 at 02:21 PM
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
(1, 'HAND BAG', 2, '2018-12-29 05:25:29', '2018-12-29 05:25:29'),
(2, 'CLUTCH BAG', 2, '2018-12-29 05:25:38', '2018-12-29 05:25:38'),
(3, 'WALLET', 2, '2018-12-29 05:25:46', '2018-12-29 05:25:46'),
(4, 'FLAT SHOE', 1, '2018-12-29 05:25:53', '2018-12-29 05:25:53'),
(5, 'HEEL SHOE', 1, '2018-12-29 05:25:58', '2018-12-29 05:25:58'),
(6, 'SANDAL', 1, '2018-12-29 05:26:04', '2018-12-29 05:26:04'),
(7, 'SKIN CARE', 3, '2018-12-29 05:26:34', '2018-12-29 05:26:34'),
(8, 'HAIR CARE', 3, '2018-12-29 05:26:41', '2018-12-29 05:26:41'),
(9, 'BODY CARE', 3, '2018-12-29 05:27:01', '2018-12-29 05:27:01');

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
(1, 'CASH', NULL, '016', NULL, NULL, NULL, '0', '0', '2018-12-29 11:18:57', '2018-12-29 11:18:57'),
(2, 'MOHAMMED KARIM', 'Modina Market, Sylhet 3100', '+8801611141115', NULL, 'SYLHET', NULL, '0', '0', '2018-12-29 11:27:45', '2018-12-29 11:27:45'),
(3, 'Shahreen Samanta', 'Chowhatta, Sylhet', '+8801611151116', NULL, 'SYLHET', NULL, '0', '0', '2018-12-29 11:28:21', '2018-12-29 11:28:21'),
(4, 'AHSAN SHAFI', 'Subidbazar, Sylhet', '+8801611161117', NULL, 'SYLHET', NULL, '0', '0', '2018-12-29 11:29:06', '2018-12-29 11:29:06'),
(5, 'ZUBAER HAQUE RAJ', 'Housing Estate', '+8801611171118', NULL, 'SYLHET', NULL, '0', '0', '2018-12-29 11:30:07', '2018-12-29 11:30:07');

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
(1, 'SHOE', 0, '2018-12-29 05:25:10', '2018-12-29 05:25:10'),
(2, 'BAG', 0, '2018-12-29 05:25:13', '2018-12-29 05:25:13'),
(3, 'COSMETICS', 0, '2018-12-29 05:25:19', '2018-12-29 05:25:19');

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

--
-- Dumping data for table `ledger_heads`
--

INSERT INTO `ledger_heads` (`id`, `ledgerName`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Self Investment', 'Income', '2018-12-29 05:31:02', '2018-12-29 05:31:02'),
(2, 'Office Rent', 'Expence', '2018-12-29 06:16:27', '2018-12-29 06:16:27');

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
(343, '2014_10_12_000000_create_users_table', 1),
(344, '2014_10_12_100000_create_password_resets_table', 1),
(345, '2018_06_30_123738_create_unit_types_table', 1),
(346, '2018_06_30_134223_create_settings_table', 1),
(347, '2018_07_02_122958_create_groups_table', 1),
(348, '2018_07_03_100018_create_categories_table', 1),
(349, '2018_07_03_155050_create_products_table', 1),
(350, '2018_07_05_111105_create_suppliers_table', 1),
(351, '2018_07_08_093900_create_customers_table', 1),
(352, '2018_07_08_095258_create_zones_table', 1),
(353, '2018_07_08_113758_create_ledger_heads_table', 1),
(354, '2018_07_08_113817_create_vouchers_table', 1),
(355, '2018_07_11_112119_create_invoices_table', 1),
(356, '2018_07_11_113714_create_purchases_table', 1),
(357, '2018_07_12_150021_create_paymentsheets_table', 1),
(358, '2018_07_12_151655_create_sellings_table', 1),
(359, '2018_07_14_154542_create_payments_table', 1),
(360, '2018_10_21_062806_create_bonuses_table', 1),
(361, '2018_12_20_071052_create_memberships_table', 1);

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
(1, 1, NULL, 0.00, 'incoming', 'cash', NULL, 'cash', NULL, NULL, NULL, '2018-12-29', '2018-12-29 11:18:57', '2018-12-29 11:20:09'),
(2, 1, 2, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2018-12-29', '2018-12-29 11:27:45', '2018-12-29 11:27:45'),
(3, 1, 3, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2018-12-29', '2018-12-29 11:28:21', '2018-12-29 11:28:21'),
(4, 1, 4, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2018-12-29', '2018-12-29 11:29:06', '2018-12-29 11:29:06'),
(5, 1, 5, 0.00, 'opening', 'customer', 'Opening', 'due', NULL, NULL, NULL, '2018-12-29', '2018-12-29 11:30:07', '2018-12-29 11:30:07'),
(6, 1, 2, 0.00, 'opening', 'supplier', 'Opening', 'due', NULL, NULL, NULL, NULL, '2018-12-29 05:30:34', '2018-12-29 05:30:34');

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
(1, 1, 'Ladies Flat Shoe', 'SHOE', 'FLAT SHOE', 'Valentino', 'PCS', '35', 'RED', 'DGSF-01', '1000', '500', '1000000001', NULL, '0000-00-00', '0', '0', '2018-12-29 06:25:15', '2018-12-29 06:25:15'),
(3, 1, 'Ladies Flat Shoe', 'SHOE', 'FLAT SHOE', 'Valentino', 'PCS', '36', 'RED', 'DGSF-02', '1000', '500', '1000000003', NULL, '0000-00-00', '0', '0', '2018-12-29 06:25:25', '2018-12-29 06:25:25'),
(4, 1, 'Ladies Clutch Bag', 'BAG', 'CLUTCH BAG', 'None Brand', 'PCS', NULL, 'Red', 'DGBC-01', '800', '500', '1000000004', NULL, '0000-00-00', '0', '0', '2018-12-29 07:20:49', '2018-12-29 07:20:49');

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
(1, 1, 0, 1, 50, NULL, 500.00, '2018-12-29', 0, '2018-12-29 06:25:15', '2018-12-29 06:25:15'),
(2, 1, 0, 3, 50, NULL, 500.00, '2018-12-29', 0, '2018-12-29 06:25:26', '2018-12-29 06:25:26'),
(3, 1, 0, 4, 50, NULL, 500.00, '2018-12-29', 0, '2018-12-29 07:20:50', '2018-12-29 07:20:50');

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
(1, 'BDT', '5', '5', 'Dreams Gallery', NULL, '+8801611141115', '0', 'Shop#904, City Centre, 9th Floor, Zindabazar, Sylhet.', 'Thanks for Shopping with DREAMS GALLERY', '2018-12-29 11:18:57', '2018-12-29 11:18:57');

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
(1, 'CASH', NULL, NULL, NULL, '0', '0', '2018-12-29 11:18:57', '2018-12-29 11:18:57'),
(2, 'Vera', 'Yiwu, China', '+86154155', '151515@qq.com', '0', '0', '2018-12-29 05:30:34', '2018-12-29 05:30:34');

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
(1, 'PCS', '2018-12-29 05:20:22', '2018-12-29 05:20:22'),
(4, 'PAIR', '2018-12-29 05:20:39', '2018-12-29 05:20:39');

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
(1, 'Bokor Talukdar', 'world_first@yahoo.com', 'bokortalukdar', '$2y$10$rdHGvLN5o4yJmTUaamJqueZgQBoX9nvU5IR8tZVPl4hStd2zEzHXC', 'Admin', NULL, '2018-12-26 12:15:02', '2018-12-26 12:15:02');

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
(1, 'SYLHET', '2018-12-29 05:23:51', '2018-12-29 05:23:51'),
(2, 'DHAKA', '2018-12-29 05:23:58', '2018-12-29 05:23:58'),
(3, 'CHITTAGONG', '2018-12-29 05:24:20', '2018-12-29 05:24:20'),
(4, 'NARAYANGANJ', '2018-12-29 05:24:26', '2018-12-29 05:24:26'),
(5, 'SUNAMGANJ', '2018-12-29 05:24:33', '2018-12-29 05:24:33'),
(6, 'BARISHAL', '2018-12-29 05:24:46', '2018-12-29 05:24:46'),
(7, 'RAJSHAHI', '2018-12-29 05:24:51', '2018-12-29 05:24:51');

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_model_unique` (`model`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ledger_heads`
--
ALTER TABLE `ledger_heads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=362;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymentsheets`
--
ALTER TABLE `paymentsheets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
