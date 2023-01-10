//
//  ApiKeyViewModel.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import Foundation

@MainActor
class ApiKeyViewModel: ObservableObject {
    @Published var apiKey: String = ""
    @Published var validateState: ValidateState = .before

    private var model: ApiKeyModel

    init() {
        model = ApiKeyModel()
        apiKey = model.getApiKey() ?? ""
    }

    func deactivateApiKey() {
        validateState = .before
    }

    func saveApiKey() async {
        do {
            validateState = .loading
            try await model.saveApiKey(value: apiKey)
            validateState = .activated
        } catch HTTPRequestError.notFoundError {
            validateState = .failure("Endpoint not found")
        } catch HTTPRequestError.unauthorizedError {
            validateState = .failure("Invalid API Key")
        } catch HTTPRequestError.serverOverloadError {
            validateState = .failure("OpenAI server is currently overloaded")
        } catch {
            validateState = .failure("Unexpected error occured")
        }
    }
}

enum ValidateState: Equatable {
    case before, loading, activated, failure(String)
}
