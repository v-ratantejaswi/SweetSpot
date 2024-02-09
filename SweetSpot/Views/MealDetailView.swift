//
//  MealDetailView.swift
//  SweetSpot
//
//  Created by Ratan Tejaswi Vadapalli on 2/7/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let mealId: String
    @ObservedObject var viewModel = MealDetailViewModel()
    @State private var showRecipe = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            Button(action: {
                withAnimation {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .padding()
            .zIndex(1)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if let imageUrl = viewModel.mealInfo?.strMealThumb {
                        ZStack(alignment: .bottomLeading) {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                    
                    LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]), startPoint: .center, endPoint: .bottom)
                        .frame(height: 100)
                    
                    Text(viewModel.mealInfo?.strMeal ?? "Loading...")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                .padding()
                                
                        }
                    } else {
                        Color.gray.frame(width: UIScreen.main.bounds.width, height: 300)
                    }
                    
                    
                    HStack {
                        if let youtubeURL = viewModel.mealInfo?.strYoutube, UIApplication.shared.canOpenURL(youtubeURL) {
                                Button(action: {
                                UIApplication.shared.open(youtubeURL)
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.red)
                                }
                        }
                        Text(showRecipe ? "Recipe" : "Ingredients")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Button(action: {
                            withAnimation {
                                showRecipe.toggle()
                            }
                        }) {
                            if showRecipe {
                                
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    
                    if showRecipe {
                        
                        Text(viewModel.mealInfo?.strInstructions ?? "")
                            .padding()
                            .background(Color.white)
                            .font(.body)
                            .foregroundColor(.primary)
                            .shadow(radius: 1)
                    } else {
                        
                        ForEach(viewModel.mealInfo?.ingredientsWithMeasurements().enumerated().map({ ($0.offset, $0.element) }) ?? [], id: \.0) { index, item in
                            HStack {
                                Text(item.ingredient)
                                Spacer()
                                Text(item.measurement)
                            }
                            .padding(.horizontal)
                            .background(Color.white)
                            .font(.body)
                            .foregroundColor(.primary)
                            .shadow(radius: 1)
                        }
                    }
                }
            }
            .zIndex(0)
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            viewModel.fetchMealDetail(by: mealId)
        }
        .navigationBarHidden(true)
    }
}


