https://digitalservicebund.slack.com/archives/C03EETLE16Y/p1663684515317499


# 8. SOAP over SAML

Date: 2022-12-21

## Status

Accepted

## Context

According to the [TR-03130 eID-Server Part 1](https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR03130/TR-03130_TR-eID-Server_Part1.pdf)
chapter 2.3.1, the eID-Server provides two interfaces: 
- SAOP (Simple Object Access Protocol)
- SAML (Security Assertion Markup Language)

We need to decide for one interface.<br> 
_(Flow charts for both approaches, of the eID-Server implementation we use, can be found in the 'Integrationshandbuch für den eID-Service der D-Trust, Version 2.0.0')_

## Decision

Given a user has successfully identified using an eID-Client, the followup task of 
storing the ID data / passing the ID data to the eService is a key difference between both approaches:

**SAML**: <br>
ID data is passed to us as a SAML response from the eID-Server, and we are required to store it until the eService requests it from us. 

**SOAP**: <br>
ID data is stored with the eID-Server and the eService will request the data directly from there, through us.

## Consequences

We create the SOAP signature certificates and implement a proxy behaviour from the eID-Server to the eService, passing the ID data without storing it at any point. 


