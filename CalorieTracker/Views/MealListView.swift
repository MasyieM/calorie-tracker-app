//
//  MealListView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var mealDataStore = MealDataStore()
    
    var body: some View {
        List {
            ForEach(MealTime.allCases) { mealTime in
                let mealsForTime = mealDataStore.mealEntries.filter { $0.mealTime == mealTime }
                
                if !mealsForTime.isEmpty {
                    Section(header: Text(mealTime.rawValue.capitalized)) {
                        ForEach(mealsForTime) { entry in
                            HStack {
                                Text(entry.food)
                                Spacer()
                                Text("\(entry.calories) cal")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MealListView()
}
