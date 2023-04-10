//
//  ChatGPTAPI.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/09.
//

import Foundation
import RxSwift

struct ChatGPTRequest: APIRequest {
    private let apiKey = "your_api_key_here"

    typealias Response = ChatCompletion
    let text: String
    var urlRequest: URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = "You: \(text)\nAI:"
        let json: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 50,
            "n": 1,
            "stop": ["\n"],
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        return request
    }
}

class ChatGPTAPI {
    func sendTextToChatGPT(text: String) -> Observable<ChatCompletion> {
        var client = APIClient()
        return client.send(ChatGPTRequest(text: text))
    }
}
