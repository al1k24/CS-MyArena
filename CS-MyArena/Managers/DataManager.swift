//
//  DataManager.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import Foundation

class DataManager {
    
    private init() {}
    static let shared = DataManager()
    
    func getServerStatusData(by token: String, _ completion: @escaping (Server?) -> Void) {
        let param = ["ver": "2"]
        MyArenaService.shared.fetchData(of: ServerResult.self, by: token, for: .status, with: param) { [weak self] (result) in
            switch result {
            case .failure(let error):
                completion(nil)
                print("* Error: \(error.localizedDescription)")
            case .success(let data):
                guard let self = self else {
                    completion(nil)
                    return
                }
                
                if let serverData = self.prepareServerStatusData(data) {
                    completion(serverData)
                }
            }
        }
    }
    
    private func prepareServerStatusData(_ result: ServerResult) -> Server? {
        guard let id = result.serverId,
              let data = result.data,
              let name = data.hostName,
              let serverIp = data.address,
              let serverPort = data.port,
              let map = data.mapName,
              let playersOnline = data.numPlayers,
              let totalPlayers = data.maxPlayers
        else { return nil }
    
        let ip = "\(serverIp):\(serverPort)"
        let serverData = Server(id: id,
                                name: name,
                                ip: ip,
                                map: map,
                                playersOnline: playersOnline,
                                totalPlayers: totalPlayers,
                                image: "")
        return serverData
    }
}
