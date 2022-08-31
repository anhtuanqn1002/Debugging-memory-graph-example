//
//  AlertViewController.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 21/08/2022.
//

import UIKit

class AlertViewController: BaseViewController {
    var okAction: (() -> ())?

    @IBAction func okAction(_ sender: UIButton) {
        self.okAction?()
    }
}
