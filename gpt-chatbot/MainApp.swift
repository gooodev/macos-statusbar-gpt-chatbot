//
//  gpt_chatbotApp.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/9/23.
//

import SwiftUI

@main
struct MainApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {}
    }
}
