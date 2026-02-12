//
//  MealListView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct MealListView: View {
    @StateObject var mealDataStore =  MealDataStore()
    
    var body: some View {
        List {
            ForEach(MealTime.allCases, id: \.self) { mealTime in
                let mealsForTime = mealDataStore.mealEntries.filter { $0.mealTime == mealTime }
                
                Section(header: Text(mealTime.rawValue.capitalized)) {
                    if mealsForTime.isEmpty{
                        Text("+ Add")
                    } else {
                        ForEach(mealsForTime) { entry in
                            HStack {
                                Text(entry.food)
                                Spacer()
                                Text("\(entry.calories) cal")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Text("Total Calories: ")
                    }
                }
            }
        }
    }
}

#Preview {
    MealListView(mealDataStore: MealDataStore.makePreview())
}
