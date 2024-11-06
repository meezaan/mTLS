#!/bin/bash

## Setup - change these to your hear's content ##

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

## Setup Ends ##
#######################################################
#######################################################
#######################################################

#######################################################
## Script - Change this at your own risk ##
#######################################################

## Create directories
echo "Creating directories..."
mkdir -p $ROOTCA_DIR
mkdir -p $CLIENT_DIR
mkdir -p $SERVER_DIR
echo "Directories created."


## Generate Root CA and CA key
echo "Generating RootCA and Key..."
openssl req -x509 -sha256 -days $ROOTCA_VALIDITY -nodes -newkey rsa:$KEY_LENGTH -subj "$ROOTCA_SUBJECT" -keyout $ROOTCA_DIR/root.key -out $ROOTCA_DIR/root.crt
echo "RootCA and key generated."

## Generate Server CSR and Certificate
echo "Generating Server CSR and Key..."
### CSR
openssl req -out $SERVER_DIR/server.csr -newkey rsa:2048 -nodes -keyout $SERVER_DIR/server.key -subj "$SERVER_SUBJECT"
echo "CSR and key generated."

### Certificate
echo "Generating Server Certificate..."
openssl x509 -req -sha256 -days $CERTIFICATE_VALIDITY -CA $ROOTCA_DIR/root.crt -CAkey $ROOTCA_DIR/root.key -set_serial 0 -in $SERVER_DIR/server.csr -out $SERVER_DIR/server.crt
echo "Server certificate generated."

## Generate Client CSR and Certificate
echo "Generating Client CSR and Key..."
### CSR
openssl req -out $CLIENT_DIR/client.csr -newkey rsa:2048 -nodes -keyout $CLIENT_DIR/client.key -subj "$CLIENT_SUBJECT"
echo "CSR and key generated."

### Certificate
echo "Generating Client Certificate..."
openssl x509 -req -sha256 -days $CERTIFICATE_VALIDITY -CA $ROOTCA_DIR/root.crt -CAkey $ROOTCA_DIR/root.key -set_serial 1 -in $CLIENT_DIR/client.csr -out $CLIENT_DIR/client.crt
echo "Client certificate generated."
