/*********************************************************************
* Copyright (c) Intel Corporation 2020
* SPDX-License-Identifier: Apache-2.0
**********************************************************************/
SELECT 'CREATE DATABASE rpsdb' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'rpsdb')\gexec

\connect rpsdb

CREATE EXTENSION IF NOT EXISTS citext;

CREATE TABLE IF NOT EXISTS ciraconfigs(
  cira_config_name citext NOT NULL,
  mps_server_address varchar(256),
  mps_port integer,
  user_name varchar(40),
  password varchar(63),
  common_name varchar(256),
  server_address_format integer,
  auth_method integer,
  mps_root_certificate text,
  proxydetails text,
  tenant_id varchar(36) NOT NULL,
  PRIMARY KEY (cira_config_name, tenant_id)
);
CREATE TABLE IF NOT EXISTS ieee8021xconfigs(
    profile_name citext,
    auth_protocol integer,
    servername VARCHAR(255),
    domain VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    roaming_identity VARCHAR(255),
    active_in_s0 BOOLEAN,
    pxe_timeout integer,
    wired_interface BOOLEAN NOT NULL,
    tenant_id varchar(36) NOT NULL,
    PRIMARY KEY (profile_name, tenant_id)
);
CREATE TABLE IF NOT EXISTS wirelessconfigs(
  wireless_profile_name citext NOT NULL,
  authentication_method integer,
  encryption_method integer,
  ssid varchar(32),
  psk_value integer,
  psk_passphrase varchar(63),
  link_policy int[],
  creation_date timestamp,
  created_by varchar(40),
  tenant_id varchar(36) NOT NULL,
  ieee8021x_profile_name citext,
  FOREIGN KEY (ieee8021x_profile_name,tenant_id)  REFERENCES ieee8021xconfigs(profile_name,tenant_id),
  PRIMARY KEY (wireless_profile_name, tenant_id)
);
CREATE TABLE IF NOT EXISTS profiles(
  profile_name citext NOT NULL,
  activation varchar(20) NOT NULL,
  amt_password varchar(40),
  generate_random_password BOOLEAN NOT NULL,
  cira_config_name citext,
  FOREIGN KEY (cira_config_name,tenant_id)  REFERENCES ciraconfigs(cira_config_name,tenant_id),
  creation_date timestamp,
  created_by varchar(40),
  mebx_password varchar(40),
  generate_random_mebx_password BOOLEAN NOT NULL,
  tags text[],
  dhcp_enabled BOOLEAN,
  ip_sync_enabled BOOLEAN NULL,
  local_wifi_sync_enabled BOOLEAN NULL,
  tenant_id varchar(36) NOT NULL,
  tls_mode integer NULL,
  user_consent varchar(7) NULL,
  ider_enabled BOOLEAN NULL,
  kvm_enabled BOOLEAN NULL,
  sol_enabled BOOLEAN NULL,
  tls_signing_authority varchar(40) NULL,
  ieee8021x_profile_name citext,
  uefi_wifi_sync_enabled BOOLEAN NULL,
  FOREIGN KEY (ieee8021x_profile_name,tenant_id)  REFERENCES ieee8021xconfigs(profile_name,tenant_id),
  PRIMARY KEY (profile_name, tenant_id)
);
CREATE TABLE IF NOT EXISTS profiles_wirelessconfigs(
  wireless_profile_name citext,
  profile_name citext,
  FOREIGN KEY (wireless_profile_name,tenant_id)  REFERENCES wirelessconfigs(wireless_profile_name,tenant_id),
  FOREIGN KEY (profile_name,tenant_id)  REFERENCES profiles(profile_name,tenant_id),
  priority integer,
  creation_date timestamp,
  created_by varchar(40),
  tenant_id varchar(36) NOT NULL,
  PRIMARY KEY (wireless_profile_name, profile_name, priority, tenant_id)
);
CREATE TABLE IF NOT EXISTS domains(
  name citext NOT NULL,
  domain_suffix citext NOT NULL,
  provisioning_cert text,
  provisioning_cert_storage_format varchar(40),
  provisioning_cert_key text,
  creation_date timestamp,
  expiration_date timestamp,
  created_by varchar(40),
  tenant_id varchar(36) NOT NULL,
  CONSTRAINT domainname UNIQUE (name, tenant_id),
  CONSTRAINT domainsuffix UNIQUE (domain_suffix, tenant_id),
  PRIMARY KEY (name, domain_suffix, tenant_id)
);
CREATE TABLE IF NOT EXISTS proxyconfigs(
  proxy_config_name citext,
  address citext NOT NULL,
  info_format integer NOT NULL,
  port integer NOT NULL,
  network_dns_suffix varchar(192),
  creation_date timestamp,
  tenant_id varchar(36),
  CONSTRAINT address_port_tenant_id UNIQUE (address, port, tenant_id),
  PRIMARY KEY (proxy_config_name, tenant_id)
);
CREATE TABLE IF NOT EXISTS profiles_proxyconfigs(
  proxy_config_name citext,
  profile_name citext,
  FOREIGN KEY (proxy_config_name,tenant_id)  REFERENCES proxyconfigs(proxy_config_name,tenant_id),
  FOREIGN KEY (profile_name,tenant_id)  REFERENCES profiles(profile_name,tenant_id),
  priority integer,
  creation_date timestamp,
  created_by varchar(40),
  tenant_id varchar(36),
  PRIMARY KEY (proxy_config_name, profile_name, priority, tenant_id)
);
