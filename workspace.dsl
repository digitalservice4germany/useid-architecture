workspace "UseID" "Systemarchitektur" {
    model {
        eidServer = softwareSystem "eID-Server" "" "Existing System" {
        }

        nkb = softwareSystem "NKB" "" "Existing System" {
            -> eidServer "Schnittstelle" ""
        }

        app = softwareSystem "Bund ID App" "" "Software System" {
            mobileApp = container "Mobile Applikation" "" "iOS/Android" "App" {
                -> nkb "Schnittstelle" "HTTPS"
                -> eidServer "Schnittstelle" ""
            }
        }

        person "Nutzer:in" {
            -> mobileApp "Verwendet"
        }
    }

    views {
        systemContext app "System-Kontext" "" {
            include *
            autoLayout
        }

        container app "Containers" {
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
            element "App" {
                shape MobileDevicePortrait
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