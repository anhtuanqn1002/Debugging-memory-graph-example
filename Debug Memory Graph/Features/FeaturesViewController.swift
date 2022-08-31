//
//  FeaturesViewController.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 21/08/2022.
//

import UIKit

// MARK: - Features screen
final class FeaturesViewController: BaseViewController {
    lazy var alertViewController: AlertViewController = {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        controller.okAction = { self.cancelAlert() }
        return controller
    }()
    
    lazy var dataProvider: DataProvider = {
        let dataProvider = DataProvider()
        dataProvider.delegate = self
        return dataProvider
    }()
    
    @IBOutlet var backgroundImage: UIImageView!
    private var largeArray: [Int64] = [Int64].init(repeating: 123456, count: 1_000_000)
    private var workItem: DispatchWorkItem?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAction(_:)))
        navigationItem.rightBarButtonItem = rightItem
                
        backgroundImage.addOverlay(color: .random().withAlphaComponent(0.3))
    }
    
    // MARK: - Actions
    @IBAction func showAlert(_ sender: Any) {
        print(#function)
        present(alertViewController, animated: true)
    }
    
    @IBAction func dispatchWorkItem(_ sender: Any) {
        print(#function)
        let showAlertWorkItem = DispatchWorkItem(qos: .background, block: {
            self.largeArray[0] = 1
            print("\(#function) done")
        })
        workItem = showAlertWorkItem
        DispatchQueue.global().async(execute: showAlertWorkItem)
    }
    
    @IBAction func registerNotificationCenter(_ sender: Any) {
        print(#function)
        NotificationCenter.default.addObserver(forName: addNewItemNotification, object: nil, queue: .main, using: addNewItem)
    }
    
    @IBAction func getUserUsingDataBinding(_ sender: Any) {
        print(#function)
        dataBinding()
        FeaturesViewModel.shared.loadUsers()
    }
    
    @IBAction func getUserWitCompleteClosure(_ sender: Any) {
        print(#function)
        FeaturesViewModel.shared.loadUsers { isSuccess in
            DispatchQueue.main.async {
                self.showToast(message: "User fetching: isSuccess = \(isSuccess)")
            }
        }
    }
    
    @IBAction func useDelegate(_ sender: Any) {
        print(#function)
        dataProvider.loadData()
    }
    
    // MARK: - Support methods
    func cancelAlert() {
        alertViewController.dismiss(animated: true, completion: nil)
    }
    
    func dataBinding() {
        FeaturesViewModel.shared.fetchUsersFailed = {
            DispatchQueue.main.async {
                self.showToast(message: "User fetching failed")
            }
        }
        
        FeaturesViewModel.shared.fetchUsersSucceed = {
            DispatchQueue.main.async {
                self.showToast(message: "User fetching succeed")
            }
        }
    }
    
    @objc func handleAddAction(_ sender: UIBarButtonItem) {
        print("\(#function)")
        let addNewItemViewController = storyboard!.instantiateViewController(identifier: "AddNewItemViewController")
        navigationController?.pushViewController(addNewItemViewController, animated: true)
    }
    
    @objc func addNewItem(_ notfication: Notification) {
        print("\(#function) - \(String(describing: notfication.object))")
    }
}

// MARK: - DataDelegate
extension FeaturesViewController: DataDelegate {
    func dataLoaded() {
        print(#function)
    }
}
