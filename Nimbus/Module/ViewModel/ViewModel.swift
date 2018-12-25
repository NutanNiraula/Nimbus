//
//  ViewModel.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

class ViewModel {
    var toDoFetchClient: APIClient
    var dataModel: ((ToDoData) -> ())?
    
    init(todoFetchService: APIClient) {
        self.toDoFetchClient = todoFetchService
    }
    
    func getData(forId id: Int = 5) {
        toDoFetchClient.endPoint.url = AppUrls.getAppUrl(fromPath: "todos/\(id)")
        toDoFetchClient.request(withObject: nil) { [weak self] (result) in
            switch result.decodeJson(toType: ToDoData.self) {
            case .success(let data):
                self?.dataModel!(data)
                print(data.title.value())
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
