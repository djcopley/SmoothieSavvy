/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The profile image that reflects the selected item state.
*/

import SwiftUI
import PhotosUI

struct RecipeImage: View {
    let imageState: AddRecipeModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
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
}

struct RoundedRectangleRecipeImage: View {
    let imageState: AddRecipeModel.ImageState
    
    var body: some View {
        RecipeImage(imageState: imageState)
            .scaledToFill()
            .frame(width: width, height: height)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private let height: CGFloat = 55
    private let width: CGFloat = 55
    private let cornerRadius: CGFloat = 6
}
