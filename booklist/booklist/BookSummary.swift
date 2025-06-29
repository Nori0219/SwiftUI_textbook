//
//  BookSummary.swift
//  booklist
//
//  Created by 杉井位次 on 2025/06/29.
//

import SwiftData

//本データを保存するためのデータ構造を定義する

@Model
final class BookSummary {
    @Attribute(.unique) var id: String
    var title: String
    var thumbnail: String?
    
    init(id: String, title: String, thumbnail: String? = nil) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
}
