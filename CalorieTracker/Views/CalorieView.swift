//
//  TopCardView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct CalorieView: View {
    
    @StateObject var mealDataStore: MealDataStore
    @State private var showCaloriesSetView: Bool = false
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
//------------------------------ CALORIES SET VIEW OVERLAY ------------------------------//
                        if showCaloriesSetView {
                            
                            ZStack {
                                CaloriesSetView(
                                    mealDataStore: mealDataStore,
                                    isCaloriesSetViewPresented: $showCaloriesSetView
                                )
                                .frame(width: 350, height: 160)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                                .transition(.scale.combined(with: .opacity))
                                .zIndex(1)
                            }
                        }
        }
    }
}

#Preview {
    CalorieView(mealDataStore: MealDataStore.makePreview())
}
