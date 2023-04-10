//
//  APIRequest.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/10.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    var urlRequest: URLRequest { get }
}
