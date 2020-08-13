//
//  QuoteAPI.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 13.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

protocol QuoteAPIDelegate: class {
    func fetchQuotes(quotesArray: [Quote])
}

class QuoteAPI {
    
    var quotes = [Quote]()
    weak var delegate: QuoteAPIDelegate?
    
    func performRequest(author: String) {
        
        let authorComponents = author.components(separatedBy: " ")
        let firstname = authorComponents[0]
        let lastname = authorComponents[1]
        
        let url = URL(string: "https://www.breakingbadapi.com/api/quote?author=" + firstname + "+" + lastname)!
                        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(QuoteData.self, from: data!)
            
            let data = decodedData
            let totalQuotes = data.count - 1
            
            for index in stride(from: 0, to: totalQuotes, by: 1) {
                self.quotes.append(Quote(quoteId: data[index].quote_id, quote: data[index].quote, author: data[index].author))
            }
            
            self.delegate?.fetchQuotes(quotesArray: self.quotes)
        }
        
        task.resume()
    }

}

