//
//  TopCardView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct CalorieView: View {
    
    @StateObject var vm: DataStore
    @Binding var showCaloriesSetView: Bool
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Today's Calories")
                    .font(.title3)
                    .fontWeight(.heavy)
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(vm.totalDailyCalories)")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .monospacedDigit()
                            .frame(minWidth: 100, alignment: .trailing)
                        Text("cal")
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .padding(.trailing)
                    }
                    Text("Balance / Daily Goal")
                        .fontWeight(.semibold)
                    Text("\(vm.dailyCaloriesBalance) / \(vm.caloriesDailyLimit) cal")
                        .monospacedDigit()
                }
                .padding()
                .background(
                    vm.dynamicBackgroundColor(for: vm.totalDailyCalories, dailyLimit: vm.caloriesDailyLimit)
                        .opacity(0.6)
                )
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
        vm: DataStore.makePreview(),
        showCaloriesSetView: .constant(false)
    )
}
