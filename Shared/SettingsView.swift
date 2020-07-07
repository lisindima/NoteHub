//
//  SettingsView.swift
//  Note
//
//  Created by Дмитрий Лисин on 07.07.2020.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var purchasesStore: PurchasesStore = PurchasesStore.shared
    @State private var iCloudSync: iCloudSync = .normal
    @State private var showSubcriptionSheet: Bool = false
    
    var body: some View {
        Form {
            Section {
                if !purchasesStore.purchasesInfo!.activeSubscriptions.isEmpty {
                    HStack {
                        Image(systemName: "plus.app.fill")
                            .frame(width: 24)
                            .foregroundColor(.purple)
                        Button(action: {}) {
                            VStack(alignment: .leading) {
                                Text("Управление подпиской")
                                    .foregroundColor(.primary)
                                if purchasesStore.purchasesSameDay {
                                    Text("Подписка возобновится: Сегодня, \(purchasesStore.purchasesInfo!.expirationDate(forEntitlement: "NoteHub Plus")!, formatter: purchasesStore.dateHour)")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("Подписка возобновится: \(purchasesStore.purchasesInfo!.expirationDate(forEntitlement: "NoteHub Plus")!, formatter: purchasesStore.dateDay)")
                                        .font(.system(size: 11))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                } else {
                    HStack {
                        Image(systemName: "plus.app.fill")
                            .frame(width: 24)
                            .foregroundColor(.purple)
                        Button("Оформить подписку") {
                            showSubcriptionSheet = true
                        }
                        .foregroundColor(.primary)
                        .sheet(isPresented: $showSubcriptionSheet) {
                            SubscriptionSplashScreen()
                        }
                    }
                }
                if iCloudSync == .normal {
                    HStack {
                        Image(systemName: "icloud")
                            .frame(width: 24)
                            .foregroundColor(.green)
                        VStack(alignment: .leading) {
                            Text("Синхронизация работает")
                            Text("Все сервисы работают в обычном режиме.")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                } else if iCloudSync == .problem {
                    HStack {
                        Image(systemName: "exclamationmark.icloud")
                            .frame(width: 24)
                            .foregroundColor(.yellow)
                        VStack(alignment: .leading) {
                            Text("Наблюдаются неполадки")
                            Text("Cихронизация может занять больше времени.")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                } else if iCloudSync == .failure {
                    HStack {
                        Image(systemName: "xmark.icloud")
                            .frame(width: 24)
                            .foregroundColor(.red)
                        VStack(alignment: .leading) {
                            Text("Синхронизация не работает")
                            Text("Данные пользователей сохраняются локально.")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                } else if iCloudSync == .loading {
                   HStack {
                        ProgressView()
                            .frame(width: 24)
                        VStack(alignment: .leading) {
                            Text("Загрузка")
                            Text("Проверяем работоспособность сервера.")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

enum iCloudSync {
    case normal, problem, failure, loading
}
