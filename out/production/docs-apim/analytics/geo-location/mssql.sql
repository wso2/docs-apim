CREATE TABLE BLOCKS (
	network_cidr varchar(45) DEFAULT NULL,
	network BIGINT DEFAULT NULL,
	  broadcast BIGINT DEFAULT NULL,
	 geoname_id BIGINT DEFAULT NULL,
	  registered_country_geoname_id BIGINT DEFAULT NULL,
	  represented_country_geoname_id BIGINT DEFAULT NULL,
	  is_anonymous_proxy SMALLINT DEFAULT '0',
	  is_satellite_provider SMALLINT DEFAULT '0',
	  postal_code VARCHAR(45) DEFAULT NULL,
	  latitude DECIMAL(10,4) DEFAULT NULL,
	  longitude DECIMAL(10,4) DEFAULT NULL,
	network_blocks varchar(45) DEFAULT NULL);

CREATE INDEX idx_blocks_network ON BLOCKS (network);
CREATE INDEX idx_blocks_broadcast ON BLOCKS (broadcast);
CREATE INDEX idx_blocks_network_blocks ON BLOCKS (network_blocks);

CREATE TABLE LOCATION (
	  geoname_id BIGINT NOT NULL,
	  locale_code VARCHAR(10) DEFAULT NULL,
	  continent_code VARCHAR(10) DEFAULT NULL,
	  continent_name VARCHAR(20) DEFAULT NULL,
	  country_iso_code VARCHAR(10) DEFAULT NULL,
	  country_name VARCHAR(45) DEFAULT NULL,
	  subdivision_1_iso_code VARCHAR(10) DEFAULT NULL,
	  subdivision_1_name VARCHAR(1000) DEFAULT NULL,
	  subdivision_2_iso_code VARCHAR(10) DEFAULT NULL,
	  subdivision_2_name VARCHAR(1000) DEFAULT NULL,
	  city_name VARCHAR(1000) DEFAULT NULL,
	  metro_code BIGINT DEFAULT NULL,
	  time_zone VARCHAR(30) DEFAULT NULL,
	  PRIMARY KEY (geoname_id));

CREATE TABLE IP_LOCATION (
	  ip VARCHAR(100) NOT NULL,
	  country_name VARCHAR(200) DEFAULT NULL,
	  city_name VARCHAR(200) DEFAULT NULL,
	  PRIMARY KEY (ip)
);
