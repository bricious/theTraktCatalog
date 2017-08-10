//
//  ListObject.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 08/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import Mapper

struct ListObject: Mappable {

    let title: String!
    let year: Int!
    let ids: IdsObj!
    
    init(map: Mapper) throws {
        title = try map.from("title")
        year = try map.from("year")
        
        ids = try map.from("ids") as IdsObj
    }
    
}

struct IdsObj: Mappable {
    
    let trakt: Int!
    let slug: String!
    let imdb: String!
    let tmdb: Int!
    
    init(map: Mapper) throws {
        trakt = try map.from("trakt")
        slug = try map.from("slug")
        imdb = try map.from("imdb")
        tmdb = try map.from("tmdb")
    }
}
