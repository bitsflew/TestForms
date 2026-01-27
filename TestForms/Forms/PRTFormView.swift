//
//  PRTFormView.swift
//  TestForms
//
//  Created by Henk on 20/01/2026.
//

/*
 ====================================================================
 SOORT MEETMIDDEL
 ====================================================================
 CODE   Omschrijving
 --------------------------------------------------------------------
 emk    Afzuigunit (0-emissiekast)
 mnm    Manometer
 pdm    Pedaalkrachtmeter
 prt    Platenremtestinrichting
 r12    Rollenremtestinrichting klasse-1 en 2
 rmt    Roetmeter
 rt1    Rollenremtestinrichting klasse-1
 rt2    Rollenremtestinrichting klasse-2
 rvm    Remvertragingsmeter
 vgm    Uitlaatgastester (Viergasmeter)
 dlt    Deeltjesteller

 ====================================================================
 12 RESULTAATBESTANDEN
 ====================================================================

 */

/*
 Maak een tabel met alle  controles en metingen die verplicht zijn  tijdens de jaarlijkse (her)certificering van een personenvoertuig APK meetapparatruur
 Toon  voor de metingen de referentiewaarde, eenheid en toegestane tolerantie
 toon de metingens als het laatst in de tabel
 toon voor elke meting ook alle tussenstappen  inclusief de inputs
 label controlers met controle and metingene met meting
 Maak de tfabel een Platenremtestinrichting
 */
import SwiftUI

struct PRTFormModel: Codable {
    var name = "Platenremtestbank"
    
    var tests: [TestGroup] = [
        TestGroup(label: "Conformiteit", tests: [
            
        ]),
        TestGroup(label: "Algemeenm", tests: [
            .passedFailed(PassedFailedTest(label: "Omgevingstemperatuur +5 tot 40 °C")),
            .passedFailed(PassedFailedTest(label: "NL handleiding en NL opschriften")),
            .passedFailed(PassedFailedTest(label: "Voedingsspanning")),
            .passedFailed(PassedFailedTest(label: "Electronische / mechanische werking")),
            .passedFailed(PassedFailedTest(label: "Optische contr. / alle onderdelen aanwezig")),
        ]),
        TestGroup(label: "Lineariteitstest", tests: [
         ])
            
    ]
    
    var t10 = TextTest(label: "text",validInputs: ["A","B"])
    
    var t1 = PassedFailedTest(label: "Verzegeling onbeschadigd")
    var t2 = PassedFailedTest(label: "Typekeuringserst. met bijlage en doc. aanwezig")
    var t3 = PassedFailedTest(label: "Aanwezige printplaten en voedingsuni")
    var t4 = PassedFailedTest(label: "Krachtopnemers | Type: KFL2301")
    var t5 = PassedFailedTest(label: "Softwareversie: 1.22")
    var t6 = PassedFailedTest(label: "Checksum: 7A46")

    var t20: [TwoValueTest] = [
        TwoValueTest(label: "50", v1: 50),
        TwoValueTest(label: "100", v1: 100),
        TwoValueTest(label: "200", v1: 200),
        TwoValueTest(label: "300", v1: 300),
        TwoValueTest(label: "400", v1: 400),
        TwoValueTest(label: "500", v1: 500),
        TwoValueTest(label: "700", v1: 700),
        TwoValueTest(label: "800", v1: 800),
        TwoValueTest(label: "900", v1: 900)
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

struct PRTFormView: View {
    @State
    var testModel = PRTFormModel()
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
