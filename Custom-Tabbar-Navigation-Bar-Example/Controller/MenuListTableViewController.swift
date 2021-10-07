//
//  MenuListTableViewController.swift
//  Custom-Tabbar-Navigation-Bar-Example
//
//  Created by Mac on 01/10/21.
//

import UIKit

class MenuListTableViewController: UITableViewController {
    weak var delegate: CustomTabBarController?
    @IBAction func profileDetailsTapped(_ sender: Any) {
        dismiss(animated: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
            self.delegate?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        dismiss(animated: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            self.delegate?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func aboutUsButtonTapped(_ sender: Any) {
        dismiss(animated: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            self.delegate?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
