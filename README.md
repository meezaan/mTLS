# Generating mTLS Keys and Certificates

This is a simple script to generate mTLS keys and certificates for a root CA, server and client. It currently only generates one server and client againd the root CA.

You can then tweak the script as needed to generate more clients for the same server using the same root CA.

### Configuration

The top part of the script has some configuration that you can tweak before executing it. It's self explanatory:

```
## All validity is in days
ROOTCA_VALIDITY=7000
CERTIFICATE_VALIDITY=1800

ROOTCA_SUBJECT='/O=Mamluk LLC /CN=example.com'
SERVER_SUBJECT='/O=Mamluk Server /CN=server.example.com'
CLIENT_SUBJECT='/O=Mamluk Client /CN=client.example.com'

KEY_LENGTH=2048 # In bits. 2048 or 4096.

OUTPUT_DIR=./certificates
ROOTCA_DIR=$OUTPUT_DIR/root
SERVER_DIR=$OUTPUT_DIR/server
CLIENT_DIR=$OUTPUT_DIR/client
```

### Run and Generate Certificates

Run the script:

```
sh mtls.sh
```

This will create 3 directories in the `OUTPUT_DIR`: `root`, `server`, anf `client`, which will contain the files needed for you to configure both your client and server for mTLS.

Please **do not forget to keep track of the expiry dates**.