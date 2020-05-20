//
//  GuideStretch+DAOMapping.swift
//  Stretching
//
//  Created by Arif Luthfiansyah on 19/05/20.
//  Copyright © 2020 MC2-11. All rights reserved.
//

import Foundation

struct GuideStretchEntity {
    let duration: Int64 // in seconds
    let id: String
    let stretchingId: String
    let title: String
    
    init(
        duration: Int64,
        stretchingId: String,
        title: String
    ) {
        self.duration = duration
        self.id = UUID().uuidString
        self.stretchingId = stretchingId
        self.title = title
    }
}
