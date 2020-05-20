//
//  Stretch+DAOMapping.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import Foundation

struct StretchEntity {
    let duration: Int64 // in seconds
    let guides: [GuideStretchEntity]
    let id: String
    let recommend: Bool
    let title: String
    let type: String
    
    init(
        duration: Int64,
        guides: [GuideStretchEntity],
        recommend: Bool,
        title: String,
        type: String
    ) {
        self.duration = duration
        self.guides = guides
        self.id = UUID().uuidString
        self.recommend = recommend
        self.title = title
        self.type = type
    }
}
