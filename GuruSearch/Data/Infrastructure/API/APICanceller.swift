//
//  APICanceller.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/21.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Alamofire

final class APICanceller {

    static let shared = APICanceller()
    private init() {}

    private var dataRequestArray = [Alamofire.DataRequest]()

    func append(dataRequest: Alamofire.DataRequest) {
        removeFinishedAndCancelledDataRequest()
        dataRequestArray.append(dataRequest)
    }

    func allCancel() {
        removeFinishedAndCancelledDataRequest()
        cancelAndRemove(targetArray: self.dataRequestArray)
    }

    func cancel(urlRequest: URLRequest) {
        removeFinishedAndCancelledDataRequest()
        let target = self.dataRequestArray.filter { $0.request == urlRequest }
        cancelAndRemove(targetArray: target)
    }

    func cancel(url: URL) {
        removeFinishedAndCancelledDataRequest()
        let target = self.dataRequestArray.filter { dataRequest -> Bool in
            guard let requestUrl = dataRequest.request?.url else {
                return false
            }
            if requestUrl == url {
                return true
            }
            return false
        }
        cancelAndRemove(targetArray: target)
    }

    private func remove(dataRequest: Alamofire.DataRequest) {
        if let index = dataRequestArray.firstIndex(of: dataRequest) {
            dataRequestArray.remove(at: index)
        }
    }

    private func removeFinishedAndCancelledDataRequest() {
        let target = self.dataRequestArray.filter { $0.isFinished || $0.isCancelled }
        target.forEach { self.remove(dataRequest: $0) }
    }

    private func cancelAndRemove(targetArray: [Alamofire.DataRequest]) {
        targetArray.forEach { dataRequest in
            dataRequest.cancel()
            self.remove(dataRequest: dataRequest)
        }
    }
}
