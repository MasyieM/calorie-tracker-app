//
//  MealDataStore.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import Foundation
import SwiftUI
import Combine

class MealDataStore: ObservableObject {
    
    @Published var mealEntries: [MealEntry] = [MealEntry(food: "Eggs", calories: 200, mealTime: .breakfast), //full of samples for view building purposes
                                               MealEntry(food: "Toast", calories: 150, mealTime: .breakfast),
                                               MealEntry(food: "Chicken Rice", calories: 600, mealTime: .lunch),
                                               MealEntry(food: "Pasta", calories: 500, mealTime: .dinner)]
    
    func addMealEntry(food: String, calories: Int, mealTime: MealTime){
        let mealEntry = MealEntry(food: food, calories: calories, mealTime: mealTime) //with each add function, instances the struct
        mealEntries.append(mealEntry)
    }
    
    func getMealEntry(for mealTime: MealTime) -> [MealEntry]{
        return mealEntries.filter { $0.mealTime == mealTime } //filters the entries for categorising in the view
    }
    
    func editMealEntry(id: UUID, newFood: String, newCalories: Int, newMealTime: MealTime){
        if let index = mealEntries.firstIndex(where: { $0.id == id }) {
            mealEntries[index].food = newFood
            mealEntries[index].calories = newCalories
            mealEntries[index].mealTime = newMealTime
        } else {
            print("Error: Entry not found!")
        }
    }
    
    func deleteMealEntry(id: UUID){
        if let index = mealEntries.firstIndex(where: { $0.id == id }) {
            mealEntries.remove(at: index)
        } else {
            print("Error: Entry not found!")
        }
    }
}
