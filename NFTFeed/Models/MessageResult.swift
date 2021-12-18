//
//  MessageResult.swift
//  NFTFeed
//
//  Created by PJ Gray on 12/18/21.
//

import UIKit

class MessageResult: NSObject, Codable {
    var removed: Bool?
    var logIndex: String?
    var transactionIndex: String?
    var transactionHash: String?
}
