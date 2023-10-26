//
//  Bundle-Decodable.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 22.10.2023.
//

import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {// t.Type: jsondan gelen verinin doğru türe dönmesini sağlar
        guard let url = self.url(forResource: file, withExtension: nil) else { // forResource kısmı jsonu temsil eder. with extension ise uzantısını. İstersen emin olduğun için forResource: "data", withExtension: "json" yazabilirsin.
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
