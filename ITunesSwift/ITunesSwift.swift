//
//  ITunesSwift.swift
//  ITunesSwift
//
//  Created by Kazuyoshi Tsuchiya on 2014/09/21.
//  Copyright (c) 2014 tsuchikazu. All rights reserved.
//

public func findAll() -> ITunesSearchApi {
    return ITunesSearchApi(media: Media.All)
}
public func find(media: Media) -> ITunesSearchApi {
    return ITunesSearchApi(media: media)
}
public func find(entity: Entity) -> ITunesSearchApi {
    return ITunesSearchApi(entity: entity)
}
public func lookup(id: Int) -> ITunesLookupApi {
    return ITunesLookupApi(idName: "id", id: id)
}
public func lookup(idName: String, id: Int) -> ITunesLookupApi {
    return ITunesLookupApi(idName: idName, id: id)
}