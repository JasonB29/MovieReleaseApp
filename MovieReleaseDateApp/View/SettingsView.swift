//
//  SettingsView.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 05/09/2021.
//
//  This view handles the selection of the search parameters that are passed to the http query.
//  An API Key from TMDB is required to access the service, this value is stored in the UserDefaults
//  once inputted by the user.

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var apiKey = "\(UserDefaults.standard.value(forKey: "API_KEY") ?? "")"
    @State private var region = "GB"
    @State private var language = ""
    
    enum Languages: String, Identifiable {
        case en
        case fr
        case de
        case es
        case it
        
        var id: String {self.rawValue}
    }
    
    let regions = ["US", "GB", "FR", "DE", "ES", "IT"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please TMDB API KEY")) {
                    TextField("API Key: ", text: $apiKey)
                        .modifier(ClearButton(text: $apiKey))
                        .accessibilityIdentifier("API TextField")
                }
                
                Section(header: Text("Language")) {
                    Picker("Language", selection: $language) {
                        Text("English").tag(Languages.en.rawValue)
                        Text("French").tag(Languages.fr.rawValue)
                        Text("German").tag(Languages.de.rawValue)
                        Text("Spanish").tag(Languages.es.rawValue)
                        Text("Italian").tag(Languages.it.rawValue)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accessibilityIdentifier("languagePicker")
                }
                Section(header: Text("Region")) {
                    Picker("Region", selection: $region) {
                        ForEach(regions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accessibilityIdentifier("regionPicker")
                }
                
                Button(action: {
                    self.saveSettings()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
    }
    
    func saveSettings() {
        UserDefaults.standard.setValue(apiKey, forKey: "API_KEY")
        UserDefaults.standard.setValue(language, forKey: "LANGUAGE")
        UserDefaults.standard.setValue(region, forKey: "REGION")
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
