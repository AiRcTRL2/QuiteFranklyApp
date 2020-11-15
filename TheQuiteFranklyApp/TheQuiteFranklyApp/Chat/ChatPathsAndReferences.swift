//
//  ChatPathsAndReferences.swift
//  TheQuiteFranklyApp
//
//  Created by Karim Elgendy on 07/04/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Firebase

struct ChatPathsAndReferences {
    struct refs {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
