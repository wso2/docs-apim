# Using Single Key Encryption

WSO2 Micro Integrator uses [asymmetric encryption]({{base_path}}/install-and-setup/setup/mi-setup/security/configuring_keystores) by default, which means that a **key pair** (public key and private key) for encrypting/decrypting information. If required, you can switch to **single key encryption** (symmetric encryption), which means that a single key will be shared for encryption and decryption of information.

## Enable single key encryption

To enable symmetric encryption, open the deployment.toml file and add the following configurations:

```toml
[encryption]
key = "value"
```

## Encrypt the symmetric key

For better security, the symmetric key in the deployment.toml file should be encrypted.
See [Encrypting Passwords]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text) to replace this key with an encrypted value.
