//
//  ApiKeyModel.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import SwiftUI

class ApiKeyModel {
    @AppStorage(wrappedValue: "", "OPENAI_API_KEY", store: .standard) private var apiKey: String

    func getApiKey() -> String? {
        apiKey
    }

    func saveApiKey(value: String) async throws {
        try await valideteApiKey(value: value)
        apiKey = value
    }

    private func valideteApiKey(value: String) async throws {
        try await OpenAiService().validateApiKey(apiKey: value)
    }
}
