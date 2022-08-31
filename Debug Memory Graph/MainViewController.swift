//
//  MainViewController.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 21/08/2022.
//

import UIKit

class BaseViewController: UIViewController {
    deinit {
        print("\(String(describing: self)) deinit.")
    }
}

final class MainViewController: BaseViewController {

    lazy var featuresViewController: FeaturesViewController = {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FeaturesViewController") as! FeaturesViewController
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showFeaturesScreen(_ sender: Any) {
        navigationController?.pushViewController(featuresViewController, animated: true)
    }
    
    
    @IBAction func showFeaturesScreenNew(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FeaturesViewController") as! FeaturesViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

