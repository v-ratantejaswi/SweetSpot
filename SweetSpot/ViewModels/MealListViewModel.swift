//
//  MealListViewModel.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    private let service = MealService()
    
    func fetchDesserts() {
        service.fetchDessert { [weak self] result in
            switch result{
            case .success(let mealList):
                self?.meals = mealList.meals.sorted { $0.strMeal < $1.strMeal}
            case .failure(_):
                print("Error fetching meals: (error.localizedDescription)")
            }
        }
    }
}
