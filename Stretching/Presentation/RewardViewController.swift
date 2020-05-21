//
//  RewardViewController.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class RewardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var namaFilter = ["Thunder Filter", "Love Love Filter", "Cowboy heart Filter"]
    var fotoFilter = [ #imageLiteral(resourceName: "thunder copy"), #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024"), #imageLiteral(resourceName: "istockphoto-1134423558-1024x1024")]
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "RewardViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
    }

}
extension RewardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namaFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! RewardViewCell
        cell.filterImage.image = fotoFilter[indexPath.row]
        cell.filterName.text = namaFilter[indexPath.row]
        return cell
    }
    
    
}
