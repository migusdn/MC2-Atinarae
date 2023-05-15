//
//  Category.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/13.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var user: User?
    @Persisted var name: String
}
