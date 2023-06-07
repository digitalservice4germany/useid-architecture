# Problem statement for the device switch

## Problem 

The `tcTokenUrl` and the corresponding `refreshAddress` inside the `tcToken` contain sensitive information.
By using phishing, an attacker can start a legitimate flow with an eService, forward the `tcTokenUrl` to a victim,
who identifies for this session, and call the `refreshAddress` of the victim on their device.
Since there is no second authentication to the `refreshAddress`, just by knowing and being the first
one to open it, the attacker can impersonate the user.

## Phishing attack

* The attacker starts a legit identification flow with some eService on his device
* The attacker reads the QR code from the displayed page
  * The QR code contains the `tcTokenUrl` and a `widgetSessionId` which let’s the UseID Backend identify this instance of the widget
* The attacker creates a phishing website which looks like the original eService and includes a fake version of the widget including the attackers QR code
* The attacker tricks the user to open the website and start an identification flow with the attacker’s QR Code
* The user scans the QR Code with their smartphone which opens the eID-Client
* The eID-Client fetches the `tcToken` of the attacker with the `tcTokenUrl` from the QR Code
  * Note: The `tcToken` includes the `sessionId` of the attackers session with the eID-Server
* The user identifies with scanning their ID card
* The eID-Client sends the user’s identity data to the eID-Server with the `sessionId` of the attacker
* The eID-Client sends a success message to the UseID backend with the `widgetSessionId` of the attacker
* The UseID backend propagates the success message to the widget of the attacker using the `widgetSessionId`
* The widget redirects the attackers browser to the `refreshAddress` of the legit eService
* The eService fetches the identity data of the user from the eID-Server using the attackers `sessionId`
* The attacker now impersonates the user on the eService website
