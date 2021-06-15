//
//  SourcesViewModel.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import UIKit
import Foundation
import Alamofire

class SourcesVM {
    
    static var shared = SourcesVM()
    
    var newsSources = SourcesDM(detail: JSONDictionary())
    var sourcesDataArray = [Sources]()
    var sources = Sources(dict: JSONDictionary())
    
    private init() {}
    
//    func getSources(dict: JSONDictionary, response: @escaping responseCallBack) {
//        APIManager.getSources(dict: dict, successCallback: { (responseDict) in
//            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
//            if self.parseUserData(response: responseDict) {
//                response(message, nil)
//            } else {
//                response(nil, nil)
//            }
//
//        }) { (errorReason, error) in
//            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
//        }
//    }
    
    func getSources(completion: @escaping (SourcesDM) ->()) {
        let url = "https://newsapi.org/v2/sources?apiKey=4d3e1ce2523f46418ff4a356b80f556d"

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in

            if let error = response.error {
                print(error.localizedDescription)
            } else if response.data != nil {
                if let dict = response.value as? JSONDictionary
                {
                    print(dict)
                    self.sourcesDataArray.removeAll()
                    let srcs = dict[APIKeys.kSources] as? JSONArray ?? []
                    for src in srcs {
                        let model = Sources(dict: src)
                        self.sourcesDataArray.append(model)
                    }
                    self.newsSources.sources = self.sourcesDataArray
                    completion(self.newsSources)
                }
            }
        }
    }
}
