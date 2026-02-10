//
//  TopCardView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct CalorieView: View {
    var totalCalories: Int = 1000
    var dailyLimit: Int = 2000 //values are placeholders for now
    var calorieBalance: Int { dailyLimit - totalCalories }
    
    var body: some View {
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
                Text("\(calorieBalance) / \(dailyLimit) cal")
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            .cornerRadius(20)
        }
        
    }
}

#Preview {
    CalorieView()
}
