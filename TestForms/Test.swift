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

protocol Test: Codable, Identifiable {
    var id: UUID { get }
    var label: String { get }
    var result: TestResult? { get }
}

struct PassedFailedTest: Test {
    let id = UUID()
    let label: String
    var measurement: TestResult?

    private enum CodingKeys: String, CodingKey {
        case label
        case measurement
    }

    var result: TestResult? {
        if let measurement {
            return measurement
        } else {
            return nil
        }
    }
}

struct OneValueTest: Test {
    let id = UUID()
    let label: String
    var measurement: Double?
    var value: Double?

    var result: TestResult? {
        nil
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case measurement
    }
}

struct TextTest: Test {
    let id = UUID()
    let label: String
    let validInputs: [String]
    var input: String?
    var value: String? {
        return nil
    }

    var result: TestResult? {
        guard let input else {
            return nil
        }
        return validInputs.contains(input) ? .passed : .failed
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case label
        case input
        case validInputs
    }
}

func calcDiff(test: TwoValueTest) -> Double? {
    if let v2 = test.v2,
       let v3 = test.v3
    {
        return abs(v2 - v3)
    } else {
        return nil
    }
}

enum TestType: Codable {
    case passedFailed(PassedFailedTest)
    case twoValue(TwoValueTest)
}

struct TestGroup: Test {
    var id: UUID = .init()
    var label: String
    var tests: [TestType]

    var result: TestResult? {
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
