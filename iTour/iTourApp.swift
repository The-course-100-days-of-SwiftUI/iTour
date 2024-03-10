//
//  iTourApp.swift
//  iTour
//
//  Created by Margarita Mayer on 13/12/23.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: Destination.self)
    }
}
