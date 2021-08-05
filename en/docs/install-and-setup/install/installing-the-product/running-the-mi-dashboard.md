# Running the Micro Integrator Dashboard

Follow the steps given below to install the WSO2 Micro Integrator runtime and its monitoring Dashboard.

## Before you begin

-     [Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi-dashboard) the Micro Integrator dashboard.
-     Before starting the dashsboard, [start the Micro Integrator]({{base_path}}/install-and-setup/install/installing-the-product/running-the-mi).

## Configuring Single Sign-on with OpenID Connect

!!! note "Before you begin"
	-	Upgrade Micro Integrator Dashboard to version 4.0.1 or above to enable this feature.
	-       By default, the Micro Inetgrator user store is used to authenticate users. The following instructions are applicable only if you want to enable Single Sign-On.
	-	See the documentation of your preferred Identity provider for instructions on setting up OpenID Connect.

Follow the steps given below to connect the Micro Integrator Dashboard to your Identity provider.

1.	Open the `deployment.toml` file stored in the `<MI_DASHBOARD_HOME>/conf/` directory.
2.	Add the following configurations and update the required values.

	```toml
	[sso]
	enable = true
	client_id = "8e4uDF4ewc2aEa"
	idp_url = "https://localhost:9443"
	jwt_issuer = "https://localhost:9443/oauth2/token"
	resource_server_URLs = ["https://localhost:9743"]
	sign_in_redirect_URL = "https://localhost:9743/sso"
	```

	Parameters used above are explained below.

	<table>
		<tr>
			<th>Parameter</th>
			<th>Desciption</th>
		</tr>
		<tr>
			<td>
				<code>enable</code>
			</td>
			<td>
				Use this paramater to enable Single Sign-On.
			</td>
		</tr>
		<tr>
			<td>
				<code>client_id</code>
			</td>
			<td>
				The client ID generated from the Identity Provider.
			</td>
		</tr>
		<tr>
			<td>
				<code>idp_url</code>
			</td>
			<td>
				The URL of the Identity Provider.
			</td>
		</tr>
		<tr>
			<td>
				<code>jwt_issuer</code>
			</td>
			<td>
				The Identity Provider's issuer identifier.
			</td>
		</tr>
		<tr>
			<td>
				<code>resource_server_URLs</code>
			</td>
			<td>
				The URL of the Micro Integrator Dashboard.
			</td>
		</tr>
		<tr>
			<td>
				<code>sign_in_redirect_URL</code>
			</td>
			<td>
				The Sign In redirect URL of the Micro Integrator Dashboard.
			</td>
		</tr>

	</table>

See the [complete list of parameters]({{base_path}}/reference/config-catalog-mi-dashboard/#single-sign-on) you can configure for the single sign-on.

## Starting the dashboard server

Follow the steps given below.

1.    Open a command prompt as explained below.

      <table>
            <tr>
                  <th>On <b>Linux/macOS</b></td>
                  <td>Establish an SSH connection to the server, log on to the text Linux console, or open a terminal window.</td>
            </tr>
            <tr>
                  <th>On <b>Windows</b></td>
                  <td>Click <b>Start &gt;Run</b>, type <b>cmd</b> at the prompt, and then press <b>Enter</b>.</td>
            </tr>
      </table>     

2.    Navigate to the `<MI-DASHBOARD_HOME>/bin` folder from your command line.
3.    Execute one of the commands given below.

       ```bash tab="On macOS/Linux"
       sh dashboard.sh
       ```

       ```bash tab="On Windows"
       dashboard.bat
       ```

## Accessing the dashboard

Once you have [started the dashboard server](#starting-the-dashboard-server), you can access the dashboard using the following URL:

```bash
https://localhost:9743/dashboard
```

!!! Warning

     - In a non-production environment (with the self-signed certificate), you have to add the certificate of the micro integrator instance to the browser as a trusted source. For example, direct the browser to `https://localhost:9164/management` and add the site as trusted. This step will not be required with a custom production certificate.
     - We have identified issues with the Microsoft Edge browser, which prompts trusting the management URL (with the self-signed certificate) in a loop. Please try trusting the management URL in the same tab if you face this issue. If the issue still persists, consider switching the browser.

See the [Micro Integrator Dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard) documentation for information on how to sign in and use the dashboard.

## Stopping the dashboard server

To <b>stop</b> the dashboard standalone application, go to the terminal and press <i>Ctrl+C</i>.
