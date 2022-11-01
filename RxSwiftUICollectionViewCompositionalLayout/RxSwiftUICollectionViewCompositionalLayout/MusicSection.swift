//
//  MusicSection.swift
//  ExYoutubeMusic
//
//  Created by 김종권 on 2022/04/23.
//

import UIKit
import SnapKit
import Then
import RxRelay
import RxDataSources

struct Concept: Equatable {
    let image: UIImage
    let title: String
    let desc: String
    let id: Int
}

struct Music: Equatable {
    let image: UIImage
    let title: String
    let desc: String
    let id: Int
}

enum MusicOriginSection: Equatable {
    case concept([Concept])
    case music([Music])
}

enum MusicSectionItem: Equatable, IdentifiableType {
    var identity: Int {
        return 0
    }
    
    typealias Identity = Int
    
    case concept(Concept)
    case music(Music)
}
