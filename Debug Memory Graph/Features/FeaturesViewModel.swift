//
//  FeaturesViewModel.swift
//  Debug Memory Graph
//
//  Created by Tuan Nguyen on 25/08/2022.
//

import Foundation

class FeaturesViewModel {
    static let shared = FeaturesViewModel()
    private init() {}
    var fetchUsersFailed : (() -> ()) = {}
    var fetchUsersSucceed: (() -> ()) = {}
    
    func loadUsers() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let isSuccess = Bool.random()
            isSuccess ? self.fetchUsersSucceed() : self.fetchUsersFailed()
        }
    }
    
    func loadUsers(with completionClosuer: ((_ isSuccess: Bool) -> Void)?) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let isSuccess = Bool.random()
            completionClosuer?(isSuccess)
        }
    }
}
