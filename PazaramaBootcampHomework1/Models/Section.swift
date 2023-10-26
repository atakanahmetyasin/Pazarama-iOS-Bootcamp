//
//  Section.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 22.10.2023.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let title: String
    let type: String
    let items: [Shop]
 
}
