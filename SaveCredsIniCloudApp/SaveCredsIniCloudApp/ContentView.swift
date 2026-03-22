//
// ContentView.swift
// SaveCredsIniCloudApp
//
// Created by MANAS VIJAYWARGIYA on 22/03/26.
// ------------------------------------------------------------------------
// 
// ------------------------------------------------------------------------
//
    


import SwiftUI

struct ContentView: View {
  @State private var username: String = ""
  @State private var password: String = ""
  
  var body: some View {
    VStack {
      TextField("Username", text: $username)
        .keyboardType(.emailAddress)
      SecureField("Password", text: $password)
        .keyboardType(.default)
      Button("Log In") {
        saveToSharedKeychain()
      }
    }
    .padding()
  }
  
  private func saveToSharedKeychain() {
    let domain = apiDomain
    let user = username
    let pass = password
    
    let cfDomain = domain as CFString
    let cfUser = user as CFString
    let cfPass = pass as CFString
    
    SecAddSharedWebCredential(cfDomain, cfUser, cfPass) { error in
      DispatchQueue.main.async {
        if let error {
          print("Keychain Error:", error)
        } else {
          print("Credentials saved successfully")
        }
      }
    }
  }
}

#Preview {
  ContentView()
}

// When the domain hosted and the same need to be added here in Associated Domain in Capabilities - webcredentials:apidomain.com
var apiDomain: String = "apidomain.com"
