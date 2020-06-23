//
//  NetworkConnection.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Alamofire

enum NetworkConnection {
    /// Check network connection.
    static func isReachable(onlyViaWiFi: Bool = false, completion: @escaping(Swift.Result<Void, NetworkReachabilityError>) -> Void) {
        guard let reachabilityManager = NetworkReachabilityManager() else {
            completion(.failure(.notReachable))
            return
        }

        reachabilityManager.startListening { networkReachabilityStatus in
            switch networkReachabilityStatus {
            case .notReachable:
                print("The network is not reachable.")
                completion(.failure(.notReachable))

            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                completion(.success(()))

            case .reachable(.cellular):
                print("The network is reachable over the WWAN connection")
                if onlyViaWiFi {
                    completion(.failure(.onlyViaWiFi))
                }
                else {
                    completion(.success(()))
                }

            case .unknown:
                print("It is unknown whether the network is reachable.")
                completion(.failure(.notReachable))
            }
        }
    }
}
