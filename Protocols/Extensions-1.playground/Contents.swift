import UIKit



protocol Parser {
    associatedtype Input
    associatedtype Output
    
    func parse(input: Input) -> Output
}

// if you do not implement, then the default is used
extension Parser {
    
    func parse(input: String) -> [String]  {
        return ["<html></html>", "<p></p>"]
    }
}

class XHTMLParser: Parser {
    
}

let xhtmlParser = XHTMLParser()
xhtmlParser.parse(input: "")



