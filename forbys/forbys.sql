-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 03 2024 г., 18:34
-- Версия сервера: 8.0.29
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `forbys`
--

-- --------------------------------------------------------

--
-- Структура таблицы `tb_notifications`
--

CREATE TABLE `tb_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tb_notifications`
--

INSERT INTO `tb_notifications` (`id`, `name`, `text`) VALUES
(1, 'Первое уведомление!', 'Это первое тестовое уведомление. Здесь я напишу, только это, но мог бы многое. Ещё текста, чтобы посмотреть, как будет выглядить.'),
(2, 'Второе уведомление!', 'Это второе тестовое уведомление. Здесь я напишу, только это, но мог бы многое. Ещё текста, чтобы посмотреть, как будет выглядить.');

-- --------------------------------------------------------

--
-- Структура таблицы `tb_nots_vs_orgs`
--

CREATE TABLE `tb_nots_vs_orgs` (
  `id` bigint UNSIGNED NOT NULL,
  `not_id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `is_readed` tinyint NOT NULL DEFAULT '0',
  `is_worked` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tb_nots_vs_orgs`
--

INSERT INTO `tb_nots_vs_orgs` (`id`, `not_id`, `org_id`, `is_readed`, `is_worked`) VALUES
(1, 1, 6, 0, 0),
(2, 2, 6, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `tb_organizations`
--

CREATE TABLE `tb_organizations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `type` enum('СОШ','ООШ','ДОУ','ДО') CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tb_organizations`
--

INSERT INTO `tb_organizations` (`id`, `name`, `password`, `type`, `url`) VALUES
(5, 'Новонукутская СОШ', 'test', 'СОШ', 'novonukutsk'),
(6, 'Новоленинская СОШ', 'test', 'СОШ', 'novolenino'),
(7, 'Хадаханская СОШ', 'test', 'СОШ', 'hadahan'),
(8, 'Харетская СОШ', 'test', 'СОШ', 'harety');

-- --------------------------------------------------------

--
-- Структура таблицы `tb_sessions`
--

CREATE TABLE `tb_sessions` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `session_key` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tb_sessions`
--

INSERT INTO `tb_sessions` (`id`, `org_id`, `session_key`) VALUES
(1, 6, 'f81c2de79623987e5fee22f4538464e8'),
(2, 6, 'c340980bf894cec895d1136c6a2579f9'),
(3, 6, 'e6eb9ba4c8923783eaca40e552366da6'),
(4, 6, '5357ee5a5a9ce23d37d10f1d8dc5253a'),
(5, 7, 'de47a3d2a765181e25b60019ef1a2aed'),
(6, 6, '224fee69ce9dab91268945ab8f476e05'),
(7, 6, '5eeda0afa7171b649f550736209f238d'),
(8, 5, '4677e8563776f908a0c1b50621f8b62a'),
(9, 6, '6b5c783a822b51725bdae8032002a706'),
(10, 5, '167ed45eacca932e867dc6d7bdd6baba'),
(11, 5, '07ec5ea7b49331c5607681ea449e54b0'),
(12, 5, '7f392b2143cecd47512ef407bfe52450'),
(13, 6, '2dc7a1c7b3d2851eb3dd7c9fdf856a8f'),
(14, 6, 'edc96610a4f994e21552f7b76a5d0954'),
(15, 6, '2193b7fcd673a8d5d63af7f8e7331928'),
(16, 6, '6084066364de1930bfd7b628bdc2ab58'),
(17, 6, '17c6f0bfe0249f3c0832a09519d0a4a0');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `tb_notifications`
--
ALTER TABLE `tb_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tb_nots_vs_orgs`
--
ALTER TABLE `tb_nots_vs_orgs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tb_organizations`
--
ALTER TABLE `tb_organizations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tb_sessions`
--
ALTER TABLE `tb_sessions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `tb_notifications`
--
ALTER TABLE `tb_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `tb_nots_vs_orgs`
--
ALTER TABLE `tb_nots_vs_orgs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tb_organizations`
--
ALTER TABLE `tb_organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `tb_sessions`
--
ALTER TABLE `tb_sessions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
