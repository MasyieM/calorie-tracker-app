//
//  CalorieTrackerApp.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

@main
struct CalorieTrackerApp: App {
    
    @StateObject var vm = DataStore()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
        }
    }
}
