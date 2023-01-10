//
//  SwiftUIView.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/6/23.
//

import SwiftUI

struct ApiKeyInputField: View {
    @ObservedObject var viewModel: ApiKeyViewModel
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Your OpenAI API Key:")
                    TextField("", text: $viewModel.apiKey)
                        .cornerRadius(5)
                        .disabled(disableApiKeyField())
                        .onSubmit(handleSubmit)
                }
                HStack {
                    Spacer()

                    switch viewModel.validateState {
                    case let .failure(error): Text(error).foregroundColor(.red)
                    case .activated: Text("Activated!").foregroundColor(.green)
                    case .loading: ProgressView().scaleEffect(x: 0.5, y: 0.5, anchor: .center).frame(height: 5)

                    default: EmptyView()
                    }
                    VStack {
                        Button(
                            action: handleSubmit,
                            label: {
                                Text(
                                    disableApiKeyField() ? "Edit" : "Activate"
                                )
                                .frame(maxWidth: .infinity)
                            }
                        )
                        .cornerRadius(5)
                    }.frame(width: 80)
                }
                .frame(alignment: .leading)
            }
        }
    }

    func disableApiKeyField() -> Bool {
        viewModel.validateState == .activated || viewModel.validateState == .loading
    }

    func handleSubmit() {
        if disableApiKeyField() {
            viewModel.deactivateApiKey()
        } else {
            Task {
                await viewModel.saveApiKey()
            }
        }
    }
}

struct ApiKeyInputField_Previews: PreviewProvider {
    static var previews: some View {
        ApiKeyInputField(viewModel: ApiKeyViewModel())
    }
}
