//
//  NSTextView+Extension.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/7/23.
//

import Foundation
import SwiftUI

extension NSTextView {
    override open var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}
