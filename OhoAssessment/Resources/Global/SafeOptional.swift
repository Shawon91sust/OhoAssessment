//
//  SafeOptional.swift
//  OhoAssessment
//
//  Created by Shawon Rejaul on 21/3/24.
//

import Foundation
import UIKit

/// Interface to safely unwrap variable values.
public protocol SafeUnwrappable { static func nilValue()->Self }

public extension Optional where Wrapped:SafeUnwrappable {
    var safe: Wrapped {
        switch self {
        case .some(let value): return value
        case .none: return Wrapped.nilValue()
        }
    }
}

extension Bool: SafeUnwrappable {
    public static func nilValue() -> Bool { return false }
}
extension Int:SafeUnwrappable {
    public static func nilValue() -> Int { return 0 }
}
extension Float:SafeUnwrappable {
    public static func nilValue() -> Float { return 0 }
}
extension Double:SafeUnwrappable {
    public static func nilValue() -> Double { return 0 }
}
extension CGFloat:SafeUnwrappable {
    public static func nilValue() -> CGFloat { return 0 }
}
extension String: SafeUnwrappable {
    public static func nilValue() -> String { return "" }
}
extension Array: SafeUnwrappable {
    public static func nilValue() -> Array<Element> { return [] }
}
extension Dictionary: SafeUnwrappable {
    public static func nilValue() -> Dictionary<Key, Value> { return [:] }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
