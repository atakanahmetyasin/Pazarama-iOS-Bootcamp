//
//  LastViewedCell.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit

class LastViewedCell: UICollectionViewCell, SelfConfiguringCell {
 
        static var reuseIdentifier: String = "LastViewedCell"
        
        func configure(with shop: Shop) {
            lastViewedLabel.text = shop.name
            lastViewedImage.image = UIImage(named: shop.image)
        }
        
        
        let lastViewedLabel: UILabel = {
            let lastViewedLabel = UILabel()
//            lastViewedLabel.font = UIFont.systemFont(ofSize: 22,weight: .regular)
            lastViewedLabel.font = UIFont(name: "GillSans-SemiBoldItalic", size: 15)
            lastViewedLabel.textAlignment = .center
            lastViewedLabel.textColor = .black
            lastViewedLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            lastViewedLabel.translatesAutoresizingMaskIntoConstraints = false
            return lastViewedLabel
        }()
        
        let lastViewedImage: UIImageView = {
            let lastViewedImage = UIImageView()
            lastViewedImage.backgroundColor = .clear
            lastViewedImage.layer.cornerRadius = 10
            lastViewedImage.clipsToBounds = true
            lastViewedImage.translatesAutoresizingMaskIntoConstraints = false
            return lastViewedImage
        }()

        
        private func addViews(){
            addSubview(lastViewedLabel)
            addSubview(lastViewedImage)

            let stackView = UIStackView(arrangedSubviews: [lastViewedImage, lastViewedLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
                    stackView.axis = .vertical
//            stackView.alignment = .leading
                    contentView.addSubview(stackView)
                    NSLayoutConstraint.activate([

                        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
                        stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                    ])
            stackView.setCustomSpacing(15, after: lastViewedImage)
           

        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }


