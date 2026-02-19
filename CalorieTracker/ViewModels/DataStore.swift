//
//  DataStore.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import Foundation
import SwiftUI
import Combine

class DataStore: ObservableObject {
    
    @Published var mealEntries: [MealEntry] = []
    @Published var caloriesDailyLimit: Int = 2000 //2000 is default, can be changed via the UI if desired
    
    var totalDailyCalories: Int {
        mealEntries.reduce(0) { $0 + $1.calories }
    }
    
    var dailyCaloriesBalance: Int {
        caloriesDailyLimit - totalDailyCalories
    }
    
//------------------------------------ MEAL CRUD ------------------------------------//
    
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

//------------------------------------ UPDATE DAILY CALORIES FUNCTION ------------------------------------//
    
    func updateDailyCalories(calories: Int){
        caloriesDailyLimit = calories
    }

//------------------------------------ TOTAL CALORIES CALCULATION ------------------------------------//
    
    func calculateTotalCaloriesPerMealTime(mealTime: MealTime) -> Int {
        let filteredMeals = mealEntries.filter { $0.mealTime == mealTime }
        let total = filteredMeals.reduce(0) { $0 + $1.calories }
        return total
    }
    
//------------------------------------ PREVIEW SAMPLE DATA FUNCTION ------------------------------------//
    static func makePreview() -> DataStore {
        let sampleDatabase = DataStore()
        
        sampleDatabase.caloriesDailyLimit = 2000
        
        sampleDatabase.mealEntries = [
                MealEntry(food: "Oatmeal", calories: 250, mealTime: .breakfast),
                MealEntry(food: "Chicken Salad", calories: 400, mealTime: .lunch),
                MealEntry(food: "Apple", calories: 80, mealTime: .snack),
                MealEntry(food: "Yogurt", calories: 120, mealTime: .snack)
        ]
        return sampleDatabase
    }
}
