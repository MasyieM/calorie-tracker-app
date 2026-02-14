//
//  AddMealView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 13/02/2026.
//

import SwiftUI

struct AddMealView: View {
    
    enum Field { case food, calories }
    
    @StateObject var mealDataStore =  MealDataStore()
    @State var mealTimeSelection: MealTime = .none
    @State var foodInput: String = ""
    @State var caloriesInput: Int?
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
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
            .padding(.bottom, 20)
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
            Button {
                mealDataStore.addMealEntry(food: foodInput, calories: caloriesInput ?? 0, mealTime: mealTimeSelection)
                dismiss()
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
    }
}

#Preview {
    AddMealView()
}
