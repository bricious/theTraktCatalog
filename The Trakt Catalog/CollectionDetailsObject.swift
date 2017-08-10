//
//  CollectionDetailsObject.swift
//  The Trakt Catalog
//
//  Created by Fabricio Rodrigues on 08/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import Mapper

struct CollectionDetailsObject: Mappable {
    
    let imageListPoster: [ImagesPosters]
    let imageListBackdrops: [ImagesBackdrops]

    
    init(map: Mapper) throws {
        
        imageListPoster = try map.from("posters") as [ImagesPosters]
        imageListBackdrops = try map.from("backdrops") as [ImagesBackdrops]
        
    }

}

struct ImagesBackdrops: Mappable {
    
    let file_path:String!
    
    init(map: Mapper) throws {
        file_path = try map.from("file_path")
    }
    
}

struct ImagesPosters: Mappable {
    
    let file_path:String!
    
    init(map: Mapper) throws {
        file_path = try map.from("file_path")
    }
    
}

