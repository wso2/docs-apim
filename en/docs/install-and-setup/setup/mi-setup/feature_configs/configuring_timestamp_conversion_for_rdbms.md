# Configuring Timestamp Conversion for RDBMS

!!! Note
	Note that the following functionality is only applicable to **data integration** use cases in WSO2 Micro Integrator.

By default, a timestamp is always converted to the UTC time zone before
inserting the timestamp data to the database. When retrieving the data,
the server will convert the timestamp back to the server's time zone.
This can sometimes lead to inconsistencies where the time zones
applicable to timestamps (for inserting data and retrieving data) are
different. 

Therefore, you can disable UTC conversion for RDBMSs as follows:

1.  Open the server startup script, which is stored in the `MI_HOME/bin` directory.
    - For Linux: `micro-integrator.sh`
    - For Windows: `micro-integrator.bat`
2.  Set the following property to true: `-Ddss.legacy.timezone.mode=true`  

This configuration ensures that data is entered into RDBMSs using the server time zone without converting to UTC.

  
