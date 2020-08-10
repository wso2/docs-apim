CREATE TABLE `BLOCKS` (
`network_cidr` varchar(45) DEFAULT NULL,
`network` int(10) unsigned DEFAULT NULL,
  `broadcast` int(10) unsigned DEFAULT NULL,
 `geoname_id` int(11) DEFAULT NULL,
  `registered_country_geoname_id` int(11) DEFAULT NULL,
  `represented_country_geoname_id` int(11) DEFAULT NULL,
  `is_anonymous_proxy` tinyint(3) DEFAULT '0',
  `is_satellite_provider` tinyint(1) DEFAULT '0',
  `postal_code` varchar(45) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
`network_blocks` varchar(45) DEFAULT NULL);
CREATE INDEX idx_blocks_network ON BLOCKS (`network`);
CREATE INDEX idx_blocks_broadcast ON BLOCKS (`broadcast`);
CREATE INDEX idx_blocks_network_blocks ON BLOCKS (`network_blocks`);
CREATE TABLE `LOCATION` (
  `geoname_id` int(10) unsigned NOT NULL,
  `locale_code` varchar(10) DEFAULT NULL,
  `continent_code` varchar(10) DEFAULT NULL,
  `continent_name` varchar(20) DEFAULT NULL,
  `country_iso_code` varchar(10) DEFAULT NULL,
  `country_name` varchar(45) DEFAULT NULL,
  `subdivision_1_iso_code` varchar(10) DEFAULT NULL,
  `subdivision_1_name` varchar(1000) DEFAULT NULL,
  `subdivision_2_iso_code` varchar(10) DEFAULT NULL,
  `subdivision_2_name` varchar(1000) DEFAULT NULL,
  `city_name` varchar(1000) DEFAULT NULL,
  `metro_code` int(11) DEFAULT NULL,
  `time_zone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`geoname_id`));
CREATE TABLE `IP_LOCATION` (
  `ip` varchar(100) NOT NULL,
  `country_name` varchar(200) DEFAULT NULL,
  `city_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ip`));

