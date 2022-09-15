# UseID Integration

To integrate UseID mobile app and web widget, the following steps are necessary for services already having an existing eID integration.

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

> The eService usually presents a link to the user which points to the eID client application (e.g. AusweisApp2) including the tcTokenURL as a query parameter. With UseID, this is replaced by the web widget displaying a QR code which can be scanned to start the UseID mobile app.

### 2. ID process

The underlying eID technology has not changed for the eService, including the process steps of scanning the identification document and PIN entry. Changes for the users are in using the UseID mobile app on their smartphones as scanning devices.

### 3. Success and Refresh

The user is returned to the `refreshAddress` of the eService, which is provided in the TC token, on the device displaying the widget.

## Security

Instead of staying on the same device, a QR code is displayed to be scanned by the user's smartphone. At success, the user returns to the page displaying the widget and gets forwarded to the refresh address. The embedded widget (locally in the browser) and the smartphone establish an end-to-end encrypted channel so that any communication going through UseID servers can only be interpreted by the user's devices; especially `tcTokenURL` and `refreshAddress` are never exposed to UseID servers.

Otherwise, see [Technical Guideline TR-03130](https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR03130/TR-03130_TR-eID-Server_Part1.pdf?__blob=publicationFile&v=3) for more information.
