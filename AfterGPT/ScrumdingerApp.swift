/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import GoogleMobileAds

@main
struct ScrumdingerApp: App {
    @StateObject private var conversationStore = ConversationStore()
    @StateObject private var sentenceStore = SentenceStore()
    
    @State private var errorWrapper: ErrorWrapper?
    @AppStorage("onboard") var onboard: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if onboard {
                ContentView(conversations: $conversationStore.conversations, sentences: $sentenceStore.sentences){
                    Task {
                        do {
                            try await conversationStore.save(conversations: conversationStore.conversations)
                            try await sentenceStore.save(sentences:  sentenceStore.sentences)
                        } catch {
                            errorWrapper = ErrorWrapper(error:error, guidance:"Try again later.")
                        }
                    }
                }
                .task {
                    do {
                        let runned = UserDefaults.standard.bool(forKey:"runned")
                        if !runned{
                            conversationStore.conversations = Conversation.sampleData
                            sentenceStore.sentences = StoredSentence.sampleData
                            
                            //try await conversationStore.save(conversations: conversationStore.conversations)
                            UserDefaults.standard.set(true, forKey: "runned")
                        }
                        else{
                            try await conversationStore.load()
                            try await sentenceStore.load()
                        }
                        //UserDefaults.standard.removeObject(forKey: "runned")
                        
                        
                        //UserDefaults.standard.removeObject(forKey: "onboard")
                        
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "App will load sample data and continue.")
                    }
                }
                
            } else{
                OnboardingArrayView(onboardingArray: Onboarding.sampleData)
            }
        }
    }
}




class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Initialize Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        //    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers =
        //        [ kGADSimulatorID ] as? [String]
        
        return true
    }
}
