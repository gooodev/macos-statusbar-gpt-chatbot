//
//  Constants.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import Foundation

struct Constants {
    enum Urls {
        static let textCompletionUrl = URL(string: "https://api.openai.com/v1/completions")!
    }

    enum AIModels {
        static let textDavinci = "text-davinci-003"
    }

    enum Options {
        static let maxToken = 1000
    }
}
