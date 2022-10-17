## Magnus flow (mobile only)

The following flow displays the "Magnus" eID flow. Magnus depicts the flow which applies for customers who already have an existing eID integration.
See [this confluence page](https://digitalservicebund.atlassian.net/wiki/spaces/UseID/pages/438829109/Components+and+Flows) for more information.

```mermaid
sequenceDiagram
    autonumber
    
    actor user as User
    participant browser as Mobile Browser
    participant eService as eService
    participant server as eID Server
    participant widget as UseID Web-Widget
    participant backend as UseID Backend Server
    participant smartphone as Smartphone
    participant app as UseID Mobile App (eID Client)
    participant id as ID card
    
    user ->> browser: open
    browser ->> eService: access webapp
    eService ->> widget: integrate script which creates iframe <br>[tcTokenURL]
    widget ->> backend: (iframe) get widget page
    backend -->> widget: return widget page<br>[eIDClientURL incl. tcTokenURL]
    widget -->> user: display widget
    user ->> smartphone: click deep link in widget<br>[eIDClientURL]
    smartphone ->> app: open via eIDClientURL <br>[tcTokenURL]
    app ->> backend: get tcToken from tcTokenURL
    backend ->> server: start session
    server -->> backend: return session identifier <br>[eIDSessionId]
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
    app -->> browser: open refresh address<br>[eIDSessionId]
    browser ->> eService: access success page
    eService ->> server: get identity data <br>[eIDSessionId]
    server -->> eService: return <br>[identity data]
    eService -->> browser: display success page
    browser -->> user: view page
```
