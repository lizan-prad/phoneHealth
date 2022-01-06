//
//  Observable.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import Foundation
import UIKit

class Observable<T> {

    var value: T? {
        didSet {
            self.listener?(value)
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener?(value)
        self.listener = listener
    }
}
