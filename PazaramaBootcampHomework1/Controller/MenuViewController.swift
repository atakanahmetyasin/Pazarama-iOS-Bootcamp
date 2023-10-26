//
//  MenuViewController.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit
class MenuViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        view.addSubview(label)
        label.text = "Have fun Shopping"
        label.font = UIFont.systemFont(ofSize: 30,weight: .bold)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        
        view.backgroundColor = .systemBackground

        
        // Do any additional setup after loading the view.
    }
    

}
