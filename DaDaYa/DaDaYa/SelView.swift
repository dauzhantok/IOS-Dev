//
//  SelView.swift
//  DaDaYa
//
//  Created by Dauzhan Tokpakbayev on 3/7/20.
//  Copyright © 2020 Dauzhan Tokpakbayev. All rights reserved.
//

import Foundation
import UIKit

class SelView: UIViewController {
    
    var onSelect: ((UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func ColButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "RED" {
            self.onSelect?(UIColor.red)
        } else {
            self.onSelect?(UIColor.blue)
        }
        
        self.dismiss(animated: true)
    }
}
