## Paula flow

The following flow displays the "Paula" eID flow. Paula depicts the flow for customers without eID integration using a simplified API provided by the Backend Server. 
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
    eService ->> backend: start flow
    backend ->> server: start session
    server -->> backend: return session identifier [sessionId]
    backend ->> backend: generate tcTokenURL
    backend -->> eService: return [tcTokenURL]
    eService ->> widget: integrate and send [tcTokenURL]
    widget ->> backend: get widget with QR Code [tcTokenURL]
    backend ->> backend: generate QR Code [eIDClientURL]
    backend -->> widget: return widget
    widget -->> user: display widget
    user ->> smartphone: open camera
    smartphone ->> widget: scan QR Code
    widget -->> smartphone: return [eIDClientURL]
    smartphone ->> app: open [tcTokenURL]
    app ->> backend: get tcToken from tcTokenURL
    backend -->> app: return [tcToken]
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
    eService ->> backend: get identity data [sessionId]
    backend ->> server: get identity data [sessionId]
    server -->> backend: return [decrypted identity data]
    backend -->> eService: return [decrypted identity data]
    eService -->> browser: refresh page
    browser -->> user: view page
```