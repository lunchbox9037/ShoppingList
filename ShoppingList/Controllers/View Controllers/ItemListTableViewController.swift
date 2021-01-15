//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by stanley phillips on 1/15/21.
//

import UIKit

class ItemListTableViewController: UITableViewController {
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistentStorage()
    }
    
    // MARK: - Actions
    @IBAction func addItemButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: "What do you need?", preferredStyle: .alert)
        alert.addTextField { (itemName) in
            itemName.placeholder = "Item Name"
        }
        alert.addTextField { (itemAmount) in
            itemAmount.placeholder = "How Many?"
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let newItemName = alert.textFields?[0].text, !newItemName.isEmpty,
                 let quantity = alert.textFields?[1].text else {return}
            ItemController.shared.createNewItemWith(name: newItemName, quantity: Int(quantity))
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        cell.updateCellWith(item: ItemController.shared.items[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Custom Cell Delegate Functions
extension ItemListTableViewController: ItemTableViewCellDelegate {
    func updateStepperValue(_ sender: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let itemToIncrement = ItemController.shared.items[indexPath.row]
        let amountToIncrement = sender.quantityStepper.value
        ItemController.shared.updateQuantity(item: itemToIncrement, amount: Int(amountToIncrement))
        self.tableView.reloadData()
    }
    
    func togglePurchasedButton(_ sender: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let itemToToggle = ItemController.shared.items[indexPath.row]
        ItemController.shared.toggleIsPurchased(item: itemToToggle)
        self.tableView.reloadData()
    }
}
