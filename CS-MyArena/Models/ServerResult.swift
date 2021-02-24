//
//  ServerResult.swift
//  CS-MyArena
//
//  Created by Алик on 18.02.2021.
//

import Foundation

struct ServerResult {
    let message: String?
    
    let status: String?
    let online: Int?
    let data: GQData?
    let serverId: String?
//    let server_address: String?
//    let server_maxslots: String?
//    let server_location: String?
//    let server_type: String? //Публичный 500 FPS",
    //"server_dateblock": "1616236435",
    //"server_daystoblock": 30,
    //"map_img": "www.myarena.ru/lgsl/images/maps/halflife/cstrike/de_prodigy.jpg",
}

extension ServerResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case message
        case status
        case online
        case data
        case serverId = "server_id"
    }
}

struct GQData {
    let address: String? //Server ip
    let hostName: String? //Server name
    let mapName: String?
    let maxPlayers: Int?
    let numPlayers: Int?
    let isOnline: Bool?
    let port: String?
}

extension GQData: Decodable {
    enum CodingKeys: String, CodingKey {
        case address = "gq_address"
        case hostName = "gq_hostname"
        case mapName = "gq_mapname"
        case maxPlayers = "gq_maxplayers"
        case numPlayers = "gq_numplayers"
        case isOnline = "gq_online"
        case port = "gq_port"
    }
}
