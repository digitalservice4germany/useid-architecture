# BundesIdent Integration

To integrate the BundesIdent mobile app and web widget, the following steps are necessary for services already having an existing eID integration.

## Integration

### 1. Embedding Widget

eService embeds widget via JavaScript by adding the following empty container to the HTML page:

```html
<div id="useid-widget-container" data-tc-token-url="{}"></div>
```

and including this script in the page:

```html
<script async src="https://eid.digitalservicebund.de/widget.js"></script>
```

As value for `data-tc-token-url` the already known tcTokenURL is used.

> The eService usually presents a link to the user which points to the eID client application (e.g. AusweisApp2, BundesIdent) including the tcTokenURL as a query parameter. With BundesIdent, this is handled by the web widget to increase the recognition value.

### 2. ID process

The underlying eID technology has not changed for the eService, including the process steps of scanning the identification document and PIN entry. Changes for the users are in using the BundesIdent mobile app on their smartphones as scanning devices.

### 3. Success and Refresh

The user is returned to the `refreshAddress` of the eService, which is provided in the TC token.
