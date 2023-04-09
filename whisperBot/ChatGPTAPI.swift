//
//  ChatGPTAPI.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/09.
//

import Foundation

func sendChatGPTRequest(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    print("sendChatGPTRequest")
    let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer " + "API_KEY", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let requestBody: [String: Any] = [
        "prompt": prompt,
        "max_tokens": 50,
        "n": 1,
        "stop": ["\n"],
        "temperature": 0.8
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
            guard let choices = jsonObject?["choices"] as? [[String: Any]],
                  let firstChoice = choices.first,
                  let text = firstChoice["text"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            completion(.success(text))
        } catch {
            completion(.failure(error))
        }
    }

    task.resume()
}
