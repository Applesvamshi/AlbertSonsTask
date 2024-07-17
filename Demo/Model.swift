//
//  Model.swift
//  Demo
//
//  Created by Vamshi on 17/07/24.
//

import Foundation

struct Responsedata : Codable {
    let total : Int?
    let totalHits : Int?
    let hits : [Hits]?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        totalHits = try values.decodeIfPresent(Int.self, forKey: .totalHits)
        hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
    }

}
struct Hits : Codable, Identifiable {
    let id : Int?
    let pageURL : String?
    let type : String?
    let tags : String?
    let previewURL : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case previewURL = "previewURL"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        pageURL = try values.decodeIfPresent(String.self, forKey: .pageURL)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
    }
}
