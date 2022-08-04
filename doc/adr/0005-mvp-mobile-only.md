# 5. MVP mobile only

Date: 2022-08-03

## Status

Accepted

Supercedes [4. E2EE for Refresh Address](0004-e2ee-for-refresh-address.md)

## Context

The device switch from mobile to desktop opens a door for phishing attacks in the current setup.

For the first use case, the goal is to develop an MVP.

## Decision

To reduce the complexity of the product, we focus on a mobile only flow.

We don't store any session information of the eService for the identification flow.

We store a static refresh address per eService, thus it will not be injected every time the eService starts a new session. For the tcToken, a sessionId is appended, which is individually for each new tcToken.

## Consequences

The mobile only flow makes all phishing attacks regarding the device switch impossible.

No session information means, that each call to the tcTokenURL creates a new tcToken.

The widget will only be displaying a link for the user to click and has no server sent events, no secret and no encryption of the refresh address, because there is no back channel to the widget.

