//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by stanley phillips on 1/15/21.
//

import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func togglePurchasedButton(_ sender: ItemTableViewCell)
    func updateStepperValue(_ sender: ItemTableViewCell)
}
class ItemTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemPurchasedButton: UIButton!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    
    // MARK: - Properties
    weak var delegate: ItemTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func itemPurchasedButtonPressed(_ sender: Any) {
        delegate?.togglePurchasedButton(self)
    }
    @IBAction func stepperTapped(_ sender: Any) {
        delegate?.updateStepperValue(self)
    }
    
    // MARK: - Methods
    func updateCellWith(item: Item) {
        nameLabel.text = item.name
        if let quantity = item.quantity {
            quantityStepper.stepValue = 1
            quantityStepper.minimumValue = 1
            quantityStepper.maximumValue = 20
            quantityStepper.value = Double(quantity)
            quantityLabel.text = String(quantity)
        }
        updatePurchasedStatus(itemPurchased: item.isPurchased)
    }
    
    func updatePurchasedStatus(itemPurchased: Bool) {
        let imageName = itemPurchased ? "checkmark.square" : "square"
        itemPurchasedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
