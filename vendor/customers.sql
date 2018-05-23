-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Creato il: Mag 14, 2018 alle 08:32
-- Versione del server: 5.7.22-0ubuntu0.16.04.1
-- Versione PHP: 7.0.30-1+ubuntu16.04.1+deb.sury.org+1

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dalavoro_ps16`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `ps_customer_gdpr`
--

DROP TABLE IF EXISTS `ps_customer_gdpr`;
CREATE TABLE `ps_customer_gdpr` (
  `id_customer_gdpr` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `date_sign` datetime NOT NULL,
  `ip_address` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `value` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `ps_customer_jobs`
--

DROP TABLE IF EXISTS `ps_customer_jobs`;
CREATE TABLE `ps_customer_jobs` (
  `id_customer_job_area` int(11) NOT NULL,
  `id_customer_job_name` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `ps_customer_job_area`
--

DROP TABLE IF EXISTS `ps_customer_job_area`;
CREATE TABLE `ps_customer_job_area` (
  `id_customer_job_area` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `ps_customer_job_name`
--

DROP TABLE IF EXISTS `ps_customer_job_name`;
CREATE TABLE `ps_customer_job_name` (
  `id_job_name` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struttura della tabella `ps_customer_profile`
--

DROP TABLE IF EXISTS `ps_customer_profile`;
CREATE TABLE `ps_customer_profile` (
  `id_customer_profile` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_job_area` int(11) NOT NULL,
  `id_job_name` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `ps_customer_gdpr`
--
ALTER TABLE `ps_customer_gdpr`
  ADD PRIMARY KEY (`id_customer_gdpr`);

--
-- Indici per le tabelle `ps_customer_job_area`
--
ALTER TABLE `ps_customer_job_area`
  ADD PRIMARY KEY (`id_customer_job_area`);

--
-- Indici per le tabelle `ps_customer_job_name`
--
ALTER TABLE `ps_customer_job_name`
  ADD PRIMARY KEY (`id_job_name`);

--
-- Indici per le tabelle `ps_customer_profile`
--
ALTER TABLE `ps_customer_profile`
  ADD PRIMARY KEY (`id_customer_profile`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `ps_customer_gdpr`
--
ALTER TABLE `ps_customer_gdpr`
  MODIFY `id_customer_gdpr` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `ps_customer_job_area`
--
ALTER TABLE `ps_customer_job_area`
  MODIFY `id_customer_job_area` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `ps_customer_job_name`
--
ALTER TABLE `ps_customer_job_name`
  MODIFY `id_job_name` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT per la tabella `ps_customer_profile`
--
ALTER TABLE `ps_customer_profile`
  MODIFY `id_customer_profile` int(11) NOT NULL AUTO_INCREMENT;SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
