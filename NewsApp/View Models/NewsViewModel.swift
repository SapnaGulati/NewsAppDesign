//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by ios4 on 26/05/21.
//
/*
import Foundation

class NewsViewModel : NSObject {
    
    static var shared = NewsViewModel()
    private var newsService : NewsAPIService!
    
    private(set) var newsData: NewsDataModel!{
        didSet {
            self.bindNewsViewModelToController()
        }
    }
    
    var bindNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.newsService =  NewsAPIService()
        callFuncToGetNews()
    }
    
    func callFuncToGetNews() {
        self.newsService.getArticles { (newsDataModel) in
            self.newsData = newsDataModel
        }
    }
}*/
