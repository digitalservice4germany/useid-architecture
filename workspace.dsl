workspace "UseID" "Systemarchitektur" {
    model {
        eidServer = softwareSystem "eID-Server" "" "Existing System" {
        }

        nkb = softwareSystem "NKB" "" "Existing System" {
            -> eidServer "Schnittstelle" ""
        }

        trustService = softwareSystem "Vertrauensdiensteanbieter" "" "Existing System" {
            -> eidServer "Schnittstelle" ""
        }

        administrativeProcedure = softwareSystem "Fachverfahren" "" "Existing System, Web Browser" {
            -> trustService "Schnittstelle" ""
        }

        app = softwareSystem "Bund ID App" "" "Software System" {
            mobileApp = container "Mobile Applikation" "" "iOS/Android" "App" {
                -> nkb "Schnittstelle" "HTTPS"
                -> trustService "Signatur" "QES"
                -> eidServer "Schnittstelle" ""
            }
            qrCodeServer = container "QR-Code-Server" "" "Java" {
            }
        }
        administrativeProcedure -> mobileApp "Leitet auf" "QR Code"
        administrativeProcedure -> qrCodeServer "Schnittstelle" "HTTPS"

        person "Nutzer:in" {
            -> mobileApp "Verwendet"
            -> administrativeProcedure "Verwendet"
        }
    }

    views {
        container app "Containers" {
            include *
            autoLayout
            title "Bund ID app Architecture"
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "App" {
                shape MobileDevicePortrait
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
        }

        terminology {
            softwareSystem Software-System
        }
    }
}