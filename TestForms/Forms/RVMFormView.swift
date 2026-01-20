//
//  RVMFormView.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import SwiftUI

struct RVMFormModel: Codable {
    var name = "Remmentestbank"
    
    var tests: [TestGroup] = [
        TestGroup(label: "Conformiteit", tests: [
            .passedFailed(PassedFailedTest(label: "Verzegeling onbeschadigd")),
            .passedFailed(PassedFailedTest(label: "Typekeuringserst. met bijlage en doc. aanwezig")),
            .passedFailed(PassedFailedTest(label: "Aanwezige printplaten en voedingsuni"))

        ]),
        TestGroup(label: "Metingen", tests: [
            .twoValue(TwoValueTest(label: "50")),
            .twoValue(TwoValueTest(label: "100")),
            .twoValue(TwoValueTest(label: "200")),
            .twoValue(TwoValueTest(label: "300")),
            .twoValue(TwoValueTest(label: "400")),
            .twoValue(TwoValueTest(label: "500")),
            .twoValue(TwoValueTest(label: "700")),
            .twoValue(TwoValueTest(label: "800")),
            .twoValue(TwoValueTest(label: "/00"))
        ])
    ]
    
    var t1 = PassedFailedTest(label: "Verzegeling onbeschadigd")
    var t2 = PassedFailedTest(label: "Typekeuringserst. met bijlage en doc. aanwezig")
    var t3 = PassedFailedTest(label: "Aanwezige printplaten en voedingsuni")
    var t4 = PassedFailedTest(label: "Krachtopnemers | Type: KFL2301")
    var t5 = PassedFailedTest(label: "Softwareversie: 1.22")
    var t6 = PassedFailedTest(label: "Checksum: 7A46")

    var t20: [TwoValueTest] = [
        TwoValueTest(label: "50", v0: 50),
        TwoValueTest(label: "100", v0: 100),
        TwoValueTest(label: "200", v0: 200),
        TwoValueTest(label: "300", v0: 300),
        TwoValueTest(label: "400", v0: 400),
        TwoValueTest(label: "500", v0: 500),
        TwoValueTest(label: "700", v0: 700),
        TwoValueTest(label: "800", v0: 800),
        TwoValueTest(label: "900", v0: 900)
    ]
   
    var passed: Bool {
        let mirror = Mirror(reflecting: self)

        var allPassed = true
        
        for child in mirror.children where allPassed {
            if let test = child.value as? any Test {
                if test.result != .passed {
                    allPassed = false
                }
            }
        }
        
        return allPassed
    }
}

struct RVMFormView: View {
    @State
    var testModel = RVMFormModel()
    var body: some View {
        Form {
            let passed = testModel.passed
            Button(passed ? "Onderteken" : "Afgekeurd") {
                let s = testModel.toPrettyJSONString()
                print(s)
            }
            .buttonStyle(.plain)
            
            Section("Conformiteit") {
                PassedFailedField(test: $testModel.t1)
                PassedFailedField(test: $testModel.t2)
                PassedFailedField(test: $testModel.t3)
             }
            
            Section("Krachtopnemen") {
                PassedFailedField(test: $testModel.t4)
            }
            
            Section("Algemeen") {
                PassedFailedField(test: $testModel.t5)
                PassedFailedField(test: $testModel.t6)
            }
            
            Section("MeetreMeetgegevenssuktaten") {
                TwoValueGridView(tests: $testModel.t20)
             }
        }
    }
}
