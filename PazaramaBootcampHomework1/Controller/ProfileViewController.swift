//
//  ProfileViewController.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
       
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    @objc func backButton(){
         dismiss(animated: true)
    }


}
