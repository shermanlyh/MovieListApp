//
//  MovieList.swift
//  Test
//
//  Created by Shermanlyh on 16/6/2022.
//

import Foundation
struct MovieListElement: Codable {
    let uuid, name: String
    let openDate: TimeInterval
    let poster: String
    let rating: Double
    let likeCount, reviewCount, duration: Int
    let sort: Int?
}

typealias MovieList = [MovieListElement]
