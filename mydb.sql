-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 18. pro 2014, 14:08
-- Verze serveru: 5.6.17
-- Verze PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `mydb`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_kruh`
--

CREATE TABLE IF NOT EXISTS `anezkaj_kruh` (
  `id_kruh` int(11) NOT NULL AUTO_INCREMENT,
  `umisteni` char(1) NOT NULL,
  PRIMARY KEY (`id_kruh`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Vypisuji data pro tabulku `anezkaj_kruh`
--

INSERT INTO `anezkaj_kruh` (`id_kruh`, `umisteni`) VALUES
(1, 'v'),
(2, 'v'),
(3, 'h'),
(4, 'v'),
(5, 'v'),
(6, 'h'),
(7, 'v'),
(8, 'h'),
(9, 'h');

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_pes`
--

CREATE TABLE IF NOT EXISTS `anezkaj_pes` (
  `id_pes` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno_pes` varchar(45) NOT NULL,
  `pohlavi` varchar(15) NOT NULL,
  `trida` varchar(45) NOT NULL,
  `anezkaj_vystavovatel_id_vystavovatel` int(11) NOT NULL,
  `anezkaj_plemeno_id_plemeno` int(11) NOT NULL,
  PRIMARY KEY (`id_pes`),
  KEY `fk_anezkaj_pes_anezkaj_vystavovatel_idx` (`anezkaj_vystavovatel_id_vystavovatel`),
  KEY `fk_anezkaj_pes_anezkaj_plemeno1_idx` (`anezkaj_plemeno_id_plemeno`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Vypisuji data pro tabulku `anezkaj_pes`
--

INSERT INTO `anezkaj_pes` (`id_pes`, `jmeno_pes`, `pohlavi`, `trida`, `anezkaj_vystavovatel_id_vystavovatel`, `anezkaj_plemeno_id_plemeno`) VALUES
(4, 'Luna', 'f', 'dorost', 4, 4),
(5, 'Azor', 'm', 'Dorost', 9, 3);

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_plemeno`
--

CREATE TABLE IF NOT EXISTS `anezkaj_plemeno` (
  `id_plemeno` int(11) NOT NULL AUTO_INCREMENT,
  `nazev` varchar(45) NOT NULL,
  `skupina` int(11) DEFAULT NULL,
  `anezkaj_rozhodci_id_rozhodci` int(11) DEFAULT NULL,
  `anezkaj_kruh_id_kruh` int(11) NOT NULL,
  PRIMARY KEY (`id_plemeno`),
  KEY `fk_anezkaj_plemeno_anezkaj_rozhodci1_idx` (`anezkaj_rozhodci_id_rozhodci`),
  KEY `fk_anezkaj_plemeno_anezkaj_kruh1_idx` (`anezkaj_kruh_id_kruh`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Vypisuji data pro tabulku `anezkaj_plemeno`
--

INSERT INTO `anezkaj_plemeno` (`id_plemeno`, `nazev`, `skupina`, `anezkaj_rozhodci_id_rozhodci`, `anezkaj_kruh_id_kruh`) VALUES
(1, 'jezevčík', 8, NULL, 4),
(2, 'afgánský chrt', 11, NULL, 5),
(3, 'čivava', 6, 3, 6),
(4, 'akita inu', 5, NULL, 8);

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_posuzuje`
--

CREATE TABLE IF NOT EXISTS `anezkaj_posuzuje` (
  `anezkaj_rozhodci_id_rozhodci` int(11) NOT NULL,
  `anezkaj_kruh_id_kruh` int(11) NOT NULL,
  `cas_od` datetime DEFAULT NULL,
  PRIMARY KEY (`anezkaj_rozhodci_id_rozhodci`,`anezkaj_kruh_id_kruh`),
  KEY `fk_anezkaj_rozhodci_has_anezkaj_kruh_anezkaj_kruh1_idx` (`anezkaj_kruh_id_kruh`),
  KEY `fk_anezkaj_rozhodci_has_anezkaj_kruh_anezkaj_rozhodci1_idx` (`anezkaj_rozhodci_id_rozhodci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `anezkaj_posuzuje`
--

INSERT INTO `anezkaj_posuzuje` (`anezkaj_rozhodci_id_rozhodci`, `anezkaj_kruh_id_kruh`, `cas_od`) VALUES
(3, 8, '2014-12-17 12:00:00'),
(4, 9, '2014-12-16 13:00:00');

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_rozhodci`
--

CREATE TABLE IF NOT EXISTS `anezkaj_rozhodci` (
  `id_rozhodci` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno_rozhodci` varchar(45) NOT NULL,
  `prijmeni_rozhodcicol` varchar(45) NOT NULL,
  PRIMARY KEY (`id_rozhodci`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Vypisuji data pro tabulku `anezkaj_rozhodci`
--

INSERT INTO `anezkaj_rozhodci` (`id_rozhodci`, `jmeno_rozhodci`, `prijmeni_rozhodcicol`) VALUES
(3, 'Zuzana', 'Nová'),
(4, 'Marie', 'Vrátná'),
(6, 'Stanislav', 'Vaněk'),
(8, 'Anežka', 'Jáchymová');

-- --------------------------------------------------------

--
-- Struktura tabulky `anezkaj_vystavovatel`
--

CREATE TABLE IF NOT EXISTS `anezkaj_vystavovatel` (
  `id_vystavovatel` int(11) NOT NULL AUTO_INCREMENT,
  `jmeno_vystavovatel` varchar(45) NOT NULL,
  `prijmeni_vystavovatelcol` varchar(45) NOT NULL,
  `email_vystavovatel` varchar(50) NOT NULL,
  PRIMARY KEY (`id_vystavovatel`),
  UNIQUE KEY `email_vystavovatel` (`email_vystavovatel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Vypisuji data pro tabulku `anezkaj_vystavovatel`
--

INSERT INTO `anezkaj_vystavovatel` (`id_vystavovatel`, `jmeno_vystavovatel`, `prijmeni_vystavovatelcol`, `email_vystavovatel`) VALUES
(2, 'Karolína', 'Nová', 'nova@seznam.cz'),
(4, 'Petr', 'Vysoky', 'vysoky@seznam.cz'),
(5, 'Jan', 'Pressl', 'pressl@seznam.cz'),
(6, 'Veronika', 'Marová', 'marova@seznam.cz'),
(7, 'Anna', 'Králová', 'kralova@seznam.cz'),
(9, 'Blanka', 'Petříková', 'petrikova@seznam.cz');

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `seznam_psu`
--
CREATE TABLE IF NOT EXISTS `seznam_psu` (
`jmeno_pes` varchar(45)
,`prijmeni_vystavovatelcol` varchar(45)
,`jmeno_vystavovatel` varchar(45)
);
-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `zaznam_psa`
--
CREATE TABLE IF NOT EXISTS `zaznam_psa` (
`jmeno_pes` varchar(45)
,`pohlavi` varchar(15)
,`trida` varchar(45)
,`nazev` varchar(45)
);
-- --------------------------------------------------------

--
-- Struktura pro pohled `seznam_psu`
--
DROP TABLE IF EXISTS `seznam_psu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `seznam_psu` AS select `anezkaj_pes`.`jmeno_pes` AS `jmeno_pes`,`anezkaj_vystavovatel`.`prijmeni_vystavovatelcol` AS `prijmeni_vystavovatelcol`,`anezkaj_vystavovatel`.`jmeno_vystavovatel` AS `jmeno_vystavovatel` from (`anezkaj_pes` join `anezkaj_vystavovatel`) where (`anezkaj_pes`.`anezkaj_vystavovatel_id_vystavovatel` = `anezkaj_vystavovatel`.`id_vystavovatel`);

-- --------------------------------------------------------

--
-- Struktura pro pohled `zaznam_psa`
--
DROP TABLE IF EXISTS `zaznam_psa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zaznam_psa` AS select `anezkaj_pes`.`jmeno_pes` AS `jmeno_pes`,`anezkaj_pes`.`pohlavi` AS `pohlavi`,`anezkaj_pes`.`trida` AS `trida`,`anezkaj_plemeno`.`nazev` AS `nazev` from (`anezkaj_pes` join `anezkaj_plemeno`) where (`anezkaj_pes`.`anezkaj_plemeno_id_plemeno` = `anezkaj_plemeno`.`id_plemeno`);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `anezkaj_pes`
--
ALTER TABLE `anezkaj_pes`
  ADD CONSTRAINT `fk_anezkaj_pes_anezkaj_plemeno1` FOREIGN KEY (`anezkaj_plemeno_id_plemeno`) REFERENCES `anezkaj_plemeno` (`id_plemeno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_anezkaj_pes_anezkaj_vystavovatel` FOREIGN KEY (`anezkaj_vystavovatel_id_vystavovatel`) REFERENCES `anezkaj_vystavovatel` (`id_vystavovatel`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `anezkaj_plemeno`
--
ALTER TABLE `anezkaj_plemeno`
  ADD CONSTRAINT `fk_anezkaj_plemeno_anezkaj_kruh1` FOREIGN KEY (`anezkaj_kruh_id_kruh`) REFERENCES `anezkaj_kruh` (`id_kruh`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_anezkaj_plemeno_anezkaj_rozhodci1` FOREIGN KEY (`anezkaj_rozhodci_id_rozhodci`) REFERENCES `anezkaj_rozhodci` (`id_rozhodci`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Omezení pro tabulku `anezkaj_posuzuje`
--
ALTER TABLE `anezkaj_posuzuje`
  ADD CONSTRAINT `fk_anezkaj_rozhodci_has_anezkaj_kruh_anezkaj_kruh1` FOREIGN KEY (`anezkaj_kruh_id_kruh`) REFERENCES `anezkaj_kruh` (`id_kruh`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_anezkaj_rozhodci_has_anezkaj_kruh_anezkaj_rozhodci1` FOREIGN KEY (`anezkaj_rozhodci_id_rozhodci`) REFERENCES `anezkaj_rozhodci` (`id_rozhodci`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
