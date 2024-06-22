//
//  Onboarding.swift
//  Scrumdinger
//
//  Created by Ji-Seung on 2/7/24.
//

import Foundation

struct Onboarding{
    var id: Int
    var image: String
    var titleText: String
    var descriptionText: String
    var showButton: Bool?
    
    static let sampleData: [Onboarding] = [
        Onboarding(id: 1, image: "onboard1", titleText: "우선, ChatGPT와 실컷 대화하세요.", descriptionText: "수준 높은 원어민과 대화하는 것 이상의 효과입니다."),
        Onboarding(id: 2, image: "onboard2", titleText: "AfterGPT에 기록을 추가하세요.", descriptionText: "GPT와 나눴던 대화기록을 AfterGPT에 저장할 수 있습니다."),
        Onboarding(id: 3, image: "onboard3", titleText: "문장 별 분석을 받아보세요." , descriptionText: "내가 사용했던 문장에서 더 자연스러운 문장을 제안받습니다."),
        Onboarding(id: 4, image: "onboard4", titleText: "분석을 저장하세요." , descriptionText: "제안받은 문장에 대해 저장하고 수시로 복습할 수 있습니다."),
        Onboarding(id: 5, image: "onboard4", titleText: "위 과정을 반복하세요." , descriptionText: "놀라울 정도로 수준높은 영어를 구사할 수 있습니다." , showButton: true),
    ]
}
