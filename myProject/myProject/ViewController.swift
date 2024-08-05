//
//  ViewController.swift
//  myProject
//
//  Created by user264151 on 8/3/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "XibTableViewCell", bundle: nil),
                            forCellReuseIdentifier: "XibTableViewCell")
        
    }


}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "XibTableViewCell") as? XibTableViewCell)
        cell?.tblImage.image = UIImage(named:String(indexPath.row+1))
        cell?.tblLabel.text = "Random Image \(indexPath.row+1)"
        return cell!
    }
}
