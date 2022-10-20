workspace "UseID" "System Architecture" {

    !identifiers hierarchical

    model {

        user = person "User"

        d_trust = group "D-Trust" {
            eid_server = softwareSystem "eID-Server" "" "Existing System" {
                 description "Receives and decrypts identity data"
            }
        }

        eservice = softwareSystem "eService" "" "Existing System, Web Browser" {
            description "Provides Online-Service for user"

            user -> this "uses" "HTTPS, Web UI"
        }

        ds = enterprise "DigitalService" {

            useid_backend = softwareSystem "UseID Backend" "Kotlin, Spring WebFlux" "Software System" {
                description "Integrates with eID-Server and provides Web-Widget"

                eservice -> this "includes Web-Widget and fetches identity data"
                -> eid_server "get decrypted identity data"
            }

            bundes_ident = softwareSystem "BundesIdent" "iOS/Android" "App" {
                description "Reads data from ID card"

                user -> this "uses" "App"
                -> useid_backend "get tcToken"
                -> eid_server "sends encrypted identity data"
            }
        }

    }

    views {
        systemLandscape {
            include *
            title "Paula Flow"
            description "The Paula flow depicts the integration for eServices without existing eID integration."
            autolayout
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
            element "Database" {
                shape Cylinder
            }
        }


        terminology {
            softwareSystem Software-System
        }
}