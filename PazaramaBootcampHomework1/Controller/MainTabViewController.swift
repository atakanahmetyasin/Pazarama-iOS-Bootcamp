//
//  MainTabViewController.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit



class MainTabViewController: UITabBarController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewControllers()
        
        // Do any additional setup after loading the view.
        
    }
    
    func configureViewControllers(){
      
        
        let homepage = navigationController(selectedImage: UIImage(imageLiteralResourceName: "homeSelected"), unselectedImage: UIImage(imageLiteralResourceName: "home"), rootViewController: HomePageViewController())
        
        let menu = navigationController(selectedImage: nil, unselectedImage: UIImage(imageLiteralResourceName: "menu"), rootViewController: MenuViewController())
        
        let cart = navigationController(selectedImage: nil, unselectedImage: UIImage(imageLiteralResourceName: "cart"), rootViewController: CartViewController())

        let profile = navigationController(selectedImage: nil, unselectedImage: UIImage(imageLiteralResourceName: "profile"), rootViewController: ProfileViewController())
        
        let more = navigationController(selectedImage: nil, unselectedImage: UIImage(imageLiteralResourceName: "more"), rootViewController: MoreViewController())
        
        viewControllers = [homepage, cart, menu, profile, more]
        tabBar.backgroundColor = .systemBackground
        
    }
    
    func navigationController(selectedImage: UIImage?, unselectedImage: UIImage, rootViewController: UIViewController)  -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .systemBackground
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return nav
    }

 

}

