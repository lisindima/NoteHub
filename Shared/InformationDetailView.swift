//
//  InformationDetailView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 12.01.2021.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String
    var subTitle: String
    var imageName: String
    
    var body: some View {
        #if os(watchOS)
        HStack {
            Image(systemName: imageName)
                .frame(width: 24)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.primary)
                Text(subTitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        #else
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .frame(width: 30)
                .padding()
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundColor(.secondary)
            }
        }
        #endif
    }
}
