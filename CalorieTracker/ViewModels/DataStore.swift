//
//  DataStore.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class DataStore: ObservableObject {
    
    @Published var mealEntries: [MealEntryData] = []
    @Published var caloriesDailyLimit: Int = 2000 //2000 is default, can be changed via the UI if desired
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MealEntryContainer")
        container.loadPersistentStores { (descriptionOfError, error) in
            if let error = error {
                print("Error - Unable to load core data \(error)")
            } else {
                print("Success - Core data loaded successfully!")
            }
        }
    }
    
    //fetches data from the Core Data entity to populate the mealEntries array
    func fetchData() {
        let request = NSFetchRequest<MealEntryData>(entityName: "MealEntryData")
        
        do {
            mealEntries = try container.viewContext.fetch(request)
        } catch let error {
            print("Fetch data failed. Error: \(error)")
        }
    }
    
    var totalDailyCalories: Int {
        Int(mealEntries.reduce(0) { $0 + $1.calories })
    }
    
    var dailyCaloriesBalance: Int {
        caloriesDailyLimit - totalDailyCalories
    }
    
//------------------------------------ MEAL CRUD ------------------------------------//
    
    func addMealEntry(food: String, calories: Int, mealTime: MealTime){
        let mealEntry = MealEntryData(context: container.viewContext)
        mealEntry.id = UUID()
        mealEntry.food = food
        mealEntry.calories = Int16(calories)
        mealEntry.mealTime = mealTime.rawValue
        
        do {
            try container.viewContext.save()
        } catch {
            print("Add meal entry failed!")
        }
    }
    
    func getMealEntry(for mealTime: MealTime) -> [MealEntryData]{
        return mealEntries.filter { $0.mealTime == mealTime.rawValue } //filters the entries for categorising in the view
    }
    
    func editMealEntry(id: UUID, newFood: String, newCalories: Int, newMealTime: MealTime){
        if let index = mealEntries.firstIndex(where: { $0.id == id }) {
            mealEntries[index].food = newFood
            mealEntries[index].calories = Int16(newCalories)
            mealEntries[index].mealTime = newMealTime.rawValue
        } else {
            print("Error: Entry not found!")
        }
        
        do {
            try container.viewContext.save()
        } catch {
            print("Edit meal entry failed!")
        }
    }
    
    func deleteMealEntry(id: UUID){
        if let index = mealEntries.firstIndex(where: { $0.id == id }) {
            let object = mealEntries[index]
            container.viewContext.delete(object)
            mealEntries.remove(at: index)
        } else {
            print("Error: Entry not found!")
        }
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error: Delete meal entry failed!")
        }
    }

//------------------------------------ UPDATE DAILY CALORIES FUNCTION ------------------------------------//
    
    func updateDailyCalories(calories: Int){
        caloriesDailyLimit = calories
    }

//------------------------------------ TOTAL CALORIES CALCULATION ------------------------------------//
    
    func calculateTotalCaloriesPerMealTime(mealTime: MealTime) -> Int {
        let filteredMeals = mealEntries.filter { $0.mealTime == mealTime.rawValue }
        let total = filteredMeals.reduce(0) { $0 + $1.calories }
        return Int(total)
    }

//------------------------------------ CALORIES CARD BACKGROUND COLOR ------------------------------------//
    
    func dynamicBackgroundColor(for totalCalories: Int, dailyLimit: Int) -> Color { //requires Combine to work
        let ratio = min(max(Double(totalCalories) / Double(dailyLimit), 0), 1)
        
        if ratio < 0.5 {
            let progress = ratio / 0.5
            return Color(
                red: 0,
                green: progress,
                blue: 1 - progress
            )
        } else {
            let progress = (ratio - 0.5) / 0.5
            return Color (
                red: progress,
                green: 1 - progress,
                blue: 0
            )
        }
    }
    
//------------------------------------ PREVIEW SAMPLE DATA FUNCTION ------------------------------------//
    
    static func makePreview() -> DataStore {
        let sampleDatabase = DataStore()
        
        let context = sampleDatabase.container.viewContext
        
        sampleDatabase.caloriesDailyLimit = 2000
        
        let meal1 = MealEntryData(context: context)
            meal1.id = UUID()
            meal1.food = "Oatmeal"
            meal1.calories = 250
            meal1.mealTime = MealTime.breakfast.rawValue
            
            let meal2 = MealEntryData(context: context)
            meal2.id = UUID()
            meal2.food = "Chicken Salad"
            meal2.calories = 400
            meal2.mealTime = MealTime.lunch.rawValue
            
            let meal3 = MealEntryData(context: context)
            meal3.id = UUID()
            meal3.food = "Apple"
            meal3.calories = 80
            meal3.mealTime = MealTime.snack.rawValue
            
            do {
                try context.save()
            } catch {
                print("Preview data failed")
            }
        
        return sampleDatabase
    }
}
