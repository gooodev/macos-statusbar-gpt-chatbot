//
//  MessageEntity+CoreDataProperties.swift
//  gpt-chatbot
//
//  Created by 佐々木良 on 1/9/23.
//
//

import CoreData
import Foundation

public extension MessageEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
    }

    @NSManaged var timestamp: Date?
    @NSManaged var sender: Int16
    @NSManaged var message: String?
}

extension MessageEntity: Identifiable {
    var senderType: SenderType {
        get {
            SenderType(rawValue: sender) ?? .unknown
        }

        set {
            sender = newValue.rawValue
        }
    }

    var dateStr: String {
        let dateFormatter = DateFormatter()
        return dateFormatter.string(from: timestamp!)
    }
}
