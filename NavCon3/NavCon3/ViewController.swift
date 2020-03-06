//
//  ViewController.swift
//  NavCon3
//
//  Created by Dauzhan Tokpakbayev on 3/6/20.
//  Copyright © 2020 Dauzhan Tokpakbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func plus(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NaviC") as NaviCon
        vc.parameter = { [weak self] width, height, x, y, color in
            guard let self = self else { return }
                    
            let figure = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            figure.backgroundColor = color
            self.view.addSubview(figure)
                    
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.DidTap))
            figure.addGestureRecognizer(tapGestureRecognizer)
        
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.DidPan))
            figure.addGestureRecognizer(panGestureRecognizer)
        
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.DidPinch))
            figure.addGestureRecognizer(pinchGestureRecognizer)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func DidTap(_ sender: UITapGestureRecognizer) {
        if let figure = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "NaviC") as NaviCon
            vc.sFigure = figure
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var baseOrigin: CGPoint!
    
    @objc func DidPan(_ recognizer: UIPanGestureRecognizer) {
        if let figure = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = figure.frame.origin
            case .changed:
                let d = recognizer.translation(in: figure)
                figure.frame.origin.x = baseOrigin.x + d.x
                figure.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
    
    @objc func DidPinch(_ sender: UIPinchGestureRecognizer) {
        if let figure = sender.view {
            if sender.state == .began || sender.state == .changed {
                figure.transform = (figure.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
}
