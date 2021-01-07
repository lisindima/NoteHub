//
//  SubscriptionView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 07.01.2021.
//

import SwiftUI
import Purchases

struct SubscriptionView: View {
    var body: some View {
        VStack {
            ScrollView {
                SubscriptionTitleView()
                    .padding(.bottom)
                    .padding(.top, 50)
                SubscriptionContainerView()
                    .padding(.bottom, 50)
            }
            Spacer()
            HStack {
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor.opacity(0.2))
                            .frame(maxWidth: .infinity, maxHeight: 72)
                        VStack {
                            Text("Ежемесячно")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                            Text("test")
                        }
                    }
                }
                .padding(.trailing, 4)
                Button(action: {}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: .infinity, maxHeight: 72)
                        VStack {
                            Text("Ежегодно")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("test")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.leading, 4)
            }
            .padding(.top, 8)
            .padding(.horizontal)
            HStack {
                Button(action: {}) {
                    Text("Восстановить платеж")
                        .font(.footnote)
                }
                Text("|")
                    .font(.footnote)
                Link("Политика", destination: URL(string: "https://apple.com")!)
                    .font(.footnote)
                Text("|")
                    .font(.footnote)
                Link("Правила", destination: URL(string: "https://apple.com")!)
                    .font(.footnote)
            }.padding(.vertical)
        }
    }
}

struct SubscriptionTitleView: View {
    var body: some View {
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
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal)
        }
    }
}

struct SubscriptionContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(title: "Изменение иконки", subTitle: "Измените стандартную иконку приложения на любую другую, которая придется по вкусу!", imageName: "app")
            InformationDetailView(title: "Изменение цвета акцентов", subTitle: "Вы сможете менять цвет акцентов в приложении, на абсолютно любой!", imageName: "paintbrush")
            InformationDetailView(title: "Тёмная тема", subTitle: "Темная тема теперь всегда! Конечно, если вы этого захотите)", imageName: "moon")
            InformationDetailView(title: "Удаление рекламы", subTitle: "Полное удаление рекламы из приложения.", imageName: "tag")
            InformationDetailView(title: "Поддержка", subTitle: "Оформляя подписку вы поддерживаете разработчика и позволяете развиваться приложению.", imageName: "heart")
        }
        .padding(.horizontal)
    }
}

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .frame(width: 30)
                .padding()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}
