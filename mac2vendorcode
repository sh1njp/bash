#!/bin/bash


sqlite3 db.sqlite3 << EOS
CREATE TABLE Oui (registry,assignment,organization_name,organization_address);
CREATE TABLE Mac (mac_addr);
.mode csv
.import oui.csv Oui
.import mac.txt Mac
.header on
select Mac.mac_addr,Oui.organization_name from Mac LEFT OUTER JOIN Oui ON (upper(substr(replace(Mac.mac_addr,":",""),1,6)) = Oui.assignment);
EOS
