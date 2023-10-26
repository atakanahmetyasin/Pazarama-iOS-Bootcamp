//
//  CategoriesCell.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit

class CategoriesCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier: String = "CategoriesCell"
    

    let categoryImageView : UIImageView = {
        let categoryImage = UIImageView()
        categoryImage.backgroundColor = .clear
        categoryImage.layer.cornerRadius = 25
        categoryImage.clipsToBounds = true
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        return categoryImage
    }()
    
    let categoryButton: UIButton = {
        let categoryButton = UIButton(type: .custom)
//        categoryButton.backgroundColor = .systemMint
        categoryButton.setTitleColor(.blue, for: .normal)
        categoryButton.setTitleColor(.red, for: .highlighted)
        categoryButton.titleLabel?.textAlignment = .center
//        categoryButton.titleLabel?.numberOfLines = 4
        categoryButton.titleLabel?.font = UIFont(name: "Arial", size: 14) //GillSans-BoldItalic
//        categoryButton.layer.cornerRadius = 10
//        categoryButton.clipsToBounds = true
//        categoryButton.layer.borderColor = UIColor.black.cgColor
//        categoryButton.layer.borderWidth = 0.5
        categoryButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        categoryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        categoryButton.titleLabel?.lineBreakMode = .byWordWrapping
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return categoryButton
    }()
    
     @objc func categoryButtonTapped(){

         let rootVC = MenuViewController()
         rootVC.title = "Category Selected"
         let navVC = UINavigationController(rootViewController: rootVC)
         self.window?.rootViewController?.present(navVC, animated: true)
         
    }
    
    
    private func addViews() {
//        backgroundColor = .quaternaryLabel
        let seperator = UIView(frame: .zero)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .quaternaryLabel
        
        
        addSubview(categoryButton)
        addSubview(categoryImageView)

        
        let stackView = UIStackView(arrangedSubviews: [ categoryImageView,categoryButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: categoryImageView)

       
        
    }
    
    func configure(with shop: Shop){
        categoryButton.setTitle(shop.name, for: .normal)
        
        // Buttonun textini altı çizili yapar. Basılı kalınca rengini kırmızı yapar
        let attributedString = NSAttributedString(string: shop.name, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : UIColor.blue])
        categoryButton.setAttributedTitle(attributedString, for: .normal)
        
        categoryImageView.image = UIImage(named: shop.image)   
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


    
