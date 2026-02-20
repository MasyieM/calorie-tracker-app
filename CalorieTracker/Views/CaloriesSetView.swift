//
//  CalorieSetView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 18/02/2026.
//

import SwiftUI

struct CaloriesSetView: View {
    
    @StateObject var vm: DataStore
    @State var caloriesLimitInput: Int?
    @Binding var isCaloriesSetViewPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
//-------------------------------- X BUTTON --------------------------------//
                Button {
                    isCaloriesSetViewPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.8))
                }
            }
            Text("Daily calorie limit")
                .bold()
                .font(.title3)
            TextField("0", value: $caloriesLimitInput, formatter: AppFormatters.integer)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .frame(width: 150)
            
            Button {
                
                guard
                    let calories = caloriesLimitInput,
                    calories > 0
                else { return }
                
                if let calories = caloriesLimitInput {
                    vm.updateDailyCalories(calories: calories)
                } else {
                    print("Calories input is invalid.")
                }
                
                isCaloriesSetViewPresented = false

            } label: {
                Text("Save")
                    .foregroundStyle(Color.white)
                    .padding(10)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(7)
            }

        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CaloriesSetView(
        vm: DataStore(),
        isCaloriesSetViewPresented: .constant(true)
    )
}
