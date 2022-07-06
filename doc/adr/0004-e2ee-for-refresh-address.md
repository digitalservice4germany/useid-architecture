# 4. E2EE for Refresh Address

Date: 2022-06-24

## Status

Accepted

## Context

The eService (Service Provider) creates a `tcTokenURL` for the eID client to get the TC token. Inside this token, there is a `refreshAddress` for the user to be redirected to after the eID process is finished.

The eService (Service Provider) embeds a widget containing a QR code for the eID client (mobile app) to scan. The QR code contains the `tcTokenURL`. Inside the eID client, the URL is read, the token is fetched and used for the eID process. After that process is finished, the eID client needs to push this address to the widget for the browser to redirect the user to it.

For the communication channel between web widget in the browser and eID client on a mobile device, a server is established as message proxy, because the devices can't communicate directly.

## Decision

We create an end-to-end encrypted channel between web widget and mobile client for E2EE communication. The key is generated in the user's browser and handed over to the mobile app via QR code.

After finishing the eID process on the mobile device, the app encrypts the `refreshAddress` and send the ciphertext (via message proxy server) to the widget, which decrypts the message.

We use symmetric encryption, since it's easy to implement, fast, and we don't need any features of public-key cryptography.

As cipher, we use AES-GCM with 256-bit keys, which is fast, authenticated and [supported via Web Crypto API](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto) by modern browsers.

## Consequences

The message proxy server can't read any message. The `refreshAddress` is securely exchanged between mobile app and (desktop) browser, so only the authorized parts in this process (i.e. only the user's devices) are able to read the `refreshAddress`.

The work for the client-side script inside the widget becomes heavier. We need secure crypto implementations and a strong key generation inside the widget.

We need to encode the key inside the QR code without sending it to the server.
