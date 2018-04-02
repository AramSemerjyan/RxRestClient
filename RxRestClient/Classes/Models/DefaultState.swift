//
//  DefaultState.swift
//  RxRestClient
//
//  Created by Tigran Hambardzumyan on 3/23/18.
//

import Foundation

public struct DefaultState: ResponseState {
    public var success: Bool?
    public var state: BaseState?

    public init(state: BaseState) {
        self.state = state
        self.success = false
    }

    public init(response: (HTTPURLResponse, String)) {
        self.state = BaseState.online
        self.success = 200 <= response.0.statusCode && response.0.statusCode < 300
    }

    public static let empty = DefaultState(state: BaseState.empty)
}