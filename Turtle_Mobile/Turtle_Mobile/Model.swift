//
//  Model.swift
//  Turtle_Mobile
//
//  Created by Mac2_iparknow on 2023/12/12.
//

import Foundation


struct Model_YouBike: Decodable, Hashable{
    let sno: String
    let sna: String
    let tot: Int
    let sbi: Int
    let sarea: String
    let mday: String
    let lat: Double
    let lng: Double
    let ar: String
    let sareaen: String
    let snaen: String
    let aren: String
    let bemp: Int
    let act: String
    let srcUpdateTime: String
    let updateTime: String
    let infoTime: String
    let infoDate: String
}

