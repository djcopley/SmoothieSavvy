/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The profile image that reflects the selected item state.
*/

import SwiftUI
import PhotosUI

struct RecipeImageView: View {
    let imageState: EditRecipeViewModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let recipeImage):
            let image = recipeImage.image
            image
                .resizable()
                .draggable(image) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                }
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "photo")
                .font(.system(size: 40))
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
        }
    }
    
    let height: CGFloat = 55
    let width: CGFloat = 55
}

struct RoundedRectangleRecipeImageView: View {
    let imageState: EditRecipeViewModel.ImageState
    
    var body: some View {
        RecipeImageView(imageState: imageState)
            .scaledToFill()
            .frame(width: width, height: height)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    let height: CGFloat = 55
    let width: CGFloat = 55
    let cornerRadius: CGFloat = 6
}
