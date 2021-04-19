# Setting up a Load balancer

When you have a [clustered deployment]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei), you need to set up a load balancer to manage the incoming traffic. The load balancer automatically distributes incoming traffic across the
multiple nodes in your cluster, which enables better fault tolerance in your deployment.

## Introduction

Let's consider the two-node Micro Integrator cluster and set up the load balancer. The HTTP and HTTPS URLs for accessing the two nodes are as follows:

-	HTTP URL: `http://<Ip_Address>:<HttpPort>`
-	HTTPS URL: `http://<Ip_Address>:<HttpsPort>`

Note that `HttpPort`= 8280 + offset and `HttpsPort`= 8243 + offset.

The load balancer directs requests to the server on a round robin basis. For example, the load balancer will direct requests to node 1 (xxx.xxx.xxx.xx1) of the Micro Integrator cluster as follows:

-   HTTP requests will be directed to node 1 using the `http://xxx.xxx.xxx.xx1/<service>` URL via HTTP 80 port.
-   HTTPS requests will be directed to node 1 using the `https://xxx.xxx.xxx.xx1/<service>` URL via HTTPS 443 port.

If your system uses any other ports, be sure to replace 80 and 443 values with the corresponding ports when you follow the instructions given here.

## Configuring the load balancer

Follow the steps below to configure [NGINX
Plus](https://www.nginx.com/products/) version 1.7.11 or [NGINX
community](http://nginx.org/) version 1.9.2 as the load balancer.

1.  Install NGINX Plus or the NGINX community version on your cluster
    network.
2.  Create a **VHost** file named `ei.http.conf` in the `/etc/nginx/conf.d` directory and add the
    following configurations. This configures NGINX Plus to direct the HTTP requests to the two
    Micro Integrator nodes (xxx.xxx.xxx.xx1 and xxx.xxx.xxx.xx2) via the HTTP 80 port using
    the `http://ei.wso2.com/` URL. If you are setting up NGINX on a Mac OS, you will not have the `conf.d` directory.

    !!! Note
    	  Follow the steps given below to add the **VHost** files mentioned in this step and the preceding steps:

    	  1. Create a directory named `conf` in the `nginx` directory, and create the `ei.http.conf` file inside.
    	  2. Open the `nginx/nginx.conf` file and add the following entry before the final. This includes all the files in the `conf` directory into the NGINX server: `include conf/*.conf;`

	 ```java
	 upstream wso2.ei.com {
     server xxx.xxx.xxx.xx1:8290;
     server xxx.xxx.xxx.xx2:8290;
	 }
	 server {
     listen 80;
     server_name ei.wso2.com;
     location / {
			 proxy_set_header X-Forwarded-Host $host;
			 proxy_set_header X-Forwarded-Server $host;
			 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			 proxy_set_header Host $http_host;
			 proxy_read_timeout 5m;
			 proxy_send_timeout 5m;
			 proxy_pass http://wso2.ei.com;
			 proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";
      	}
	     }
	 ```

3. Create a VHost file (`ei.https.conf`) in the `nginx/conf.d` directory or in the `nginx/conf` directory if you are on a MacOS and add the following configurations. This configures NGINX Plus to direct the HTTPS requests to the two Micro Integrator nodes (xxx.xxx.xxx.xx1 and xxx.xxx.xxx.xx2) via the HTTPS 443 port using the `https://ei.wso2.com/` URL.
	 -	NGINX Community version
			```java
			upstream ssl.wso2.ei.com {
			server xxx.xxx.xxx.xx1:8243;
			server xxx.xxx.xxx.xx2:8243;
			ip_hash;
			}  
			server {
				listen 443;
				server_name ei.wso2.com;
				ssl on;
				ssl_certificate /etc/nginx/ssl/server.crt;
				ssl_certificate_key /etc/nginx/ssl/server.key;
				location / {
					proxy_set_header X-Forwarded-Host $host;
					proxy_set_header X-Forwarded-Server $host;
					proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
					proxy_set_header Host $http_host;
					proxy_read_timeout 5m;
					proxy_send_timeout 5m;
					proxy_pass https://ssl.wso2.ei.com;  
					proxy_http_version 1.1;
					proxy_set_header Upgrade $http_upgrade;
					proxy_set_header Connection "upgrade";
						}
					}
			```

	  -	NGINX Plus
			```java
			upstream ssl.wso2.ei.com {
	    		server xxx.xxx.xxx.xx1:8243;
	    		server xxx.xxx.xxx.xx2:8243;
	            	sticky learn create=$upstream_cookie_jsessionid
	            	lookup=$cookie_jsessionid
	            	zone=client_sessions:1m;
						}
						server {
							listen 443;
	    		server_name ei.wso2.com;
	    		ssl on;
	    		ssl_certificate /etc/nginx/ssl/server.crt;
	    		ssl_certificate_key /etc/nginx/ssl/server.key;
	    		location / {
					proxy_set_header X-Forwarded-Host $host;
					proxy_set_header X-Forwarded-Server $host;
					proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
					proxy_set_header Host $http_host;
					proxy_read_timeout 5m;
					proxy_send_timeout 5m;
	               proxy_pass https://ssl.wso2.ei.com;
	               proxy_http_version 1.1;
	               proxy_set_header Upgrade $http_upgrade;
	               proxy_set_header Connection "upgrade";
	        	}
				}
			```

4. Create a directory named `ssl` inside the `nginx` directory.
5. Follow the instructions below to create SSL certificates for both Micro Integrator nodes.

	 1. Execute the following command to create the Server Key:

		  ```bash
		  sudo openssl genrsa -des3 -out server.key 1024
		  ```

	 2. Execute the following command to request to sign the certificate:

		  ```bash
		  sudo openssl req -new -key server.key -out server.csr
		  ```

	 3. Execute the following commands to remove the passwords:

		  ```bash
		  sudo cp server.key server.key.org
		  sudo openssl rsa -in server.key.org -out server.key
		  ```

	 4. Execute the following command to sign your SSL Certificate:

		  ```bash
		  sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
		  ```

	 5. Execute the following command to add the certificate to the `<MI_HOME>/repository/resources/security/client-truststore.jks` file:

		  ```bash
		  keytool -import -trustcacerts -alias server -file server.crt -keystore client-truststore.jks
		  ```

6. Execute the following command to restart the NGINX Plus server:

	 -	NGINX Community

	  	```bash
	  	sudo nginx -s stop
	  	sudo nginx
	  	```

	 -	NGINX Plus

	  	```bash
	  	sudo service  nginx  restart
	  	```

	 -	Execute the following command if you do not need to restart the server when you are simply making modifications to the VHost file:
			```bash
			sudo service nginx reload
			```
