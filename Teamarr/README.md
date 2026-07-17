\# Teamarr Home Assistant Add-on



Teamarr is a sports channel and EPG management application designed to work with Dispatcharr.



This add-on packages the official Teamarr container for use with Home Assistant OS.



\## Installation



1\. Add this repository to the Home Assistant Add-on Store.

2\. Install the Teamarr add-on.

3\. Start the add-on.

4\. Open the web interface on port 9195.



\## Connecting to Dispatcharr



When configuring Dispatcharr inside Teamarr, do not use `localhost`.



Use the IP address or hostname of your Home Assistant system together with the Dispatcharr port.



Example:



```

http://192.168.1.100:9191

```



\## Persistent data



Teamarr stores its application data in `/app/data`.



The add-on redirects this to Home Assistant's persistent `/data/teamarr` directory.



\## Upstream Project



https://github.com/Pharaoh-Labs/teamarr

