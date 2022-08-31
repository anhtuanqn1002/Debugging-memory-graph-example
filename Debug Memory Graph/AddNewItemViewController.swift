//
//  AddNewItemViewController.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 23/08/2022.
//

import UIKit

final class AddNewItemViewController: BaseViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func createNewItem(_ sender: Any) {
        view.endEditing(true)
        NotificationCenter.default.post(name: addNewItemNotification, object: nameTextField.text)
        navigationController?.popViewController(animated: true)
    }
}
