//
//  TwoValueTest.swift
//  TestForms
//
//  Created by Henk on 27/01/2026.
//


import Foundation

struct TwoValueTest: Test, Hashable {
    let id = UUID()
    let label: String
    var v1: Double?
    var v2: Double?
    var v3: Double?
    let evaluate: (Self) -> Double? = calcDiff
    // let validate: (Double,Double,Double) -> Double?
    var value: Double? {
        evaluate(self)
    }

    var result: TestResult? {
        if let value {
            if value <= 50 {
                return .passed
            } else {
                return .failed
            }

        } else {
            return nil
        }
    }
    
    var evaluate1 = """
    function evaluate(v1,v2,v3)  {
        return abs(v2 - v3)
    }
    """
    
    var validate = """
    function validate(v1,v2,v3,v4) {
        return v4 M 0.5
    }
    """

    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case v2
        case v3
        case evaluate1
        case validate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(label)
        hasher.combine(v2)
        hasher.combine(v3)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.label == rhs.label &&
            lhs.v2 == rhs.v2 &&
            lhs.v3 == rhs.v3
    }
}
