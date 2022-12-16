# 7. Custom ClientURL scheme

Date: 2022-12-13

## Status

Accepted

## Context

The [Technical Guideline TR-03124-1](https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR03124/TR-03124-1.pdf) specifies the URL scheme for the ClientURL. 
For now, we are not aiming to be a full eID-Client. Therefore, we do not need to stick to the specified ClientURL in chapter 2.2. 
Our ClientURL scheme should only open our app (BundesIdent) and should not interfere with other eID-Clients. 

## Decision

Instead of <br>
`eid://127.0.0.1:24727/eID-Client` <br>
we use <br>
`bundesident://127.0.0.1:24727/eID-Client` <br>

Referencing [ADR 13 - Format of the eID-Client URL](https://github.com/digitalservicebund/useid-backend-service/blob/main/doc/adr/0013-format-of-eid-client-url.md), 
`bundesident://...` is used as universal link / app link for opening BundesIdent. 
If the `bundesident://...`scheme does not open BundesIdent, `eid://...` is used as the fallback ClientURL, thus, any installed full eID-Client is opened.

## Consequences

BundesIdent, e.g. our eID-Client, will only open when the user tries to identify for eServices using our BundesIdent widget.
Other eServices that conform to the `eid://...` scheme will not be able to open BundesIdent, they will use the full eID-Clients, like AA2.  

