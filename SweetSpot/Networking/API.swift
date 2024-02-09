//
//  API.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation
struct API {
    static let baseUrl = "https://themealdb.com/api/json/v1/1/"
    static let dessertUrl = baseUrl + "filter.php?c=Dessert"
    
    static func mealDetailUrl(for id: String) -> String {
        return baseUrl + "lookup.php?i=\(id)"
    }
}
