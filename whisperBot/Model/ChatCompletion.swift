//
//  ChatCompletion.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/10.
//

import Foundation

struct ChatCompletion: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
}

struct Usage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct Choice: Decodable {
    let message: Message
    let finish_reason: String
    let index: Int
}

struct Message: Decodable {
    let role: String
    let content: String
}
