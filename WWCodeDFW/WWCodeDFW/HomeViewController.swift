//
//  HomeViewController.swift
//  WWCodeDFW
//
//  Created by AlkaLocal on 10/9/17.
//  Copyright © 2017 WWCode. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        let label = UILabel.init()
        label.text = "Hello, world!"
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(self.view)
            make.height.width.equalTo(100)
        }
    }
}
