import Foundation

extension String {
    func range(of substring: String) -> NSRange {
        return NSString(string: self).range(of: substring)
    }
    
    func ranges(of substring: String) -> [NSRange] {
        return ranges(of: substring, offset: 0)
    }
    
    private func ranges(of substring: String, offset: Int) -> [NSRange] {
        let firstRange = range(of: substring)
        
        if firstRange.location == NSNotFound && firstRange.length == 0 {
            return []
        }
        
        let restOfString = self - firstRange
        return [firstRange + offset] + restOfString.ranges(of: substring, offset: offset + firstRange.length)
    }
}

func - (_ text: String, _ range: NSRange) -> String {
    let substring = text[..<text.index(text.startIndex, offsetBy: range.location)]
        + text[text.index(text.startIndex, offsetBy: range.location + range.length)...]
    return String(substring)
}

func + (_ range: NSRange, _ offset: Int) -> NSRange {
    return NSRange(location: range.location + offset, length: range.length)
}
