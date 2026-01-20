//
//  FormModel.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

struct CustomerModel : Codable {
    let id: Int
    let name: String
    let address: String
    let city: String
    let postalCode: String
}

struct DeviceModel : Codable {
    let id: Int
    let type: String
    let make: String
    let model: String
    let serialNumber: String
}

