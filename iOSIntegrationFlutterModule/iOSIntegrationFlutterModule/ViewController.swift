//
//  ViewController.swift
//  iOSIntegrationFlutterModule
//
//  Created by PhuongMT on 05/07/2022.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
//         Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.frame = CGRect(x: self.view.frame.size.width/2 - button.frame.size.width/2, y: self.view.frame.size.height/2 - button.frame.size.height/2, width: button.frame.width, height: button.frame.height)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
    }

    @objc func showFlutter() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        present(flutterViewController, animated: true, completion: nil)
      }
}

