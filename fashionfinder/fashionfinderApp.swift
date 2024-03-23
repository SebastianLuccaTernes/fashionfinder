//
//  fashionfinderApp.swift
//  fashionfinder
//
//  Created by Sebastian Ternes on 06.03.24.
//

import SwiftUI

@main
struct fashionfinderApp: App {
    @AppStorage("hasShownCokieConsent") var hasShownCookieConsent: Bool = false
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}

/* if hasShownCookieConsent {
 SplashScreenView() // Ihre Hauptansicht
} else {
 CookieConsentView(hasShownCookieConsent: $hasShownCookieConsent)
}
}*/
