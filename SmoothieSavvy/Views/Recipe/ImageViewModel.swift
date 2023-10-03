//
//  AddEditRecipeViewModel.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/28/23.
//

import Foundation
import CoreData
import PhotosUI
import CoreTransferable
import SwiftUI
import EmojiPicker

@MainActor
class ImageViewModel: ObservableObject {
    struct RecipeImage: Transferable {
        let uiImage: UIImage
        
        var image: Image {
            Image(uiImage: uiImage)
        }

        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(contentType: .image) { recipeImage in
                recipeImage.uiImage.pngData() ?? Data()
            } importing: { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                return RecipeImage(uiImage: uiImage)
            }
        }
    }
    
    enum TransferError: Error {
        case importFailed
    }

    enum ImageState {
        case empty
        case loading(Progress)
        case success(RecipeImage)
        case failure(Error)
    }

    
    var image: RecipeImage? {
        switch imageState {
        case .success(let recipeImage):
            return recipeImage
        default:
            return nil
        }
    }
    @Published var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: RecipeImage.self) { result in
            Task { @MainActor in
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let recipeImage?):
                    self.imageState = .success(recipeImage)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
