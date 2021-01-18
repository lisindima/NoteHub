//
//  SubscriptionView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 07.01.2021.
//

import Purchases
import SwiftUI

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
        Purchases.shared.purchasePackage(package) { _, purchaserInfo, _, _ in
            if purchaserInfo?.entitlements.active != nil {
                alertItem = AlertItem(title: "Успешно", message: "Подписка оформлена")
            }
        }
    }
    
    private func restoreSubscription() {
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            if let error = error {
                alertItem = AlertItem(title: "Ошибка", message: error.localizedDescription)
            } else {
                if purchaserInfo != nil {
                    alertItem = AlertItem(title: "Успешно", message: "Подписка восстановлена")
                }
            }
        }
    }
    
    var body: some View {
        #if os(watchOS)
        watch
        #else
        other
        #endif
    }
    
    var watch: some View {
        ScrollView {
            SubscriptionTitleView()
                .padding(.bottom)
            SubscriptionContainerView()
                .padding(.bottom)
            if let monthly = offering?.monthly {
                SubscriptionButton(
                    title: "Ежемесячно",
                    subTitle: mountlyPrice,
                    colorButton: Color.accentColor.opacity(0.2),
                    colorText: .accentColor,
                    action: { buySubscription(monthly) }
                )
            }
            if let annual = offering?.annual {
                SubscriptionButton(
                    title: "Ежегодно",
                    subTitle: yearPrice,
                    colorButton: .accentColor,
                    colorText: .white,
                    action: { buySubscription(annual) }
                )
            }
            Button(action: restoreSubscription) {
                Text("Восстановить платеж")
                    .font(.footnote)
            }
            .padding(.top)
            Link("Политика", destination: URL(string: "https://apple.com")!)
                .font(.footnote)
            Link("Правила", destination: URL(string: "https://apple.com")!)
                .font(.footnote)
        }
        .onAppear(perform: fetchProduct)
        .customAlert(item: $alertItem)
    }
    
    var other: some View {
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
                    SubscriptionButton(
                        title: "Ежемесячно",
                        subTitle: mountlyPrice,
                        colorButton: Color.accentColor.opacity(0.2),
                        colorText: .accentColor,
                        action: { buySubscription(monthly) }
                    )
                    .padding(.trailing, 4)
                }
                if let annual = offering?.annual {
                    SubscriptionButton(
                        title: "Ежегодно",
                        subTitle: yearPrice,
                        colorButton: .accentColor,
                        colorText: .white,
                        action: { buySubscription(annual) }
                    )
                    .padding(.leading, 4)
                }
            }
            .padding(.top, 8)
            .padding(.horizontal)
            HStack {
                Button(action: restoreSubscription) {
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
