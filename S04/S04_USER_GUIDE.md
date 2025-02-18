# MATRICE DE FLUX PfSense

|              |             |             | **MATRICE DE FLUX** |                   |        |                                        |
| ------------ | ----------- | ----------- | --------------- | ----------------- | ------ | -------------------------------------- |
|              |             |             |                 |                   |        |                                        |
|              |             |             | **WAN**         |                   |        |                                        |
| Protocole    | IP Source   | Port Source | IP Destination  | Port Destination  | Action | Description                            |
| IPv4/IPv6 \* | \*          | \*          | \*              | \*                | Block  | Deny All                               |
|              |             |             |                 |                   |        |                                        |
|              |             |             | **LAN**         |                   |        |                                        |
| Protocole    | IP Source   | Port Source | IP Destination  | Port Destination  | Action | Description                            |
| IPv4 ICMP    | LAN_Ecotech | \*          | \*              | \*                | Allow  | Allow ICMP to Anywhere                 |
| IPv4 TCP     | LAN_Ecotech | \*          | DMZ Subnets     | 445 (MS DS)       | Allow  | Allow MS-DOS (445) to DMZ Subnets      |
| IPv4 TCP/UDP | LAN_Ecotech | \*          | DMZ Subnets     | 139 (NetBIOS-SSN) | Allow  | Allow (NetBIOS-SSN) 139 to DMZ Subnets |
| IPv4 TCP/UDP | LAN_Ecotech | \*          | DMZ Subnets     | 138 (NetBIOS-DGM) | Allow  | Allow MS-DOS (445) to DMZ Subnets      |
| IPv4 TCP/UDP | LAN_Ecotech | \*          | DMZ Subnets     | 137 (NetBIOS-NS)  | Allow  | Allow MS-DOS (445) to DMZ Subnets      |
| IPv4 TCP/UDP | LAN_Ecotech | \*          | \*              | 3389 (MS RDP)     | Allow  | Allow MS RDP (3389) to Anywhere        |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 21 (FTP)          | Allow  | Allow FTP (21) to Anywhere             |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 143 (IMAP)        | Allow  | Allow IMAP (143) to Anywhere           |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 110 (POP)         | Allow  | Allow POP (110) to Anywhere            |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 25 (SMTP)         | Allow  | Allow SMTP (25) to Anywhere            |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 443 (HTTPS)       | Allow  | Allow HTTPS (443) to Anywhere          |
| IPv4 TCP     | LAN_Ecotech | \*          | \*              | 80 (HTTP)         | Allow  | Allow HTTP (80) to Anywhere            |
| IPv4 TCP/UDP | LAN_Ecotech | \*          | \*              | 53 (DNS)          | Allow  | Allow DNS (53) to Anywhere             |
| IPv4/IPv6 \* | \*          | \*          | \*              | \*                | Block  | Deny All                               |
|              |             |             |                 |                   |        |                                        |
|              |             |             | **DMZ**         |                   |        |                                        |
| Protocole    | IP Source   | Port Source | IP Destination  | Port Destination  | Action | Description                            |
| IPv4 ICMP    | DMZ Subnets | \*          | \*              | \*                | Allow  | Allow DMZ ICMP to Anywhere             |
| IPv4 TCP/UDP | DMZ Subnets | \*          | \*              | 53 (DNS)          | Allow  | Allow DNS (53) to Anywhere             |
| IPv4 \*      | \*          | \*          | RFC1918         | \*                | Block  | Deny DMZ Subnets to RFC1918            |
| IPv4 UDP     | DMZ Subnets | \*          | \*              | 123 (NTP)         | Allow  | Allow NTP (123) to Anywhere            |
| IPv4 TCP     | DMZ Subnets | \*          | \*              | 443 (HTTPS)       | Allow  | Allow HTTPS (443) to Anywhere          |
| IPv4 TCP     | DMZ Subnets | \*          | \*              | 80 (HTTP)         | Allow  | Allow HTTP (80) to Anywhere            |
| IPv4/IPv6 \* | DMZ Subnets | \*          | \*              | \*                | Block  | Deny All                               |
