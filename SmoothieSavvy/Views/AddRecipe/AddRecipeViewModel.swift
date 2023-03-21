/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An observable state object that contains profile details.
*/

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class AddRecipeViewModel: ObservableObject {
    
    // MARK: - Recipe Details
    
    @Published var name = ""
    @Published var description = ""
    @Published var ingredients: [Ingredient] = []
    @Published var directions: [Direction] = []
    @Published var notes = ""
    
    // MARK: - Recipe Image
    
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
    
    // MARK: - Private Methods
    
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

enum TransferError: Error {
    case importFailed
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(RecipeImage)
    case failure(Error)
}

struct RecipeImage: Transferable {
    let image: Image
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
        #if canImport(AppKit)
            guard let nsImage = NSImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(nsImage: nsImage)
            return RecipeImage(image: image)
        #elseif canImport(UIKit)
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return RecipeImage(image: image)
        #else
            throw TransferError.importFailed
        #endif
        }
    }
}
