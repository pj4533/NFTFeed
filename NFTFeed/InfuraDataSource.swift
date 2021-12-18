//
//  InfuraDataSource.swift
//  NFTFeed
//
//  Created by PJ Gray on 12/18/21.
//

import UIKit

protocol InfuraDelegate {
    func didReceiveMessage(_ message: Message?)
}

class InfuraDataSource: NSObject {
    var delegate: InfuraDelegate?
    let session = URLSession(configuration: .default)
    var socket: URLSessionWebSocketTask?

    func connect() {
        self.socket = self.session.webSocketTask(with: URL(string: "wss://mainnet.infura.io/ws/v3/\(Secrets().infuraProjectId)")!)
        self.socket?.resume()
        self.listen()
        
        // Can't figure out how to model this properly, so sending as a string. The params is a paaaaaaaain
        //
        // this filter is the key too -- i want to get only ERC721 transfers, hopefully just mints maybe?
        let message = "{\"jsonrpc\":\"2.0\",\"method\":\"eth_subscribe\",\"id\":1, \"params\":[\"logs\", {\"event\":[\"Transfer\"]}]}"
        self.socket?.send(URLSessionWebSocketTask.Message.string(message), completionHandler: { error in
            // handle errors
        })
    }
    
    func listen() {
        // this result stuff must be an async/await mechanism - not used to it yet
        self.socket?.receive(completionHandler: { result in
            switch result {
            case .success(let message):
                let decoder = JSONDecoder()
                var messageObject: Message?
                do {
                    switch message {
                    case .data(let messageData):
                        messageObject = try decoder.decode(Message.self, from: messageData)
                    case .string(let messageString):
//                        print(messageString)
                        if let messageData = messageString.data(using: .utf8) {
                            messageObject = try decoder.decode(Message.self, from: messageData)
                        } else {
                            print("Error: null message string")
                        }
                    @unknown default:
                        print("Error: unknown message type")
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
                self.delegate?.didReceiveMessage(messageObject)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
            self.listen()
        })
    }
}
