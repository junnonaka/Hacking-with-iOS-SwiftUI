//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/09.
//

import Foundation
extension Bundle{
    func decode<T:Codable>(_ file:String)->T{
        //URLの取得
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError()
        }
        //データの取得
        guard let data = try? Data(contentsOf: url) else{
            fatalError()
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        //デコード
        guard let loaded = try? decoder.decode(T.self, from: data)else {
            fatalError()
        }
        
        return loaded
        
    }
}
