//
//  SelfConfiguringCell.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 22.10.2023.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with shop: Shop)
}
