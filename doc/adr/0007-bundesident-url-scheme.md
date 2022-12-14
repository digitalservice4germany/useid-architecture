# 7. Switch from eid:// to bundesident:// scheme

Date: 2022-12-13

## Status

Accepted

## Context

The Technical Guideline TR-03124-1 eID-Client – Part 1 (version 1.4 from 8. October 2021, Chapter 2.2 Full eID-Client) specifies the URL scheme for the ClientURL. 
Since we are implementing a mobile only approach, described in ADR 5, we need to define the ClientURL as follows: 'eid://127.0.0.1:24727/eID-Client'. 
However, our eID-Client should not serve as a replacement of the currently available eID-Clients, e.g. AusweisApp2 (AA2). 
Our ClientURL schema should only open our app (BundesIdent) and should not interfere with other eID-Clients. 

## Decision

Instead of <br>
'eid://127.0.0.1:24727/eID-Client' <br>
we use <br>
'**bundesident**://127.0.0.1:24727/eID-Client' <br>

as our ClientURL schema. 

## Consequences

BundesIdent, e.g. our eID-Client, will only open when the user tries to identify for our own service (https://www.grundsteuererklaerung-fuer-privateigentum.de/), due to the individual schema 'bundesident://''.<br>
Other eServices that conform to the 'eid://' schema will not be able to open BundesIdent, they will use the installed standard eID-Clients, like AA2.  

