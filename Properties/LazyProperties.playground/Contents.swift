import UIKit

enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    var level: Level
    
    // lazy = will fetch quetions the 2nd time instantly without api call
    // private(set) = can only set within Exam structure not later
    lazy private(set) var questions: [String] = {
        
        // mock - api fetch time span
        sleep(5)
        
        switch level {
        case .easy:
            return ["What is 1+2", "What is 1+2", "What is 2+2"]
        case .medium:
            return ["What is 11+22", "What is 11+22", "What is 32+42"]
        case .hard:
            return ["What is 122+332", "What is 441+255", "What is 266+250"]
        }
    }()
}


var exam = Exam(level: .easy) // must be mutable - var
print(exam.questions)
print("Wait for 1 second")
sleep(1)
print(exam.questions) // returned instantly

// exam.questions = ["What is the capital of US?"] = NOT Allowed with private(set) property wrapper
