CREATE TABLE BLOCKS (
network_cidr varchar(45) DEFAULT NULL,
network NUMBER(10) DEFAULT NULL,
  broadcast NUMBER(10) DEFAULT NULL,
 geoname_id NUMBER(10) DEFAULT NULL,
  registered_country_geoname_id NUMBER(10) DEFAULT NULL,
  represented_country_geoname_id NUMBER(10) DEFAULT NULL,
  is_anonymous_proxy NUMBER(3) DEFAULT '0',
  is_satellite_provider NUMBER(3) DEFAULT '0',
  postal_code VARCHAR2(45) DEFAULT NULL,
  latitude NUMBER(10,4) DEFAULT NULL,
  longitude NUMBER(10,4) DEFAULT NULL,
network_blocks varchar(45) DEFAULT NULL);

CREATE INDEX idx_blocks_network ON BLOCKS (network);
CREATE INDEX idx_blocks_broadcast ON BLOCKS (broadcast);
CREATE INDEX idx_blocks_network_blocks ON BLOCKS (network_blocks);
CREATE TABLE LOCATION (
  geoname_id NUMBER(10) NOT NULL,
  locale_code VARCHAR2(10) DEFAULT NULL,
  continent_code VARCHAR2(10) DEFAULT NULL,
  continent_name VARCHAR2(20) DEFAULT NULL,
  country_iso_code VARCHAR2(10) DEFAULT NULL,
  country_name VARCHAR2(45) DEFAULT NULL,
  subdivision_1_iso_code VARCHAR2(10) DEFAULT NULL,
  subdivision_1_name VARCHAR2(1000) DEFAULT NULL,
  subdivision_2_iso_code VARCHAR2(10) DEFAULT NULL,
  subdivision_2_name VARCHAR2(1000) DEFAULT NULL,
  city_name VARCHAR2(1000) DEFAULT NULL,
  metro_code NUMBER(10) DEFAULT NULL,
  time_zone VARCHAR2(30) DEFAULT NULL,
  PRIMARY KEY (geoname_id));

CREATE TABLE IP_LOCATION (
  ip VARCHAR2(100) NOT NULL,
  country_name VARCHAR2(200) DEFAULT NULL,
  city_name VARCHAR2(200) DEFAULT NULL,
  PRIMARY KEY (ip)
);
