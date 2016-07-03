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

    private func toRegex() -> RegularExpression {
        return try! RegularExpression(pattern: self, options: RegularExpression.Options.useUnixLineSeparators)
    }

    public func sub(_ pattern: String, withString: String) -> String {
        let regex = pattern.toRegex()
        let matches = regex.matches(self)
        if matches.count > 0 {
            return regex.stringByReplacingMatches(in: self, options: RegularExpression.MatchingOptions.withTransparentBounds, range: matches[0].range, withTemplate: withString)
        }
        return self
    }

    public func gsub(_ pattern: String, withString: String) -> String {
        let regex = pattern.toRegex()
        let result = regex.stringByReplacingMatches(in: self, options: RegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, self.utf16.count), withTemplate: withString)
        return result
    }

    public func scan(_ pattern: String) -> [String] {
        let regex = pattern.toRegex()
        let matches = regex.matches(self)
        let str = self as NSString
        let result = matches.map { str.substring(with: $0.range) }
        return result
    }

    public func split(_ pattern: String, removeEmptyEntries: Bool = false) -> [String] {
        let separator = "~@$^*)+_(&%#!"
        let temp = self.gsub(pattern, withString: separator)
        var result = temp.components(separatedBy: separator)
        if removeEmptyEntries {
            result = result.filter { $0 != "" }
        }
        return result
    }

}


private extension RegularExpression {

    private func matches(_ input: String) -> [TextCheckingResult] {
        return self.matches(in: input, options: RegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, input.utf16.count))
    }

}
