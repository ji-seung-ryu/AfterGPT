//
//  ConversationStore.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/15/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import SwiftUI

@MainActor
class ConversationStore:ObservableObject{
    @Published var conversations: [Conversation] =  []
    private static func fileURL() throws -> URL{
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("conversations.data")
    }
    
    func load() async throws{
        print("conversation load")

        let task = Task<[Conversation], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let conversations = try JSONDecoder().decode([Conversation].self, from: data)
            return conversations
        }
        
        let conversations = try await task.value
        self.conversations = conversations
    }
    
    func save (conversations: [Conversation]) async throws{
        print("conversation save")

        let task = Task{
            let data = try JSONEncoder().encode(conversations)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    
}
