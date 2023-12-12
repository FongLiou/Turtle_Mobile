//
//  ViewModel.swift
//  Turtle_Mobile
//
//  Created by Mac2_iparknow on 2023/12/12.
//

import Foundation
import UIKit
import SwiftUI
class ViewModel: ObservableObject {
    @Published var youBikeData: [Model_YouBike] = []

    func Get_YouBikeData() {
        guard let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") else {
            print("Get_YouBikeData Not found url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let error = error {
                print("error", error.localizedDescription)
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([Model_YouBike].self, from: data)
                    DispatchQueue.main.async {
                        self.youBikeData = result
                        print(result.count)
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Get_YouBikeData => fetch json error:", error.localizedDescription)
            }
        }.resume()
    }
}
