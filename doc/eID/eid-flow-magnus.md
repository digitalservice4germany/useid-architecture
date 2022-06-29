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
    server -->> eService: return session identifier <br>[eIDsessionId]
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
    eService ->> server: get identity data <br>[eIDsessionId]
    server -->> eService: return identity data <br>[identity data]
    eService -->> browser: refresh page
    browser -->> user: view page
```