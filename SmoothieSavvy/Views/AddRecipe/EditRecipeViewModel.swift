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

@MainActor
class EditRecipeViewModel: ObservableObject {
    // MARK: - Initialize context
    
    @Published var recipe: Recipe
    
    let context: NSManagedObjectContext
    let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController, recipe: Recipe? = nil) {
        self.context = persistenceController.childViewContext()
        if let recipe = recipe {
            self.recipe = recipe
        } else {
            self.recipe = persistenceController.newTemporaryInstance(in: context)
        }
        self.persistenceController = persistenceController
    }
    
    func persist() {
        persistenceController.persist(recipe)
    }
    
    func newIngredient() {
        let newIngredient = Ingredient(name: "", emoji: "", context: context)
        self.recipe.addToIngredients(newIngredient)
        return newIngredient
    }
    
    func newDirection() {
        let newDirection = ""
        self.recipe.directions.append(newDirection)
        return newDirection
    }
    
    // MARK: - Recipe Image Loading

    enum TransferError: Error {
        case importFailed
    }

    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }

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
    
    @Published var imageState: ImageState = .empty {
        didSet {
            switch imageState {
            case .success(let image):
                print("")
            default:
                print("")
            }
        }
    }
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
                    self.imageState = .success(recipeImage.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}