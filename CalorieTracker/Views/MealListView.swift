//
//  MealListView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct MealListView: View {
    @StateObject var mealDataStore =  MealDataStore()
    @State private var showAddMealView: Bool = false
    @State private var mealToEditData: MealEntry? = nil
    
    var body: some View {
        ZStack (alignment: .top) {
//-------------------------------- LIST --------------------------------//
            List {
                ForEach(MealTime.allCases.filter { $0 != .none }) { mealTime in
                    let mealsForTime = mealDataStore.mealEntries.filter { $0.mealTime == mealTime }
                    
                    Section(header: Text(mealTime.rawValue.capitalized)) {
                        if mealsForTime.isEmpty{
                             Text("No food added")
                                .foregroundColor(Color.black.opacity(0.6))
                                .italic()
                        } else {
                            ForEach(mealsForTime) { entry in
                                HStack {
                                    Text(entry.food)
                                    Spacer()
                                    Text("\(entry.calories) cal")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
//----------------------------- LIST ONSWIPE ACTIONS -----------------------------//
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//-------------------------------- DELETE BUTTON --------------------------------//
                                    Button {
                                        mealDataStore.deleteMealEntry(id: entry.id)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(.blue)
//-------------------------------- EDIT BUTTON --------------------------------//
                                    Button {
                                        mealToEditData = entry
                                        showAddMealView = true
                                    } label: {
                                        Label("", systemImage: "pencil")
                                    }
                                    .tint(.orange)
                                }
                            }
//-------------------------------- TOTAL CALORIES --------------------------------//
                            HStack {
                                Text("Total Calories: ")
                                Spacer()
                                Text("total cal here")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .padding(.top, 60)
//-------------------------------- CUSTOM TOP BAR --------------------------------//
            HStack {
                Text("Meals")
                    .font(.title2)
                    .bold()
                Spacer()
//-------------------------------- ADD MEAL BUTTON --------------------------------//
                Button {
                    mealToEditData = nil
                    showAddMealView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .frame(height: 30)
            .padding()
            .background(Color.white.opacity(0.9))
            
//------------------------------ ADD MEAL VIEW OVERLAY ------------------------------//
            if showAddMealView {
                
                ZStack {
                    AddMealView(
                        mealDataStore: mealDataStore,
                        mealToEdit: mealToEditData,
                        isAddMealViewPresented: $showAddMealView
                    )
                    .frame(width: 350)
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
    MealListView(mealDataStore: MealDataStore.makePreview())
}
