//
//  ConversationStore.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/15/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import SwiftUI

@MainActor
class SentenceStore:ObservableObject{
    @Published var sentences: [StoredSentence] =  []
    
    private static func fileURL() throws -> URL{
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Sentences.data")
    }
    
    func load() async throws{
        print("sentence load")
        let task = Task<[StoredSentence], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let setences = try JSONDecoder().decode([StoredSentence].self, from: data)
            return setences
        }
        
        let sentences = try await task.value
        self.sentences = sentences
    }
    
    func save (sentences: [StoredSentence]) async throws{
        print("sentence save")

        let task = Task{
            let data = try JSONEncoder().encode(sentences)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    
}
