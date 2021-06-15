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
                    let arts = dict["sources"] as? JSONArray ?? []
                    for art in arts {
                        let model = Sources(dict: art)
                        self.sourcesDataArray.append(model)
                    }
                    self.newsSources.sources = self.sourcesDataArray
                    completion(self.newsSources)
                }
            }
        }
    }
}
