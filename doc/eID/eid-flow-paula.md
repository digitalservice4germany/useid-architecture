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
    server -->> backend: return session identifier <br>[eIDSessionId]
    backend ->> backend: generate <br>[tcTokenURL, useIDSessionId]
    backend -->> eService: return <br>[tcTokenURL, useIDSessionId]
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
    app ->> backend: get tcToken from tcTokenURL
    backend -->> app: return <br>[tcToken]
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
    widget ->> browser: redirect to <br>[refreshAddress]
    browser ->> eService: access success page
    eService ->> backend: get identity data <br>[useIDSessionId]
    backend ->> server: get identity data <br>[eIDSessionId]
    server -->> backend: return <br>[identity data]
    backend -->> eService: return <br>[identity data]
    eService -->> browser: refresh page
    browser -->> user: view page
```