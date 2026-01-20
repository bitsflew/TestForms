//
//  PassedFailed.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import SwiftUI

struct PassedFailedView: View {
    let label: String
    @State private var selected: TestResult? = nil

    var body: some View {
        HStack(spacing: 16) {
            Text(label)
            Spacer()

            SelectableButton(
                title: "Goed",
                systemImage: "checkmark.circle",
                color: .green,
                isSelected: selected == .passed
            ) {
                selected = .passed
            }

            SelectableButton(
                title: "Fout",
                systemImage: "xmark.circle",
                color: .red,
                isSelected: selected == .failed
            ) {
                selected = .failed
            }
        }
        .padding()
    }
}

#Preview {
    PassedFailedView(label: "Test label")
}

