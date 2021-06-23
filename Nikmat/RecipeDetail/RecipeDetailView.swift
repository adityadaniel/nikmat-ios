//
//  RecipeDetailView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 22/06/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct RecipeDetailView: View {
  @StateObject var viewModel: RecipeDetailViewViewModel
  let recipe: Recipe

  init(recipe: Recipe) {
    self.recipe = recipe
    _viewModel = StateObject(wrappedValue: RecipeDetailViewViewModel(service: .shared, key: recipe.key))
  }

  let gridItems = Array(repeating: GridItem(.flexible()), count: 2)

  var body: some View {
    if let recipeDetail = viewModel.recipeDetail {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          WebImage(url: URL(string: recipeDetail.image))
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)

          VStack(alignment: .leading) {
            Text(recipeDetail.title)
              .fontWeight(.medium)

            RecipeBriefInformationView(recipe: recipeDetail.convertToRecipe(withKey: recipe.key))
              .padding([.vertical], 2)

            Text("Bahan-bahan")
              .foregroundColor(.primary)
              .fontWeight(.semibold)
              .font(.system(.title3, design: .rounded))
              .padding(.top, 12)
              .padding(.bottom, 2)

            VStack(alignment: .leading, spacing: 8) {
              ForEach(recipeDetail.ingredient) { ingredient in
                Text(ingredient.asText)
                  .foregroundColor(Color(uiColor: .label))
                  .font(.footnote)
              }
            }

            Text("Cara membuat")
              .foregroundColor(.primary)
              .fontWeight(.semibold)
              .font(.system(.title3, design: .rounded))
              .padding(.top, 12)
              .padding(.bottom, 1)

            VStack(alignment: .leading, spacing: 8) {
              ForEach(recipeDetail.steps) { step in
                HStack(alignment: .top) {
                  Text("\(step.number). ")
                    .padding([.trailing], 1)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)

                  Text(step.instruction)
                }
                .foregroundColor(Color(uiColor: .label))
                .font(.footnote)
              }
            }
            .padding(.bottom, 16)
          }
          .padding(.horizontal)
        }
        .navigationTitle(recipe.title)
      }
    } else {
      ProgressView()
        .task {
          await viewModel.fetchRecipeDetail(key: recipe.key)
        }
    }
  }
}

struct RecipeDetailView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeDetailView(recipe: .mock)
  }
}
