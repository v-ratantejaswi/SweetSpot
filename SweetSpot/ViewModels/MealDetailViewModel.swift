//
//  MealDetailViewModel.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation
class MealDetailViewModel: ObservableObject {
    @Published var mealInfo: MealInfo?
    
    private let service = MealService()

    func fetchMealDetail(by id: String) {
        service.fetchMealDetail(by: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetail):
                    guard let mealInfo = mealDetail.meals.first else {
                        print("No meal info available.")
                        return
                    }
                    if mealInfo.ingredientsWithMeasurements().isEmpty {
                        print("Incomplete meal info.")
                        return
                    }
                    self?.mealInfo = mealInfo
                case .failure(let error):
                    print("Error fetching meal details: \(error.localizedDescription)")
                }
            }
        }
    }
}
