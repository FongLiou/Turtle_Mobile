//
//  function.swift
//  Turtle_Mobile
//
//  Created by Mac2_iparknow on 2023/12/12.
//

import Foundation
import SwiftUI

// MARK: - 1+2-N .....
func f_calculate(_ n: Int) -> String {
    var result = 1
    if n != 0 {
        let item = n/2
        if n % 2 != 0 {
            result += item * -1
        } else {
            result += (item-1) * -1 + n
        }
        return String(result)
    } else {
        return "0"
    }
}
// MARK: - 抽獎
func DrawPrize(Input_prizes:Dictionary<Int, Int>, prizeDistribution: [(Int, Double)]) -> (Int?, Dictionary<Int, Int>) {
    var prizes = Input_prizes
    let Count_Prizes = prizes.values.reduce(0, +)
    print(Count_Prizes)
    if Count_Prizes == 0 {
        print("所有獎品已被抽完")
        return (nil, prizes)
    }
    while true{
        // 隨機選擇獎品
        let randomValue = Double.random(in: 0...1)
        var cumulatePro = 0.0
        for (prize, probability) in prizeDistribution {
            cumulatePro += probability
            // 若隨機獎品機率 小於 當前累計機率
            // 檢查獎品數量是否大於0
            if randomValue < cumulatePro {
                if let remaining = prizes[prize], remaining > 0 {
                    prizes[prize] = remaining - 1
                    return (prize, prizes)
                } else {
                    break  // 繼續選擇其他獎品
                }
            }
        }
    }
}


// MARK: - 客製化修飾邊框
struct CustomCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
