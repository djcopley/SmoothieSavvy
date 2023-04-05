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

    let context: NSManagedObjectContext
    let persistenceController: PersistenceController
    @Published var recipe: Recipe

    init(persistenceController: PersistenceController, editing recipe: Recipe? = nil) {
        context = persistenceController.childViewContext()
        if let recipe = recipe {
            self.recipe = persistenceController.copyForEditing(of: recipe, in: context)
            if let uiImage = recipe.uiImage { self.imageState = .success(RecipeImage(uiImage: uiImage)) }
        } else {
            self.recipe = persistenceController.newTemporaryInstance(in: context)
        }
        self.persistenceController = persistenceController
    }

    func persist() {
        persistenceController.persist(recipe)
    }
    
    func newIngredient() -> Ingredient {
        let newIngredient = Ingredient(name: "", emoji: "", context: context)
        self.recipe.addToIngredients(newIngredient)
        return newIngredient
    }

    func newDirection() -> String {
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
        case success(RecipeImage)
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
            case .success(let recipeImage):
                self.recipe.uiImage = recipeImage.uiImage
            default:
                break
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
