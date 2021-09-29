//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, with price: Double)
    func didFail(with error: Error)
}

struct CoinManager {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFail(with: error!)
                }
                
                if let safeData = data {
                    if let value = self.parseJSON(from: safeData) {
                        self.delegate?.didUpdatePrice(self, with: value)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(from coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(CoinData.self, from: coinData)
            return data.last
        } catch {
            delegate?.didFail(with: error)
            return nil
        }
    }
}

struct CoinData: Decodable {
    let last: Double
}
