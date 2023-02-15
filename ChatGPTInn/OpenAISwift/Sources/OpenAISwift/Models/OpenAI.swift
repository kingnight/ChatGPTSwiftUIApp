//
//  Created by Adam Rush - OpenAISwift
//

import Foundation

public struct OpenAI: Codable {
    public let object: String?
    public let model: String?
    public let choices: [Choice]?
    public let error:ErrorObject?
}

public struct ErrorObject:Codable{
    public let message:String
    public let type:String
//    public let param:String?
//    public let code:
}

public struct Choice: Codable {
    public let text: String
}
