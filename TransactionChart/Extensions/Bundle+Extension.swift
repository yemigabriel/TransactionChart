//
//  Bundle+Extension.swift
//  TransactionChart
//
//  Created by Yemi Gabriel on 3/14/22.
//

import Foundation
extension Bundle {
    func decode<T: Decodable> (_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        return loaded
    }
}
