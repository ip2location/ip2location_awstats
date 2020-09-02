This plugin enables users to display the geolocation information, such as country, region, city, ZIP code and time zone derived from the IP addresses.

Instructions
============

1. Install **Geo::IP2Location** libraries from CPAN.
2. Upload **ip2location.pm** to `/usr/share/awstats/plugins`.
3. Open `/etc/awstats/awstats.conf` and insert following line:

        LoadPlugin="ip2location /usr/share/IP2Location/IP2LOCATION-LITE-DB1.BIN"

    **Note: ** Make sure the path to IP2Location database file is correct.

4. Disable any Maxmind GeoIP plugin as AWStats hook can only access by one plugin per time.

5. View the information by accessing "Countries" or "Hosts" from the left menu.
   
   
Dependencies
============
It's recommended to use IP2Location DB11 which included country, region, and city information.
* IP2Location LITE (Free): https://lite.ip2location.com
* IP2Location Commercial (Comprehensive): https://www.ip2location.com


IPv4 BIN vs IPv6 BIN
====================
Use the IPv4 BIN file if you just need to query IPv4 addresses.

Use the IPv6 BIN file if you need to query BOTH IPv4 and IPv6 addresses.

