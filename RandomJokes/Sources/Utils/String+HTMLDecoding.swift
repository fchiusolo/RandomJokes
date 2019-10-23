import UIKit

extension String {
    private static let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
    ]
    
    init?(htmlEncodedString: String) {
        guard let attributedString = String.buildAttributedString(htmlEncodedString) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
    private static func buildAttributedString(_ htmlEncodedString: String) -> NSAttributedString? {
        return htmlEncodedString
            .data(using: .utf8)
            .flatMap { try? NSAttributedString(data: $0, options: String.options, documentAttributes: nil) }
    }
}
