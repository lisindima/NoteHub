//
//  SubscriptionView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 07.01.2021.
//

import SwiftUI
import Purchases

struct SubscriptionView: View {
    @State private var yearPrice: String = ""
    @State private var mountlyPrice: String = ""
    @State private var alertItem: AlertItem?
    @State private var offering: Purchases.Offering?
    
    private func fetchProduct() {
        Purchases.shared.offerings { offerings, error in
            if let error = error {
                alertItem = AlertItem(title: "Ошибка", message: error.localizedDescription)
            }
            if let currentOffering = offerings?.current {
                offering = currentOffering
            }
            if let package = offerings?.current?.monthly?.localizedPriceString {
                mountlyPrice = package
            }
            if let package = offerings?.current?.annual?.localizedPriceString {
                yearPrice = package
            }
        }
    }
    
    private func buySubscription(_ package: Purchases.Package) {
        Purchases.shared.purchasePackage(package) { transaction, purchaserInfo, error, userCancelled in
            if purchaserInfo?.entitlements.active != nil {
                alertItem = AlertItem(title: "Успешно", message: "Подписка оформлена")
            }
        }
    }
    
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
                if let monthly = offering?.monthly {
                    Button(action: { buySubscription(monthly) }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentColor.opacity(0.2))
                                .frame(maxWidth: .infinity, maxHeight: 72)
                            VStack {
                                Text("Ежемесячно")
                                    .fontWeight(.bold)
                                    .font(.system(size: 16))
                                Text(mountlyPrice)
                            }
                        }
                    }
                    .padding(.trailing, 4)
                }
                if let annual = offering?.annual {
                    Button(action: { buySubscription(annual) }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: .infinity, maxHeight: 72)
                            VStack {
                                Text("Ежегодно")
                                    .fontWeight(.bold)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                Text(yearPrice)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.leading, 4)
                }
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
            }
            .padding(.vertical)
        }
        .onAppear(perform: fetchProduct)
        .customAlert(item: $alertItem)
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
    var title: String
    var subTitle: String
    var imageName: String
    
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
