//
//  OpenAiService.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import Foundation

enum HTTPRequestError: Error {
    case notFoundError, serverOverloadError, unauthorizedError, invalidResponse, unexpectedError, serverError
}

class OpenAiService {
    func fetchTextCompletion(apiKey: String, prompt: String? = nil, maxTokens: Int? = nil) async throws -> String {
        let requetBody = TextCompletionRequestBody(
            model: Constants.AIModels.textDavinci,
            prompt: prompt,
            maxTokens: maxTokens
        )

        var request = URLRequest(url: Constants.Urls.textCompletionUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try encoder.encode(requetBody)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else {
            throw HTTPRequestError.unexpectedError
        }
        print(httpStatus.statusCode)
        switch httpStatus.statusCode {
        case 200 ..< 400:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let completionData = try decoder.decode(TextCompletionResponse.self, from: data)
            return completionData.choices[0].text
        case 400:
            throw HTTPRequestError.notFoundError
        case 401:
            throw HTTPRequestError.unauthorizedError
        case 402 ..< 429:
            throw HTTPRequestError.unexpectedError
        case 429:
            throw HTTPRequestError.serverOverloadError
        case 500...:
            throw HTTPRequestError.serverError
        default:
            throw HTTPRequestError.unexpectedError
        }
    }

    func validateApiKey(apiKey: String) async throws {
        var _ = try await fetchTextCompletion(apiKey: apiKey)
    }

    struct TextCompletionRequestBody: Encodable {
        let model: String
        let prompt: String?
        let maxTokens: Int?
    }

    struct TextCompletionResponse: Decodable {
        let id: String
        let object: String
        let created: Int
        let model: String
        let choices: [Choices]
        let usage: Usage
    }

    struct Choices: Decodable {
        let text: String
        let index: Int
        let finishReason: String
    }

    struct Usage: Decodable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
    }
}
