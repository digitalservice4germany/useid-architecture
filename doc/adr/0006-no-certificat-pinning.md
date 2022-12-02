# 5. No certificate pinning

Date: 2022-12-01

## Status

Accepted

## Context

During the identification flow, the eID-Client connects to the server of a Service Provider (eService) and 
to an eID-Server. Therefor, a TLS connection is being established and the eID-Client validates the server identity 
by checking if the server certificate is signed by a trusted root CA. Connections could be restricted to servers with 
specific certificates only instead of trusting all signed certificates which is called "certificate pinning".

The eID-Client is generically implemented and only knows which servers to connect to once an identification
flow has been started (by retrieving the `tcTokenUrl` and reading the `tcToken`). 

## Decision

The eID-Client will not restrict connections to servers with specific certificates since those 
would need to be hardcoded in the eID-Client which is not possible since the servers are only
known on start of the identification flow.

## Consequences

A man-in-the-middle attack on the TLS connection is possible if an attacker comes into possession of a 
certificate signed by a trusted root CA for a domain used in the identification flow.