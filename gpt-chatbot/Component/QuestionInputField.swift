//
//  QuestionInputField.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/7/23.
//

import SwiftUI

struct QuestionInputField: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var apiKeyViewModel: ApiKeyViewModel
    @State private var message: String = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Question").frame(alignment: .leading)
                    VStack {
                        TextEditor(text: $message)
                    }
                    .padding([.all], 8)
                    .border(.gray)
                    .shadow(radius: 5)
                    .cornerRadius(4)
                }

                HStack {
                    Spacer()
                    Button("Send [⌘+Enter]") {
                        Task {
                            await sendData()
                        }
                    }
                    .keyboardShortcut(KeyEquivalent("\r"), modifiers: [.command])
                    .cornerRadius(4)
                }
            }
        }.frame(height: 150)
    }

    private func sendData() async {
        Task {
            do {
                let result = try await OpenAiService()
                    .fetchTextCompletion(apiKey: apiKeyViewModel.apiKey, prompt: message, maxTokens: 1000)
                let request = MessageEntity(context: viewContext)
                request.message = message
                request.timestamp = Date()
                request.senderType = .user

                let response = MessageEntity(context: viewContext)
                response.message = result.trimmingCharacters(in: .whitespacesAndNewlines)
                response.timestamp = Date()
                response.senderType = .bot

                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
