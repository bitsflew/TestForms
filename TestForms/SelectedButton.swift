//
//  SELECTABLEBUTTON.swift
//  TestForms
//
//  Created by Henk on 19/01/2026.
//

import SwiftUI

struct SelectableButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: isSelected ? systemImage : "circle")
                    .foregroundStyle(color)

                Text(title)
            }
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State
    var selected = false
    var body: some View {
        HStack {
            SelectableButton(
                title: "Goed",
                systemImage: "checkmark.circle",
                color: .green,
                isSelected: selected,
                action: {
                    selected.toggle()
                }
            )
            .frame(width: 70, height: 70)

            SelectableButton(
                title: "Fout",
                systemImage: "xmark.circle",
                color: .red,
                isSelected: selected,
                action: {
                    selected.toggle()
                }
            )
            .frame(width: 70, height: 70)
        }
    }
}
