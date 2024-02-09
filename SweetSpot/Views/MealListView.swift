//
//  MealLisView.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var viewModel = MealListViewModel()
    @State private var showingCards = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showingCards {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.meals) { meal in
                                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                                    MealCardView(meal: meal)
                                        .frame(height: 300)
                                        .cornerRadius(12)
                                        .shadow(radius: 4)
                                }
                            }
                        }
                    }
                } else {
                    List(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                            Text(meal.strMeal)
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .toolbar {
                Button(action: {
                    withAnimation {
                        showingCards.toggle()
                    }
                }) {
                    Image(systemName: showingCards ? "list.bullet" : "square.grid.2x2")
                }
            }
            .onAppear{
                viewModel.fetchDesserts()
            }
        }
    }
}



struct MealCardView: View {
    let meal: Meal
    @State private var isShowingVideo = false

    var body: some View {
        VStack {
            if let imageUrl = meal.strMealThumb {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)
                .clipped()
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .background(Color.secondary.opacity(0.1))
            }

            HStack {
                Text(meal.strMeal)
                    .font(.headline)
                
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

