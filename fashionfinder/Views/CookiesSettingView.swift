//
//  CookiesSettingView.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 23.03.24.
//

import SwiftUI

// Die View für die Cookie-Einstellungen
struct CookieSettingView: View {
    @State private var allowCookies: Bool = UserDefaults.standard.bool(forKey: "allowCookies")

    var body: some View {
        Form {
            Toggle(isOn: $allowCookies) {
                Text("Cookies erlauben")
            }
            .onChange(of: allowCookies) { newValue in
                UserDefaults.standard.set(newValue, forKey: "allowCookies")
            }
        }
        .navigationBarTitle("Cookie-Einstellungen", displayMode: .inline)
    }
}


#Preview {
    CookieSettingView()
}
