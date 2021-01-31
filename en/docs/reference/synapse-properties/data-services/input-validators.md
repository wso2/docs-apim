# Input Validators

Validators are added to individual input mappings in a query. Input
validation allows data services to validate the input parameters in a
request and stop the execution of the request if the input doesn’t meet
the required criteria. WSO2 Micro Integrator provides a set of
built-in validators for some of the most common use cases. It also
provides an extension mechanism to write custom validators.

## Long Range validator

Validates if an integer value is in the specified range. The validator
requires a minimum and a maximum value to set the range. 

## Double Range validator

Validates if a floating point is in the specified range. The validator
requires a minimum and a maximum value to set the range. 

## Length validator

Validates the string length of a given parameter against a specified
length.

## Pattern validator

Validates the string value of the parameter against a given regular
expression.
