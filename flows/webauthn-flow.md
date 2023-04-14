## Magnus flow (mobile only)

The following flow displays the eID flow using WebAuthn. The focus is on the usage of WebAuthn to ensure channel binding for the device switch. To generalize, it depicts the flow which applies to customers who already have an existing eID integration.
See [this confluence page]([https://digitalservicebund.atlassian.net/wiki/spaces/UseID/pages/438829109/Components+and+Flows](https://digitalservicebund.atlassian.net/wiki/spaces/UseID/pages/638615676/Secure+QR-Code+based+device+switch+with+WebAuthn)) for more information.

```mermaid
sequenceDiagram
    autonumber
    
    actor user as User
    participant browser as Desktop Browser
    participant widget as Web-Widget
    participant smartphone as Smartphone
    participant app as eID Client mobile app
    participant eService as eService
    participant server as eID Server
    participant webAuthnServer as WebAuthnServer (WAS)
    
    user ->> browser: open
    browser ->> eService: access webapp
    eService -->> browser: sends page with embedded iframe
    eService ->> widget: inserts TcToken url into iframe
    widget ->> webAuthnServer: (iframe) get widget page
    webAuthnServer -->> widget: return widget page
    widget ->> widget: create key pair used for encryption of refreshURL
    widget -->> user: display QR code with TcTokenUrl + public key
    user ->> smartphone: use smartphone to scan QR code
    smartphone ->> app: open via link embedded in QR code
    app ->> eService: get tcToken from tcTokenURL
    eService ->> server: start session
    server -->> eService: return session identifier <br>[eIDSessionId]
    eService -->> app: return <br>[tcToken, cert hash + domain of WAS]
    app ->> server: establish connection
    Note over app, server: Normal eId flow interaction
    server -->> app: return success of eId interaction
    app ->> webAuthnServer: create TLS connection
    webAuthnServer -->> app: return <br>[TLS certificate]
    app ->> app: validate TLS connection with info from eService
    app ->> app: encrypt the determined refreshURL
    app ->> webAuthnServer: create Webauthn account + send <br> [encrypted refreshURL]
    webAuthnServer -->> app: returns <br> [userId, challenge]
    app ->> smartphone: create key pair <br> [userId, challenge]
    smartphone -->> app: returns <br> [signed challenge, generated public key]
    app ->> webAuthnServer: sends <br> [userId, signed challenge, generated public key]
    webAuthnServer -->> webAuthnServer: validate challenge + store public key with userId
    webAuthnServer ->> widget: send event to start WebAuthn authentication <br> [userId, challenge]
    widget ->> browser: request WebAuthn credentials by providing challenge
    browser ->> user: show WebAuthn interaction menu
    user -->> smartphone: use smartphone to provide credentials
    smartphone -->> browser: signs challenge using the credentials
    browser -->> widget: returns signed challenge
    widget -->> webAuthnServer: returns signed challenge
    webAuthnServer -->> webAuthnServer: validate challenge
    webAuthnServer -->> widget: returns <br>[success, encrypted refreshURL, hash of eService certificate]
    widget ->> widget: decrypts refreshURL
    widget ->> eService: create TLS connection
    eService -->> widget: return <br>[TLS certificate]
    widget ->> widget: validate TLS connection with info from WAS
    widget ->> browser: redirects to refreshURL
    browser ->> eService: access success page
    eService ->> server: get identity data <br>[eIDSessionId]
    server -->> eService: return <br>[identity data]
    eService -->> browser: display success page
    browser -->> user: view page
```
