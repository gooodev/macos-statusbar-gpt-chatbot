//
//  MessageModel.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/9/23.
//
import CoreData
import Foundation

class MessageModel {
    private var viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

    func save(apiKey: String, message: String) async throws {
        do {
            let meNew = MessageEntity(context: viewContext)
            meNew.message = message
            meNew.senderType = .user
            meNew.timestamp = Date()

            let result = try await OpenAiService().fetchTextCompletion(apiKey: apiKey, prompt: message)

            let botNew = MessageEntity(context: viewContext)
            botNew.message = result
            botNew.senderType = .bot
            botNew.timestamp = Date()

            return try viewContext.save()
        } catch {
            fatalError("Failed to save data")
        }
    }
}
