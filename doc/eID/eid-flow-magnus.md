## Magnus flow

The following flow displays the "Magnus" eID flow. Magnus depicts the flow which applies for customers who already have an existing eID integration. 
See [this confluence page](https://digitalservicebund.atlassian.net/wiki/spaces/UseID/pages/438829109/Components+and+Flows) for more information.

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
    server -->> eService: return session identifier [sessionId]
    eService ->> eService: generate tcTokenURL
    eService ->> widget: integrate and send [tcTokenURL]
    widget ->> backend: get widget with QR Code [tcTokenURL]
    backend ->> backend: generate QR Code [eIDClientURL]
    backend -->> widget: return widget
    widget -->> user: display widget
    user ->> smartphone: open camera
    smartphone ->> widget: scan QR Code
    widget -->> smartphone: return URL to eID Client [eIDClientURL]
    smartphone ->> app: open [tcTokenURL]
    app ->> eService: get tcToken from tcTokenURL
    eService -->> app: return tcToken [tcToken]
    app ->> server: establish connection
    server -->> app: return [list of requested data]
    app -->> user: display requested data
    user ->> app: approve data request
    app ->> smartphone: access NFC reader
    smartphone ->> id: scan NFC chip
    id -->> smartphone: return [encrypted identity data]
    app ->> server: send [encrypted identity data]
    server ->> server: decrypt [encrypted identity data]
    server -->> app: return success
    app ->> backend: inform about success [sessionId]
    backend ->> widget: inform about success (via SSE) [sessionId]
    widget ->> browser: redirect to [refreshAddress]
    browser ->> eService: access success page
    eService ->> server: get identity data [sessionId]
    server -->> eService: return identity data [decrypted identity data]
    eService -->> browser: refresh page
    browser -->> user: view page
```