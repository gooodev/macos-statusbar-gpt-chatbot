//
//  MessageViewModel.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/9/23.
//

import Foundation
import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var message: String = ""

    private var messageModel: MessageModel
    private var apiKeyModel: ApiKeyModel

    init(viewContext: NSManagedObjectContext) {
        messageModel = MessageModel(viewContext: viewContext)
        apiKeyModel = ApiKeyModel()
    }

    func saveMessage() async {
        do {
            try await messageModel.save(apiKey: apiKeyModel.getApiKey()!, message: message)
        } catch {
            fatalError("Faield to save")
        }
    }

    private func sendTextCompletion() {}
}
