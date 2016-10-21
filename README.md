This plugin enables users to display the geolocation informaton, such as country, region, city, derived from the IP addresses.

Instructions
============

1. Install **Geo::IP2Location** libraries from CPAN.
2. Upload **ip2location.pm** to `/usr/share/awstats/plugins`.
3. Open `/etc/awstats/awstats.conf` and insert following line:

        LoadPlugin="ip2location /usr/share/IP2Location/IP2LOCATION-LITE-DB1.BIN"

    **Note: ** Make sure the path to IP2Location database file is correct.

4. Disable any Maxmind GeoIP plugin as AWStats hook can only access by one plugin per time.

5. View the information by accessing "Countries" or "Hosts" from the left menu.

6. It's recommended to use IP2Location DB3 which included country, region, and city information.
   Download free version from http://lite.ip2location.com or commercial version from
   http://www.ip2location.com.
