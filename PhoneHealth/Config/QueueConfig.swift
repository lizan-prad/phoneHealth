//
//  QueueConfig.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import Foundation

enum QueueConfig {
    static let qualityOfServiceClass = DispatchQoS.QoSClass.background
    static let backgroundQueue = DispatchQueue.global(qos: QueueConfig.qualityOfServiceClass)
}
