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
    let persistenceController: PersistenceController = .shared
    
    init(recipe: Recipe? = nil) {
        context = persistenceController.childViewContext()
        if let recipe = recipe {
            self.recipe = persistenceController.copyForEditing(of: recipe, in: context)
            if let uiImage = recipe.uiImage { self.imageState = .success(RecipeImage(uiImage: uiImage)) }
        } else {
            self.recipe = persistenceController.newTemporaryInstance(in: context)
        }
    }
    
    var recipeIsValid: Bool {
        !recipe.name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Recipe Intents
    
    // I feel like this section could be improved if I only I knew a better way
    
    func persist() {
        persistenceController.persist(recipe)
    }
    
    func newIngredient() -> Ingredient {
        objectWillChange.send()
        let newIngredient = Ingredient(name: "", context: context)
        self.recipe.addToIngredients(newIngredient)
        return newIngredient
    }

    func newDirection() -> String {
        objectWillChange.send()
        let newDirection = ""
        self.recipe.directions.append(newDirection)
        return newDirection
    }
    
    func deleteIngredient(from offsets: IndexSet) {
        offsets.map { recipe.sortedIngredients[$0] }.forEach { ingredient in
            recipe.removeFromIngredients(ingredient)
            if let empty = ingredient.recipes?.allObjects.isEmpty, empty {
                context.delete(ingredient)
            }
        }
    }
    
    func deleteDirection(from offsets: IndexSet) {
        recipe.directions.remove(atOffsets: offsets)
    }
    
    func moveDirection(from offsets: IndexSet, to offset: Int) {
        recipe.directions.move(fromOffsets: offsets, toOffset: offset)
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
