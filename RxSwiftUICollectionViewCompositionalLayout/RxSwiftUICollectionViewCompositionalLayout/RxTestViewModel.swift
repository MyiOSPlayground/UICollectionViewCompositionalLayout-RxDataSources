//
//  RxTestViewModel.swift
//  RxSwiftUICollectionViewCompositionalLayout
//
//  Created by Aaron Hanwe LEE on 2022/11/01.
//

import RxSwift
import Foundation

class RxTestViewModel: NSObject {
    
    var infoData: BehaviorSubject<[MusicOriginSection]> = .init(value: Mock.dataSource)
    
}
