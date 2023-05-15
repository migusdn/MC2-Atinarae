//
//  CategoryViewModel.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/13.
//

import Foundation
import RealmSwift
import SwiftUI
import RealmSwift

class CategoryViewModel: ObservableObject {
    private var realm: Realm
    @Published var categories: Results<Category>
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
        
        categories = realm.objects(Category.self)
    }
    func refresh() {
        categories = realm.objects(Category.self)
    }
    func createCategory(user: User, name: String) {
        guard !name.isEmpty else {
            print("Category name cannot be empty")
            return
        }
        guard !categories.contains(where: { $0.name == name && $0.user == user }) else {
            print("Category already exists")
            return
        }
        
        let newCategory = Category()
        newCategory._id = ObjectId.generate()
        newCategory.user = user
        newCategory.name = name
        
        do {
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            print("Failed to add category: \(error)")
        }
    }
    
    func updateCategory(category: Category, name: String) {
        do {
            try realm.write {
                category.name = name
            }
        } catch {
            print("Failed to update category: \(error)")
        }
    }
    
    func deleteCategory(category: Category) {
        do {
            try realm.write {
                realm.delete(category)
            }
        } catch {
            print("Failed to delete category: \(error)")
        }
    }
    func getUserCategories(for user: User) -> [Category] {
        let userCategories = categories.filter("user == %@", user)
        return Array(userCategories)
    }
}
