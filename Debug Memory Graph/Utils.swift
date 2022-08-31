//
//  Utils.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 25/08/2022.
//

import UIKit

// MARK: - Utils
let addNewItemNotification = NSNotification.Name(rawValue: "addNotification")

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension UIImageView {
    func addOverlay(color: UIColor) {
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        overlay.backgroundColor = color
        overlay.tag = 1
        
        // Check if overlay already exists before adding it
        if self.viewWithTag(1) == nil {
            self.addSubview(overlay)
        }
    }
}

extension UIViewController {    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 20)) {
        let toastLabel = UILabel(frame: .zero)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: toastLabel.trailingAnchor, constant: 10),
            toastLabel.heightAnchor.constraint(equalToConstant: 35),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: toastLabel.bottomAnchor, constant: 10)
        ])
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

protocol DataDelegate: AnyObject {
    func dataLoaded()
}

class DataProvider {
    var delegate: DataDelegate?
    
    func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.dataLoaded()
        }
    }
}
