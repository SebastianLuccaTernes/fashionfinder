//
//  CookieConsentView.swift
//  fashionfinder
//
//  Created by Tobias Wedel on 23.03.24.
//

import SwiftUI

struct CookieConsentView: View {
    @State private var consentGiven: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Spacer()
                    Text("Use of Cookies")
                        .font(.custom("BaseNeueTrial-ExtraLight", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.custom("BaseNeueTrial-ExtraLight", size: 16))
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: acceptCookies) {
                        Text("ACCEPT ALL COOKIES")
                            .font(.custom("BaseNeueTrial-Regular", size: 16))
                            .padding()
                            .foregroundColor(.white)
                        
                    }
                    .buttonStyle(CookiesConsentButtonStyle())
                    
                    NavigationLink(destination: CookieSettingView()) {
                        Text("COOKIE SETTINGS")
                    }
                    .buttonStyle(CookiesConsentButtonStyle())
                    .padding()
                    
                    Button(action: rejectCookies) {
                        Text("REJECT OPTIONAL COOKIES")
                            .font(.custom("BaseNeueTrial-Regular", size: 16))
                            .padding()
                        
                    }
                    .buttonStyle(CookiesConsentButtonStyle())
                }
            }
            .background(.black)
        }
    }

func acceptCookies() {
    UserDefaults.standard.set(true, forKey: "allowCookies")
        // Set a cookie or save to local storage that consent is given
    }
    
func rejectCookies() {
        UserDefaults.standard.set(false, forKey: "allowCookies")
    }
}


#Preview {
    CookieConsentView()
}
