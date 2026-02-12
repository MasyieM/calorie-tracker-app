//
//  MainView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            CalorieView()
            MealListView()
        }
        .padding()
    }
}

#Preview {
    MainView()
}
