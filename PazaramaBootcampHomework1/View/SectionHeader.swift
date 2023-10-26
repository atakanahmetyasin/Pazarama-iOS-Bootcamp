//
//  SectionHeader.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 22.10.2023.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView{
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
        
        let seperator = UIView(frame: .zero)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .quaternaryLabel
        
        
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 22,weight: .bold)
        
        let stackView = UIStackView(arrangedSubviews: [seperator, title])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        stackView.setCustomSpacing(10, after: seperator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
