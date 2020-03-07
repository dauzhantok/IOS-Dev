//
//  ViewController.swift
//  DaDaYa
//
//  Created by Dauzhan Tokpakbayev on 3/7/20.
//  Copyright © 2020 Dauzhan Tokpakbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func Button(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "select") as? SelView
        else { return }
        
        selectVC.onSelect = { [weak self] color in
            guard self != nil else { return }
            sender.backgroundColor=color
        }
        
        self.present(selectVC, animated: true)
    }
    

}
