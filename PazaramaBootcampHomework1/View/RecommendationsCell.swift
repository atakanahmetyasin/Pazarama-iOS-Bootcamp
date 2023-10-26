//
//  RecommendationsCell.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit
class RecommendationsCell: UICollectionViewCell,SelfConfiguringCell {
    static var reuseIdentifier: String = "RecommendationsCell"
    
    
    func configure(with shop: Shop) {
        recommendationsName.text = shop.name
        recommendationsImageView.image = UIImage(named: shop.image)
    }
    
    let addToBasket : UIButton = {
        let addToBasket = UIButton(type: .custom)
        addToBasket.backgroundColor = .systemOrange
        addToBasket.setTitle("Sepete Ekle", for: .normal)
        addToBasket.titleLabel?.font = UIFont(name: "Arial", size: 17)
        addToBasket.titleLabel?.textAlignment = .center
        addToBasket.setTitleColor(.white, for: .normal)
        addToBasket.setTitleColor(.systemBlue, for: .highlighted)
        addToBasket.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addToBasket.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addToBasket.layer.cornerRadius = 10
        addToBasket.clipsToBounds = true
        
        addToBasket.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addToBasket.translatesAutoresizingMaskIntoConstraints = false
        
        return addToBasket
    }()
    
    @objc func buttonTapped(){
        let alert = UIAlertController(title: "", message: "Sepete Eklendi", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    let recommendationsImageView : UIImageView = {
        let recommendationsImage = UIImageView()
        recommendationsImage.backgroundColor = .clear
        recommendationsImage.clipsToBounds = true
        recommendationsImage.translatesAutoresizingMaskIntoConstraints = false
        return recommendationsImage
    }()
    
    let recommendationsName : UILabel = {
        let recommendationsLabel = UILabel()
        recommendationsLabel.textColor = .black
        recommendationsLabel.textAlignment = .center
        recommendationsLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        recommendationsLabel.numberOfLines = 3
        recommendationsLabel.translatesAutoresizingMaskIntoConstraints = false
       
        return recommendationsLabel
    }()
    
    private func setupUI(){
//        backgroundColor = .quaternaryLabel
        
        let seperator = UIView(frame: .zero)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .lightGray
        
        addSubview(addToBasket)
        addSubview(recommendationsImageView)
        addSubview(recommendationsName)
        
        let stackView = UIStackView(arrangedSubviews: [recommendationsImageView, recommendationsName,addToBasket,seperator])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            seperator.widthAnchor.constraint(equalToConstant: 220),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        stackView.setCustomSpacing(10, after: recommendationsImageView)
        stackView.setCustomSpacing(10, after: recommendationsName)
        stackView.setCustomSpacing(5, after: addToBasket)
        
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
