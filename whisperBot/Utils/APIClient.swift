//
//  APIClient.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/10.
//

import Foundation

import RxCocoa
import RxSwift

class APIClient {
    func send<T: APIRequest>(_ request: T) -> Observable<T.Response> {
        return URLSession.shared.rx.response(request: request.urlRequest)
            .map { response, data -> T.Response in
                if 200 ..< 300 ~= response.statusCode {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.Response.self, from: data)
                } else {
                    throw NSError(domain: "apiClient", code: response.statusCode, userInfo: nil)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
}
