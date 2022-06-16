## Paula flow

The following flow displays the "Paula" eID flow. Paula depicts the flow for customers without eID integration using a simplified API provided by the Backend Server. 
See [this confluence page](https://digitalservicebund.atlassian.net/wiki/spaces/UseID/pages/438829109/Components+and+Flows) for more information.

```plantuml
@startuml
'https://plantuml.com/sequence-diagram

autonumber

user as "User" ->browser: open
browser as "Browser" -> eService: access webapp
eService -> backend as "UseID Backend Server": start flow
backend -> server as "eID Server": start session
backend <-- server: return session identifier
note right: sessionId
backend -> backend: generate tcTokenURL
eService <-- backend: return tcTokenURL
note right: tcTokenURL
eService -> widget as "UseID Web-Widget": integrate and send tcTokenURL
note left: tcTokenURL
widget -> backend: get widget with QR Code
note left: tcTokenURL
backend -> backend: generate QR Code
note left: eIDClientURL
widget <-- backend: return widget
user <-- widget: display widget
user -> smartphone as "Smartphone": open camera
smartphone -> widget: scan QR Code
smartphone <-- widget: return URL to eID Client
note left: eIDClientURL
smartphone -> app as "UseID Mobile App (eID Client)": open
note left: tcTokenURL
app -> backend: get tcToken from tcTokenURL
app <-- backend: return tcToken
note right: tcToken
app -> server: establish connection
app <-- server: return list of requested data
note left: list of requested data
user <-- app: display requested data
user -> app: approve data request
app -> smartphone: access NFC reader
smartphone -> id as "ID card": scan NFC chip
smartphone <-- id: return encrypted identity data
note right: encrypted identity data
app -> server: send encrypted identity data
note right: encrypted identity data
server -> server: decrypt data
note left: encrypted identity data
app <-- server: return success
app -> backend: inform about success
note right: sessionId
backend -> widget: inform about success (via SSE)
note right: sessionId
widget -> browser: redirect to refreshAddress
note right: refreshAddress
browser -> eService: access success page
eService -> backend: get identity data
note left: sessionId
backend -> server: get identity data
note left: sessionId
backend <-- server: return identity data
note right: decrypted identity data
eService <-- backend: return identity data
note right: decrypted identity data
eService --> browser: refresh page
browser --> user: view page

@enduml
```