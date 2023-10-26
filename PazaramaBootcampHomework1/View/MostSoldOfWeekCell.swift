//
//  MostSoldOfWeekCell.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit

class MostSoldOfWeekCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "MostSoldOfWeekCell"
    
    func configure(with shop: Shop) {
        mostSoldItemLabel.text = shop.name
        mostSoldItemImage.image = UIImage(named: shop.image)
        starLabel.text = shop.ratingText
        price.text = shop.priceText
    }
    
    let star : UIImageView = {
        let star = UIImageView()
        star.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemOrange)
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }()
    
    let price : UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.textAlignment = .center
        price.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        return price
    }()
    
    let starLabel : UILabel = {
        let starLabel = UILabel()
        starLabel.textColor = .black
        starLabel.textAlignment = .center
        starLabel.font = UIFont(name: "GillSans-Italic", size: 13)
        starLabel.numberOfLines = 2
        return starLabel
    }()
    
    let mostSoldItemLabel: UILabel = {
        let mostSoldItemLabel = UILabel()
        mostSoldItemLabel.textColor = .black
        mostSoldItemLabel.font = UIFont(name: "GillSans-Italic", size: 17)
        mostSoldItemLabel.textAlignment = .center
        mostSoldItemLabel.numberOfLines = 5
        mostSoldItemLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        mostSoldItemLabel.translatesAutoresizingMaskIntoConstraints = false
        return mostSoldItemLabel
    }()
    
    let mostSoldItemImage: UIImageView = {
        let mostSoldItemImage = UIImageView()
        mostSoldItemImage.backgroundColor = .clear
        mostSoldItemImage.layer.cornerRadius = 10
        mostSoldItemImage.clipsToBounds = true
        
        
        
        mostSoldItemImage.translatesAutoresizingMaskIntoConstraints = false
        return mostSoldItemImage
    }()
    
    @objc func didTapImage(){
        let rootVC = self.window?.rootViewController
        let VC = ProfileViewController()
        VC.title = "Ürün Açıklaması"
        let navVC = UINavigationController(rootViewController: VC)
        
        navVC.modalPresentationStyle = .fullScreen
        rootVC?.present(navVC, animated: true)
    }
    
    private func addViews(){
        addSubview(mostSoldItemLabel)
        addSubview(mostSoldItemImage)
        addSubview(star)
        addSubview(starLabel)
        addSubview(price)
        
        let stackViewStar = UIStackView(arrangedSubviews: [star,starLabel])
        stackViewStar.translatesAutoresizingMaskIntoConstraints = false
        stackViewStar.axis = .horizontal
        contentView.addSubview(stackViewStar)
        
        let stackViewVertical = UIStackView(arrangedSubviews: [mostSoldItemLabel, stackViewStar, price])
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        contentView.addSubview(stackViewVertical)
        
        
        let stackView = UIStackView(arrangedSubviews: [mostSoldItemImage, stackViewVertical])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        contentView.addSubview(stackView)
        
        // TapGestureRecognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(tapGestureRecognizer)
        
        
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: star.bottomAnchor,constant: 20),
            
            star.leadingAnchor.constraint(equalTo: mostSoldItemImage.trailingAnchor,constant: 2),
            
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
