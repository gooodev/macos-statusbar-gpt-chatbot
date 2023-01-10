//
//  MessagesArea.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/7/23.
//

import SwiftUI

struct MessagesArea: View {
    @FetchRequest(
        entity: MessageEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \MessageEntity.timestamp, ascending: true)],
        predicate: nil
    ) var messages: FetchedResults<MessageEntity>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(messages) { message in
                    if message.message != nil {
                        VStack {
                            Text(message.dateStr)
                            Text(message.message!)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(message.senderType == .bot ? .blue : .gray.opacity(0.8))
                                .foregroundColor(.white)
                                .border(.black.opacity(0.5))
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                        }
                    }
                }
            }
        }
        .frame(height: 230)
    }
}

struct MessagesArea_Previews: PreviewProvider {
    static var previews: some View {
        MessagesArea()
    }
}
