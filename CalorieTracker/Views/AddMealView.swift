//
//  AddMealView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 13/02/2026.
//

import SwiftUI

struct AddMealView: View {
    @StateObject var mealDataStore =  MealDataStore()
    @State var mealTimeSelection: MealTime = .none
    @State var foodInput: String = ""
    @State var calorieInput: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.8))
                }
            }
            HStack {
                Text("Meal time:")
                    .bold()
                    .font(.title3)
                Picker("", selection: $mealTimeSelection) {
                    ForEach(MealTime.allCases) { meal in
                        Text(meal.rawValue.capitalized)
                            .tag(meal)
                    }
                }
                .border(Color.gray.opacity(0.3))
            }
            HStack {
                VStack {
                    Text("Food")
                        .bold()
                        .font(.title3)
                    TextField("", text: $foodInput)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                }
                .padding()
                VStack {
                    Text("Calories")
                        .bold()
                        .font(.title3)
                    TextField("", text: $calorieInput)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                }
                .padding()
            }
            Button {
                //save function
                dismiss()
            } label: {
                Text("Save")
                    .foregroundStyle(Color.white)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(7)
            }
        }
        .padding()
    }
}

#Preview {
    AddMealView()
}
