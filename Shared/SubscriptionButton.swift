//
//  SubscriptionButton.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 12.01.2021.
//

import SwiftUI

struct SubscriptionButton: View {
    var title: String
    var subTitle: String
    var colorButton: Color
    var colorText: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorButton)
                    .frame(maxWidth: .infinity, maxHeight: 72)
                VStack {
                    Text(title)
                        .foregroundColor(colorText)
                        .fontWeight(.semibold)
                    Text(subTitle)
                        .foregroundColor(colorText)
                }
            }
        }
    }
}
