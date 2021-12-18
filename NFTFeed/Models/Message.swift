//
//  Message.swift
//  NFTFeed
//
//  Created by PJ Gray on 12/18/21.
//

import UIKit

class Message: NSObject, Codable {
    var jsonrpc: String?
    var method: String?
    var id: Int?
    var params: MessageParameters?
}
