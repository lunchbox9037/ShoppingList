//
//  ItemController.swift
//  ShoppingList
//
//  Created by stanley phillips on 1/15/21.
//

import Foundation

class ItemController {
    // MARK: - Properties
    static var shared = ItemController()
    var items: [Item] = []
    
    // MARK: - CRUD
    func createNewItemWith(name: String, quantity: Int?) {
        let newItem = Item(name: name, quantity: quantity)
        items.append(newItem)
        saveToPersistentStorage()
    }
    
    func delete(item: Item) {
        guard let itemToDelete = items.firstIndex(of: item) else {return}
        items.remove(at: itemToDelete)
        saveToPersistentStorage()
    }
    
    func updateQuantity(item: Item, amount: Int) {
        item.quantity = amount
        saveToPersistentStorage()
    }
    
    func toggleIsPurchased(item: Item) {
        item.isPurchased.toggle()
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    //create a url
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("ShoppingList.json")
        return documentsDirectoryURL
    }
    
    //save data
    func saveToPersistentStorage() {
        do {
            //decode and assign the entries array to the a data variable
            let data = try JSONEncoder().encode(items)
            //write the data to a the file url that was created
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load data
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
