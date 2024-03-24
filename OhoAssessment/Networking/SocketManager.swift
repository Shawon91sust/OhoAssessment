//
//  SocketHandler.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 24/3/24.
//

import Foundation
import SocketIO


class SocketHandler : ObservableObject{
    
    static let shared = SocketHandler()
    
    static let socketManager = SocketManager(socketURL: URL(string: Constants.socketURL)!, config: [.log(false), .forceWebsockets(true), .compress])
    let socket = socketManager.defaultSocket
    
    var lastChatId : Int = 0
    
    func connect() {
        if(!socket.status.active) {
            
            socket.connect(withPayload: ["token": Constants.authToken], timeoutAfter: 120) {
                Logger.log("socket status is:\(self.socket.status.description)")
            }
        }
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("message") {data, ack in
            // Handle the "message" event here
            if let message = data.first as? String {
                print("Received message: \(message)")
            }
        }
        
        socket.on(clientEvent: .error) { (data, _) in
            print("socket error")
        }
        
    }
    
    func disconnect() {
        print("Disconnect called")
        socket.disconnect()
    }
    
    func enterChatroom(_ channelName: String, onCompletion: @escaping (SocketMessageModel?) -> Void) {
        
        socket.on("\(channelName)") { dataArray, ack in
            if let message = dataArray.first as? String {
                print("Received message: \(message)")
            }
            
            guard let firstElement = dataArray.first as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: firstElement),
                  let model = try? JSONDecoder().decode(SocketMessageModel.self, from: jsonData) else {
                onCompletion(nil)
                return
            }
            
            onCompletion(model)

        }
    }
    
    
    
    func sendChat(roomName: String, message: String) {
        socket.emit(roomName, message)
        
        
        
        
//        socket.emit("private message", ["roomName": roomName, "chat_id": "100"]) {
//            Logger.log("private channel created")
//        }
    }
    
    
}
