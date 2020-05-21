//
//  ProfileViewController.swift
//  Stretching
//
//  Created by Steven Rafaelie on 18/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var judul = "Profile"
    var subMenu = ["", "General", "Setting"]
    var generalMenu = ["Terms & Conditions", "Privacy Policy", "Rate Our App"]
    @IBOutlet weak var tableView: UITableView!
    var settingMenu = ["Notification", "About Privacy"]
    var profile = ["nama": "Rafika", "email": "rafika@gmail.com", "telepon": "088888"]
    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "cellProfile")
        logOutButton.layer.borderColor = UIColor.orange.cgColor
        
        logOutButton.layer.cornerRadius = 10
    }
    

}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return generalMenu.count
        }
        if section == 2 {
            return settingMenu.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfile", for: indexPath) as! ProfileCell
            cell.userName.text = profile["nama"]
            cell.userEmail.text = profile["email"]
            cell.userPhone.text = profile["telepon"]
        return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
            cell.labelOutput.text = generalMenu[indexPath.row]
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
            cell.labelOutput.text = settingMenu[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        return cell

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return subMenu.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.text = subMenu[section]
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

