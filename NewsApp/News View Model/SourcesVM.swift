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
    
    func callApiToGetSources(response:@escaping responseCallBack){
    APIManager.callApiToGetSources(successCallback: { (responseDict) in
        let message = responseDict[APIKeys.kMessage] as? String ?? kSomethingWentWrong
        if self.parseGetSources(response: responseDict){
            response(message, nil)
        } else {
            response(nil, nil)
        }
    }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
}

extension SourcesVM{
    func parseGetSources(response: JSONDictionary) -> Bool{
        sourcesDataArray.removeAll()
        if let data = response[APIKeys.kSources] as? JSONArray {
            for src in data {
                let model = Sources(dict: src)
                self.sourcesDataArray.append(model)
            }
            self.newsSources.sources = self.sourcesDataArray
        }
        return true
    }
}
