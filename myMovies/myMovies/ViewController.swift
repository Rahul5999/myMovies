//
//  ViewController.swift
//  myMovies
//


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // This will pause the screen for 3 Seconds and jumps to MainViewController
        //Where segue connector identifier with"jumpToMain"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute:{
            self.performSegue(withIdentifier: "jumpToMain", sender: nil)
        })
    }


}

