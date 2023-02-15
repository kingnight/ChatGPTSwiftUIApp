//
//  ChatAPI.swift
//  ChatGPTInn
//
//  Created by kai jin on 2023/2/15.
//

import Foundation
import OpenAISwift

class ChatAPI {
    static let shared = ChatAPI()
    private let openAI:OpenAISwift
    
    private init() {
        //replace your authToken
        openAI = OpenAISwift(authToken: "")
    }
    
    func sendRequest(param:String,completion:@escaping ((String)->Void)) {
        openAI.sendCompletion(with: param, maxTokens: 100) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                if let result = success.choices?.first?.text{
                    print(result)
                    completion(result)
                }
                else{
                    if let error = success.error{
                        completion(error.message)
                    }
                    else{
                        completion("未知错误")
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(failure.localizedDescription)
            }
        }
    }
}
