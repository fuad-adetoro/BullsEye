//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Frederico on 18/01/2017.
//  Copyright © 2017 Fuad Adetoro. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the URL to the local BullsEye.html file.
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            // set the htmlData to the contents of the webpage
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                
                // load the webpage
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(_ sender: Any) {
        // Dismiss the modal 
        dismiss(animated: true, completion: nil)
    }
    
}
