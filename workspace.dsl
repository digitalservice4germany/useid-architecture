workspace "UseID" "Systemarchitektur" {
    model {
        eidServer = softwareSystem "eID-Server" "" "Existing System" {
        }

        nkb = softwareSystem "NKB" "" "Existing System" {
            -> eidServer "" ""
        }

        trustService = softwareSystem "Vertrauensdiensteanbieter" "" "Existing System" {
            -> eidServer "" ""
        }

        administrativeProcedure = softwareSystem "Fachverfahren" "" "Existing System, Web Browser" {
            -> trustService "" ""
        }

        app = softwareSystem "Bund ID App" "" "Software System" {
            mobileApp = container "Mobile App" "" "iOS/Android" "App" {
                eidClient = component "eID Client" "" "" {
                    -> eidServer "Schnittstelle" "HTTPS"
                }
                bundidAPIClient = component "bund ID API Client" "" "" {
                    -> nkb "Schnittstelle" "HTTPS"
                }

                -> trustService "Signatur" "QES"
            }
            qrCodeServer = container "QR-Code-Server" "Web-based API" "Java, Spring WebFlux" {
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
        }

        component mobileApp "AppComponents" {
            include *
            autoLayout
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
            element "Component" {
                shape Component
                background #85bbf0
                color #000000
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