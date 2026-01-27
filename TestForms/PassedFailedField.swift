//
//  PassedFailedField.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import SwiftUI

struct PassedFailedField: View {
    @Binding
    var test: PassedFailedTest
    var body: some View {
        HStack {
            Text(test.label)
            Spacer()
            
            SelectableButton(
                title: "Goed",
                systemImage: "checkmark.circle",
                color: .green,
                isSelected: test.measurement == .passed
            ) {
                test.measurement = .passed
            }

            SelectableButton(
                title: "Fout",
                systemImage: "xmark.circle",
                color: .red,
                isSelected: test.measurement == .failed
            ) {
                test.measurement = .failed
            }
         }
    }
}

struct TwoValueField: View {
    @Binding
    var test: TwoValueTest
    
    var body: some View {
        HStack {
            Text(test.label)
            Spacer()
            
            TextField("", value: $test.v2, format: .number)
            TextField("", value: $test.v3, format: .number)

            if let result = test.value {
                Text(result, format: .number)
            } else {
                Text("")
            }
        }
    }
}

struct TwoValueGridView: View {
    @Binding
    var tests: [TwoValueTest]
    
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .trailing),
        GridItem(.flexible(), alignment: .trailing),
        GridItem(.flexible(), alignment: .trailing),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            Group {
                Text("Belasting (daN)")
                    .border(.gray, width: 1)
                Text("Links (daN)")
                    .border(.gray, width: 1)
                Text("Rechts (daN)")
                    .border(.gray, width: 1)
                Text("Verschil (daN)")
                    .border(.gray, width: 1)
                Text("")
                    .border(.gray, width: 1)
            }
            .font(.headline)
            .foregroundStyle(.secondary)
            
            ForEach($tests) { $test in
                Text(test.label)
                        
                TextField("", value: $test.v2, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .border(.gray, width: 1)
                        
                TextField("", value: $test.v3, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .border(.gray, width: 1)

                if let result = test.value {
                    Text(result, format: .number)
                        .multilineTextAlignment(.trailing)
                        .border(.gray, width: 1)
                } else {
                    Text("")
                }
                        
                let imageName = if let result = test.result {
                    if result == .passed {
                        "checkmark.circle"
                    } else {
                        "xmark.circle"
                    }
                } else {
                    "circle"
                }
                        
                Image(systemName: imageName)
                    .foregroundStyle(.green)
                }
            
         }
      }
}
