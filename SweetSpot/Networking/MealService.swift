//
//  MealService.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import Foundation

class MealService {
    func fetchMealDetail(by id: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
            guard let url = URL(string: API.mealDetailUrl(for: id)) else {
                print("Invalid URL for meal detail.")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network request error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    print("No data received from the server.")
                    DispatchQueue.main.async {
                        completion(.failure(URLError(.badServerResponse)))
                    }
                    return
                }
                
                
                
                do {
                    let mealDetail = try JSONDecoder().decode(MealDetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(mealDetail))
                    }
                } catch {
                    print("JSON Decoding error: \(error)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }

    
    func fetchDessert(completion: @escaping (Result<MealsList, Error>) -> Void) {
            guard let url = URL(string: API.dessertUrl) else { return }
    
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
    
                guard let data = data else { return }
    
                do {
                    let mealList = try JSONDecoder().decode(MealsList.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(mealList))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
}



