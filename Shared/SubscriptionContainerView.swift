//
//  SubscriptionContainerView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 12.01.2021.
//

import SwiftUI

struct SubscriptionContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(
                title: "Изменение иконки",
                subTitle: "Измените стандартную иконку приложения на любую другую, которая придется по вкусу!",
                imageName: "app"
            )
            .padding(.bottom, 3)
            InformationDetailView(
                title: "Изменение цвета акцентов",
                subTitle: "Вы сможете менять цвет акцентов в приложении, на абсолютно любой!",
                imageName: "paintbrush"
            )
            .padding(.bottom, 3)
            InformationDetailView(
                title: "Тёмная тема",
                subTitle: "Темная тема теперь всегда! Конечно, если вы этого захотите)",
                imageName: "moon"
            )
            .padding(.bottom, 3)
            InformationDetailView(
                title: "Удаление рекламы",
                subTitle: "Полное удаление рекламы из приложения.",
                imageName: "tag"
            )
            .padding(.bottom, 3)
            InformationDetailView(
                title: "Поддержка",
                subTitle: "Оформляя подписку вы поддерживаете разработчика и позволяете развиваться приложению.",
                imageName: "heart"
            )
        }
        .padding(.horizontal)
    }
}
