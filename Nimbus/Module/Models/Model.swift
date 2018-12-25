//
//  Model.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct ToDoData: Decodable {
    var userId: Int?
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case userId, id, title
        case isCompleted = "completed"
    }
}

//    json structure
//    "userId": 1,
//    "id": 1,
//    "title": "delectus aut autem",
//    "completed": false

extension ToDoData: CustomStringConvertible {
    var description: String {
        return ("""
            userId: \(self.userId.value())
            id: \(self.id.value())
            title: \(self.title.value())
            completedStatus: \(self.isCompleted ?? false)
            """)
    }
}


