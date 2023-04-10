//
//  WhisperAPI.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/09.
//

import Foundation

struct WhisperRequest: APIRequest {
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

func sendWhisperRequest(audioData: Data, completion: @escaping (Result<String, Error>) -> Void) {
    let url = URL(string: "https://api.openai.com/v1/whisper/asr")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer " + "API_KEY", forHTTPHeaderField: "Authorization")
    request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    request.httpBody = audioData

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let result = jsonObject?["result"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }

    task.resume()
}
