//
//  ViewController.swift
//  Saurabh_UB
//
//  Created by saurabh srivastava on 11/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func search(_ sender: Any) {
        let text = textField.text!
        if text != ""{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImagesCollectionViewController") as! ImagesCollectionViewController
            controller.text = text
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else{
            self.showAlert("Error", message: "Type some words to search images")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

