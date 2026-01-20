//
//  Extension+Codable.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import Foundation

extension Encodable {
    func toPrettyJSONString(
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601
    ) -> String {
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = dateEncodingStrategy

            let data = try encoder.encode(self)
            return String(decoding: data, as: UTF8.self)
        } catch {
            print(error.localizedDescription)
            return ""
        }
       
    }
}
