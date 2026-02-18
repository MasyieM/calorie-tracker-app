//
//  AddMealView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 13/02/2026.
//

import SwiftUI

struct AddMealView: View {
    
    enum Field { case food, calories }
    
    @StateObject var mealDataStore = MealDataStore()
    @State var mealTimeSelection: MealTime = .none
    @State var foodInput: String = ""
    @State var caloriesInput: Int?
    @FocusState private var focusedField: Field?
    var mealToEdit: MealEntry?
    @Binding var isAddMealViewPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
//-------------------------------- X BUTTON --------------------------------//
                Button {
                    isAddMealViewPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.8))
                }
            }
            .padding(.bottom, 20)
//-------------------------------- MEAL PICKER --------------------------------//
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
            .padding(.bottom, 20)
            
            VStack {
//-------------------------------- FOOD INPUT --------------------------------//
                VStack {
                    Text("Food")
                        .bold()
                        .font(.title3)
                    TextField("What did you nom nom today?", text: $foodInput)
                        .focused($focusedField, equals: .food)
                        .multilineTextAlignment(.center)
                        .padding(15)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .frame(width: 300)
                }
                .padding(.bottom, 20)
//-------------------------------- CALORIES INPUT --------------------------------//
                VStack {
                    Text("Calories")
                        .bold()
                        .font(.title3)
                    TextField("0", value: $caloriesInput, formatter: AppFormatters.integer)
                        .focused($focusedField, equals: .calories)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(15)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .frame(width: 300)
                }
            }
            .padding()
//-------------------------------- SAVE BUTTON --------------------------------//
            Button {
                
                guard
                    !foodInput.isEmpty,
                    mealTimeSelection != .none,
                    let calories = caloriesInput,
                    calories > 0
                else { return }
                
                if let existingMeal = mealToEdit {
                    mealDataStore.editMealEntry(
                        id: existingMeal.id,
                        newFood: foodInput,
                        newCalories: calories,
                        newMealTime: mealTimeSelection
                    )
                } else {
                    
                    mealDataStore.addMealEntry(
                        food: foodInput,
                        calories: calories,
                        mealTime: mealTimeSelection
                    )
                }
                
                isAddMealViewPresented = false

                
            } label: {
                Text("Save")
                    .foregroundStyle(Color.white)
                    .padding(15)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(7)
            }
        }
        .padding()
        .onAppear {
            if let meal = mealToEdit {
                foodInput = meal.food
                caloriesInput = meal.calories
                mealTimeSelection = meal.mealTime
            } else {
                foodInput = ""
                caloriesInput = nil
                mealTimeSelection = .none
            }
        }
    }
}
#Preview {
    AddMealView(
        mealDataStore: MealDataStore(),
        mealToEdit: nil,
        isAddMealViewPresented: .constant(true)
    )
}
