//
//  MainView.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/7/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var apiKeyViewModel = ApiKeyViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Header()
            ApiKeyInputField(viewModel: apiKeyViewModel)
            Divider()
            MessagesArea()
            Divider().padding([.bottom], 10)
            QuestionInputField(apiKeyViewModel: apiKeyViewModel)
        }
        .padding()
        .frame(width: 300, height: 550)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
