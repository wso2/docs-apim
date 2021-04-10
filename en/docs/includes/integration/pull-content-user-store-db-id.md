
!!! Note "About User DB"
	If you replace 'WSO2CarbonDB' with a different id in the user DB configuration, you also need to list the id as a datasource under the <code>[realm_manager]</code> section in the <code>deployment.toml</code> file as shown below.

	```toml
	[realm_manager]
	data_source = "new_id"
	```

	Otherwise the user store database id defaults to 'WSO2CarbonDB' in the realm manager configurations..
	