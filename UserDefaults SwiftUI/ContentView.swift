//
//  ContentView.swift
//  UserDefaults SwiftUI
//
//  Created by Saif on 31/10/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct UserData: Codable {
    var firstName: String = ""
    var lastName: String = ""
}

struct ContentView: View {
    
    @State private var user = UserData()
    @State private var fName = ""
    @State private var lName = ""
    
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        VStack {
//            Button("Tap count is - \(tapCount)") {
//                self.tapCount += 1
//                UserDefaults.standard.set(self.tapCount, forKey: "Tap")
//            }
            Text("Saved data - \(fName) \(lName)")
            
            TextField("firstName",text: $user.firstName)
            TextField("lastName",text:  $user.lastName)
            
            Button("Save User details") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserDetails")
                }
            }
            .padding()
            Button("Fetch data") {
                self.fetchUserDetails()
            }
            .padding()
        }
    .padding()
    }
    
    
    func fetchUserDetails() {
        let data = UserDefaults.standard.value(forKey: "UserDetails")
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode(UserData.self, from: data as! Data) {
            self.fName = decodedData.firstName
            self.lName = decodedData.lastName
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
