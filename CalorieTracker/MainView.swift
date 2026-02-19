//
//  MainView.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm: DataStore
    @State private var showCaloriesSetView: Bool = false
    @State private var showAddMealView: Bool = false
    @State private var mealToEditData: MealEntry? = nil
    
    var body: some View {
        ZStack {
            VStack {
                CalorieView(
                    vm: vm,
                    showCaloriesSetView: $showCaloriesSetView
                )
                MealListView(
                    vm: vm,
                    showAddMealView: $showAddMealView
                )
            }
            .padding(.top, 30)
            
//------------------------------ CALORIES SET VIEW OVERLAY ------------------------------//
            if showCaloriesSetView {
                                        
                ZStack {
                    CaloriesSetView(
                        vm: vm,
                        isCaloriesSetViewPresented: $showCaloriesSetView
                    )
                    .frame(width: 300, height: 180)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
                }
            }
            
//------------------------------ ADD MEAL VIEW OVERLAY ------------------------------//
            if showAddMealView {
                            
                ZStack {
                    AddMealView(
                        vm: vm,
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
    MainView(vm: DataStore())
}
