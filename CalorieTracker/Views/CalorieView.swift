//
//  TopCardView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct CalorieView: View {
    
    @StateObject var mealDataStore: MealDataStore
    @Binding var showCaloriesSetView: Bool
    
    var totalCalories: Int = 1000
    var calorieBalance: Int = 200
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Today's Calories")
                    .font(.title3)
                    .fontWeight(.heavy)
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(totalCalories)")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        Text("cal")
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .padding(.trailing)
                    }
                    Text("\(calorieBalance) / \(mealDataStore.caloriesDailyLimit) cal")
                }
                .padding()
                .background(Color.blue.opacity(0.5))
                .cornerRadius(15)
                .overlay(
                    Button {
                        showCaloriesSetView = true
                    } label: {
                        Image(systemName: "gear")
                    }
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundStyle(Color.black.opacity(0.7))
                    .padding(8),
                    alignment: .topTrailing
                )
            }
        }
    }
}

#Preview {
    CalorieView(
        mealDataStore: MealDataStore.makePreview(),
        showCaloriesSetView: .constant(false)
    )
}
