//
//  SwiftyRegex.swift
//  SwiftyKit
//
//  Created by Tyler Long on 7/3/16.
//  Copyright © 2016 Tylingsoft. All rights reserved.
//

import Foundation


infix operator =~ {
associativity none
precedence 130
}
public func =~(str: String, pattern: String) -> Bool {
    return pattern.toRegex().matches(str).count > 0
}


public extension String {

    private func toRegex() -> NSRegularExpression {
        return try! NSRegularExpression(pattern: self, options: NSRegularExpressionOptions.UseUnixLineSeparators)
    }

    public func sub(pattern: String, withString: String) -> String {
        let regex = pattern.toRegex()
        let matches = regex.matches(self)
        if matches.count > 0 {
            return regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions.WithTransparentBounds, range: matches[0].range, withTemplate: withString)
        }
        return self
    }

    public func gsub(pattern: String, withString: String) -> String {
        let regex = pattern.toRegex()
        let result = regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions.WithTransparentBounds, range: NSMakeRange(0, self.utf16.count), withTemplate: withString)
        return result
    }

    public func scan(pattern: String) -> [String] {
        let regex = pattern.toRegex()
        let matches = regex.matches(self)
        let str = self as NSString
        let result = matches.map { str.substringWithRange($0.range) }
        return result
    }

    public func split(pattern: String, removeEmptyEntries: Bool = false) -> [String] {
        let separator = "~@$^*)+_(&%#!"
        let temp = self.gsub(pattern, withString: separator)
        var result = temp.componentsSeparatedByString(separator)
        if removeEmptyEntries {
            result = result.filter { $0 != "" }
        }
        return result
    }

}


private extension NSRegularExpression {

    private func matches(input: String) -> [NSTextCheckingResult] {
        return self.matchesInString(input, options: NSMatchingOptions.WithTransparentBounds, range: NSMakeRange(0, input.characters.count))
    }

}
