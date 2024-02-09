//
//  Meal.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    var id: String {idMeal}
    let strMealThumb: URL?

}
