//
//  ViewController.swift
//  Bulls''Eye
//
//  Created by Frederico on 16/01/2017.
//  Copyright © 2017 Fuad Adetoro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Hello, World", message: "This is my first app!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        print("The value of the slider is now: \(sender.value)")
    }
}

