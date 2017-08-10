//
//  ListDetailsObject.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 08/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import Mapper

struct ListDetailsObject: Mappable {

    let originalTitle: String!
    let releaseDate: String!
    let runTime: Int!
    let tagLine: String!
    let overview: String!
    let posterMovie: String!
    let voteAverage: Double!
    
    let genres: [Genres]!
    
    init(map: Mapper) throws {
        originalTitle = try map.from("original_title")
        releaseDate = try map.from("release_date")
        runTime = try map.from("runtime")
        tagLine = try map.from("tagline")
        overview = try map.from("overview")
        posterMovie = try map.from("poster_path")
        voteAverage = try map.from("vote_average")
        
        
        genres = try map.from("genres") as [Genres]!
    }
    
}

struct Genres: Mappable {
    
    let name:String!
    
    init(map: Mapper) throws {
        name = try map.from("name")
    }
    
}
