//
//  Header.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("GPT-3 Bot")
                .font(.system(size: 16))
                .fontWeight(.bold)
            Spacer()
            Button(
                action: {
                    NSApplication.shared.terminate(nil)
                },
                label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                }
            )
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
