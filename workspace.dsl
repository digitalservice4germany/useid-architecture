workspace "UseID" "Systemarchitektur" {
    model {
        nkb = softwareSystem "NKB" "" "Existing System" {
        }

        eidServer = softwareSystem "eID-Server" "" "Existing System" {
        }

        app = softwareSystem "bund ID App" "" "Software System" {
            -> nkb "Schnittstelle" "OAuth 2.0"
            -> eidServer "Schnittstelle" "SDK"
        }

        person "Nutzer:in" {
            -> app "Verwendet"
        }

        
    }

    views {
        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
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