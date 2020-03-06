//
//  NaviCon.swift
//  NavCon3
//
//  Created by Dauzhan Tokpakbayev on 3/6/20.
//  Copyright © 2020 Dauzhan Tokpakbayev. All rights reserved.
//

import Foundation
import UIKit

class NaviCon: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var selectCol: UIColor?
    var sFigure: UIView?

   
    @IBOutlet weak var widthText: UITextField!
    
    @IBOutlet weak var heightText: UITextField!
    
    @IBOutlet weak var xText: UITextField!
    
    @IBOutlet weak var yText: UITextField!
    
    
    @IBAction func ColButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "RED" {
            selectCol=sender.backgroundColor
        } else if sender.titleLabel?.text == "BLUE" {
            selectCol=sender.backgroundColor
        }else if sender.titleLabel?.text == "PURPLE" {
            selectCol=sender.backgroundColor
        }else {
            selectCol=sender.backgroundColor
        }
    }
    var parameter: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
    
    override func viewWillAppear(_ animated: Bool) {
    
          openViewData()
          configureNav()
      }
    
    func configureNav(){
        let deleteButton = UIBarButtonItem(title: "trash", style: .plain, target: self, action: #selector(deleteFigure))
        let addButton = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveFigure))
        
        guard sFigure != nil else {
             navigationItem.rightBarButtonItems = [ addButton]
            return
        }
        navigationItem.rightBarButtonItems = [deleteButton, addButton]
    }
    
    func openViewData(){
        guard let figure = sFigure else {return}
        print(figure.frame.width)
        self.widthText.text = figure.frame.width.description
        self.heightText.text = figure.frame.height.description
        self.xText.text = figure.frame.origin.x.description
        self.yText.text = figure.frame.origin.y.description
    }
      
    @objc func deleteFigure() {
        guard let figure = sFigure else {return}
        figure.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveFigure() {
        
        guard let width = widthText.text, let height = heightText.text, let x = xText.text, let y = yText.text, let color = selectCol else {
            let alert = UIAlertController(title: "GG", message: "Data viydet pogulat?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, BOOMER", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
            }
        guard let widthC = Double(width), let heightC = Double(height), let xC = Double(x), let yC = Double(y) else {
            let alert = UIAlertController(title: "GG", message: "Eta data ne v moem vkuse", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, BOOMER", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
            }
        let screenSize = UIScreen.main.bounds
        
        if CGFloat(widthC) > screenSize.width || CGFloat(heightC) > screenSize.height {
            let alert = UIAlertController(title: "GG", message: "this size too BIG", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, BOOMER", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let figure = sFigure else {
            parameter?(widthC, heightC, xC, yC, color)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        figure.backgroundColor = color
        figure.frame = CGRect(x: CGFloat(xC), y: CGFloat(yC), width: CGFloat(widthC), height: CGFloat(heightC))
        
        self.navigationController?.popViewController(animated: true)
    }
}

