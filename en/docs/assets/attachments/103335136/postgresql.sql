BEGIN TRANSACTION;

CREATE TABLE BLOCKS (
network_cidr varchar(45) DEFAULT NULL,
network bigint DEFAULT NULL,
  broadcast bigint DEFAULT NULL,
 geoname_id bigint DEFAULT NULL,
  registered_country_geoname_id int DEFAULT NULL,
  represented_country_geoname_id int DEFAULT NULL,
  is_anonymous_proxy smallint DEFAULT '0',
  is_satellite_provider smallint DEFAULT '0',
  postal_code varchar(45) DEFAULT NULL,
  latitude double precision DEFAULT NULL,
  longitude double precision DEFAULT NULL,
network_blocks varchar(45) DEFAULT NULL);
CREATE INDEX idx_blocks_network ON BLOCKS (network);
CREATE INDEX idx_blocks_broadcast ON BLOCKS (broadcast);
CREATE INDEX idx_blocks_network_blocks ON BLOCKS (network_blocks);
CREATE TABLE LOCATION (
  geoname_id int NOT NULL,
  locale_code varchar(10) DEFAULT NULL,
  continent_code varchar(10) DEFAULT NULL,
  continent_name varchar(20) DEFAULT NULL,
  country_iso_code varchar(10) DEFAULT NULL,
  country_name varchar(45) DEFAULT NULL,
  subdivision_1_iso_code varchar(10) DEFAULT NULL,
  subdivision_1_name varchar(1000) DEFAULT NULL,
  subdivision_2_iso_code varchar(10) DEFAULT NULL,
  subdivision_2_name varchar(1000) DEFAULT NULL,
  city_name varchar(1000) DEFAULT NULL,
  metro_code int DEFAULT NULL,
  time_zone varchar(30) DEFAULT NULL,
  PRIMARY KEY (geoname_id)
);
CREATE TABLE IP_LOCATION (
  ip varchar(100) NOT NULL,
  country_name varchar(200) DEFAULT NULL,
  city_name varchar(200) DEFAULT NULL,
  PRIMARY KEY (ip),
  CONSTRAINT ip_UNIQUE UNIQUE  (ip)
);
commit;
