//
//  MealDetail.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation
struct MealDetail: Decodable {
    let meals: [MealInfo]
}


struct MealInfo:Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: URL?
    let strYoutube: URL?
    
    var ingredients: [String] = []
    var measurements: [String] = [] 

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb, strYoutube
        case strIngredient1, strMeasure1, strIngredient2, strMeasure2,strIngredient3, strMeasure3, strIngredient4, strMeasure4,strIngredient5, strMeasure5, strIngredient6, strMeasure6,strIngredient7, strMeasure7, strIngredient8, strMeasure8, strIngredient9, strMeasure9, strIngredient10, strMeasure10,strIngredient11, strMeasure11, strIngredient12, strMeasure12, strIngredient13, strMeasure13, strIngredient14, strMeasure14,strIngredient15, strMeasure15, strIngredient16, strMeasure16,strIngredient17, strMeasure17, strIngredien18, strMeasure18,strIngredient19, strMeasure19, strIngredient20, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(URL.self, forKey: .strMealThumb)
        
        if let strYoutubeString = try container.decodeIfPresent(String.self, forKey: .strYoutube),
            let url = URL(string: strYoutubeString), !strYoutubeString.isEmpty {
            strYoutube = url
        } else {
            strYoutube = nil
        }

       
        var uniquePairs = Set<String>()

        
        for i in 1...20 {
            if let ingredientKey = CodingKeys(rawValue: "strIngredient\(i)"),
                let measureKey = CodingKeys(rawValue: "strMeasure\(i)"),
                let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey)?.trimmingCharacters(in: .whitespacesAndNewlines),
                    !ingredient.isEmpty,
                let measurement = try container.decodeIfPresent(String.self, forKey:measureKey)?.trimmingCharacters(in: .whitespacesAndNewlines),!measurement.isEmpty {
                    
                    
                    let uniqueKey = "\(ingredient)-\(measurement)"
                    if !uniquePairs.contains(uniqueKey) {
                        uniquePairs.insert(uniqueKey)
                        ingredients.append(ingredient)
                        measurements.append(measurement)
                    }
                }
            }
        }
    

    
    func ingredientsWithMeasurements() -> [(ingredient: String, measurement: String)] {
        zip(ingredients, measurements).map { ($0, $1) }
    }
}
