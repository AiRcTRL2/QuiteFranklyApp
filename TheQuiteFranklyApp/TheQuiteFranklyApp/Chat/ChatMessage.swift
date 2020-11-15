//
//  ChatMessage.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 09/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ChatMessage: Hashable, Identifiable, Codable {
    var id = UUID()
    let senderID: Int
    let senderDisplayName: String
    let message: String
    let date: Date
    
    init(senderID: Int, senderDisplayName: String, message: String, date: Date) {
        self.senderID = senderID
        self.senderDisplayName = senderDisplayName
        self.message = message
        self.date = date
    }
    
    
    static func parseFirebaseQuery(dataJSON json: JSON) -> ChatMessage? {
        let senderID = json["sender_id"].intValue
        let senderName = json["sender_name"].stringValue
        let message = json["message"].stringValue
        guard let date = DateHelper.dateFromString(dateString: json["sent_date"].stringValue) else {
            return nil
        }
        
        return ChatMessage(senderID: senderID,
                                        senderDisplayName: senderName,
                                        message: message,
                                        date: date)
    }

    
    private func getMessage() -> [String:Any] {
        return ["sender_id": self.senderID,
                "sender_name": self.senderDisplayName,
                "sent_date": DateHelper.dateString(date: self.date, returnFormat: "yyyy-MM-dd HH:mm:ss"),
                "message": self.message]
    }
    
    func sendMessage() {
        let firebaseDB = ChatPathsAndReferences.refs.databaseChats.childByAutoId()
        firebaseDB.setValue(getMessage())
    }
}
