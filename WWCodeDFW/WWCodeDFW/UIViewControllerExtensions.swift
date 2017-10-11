//
//  UIViewControllerExtensions.swift
//  WWCodeDFW
//
//  Created by Val Osipenko on 10/10/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupNavigationBar() {
        
        let tintColor = UIColor(red: 0.06, green: 0.48, blue: 0.48, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.view.backgroundColor = .white
        
        let rightButton = UIBarButtonItem(title: "Donate", style: .plain, target: self, action: #selector(donate))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func donate() {
        let donateVC = DonationsViewController()
        donateVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(donateVC, animated: true)
    }
}
