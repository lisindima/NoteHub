//
//  SubscriptionTitleView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 12.01.2021.
//

import SwiftUI

struct SubscriptionTitleView: View {
    var body: some View {
        #if os(watchOS)
        VStack {
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
            HStack {
                Text("NoteHub")
                    .fontWeight(.bold)
                Text("Plus")
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
        }
        #else
        VStack {
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.accentColor)
            HStack {
                Text("NoteHub")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Plus")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
            }
            Text("После приобретения подписки вы получите больше функций для еще лучшего опыта использования приложения.")
                .font(.caption2)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal)
        }
        #endif
    }
}
