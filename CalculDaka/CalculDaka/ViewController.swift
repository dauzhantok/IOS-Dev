//
//  ViewController.swift
//  CalculDaka
//
//  Created by Dauzhan Tokpakbayev on 1/25/20.
//  Copyright © 2020 Dauzhan Tokpakbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnSreen:Double=0;
    let model = Calculator()
    var can=true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if can{
        guard
            let numberText = sender.titleLabel?.text
        else { return }
        
        label.text?.append(numberText)
        }else{
            label.text=""
            guard
                let numberText = sender.titleLabel?.text
            else { return }
            
            label.text?.append(numberText)
            can=true
        }
    }
    func doIt(op: String) -> Bool{
           if(op != "+" && op != "-" && op != "/" && op != "X" && op != "^"){
               return true
           }
           return false
       }
    
    @IBAction func buttons(_ sender: UIButton)
    {
        guard
            let numberText = label.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
            
        else {
            return
        }
        
        label.text = ""
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)
        if doIt(op: operation){
            label.text = String(model.result)
        }
        if sender.tag == 19
        {
            label.text = ""
            
        }
        else if sender.tag == 15
        {
            can=false
            
        }
        
       
        
      
    }
    

}

