//
//  Test.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import Foundation

enum TestResult: Codable {
    case passed
    case failed
}

protocol Test: Codable, Identifiable  {
    var id: UUID { get  }
    var label: String { get }
    var result: TestResult? { get  }
}



struct PassedFailedTest:   Test{
    let id = UUID()
    let label: String
    var measurement: TestResult?
    
    private enum CodingKeys: String, CodingKey {
        case label
        case measurement
    }
    
    var result: TestResult?  {
        get {
            if let measurement {
                return measurement
            } else {
                return nil
            }
        }
    }
}

struct OneValueTest:  Test {
    let id = UUID()
    let label: String
    var measurement: Double?
    var value: Double?
    
    var result: TestResult?  {
        nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case measurement
    }
}

func calcDiff(test: TwoValueTest) -> Double? {
    if let measurement1 = test.measurement1,
       let measurement2 = test.measurement2 {
        return abs(measurement1 - measurement2)
    } else {
        return nil
    }
}



struct TwoValueTest:  Test, Hashable {
    let id = UUID()
    let label: String
    var v0: Double?
    var measurement1: Double?
    var measurement2: Double?
    let evaluate: (Self) -> Double? = calcDiff
    //let validate: (Double,Double,Double) -> Double?
    var value: Double?  {
        evaluate(self)
    }
    
    var result: TestResult?  {
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case measurement1
        case measurement2
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(label)
            hasher.combine(measurement1)
            hasher.combine(measurement2)
        }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.label == rhs.label &&
        lhs.measurement1 == rhs.measurement1 &&
        lhs.measurement2 == rhs.measurement2
    }
}

enum TestType: Codable {
    case passedFailed(PassedFailedTest)
    case twoValue(TwoValueTest)
}

struct TestGroup: Test {
    var id: UUID = UUID()
    var label: String
    var tests: [TestType]
    
    var result: TestResult?  {
        // all .passed = .passed
        // all nil = nil
        // some .failed = .failed
        let results = tests.map { testType in
            switch testType {
            case let .passedFailed(test):
                test.result
            case let .twoValue(test):
                test.result
            }
        }
        
        for result in results {
            if result == .failed {
                return .failed
            }
            
            if result == nil {
                return nil
            }
        }
        
        return .passed
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case tests
    }
    
}


