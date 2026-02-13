//
//  FoodEntryModel.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 10/02/2026.
//

import Foundation

enum MealTime: String, CaseIterable, Identifiable  { //String; each case is assigned a string value the same as case name
    case none = "Pick a meal"                        //CaseIterable; allows us to get all cases as a list
    case dinner                                      //Identifiable; assigns each case an id for looping or to be used in picker UI
    case lunch
    case breakfast
    case snack
    
    var id: String { rawValue } //Assigns each enum case an id. Required to conform to Identifiable protocol
}

struct MealEntry: Identifiable {
    var id: UUID = UUID() //Automatically assigns a unique ID to each meal entry
    var food: String
    var calories: Int
    var mealTime: MealTime
}
