//
//  Shop.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 22.10.2023.
//

import Foundation

struct Shop: Decodable, Hashable {
    let id: Int
    let name: String
    let image: String
    let ratingText: String?
    let priceText: String?
}
