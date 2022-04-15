import Foundation

//MARK: Enums instead of Structs

enum Session {
    case keynote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case normal(title: String, speaker: String, date: Date)
    case workshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case joint(title: String, speakers: [String], date: Date)
}

let keynote = Session.keynote(title: "WWDC 2022", speaker: "Tim Cook", date: Date(), isRecorded: true)

func displaySession(session: Session) {
    switch session {
    case let .keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print("\(title) - \(speaker) - \(date) - \(isRecorded)")
    case let .normal(title: title, speaker: speaker, date: date):
        print("\(title) - \(speaker) - \(date)")
    case let .workshop(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print("\(title) - \(speaker) - \(date) - \(isRecorded)")
    case let .joint(title: title, speakers: speakers, date: date):
        print("\(title) - \(speakers) - \(date)")
    }
}

func displaySessionAgain(session: Session) {
    if case let Session.keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded) = session {
        
    }
}
 
displaySession(session: keynote)
