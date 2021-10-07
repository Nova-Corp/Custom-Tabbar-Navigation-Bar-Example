//
//  CustomTabBarController.swift
//  Custom-Tabbar-Navigation-Bar-Example
//
//  Created by Mac on 01/10/21.
//

import UIKit
import SideMenu

class CustomTabBarController: UIViewController {
    @IBOutlet var customTabBarView: UIView!
    @IBOutlet var contentView: UIView!
    
    let selectedIndex = 0
    
    var tabItems: [TabItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let homeVC = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        guard let cloudVC = storyboard?.instantiateViewController(identifier: "CloudViewController") as? CloudViewController else { return }
        guard let folderVC = storyboard?.instantiateViewController(identifier: "FolderViewController") as? FolderViewController else { return }
        guard let trayVC = storyboard?.instantiateViewController(identifier: "TrayViewController") as? TrayViewController else { return }
        guard let paperPlaneVC = storyboard?.instantiateViewController(identifier: "PaperPlaneViewController") as? PaperPlaneViewController else { return }
        
        tabItems = [
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, viewController: homeVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "cloud")!, selectedImage: UIImage(systemName: "cloud.fill")!, viewController: cloudVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "folder")!, selectedImage: UIImage(systemName: "folder.fill")!, viewController: folderVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "tray")!, selectedImage: UIImage(systemName: "tray.fill")!, viewController: trayVC),
            TabItem(itemTitle: "Home", defaultImage: UIImage(systemName: "paperplane")!, selectedImage: UIImage(systemName: "paperplane.fill")!, viewController: paperPlaneVC),
        ]
        configureTabBar()
        // For Side Menu
        configureSideMenu()
    }
    
    private func configureSideMenu() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuListTableViewController") as! MenuListTableViewController
        vc.delegate = self
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.view.clipsToBounds = true
        menu.isNavigationBarHidden = true
        menu.presentationStyle = .menuSlideIn
        menu.enableSwipeToDismissGesture = true
        menu.menuWidth = self.view.frame.size.width * 0.8
        menu.statusBarEndAlpha = 0
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    @IBAction func didTapTabBarItem(_ sender: UIButton) {
        selectedTabItem(is: sender.tag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func selectedTabItem(is index: Int) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        
                        for i in 1 ... self!.tabItems.count {
                            let tabItem = self?.view.viewWithTag(i) as? UIButton
                            
                            if index == i {
                                tabItem?.setImage(self!.tabItems[i - 1].selectedImage, for: .normal)
                                tabItem?.transform = .init(scaleX: 1.5, y: 1.5)
                            } else {
                                tabItem?.setImage(self!.tabItems[i - 1].defaultImage, for: .normal)
                                tabItem?.transform = .init(scaleX: 1, y: 1)
                            }
                        }
                        
                        self?.view.layoutIfNeeded()
                        
                       })
        
        contentView.addSubview(tabItems[index - 1].viewController.view)
        tabItems[index - 1].viewController.didMove(toParent: self)
    }
    @IBAction func sideMenuAction(_ sender: Any) {
        
        guard let leftMenu = SideMenuManager.default.leftMenuNavigationController else { return }
        present(leftMenu, animated: true, completion: nil)
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func configureTabBar() {
        customTabBarView.layer.cornerRadius = customTabBarView.frame.height / 2
        customTabBarView.layer.masksToBounds = false
        customTabBarView.clipsToBounds = false
        
        DispatchQueue.main.async { [weak self] in
            self?.selectedTabItem(is: self!.selectedIndex + 1)
        }
    }
}

extension CustomTabBarController {
    struct TabItem {
        let itemTitle: String
        let defaultImage: UIImage
        let selectedImage: UIImage
        let viewController: UIViewController
    }
}
