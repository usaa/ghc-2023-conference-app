//
//  Session.swift
//  Conference
//
//  Created by Pham, Ashley on 8/28/23.
//

import Foundation

struct Session: Identifiable, Equatable {
    public let id: Int
    let title: String
    let body: String
    var isRegistered: Bool
}
