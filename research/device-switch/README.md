# Secure Device Switch 

## Goal

Many users still like to use their desktop computers to use governmental services. To identify with 
the BundesIdent app eID-Client they need to switch to the smartphone. The current solution requires the user to install a separate application on the desktop and pair their smartphone as a card reading device with the desktop app.
The following flow describes an adapted identification flow including a device switch with the goal to allow the user 
to use an eService on one device (e.g. a desktop computer) while executing the identification 
on another device (e.g. the smartphone) with the eID-Client only running on the second device. 
The flow makes use of a QR code to allow an easy transition between devices.

## Demo video
https://github.com/digitalservicebund/useid-architecture/assets/4391042/c9641c93-9571-4ec4-a99d-8fd4e30fc6ee

## Overview

* The following section describes the desired QR-Code based flow.
* The [problem statement](problem-statement.md) lays out the problems with the desired solution bye means of a phishing attack scenario.
* The [evaluation of approaches](evaluation-of-approaches.md) shows an overview of all considered mitigation strategies
for the phishing attack vector.
* The [proposal](proposal-qr-code-based-device-switch-with-webauthn.md) describes a possible solution approach 
which makes use of WebAuthn to ensure a secure switch between devices.

## Flow

### Description

* The user starts an identification process with some eService on their desktop computer
* The eService shows a BundesIdent web widget which displays a QR code
  * The QR code encodes the `eID-Client URL` including the `tcTokenUrl` and a `widgetSessionId` which is unique to this very instance of the web widget
* The user scans the QR Code with their smartphone which opens the eID-Client on the smartphone
* The eID-Client fetches the `tcToken` with the `tcTokenUrl` from the QR Code
* The user identifies with scanning their ID card
* The eID-Client sends the user’s identity data to the eID-Server
* The eID-Client sends a success message to the UseID backend service along with the `widgetSessionId`
* The UseID backend identifies the web widget instance of the user using the `widgetSessionId` and propagates the success message to it 
(via [Server-Sent Events](https://www.w3.org/TR/2021/SPSD-eventsource-20210128/), [Long Polling](https://www.rfc-editor.org/rfc/rfc6202#section-2), [WebSocket](https://www.rfc-editor.org/rfc/rfc6455) or similar means).
* The widget redirects the users browser on the desktop computer to the `refreshAddress` of the eService
* The eService fetches the identity data of the user from the eID-Server
* The user is now identified against the eService running in the browser on the desktop computer 

### Sequence diagram

```mermaid
sequenceDiagram
    autonumber
    
    actor user as User
    participant browser as Browser
    participant eService as eService
    participant server as eID Server
    participant widget as UseID Web-Widget
    participant backend as UseID Backend Server
    participant smartphone as Smartphone
    participant app as UseID Mobile App (eID Client)
    participant id as ID card
    
    user ->> browser: open
    browser ->> eService: access webapp
    eService ->> server: start session
    server -->> eService: return session identifier <br>[eIDSessionId]
    eService ->> eService: generate <br>[tcTokenURL]
    eService ->> widget: integrate script which creates iframe <br>[tcTokenURL]
    widget ->> backend: (iframe) get widget page
    backend -->> widget: return widget page <br>[widgetSessionId]
    widget ->> widget: generate <br>[widgetSessionSecret]
    widget ->> backend: open SSE channel <br>[widgetSessionId]
    backend -->> widget: return
    widget ->> widget: generate QR Code <br>[eIDClientURL incl. tcTokenURL, widgetSessionId, widgetSessionSecret]
    widget -->> user: display widget
    user ->> smartphone: open camera
    smartphone ->> widget: scan QR Code
    widget -->> smartphone: return <br>[eIDClientURL]
    smartphone ->> app: open via eIDClientURL <br>[tcTokenURL, widgetSessionId, widgetSessionSecret]
    app ->> eService: get tcToken from tcTokenURL
    eService -->> app: return <br>[tcToken]
    app ->> server: establish connection
    server -->> app: return <br>[list of requested data]
    app -->> user: display requested data
    user ->> app: approve data request
    app ->> smartphone: access NFC reader
    smartphone ->> id: scan NFC chip
    id -->> smartphone: return <br>[encrypted identity data]
    smartphone -->> app: return <br>[encrypted identity data]
    app ->> server: send <br>[encrypted identity data]
    server ->> server: decrypt data <br>[identity data] 
    server -->> app: return success
    app ->> app: encrypt refreshURL with widgetSessionSecret <br>[encrypted refreshURL]
    app ->> backend: inform about success <br>[encrypted refreshURL, widgetSessionId]
    backend ->> widget: inform about success (via SSE) <br>[encrypted refreshURL, widgetSessionId]
    widget ->> widget: decrypt refreshURL with widgetSessionSecret <br>[refreshURL]
    widget ->> browser: redirect to <br>[refreshURL]
    browser ->> eService: access success page
    eService ->> server: get identity data <br>[eIDSessionId]
    server -->> eService: return identity data <br>[identity data]
    eService -->> browser: refresh page
    browser -->> user: view page
```
