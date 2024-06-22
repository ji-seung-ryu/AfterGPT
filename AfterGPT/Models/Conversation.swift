//
//  Conversation.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/10/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import Foundation

struct Message: Identifiable, Codable{
    let id: String
    let sender: String
    
    let content: String
    let create_time: Date
    init(id: String, sender: String, content: String, create_time: Date) {
        self.id = id
        self.sender = sender
        self.content = content
        self.create_time = create_time
    }}

struct EvaluatedMessage: Identifiable, Codable {
    let id: UUID
    var comment: String?
    var score: Int?
    var better_sentence: String?
    var isSaved: Bool? // 새로운 변수를 옵셔널로 변경
    let message: Message
    
    
    init(id: UUID = UUID(), comment: String?, message: Message) {
        self.id = id
        self.comment = comment
        self.message = message
    }
    
    init(id: UUID = UUID(), comment: String?, score:Int, better_sentence:String, message: Message, isSaved: Bool? = false) {
        self.id = id
        self.comment = comment
        self.score = score
        self.better_sentence = better_sentence
        self.message = message
        self.isSaved = isSaved
    }
    
    
}


struct StoredSentence: Identifiable, Codable {
    let id: UUID
    let conversation_id : UUID
    let message_id: UUID
    var title: String?
    var comment: String?
    var score: Int?
    var better_sentence: String?
    
    let message: String
    var theme: Theme
    
    
    
    init(id: UUID = UUID(), conversation_id:UUID, message_id:UUID, title: String?, comment: String?, score:Int, better_sentence:String, message: String, theme:Theme) {
        self.id = id
        self.conversation_id = conversation_id
        self.message_id = message_id
        self.title = title
        self.comment = comment
        self.score = score
        self.better_sentence = better_sentence
        self.message = message
        self.theme = theme
    }}

struct EvaluatedConversation: Identifiable, Codable {
    let id: UUID
    var title: String
    var date: Date
    var evaluatedMessages: [EvaluatedMessage]
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    
    // Required method for Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(evaluatedMessages, forKey: .evaluatedMessages)
    }
    
    init(id: UUID = UUID(), title: String, date: Date, evaluatedMessages: [EvaluatedMessage] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.evaluatedMessages = evaluatedMessages
    }
    
}

struct Conversation: Identifiable, Codable {
    
    
    let id: UUID
    var title: String
    var date: Date
    var evaluatedMessages: [EvaluatedMessage]
    var theme: Theme
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    init(id: UUID = UUID(), title: String, date: Date, evaluatedMessages: [EvaluatedMessage] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.evaluatedMessages = evaluatedMessages
        self.theme = Theme.random()
        
    }
    init(id: UUID = UUID(), title: String, date: Date, evaluatedMessages: [EvaluatedMessage] = [], theme: Theme) {
        self.id = id
        self.title = title
        self.date = date
        self.evaluatedMessages = evaluatedMessages
        self.theme = theme
        
    }
    
    
    static var emptyConversation: Conversation{
        Conversation(title: "", date: Date.now, evaluatedMessages: [])
    }
    
    
}

struct Response: Codable {
    let statusCode: Int
    let body: String
}

extension StoredSentence{
    static let sampleData: [StoredSentence] = [
        StoredSentence(conversation_id: UUID(uuidString: "076f051b-2169-4404-92d6-f0ba4cd77aff")!, message_id:UUID(uuidString: "d2683a06-fd6b-49af-bbc7-a0fe6d5d60e6")!, title:"native english speaker 는 조금 어색한 표현이에요. english native speaker가 자연스럽습니다.", comment: "native english speaker 는 조금 어색한 표현이에요. english native speaker가 자연스럽습니다.", score: 3, better_sentence: "I want to speak as fluently as native English speakers.", message: "I just want to speak as fluently as English native speakers.", theme: .teal
                      ),
        
        StoredSentence(conversation_id: UUID(uuidString: "076f051b-2169-4404-92d6-f0ba4cd77aff")!, message_id:UUID(uuidString: "8f899399-5085-4842-8637-f212465cdae2")!, title:"good, cool도 좋지만 enjoyable, beneficial 가 같은 표현을 사용해보세요.", comment: "good, cool도 좋지만 enjoyable, beneficial 가 같은 표현을 사용해보세요.", score: 3, better_sentence: "In the club, there are many foreigners, which gives me ample opportunities to converse with people from different countries in English. This experience is both enjoyable and beneficial.", message: "Yeah, actually in club, as I said before, in club there are a lot of foreigners, so there's a lot of chances for me to talk with other countries people in English, and actually that's really good and cool.", theme: .sky
                      ),
        
        StoredSentence(conversation_id: UUID(uuidString: "7ab5f6c5-76d2-44e5-9595-817ec63bfcdb")!, message_id:UUID(uuidString: "292d08a5-0e33-45f2-a3da-d46524794b13")!, title:"hesitant to greet 은 인사를 하기 망설인다는 표현을 제대로 전할 수 있습니다.", comment: "hesitant to greet 은 인사를 하기 망설인다는 표현을 제대로 전할 수 있습니다.", score: 3, better_sentence: "In Paris, people appear more extroverted compared to Koreans. They are more comfortable saying hi to strangers, including tourists like me. This cultural difference is quite impressive to me, as Koreans are generally hesitant to greet people they meet for the first time.", message: "Actually, people in Paris look more like extroverts than Koreans, so they could easily say hi to strangers, like tourists like me, and it's really impressive for me. You know, Koreans don't like to say hi to people they meet for the first time, so it's a little bit like a cultural difference, I think.", theme: .seafoam),
        
    ]
    
}


extension Conversation {
    static let sampleData: [Conversation] = [
        Conversation(
            id: UUID(uuidString: "076f051b-2169-4404-92d6-f0ba4cd77aff")!,
            title: "[Example] Improving english",
            date: Date(),
            evaluatedMessages: [
                
                EvaluatedMessage(id: UUID(uuidString: "d2683a06-fd6b-49af-bbc7-a0fe6d5d60e6")!, comment: "native english speaker 는 조금 어색한 표현이에요. english native speaker가 자연스럽습니다.", score:4, better_sentence:"I want to speak as fluently as native English speakers.", message: Message(id: "5", sender: "user", content: "I just want to speak as fluently as English native speakers.", create_time: Date()), isSaved: true),
                EvaluatedMessage(comment: "Keep it up!", message: Message(id: "6", sender: "bot", content: "Got it! To improve spoken English, try chatting with native speakers, watching English movies, and practicing pronunciation. How often do you get to speak English in your daily routine?", create_time: Date())),
                EvaluatedMessage(comment: "other than it 이라는 표현을 사용해보세요.", score:4, better_sentence:"Actually, once a week, I go to the English debate club to participate in English debates. This really helps me improve my English. In addition, I usually try to watch English videos on YouTube. These are all the things I do to improve my English." ,message: Message(id: "7", sender: "user", content: "Actually, once a week, I go to English debate club to debate in English. That really helps me improve my English. And other than it, I usually try to watch an English video on YouTube. So that's the all things I do to improve my English.", create_time: Date())),
                EvaluatedMessage(comment: "Keep it up!", message: Message(id: "8", sender: "bot", content: "That's a great routine! Regular debates and watching English videos are excellent methods. Have you considered incorporating more casual conversations in English, like chatting with friends or joining online forums?", create_time: Date())),
                EvaluatedMessage(id: UUID(uuidString: "8f899399-5085-4842-8637-f212465cdae2")!, comment: "good, cool도 좋지만 enjoyable, beneficial 가 같은 표현을 사용해보세요.", score:4, better_sentence:"In the club, there are many foreigners, which gives me ample opportunities to converse with people from different countries in English. This experience is both enjoyable and beneficial.", message: Message(id: "9", sender: "user", content: "Yeah, actually in club, as I said before, in club there are a lot of foreigners, so there's a lot of chances for me to talk with other countries people in English, and actually that's really good and cool.", create_time: Date()),isSaved: true),
                EvaluatedMessage(comment: "Keep it up!", message: Message(id: "10", sender: "bot", content: "That's fantastic! Engaging with people from different countries in the debate club is a fantastic way to enhance your conversational skills. Anything specific you find challenging during these conversations?", create_time: Date())),
                EvaluatedMessage(comment: "빠르게 말하다는 say in very fast speed 보다 speak quickly 가 자연스럽습니다.", score:3, better_sentence:"In my opinion, listening is more important than speaking. However, I find it challenging to understand native speakers, especially when they speak quickly." , message: Message(id: "11", sender: "user", content: "Actually, speaking doesn't matter compared to listening. So for me, listening is really hard to understand, especially when it comes to native speakers. So when native speakers say in very fast speed, sometimes it's really hard to understand what they mean.", create_time: Date())),
                EvaluatedMessage(comment: "Keep it up!", message: Message(id: "12", sender: "bot", content: "I get it. Native speakers can be speedy! To improve listening skills, try listening to various accents, watching English movies without subtitles, and using language learning apps. What kind of content do you find most challenging to understand?", create_time: Date()))
                
            ],theme: .seafoam
        ),
        Conversation(
            id: UUID(uuidString: "7ab5f6c5-76d2-44e5-9595-817ec63bfcdb")!,
            title: "[Example] Exploring Cultural Differences",
            date: Date(),
            evaluatedMessages: [
                EvaluatedMessage(id: UUID(uuidString: "59c023ee-cb22-4c76-9fa0-ccdb6ab082da")!, comment: "when it comes to는 '특히 ~에 관하여' 라는 표현으로 사용될 수 있습니다.", score: 3, better_sentence: "I'm interested in learning about cultural differences, especially when it comes to social interactions.", message: Message(id: "3", sender: "user", content: "I want to explore cultural differences, particularly in the way people interact.", create_time: Date())),
                EvaluatedMessage(comment: "Solid recommendation!", score: 5, better_sentence: "", message: Message(id: "4", sender: "Bot", content: "Sure thing! Understanding cultural nuances is fascinating. Have you noticed any specific cultural differences that caught your attention?", create_time: Date())),
                EvaluatedMessage(id: UUID(uuidString: "292d08a5-0e33-45f2-a3da-d46524794b13")! ,comment: "hesitant to greet 은 인사를 하기 망설인다는 표현을 제대로 전할 수 있습니다.", score: 4, better_sentence: "In Paris, people appear more extroverted compared to Koreans. They are more comfortable saying hi to strangers, including tourists like me. This cultural difference is quite impressive to me, as Koreans are generally hesitant to greet people they meet for the first time.", message: Message(id: "5", sender: "user", content: "Actually, people in Paris look more like extroverts than Koreans, so they could easily say hi to strangers, like tourists like me, and it's really impressive for me. You know, Koreans don't like to say hi to people they meet for the first time, so it's a little bit like a cultural difference, I think.", create_time: Date()), isSaved: true),
                EvaluatedMessage(comment: "Keep it up!", score: 5, better_sentence: "", message: Message(id: "6", sender: "bot", content: "That's fascinating! Cultural variations in social norms are indeed captivating. Have you encountered any other interesting cultural observations during your travels?", create_time: Date())),
                EvaluatedMessage(comment: "found it to be old and class라는 표현을 사용할 수 있습니다.", score: 2, better_sentence: "I have visited the Paris subway and found it to be old and classic compared to the Seoul metro. However, I noticed that the Paris subway is a bit dirty and messy compared to the Korean metro", message: Message(id: "7", sender: "user", content: "Yeah, I've been to, like, Paris subway, and it's a little bit old and classic compared to Seoul metro, and I feel like, yeah, there's a little bit DALL·E dirty and messy compared to Korean.", create_time: Date())),
                EvaluatedMessage(comment: "I appreciate the advice!", score: 4, better_sentence: "", message: Message(id: "8", sender: "bot", content: "Each city's subway system does have its own unique character. Were there any other aspects that stood out to you during your travels?", create_time: Date()))
            ],
            theme: .teal
        )

       
        

    ]
}


