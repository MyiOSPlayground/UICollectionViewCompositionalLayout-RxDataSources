//
//  Mock.swift
//  ExYoutubeMusic
//
//  Created by 김종권 on 2022/04/23.
//

import UIKit

enum Mock {
    static let dataSource = [
        MusicOriginSection.concept(
            [
                .init(image: UIColor.random.image(), title: "concept아이템(title1)", desc: "concept아이템(desc1)", id: 1),
                .init(image: UIColor.random.image(), title: "concept아이템(title2)", desc: "concept아이템(desc2)", id: 2),
                .init(image: UIColor.random.image(), title: "concept아이템(title3)", desc: "concept아이템(desc3)", id: 3),
                .init(image: UIColor.random.image(), title: "concept아이템(title4)", desc: "concept아이템(desc4)", id: 4),
                .init(image: UIColor.random.image(), title: "concept아이템(title5)", desc: "concept아이템(desc5)", id: 5),
                .init(image: UIColor.random.image(), title: "concept아이템(title6)", desc: "concept아이템(desc6)", id: 6),
                .init(image: UIColor.random.image(), title: "concept아이템(title7)", desc: "concept아이템(desc7)", id: 7),
                .init(image: UIColor.random.image(), title: "concept아이템(title8)", desc: "concept아이템(desc8)", id: 8),
                .init(image: UIColor.random.image(), title: "concept아이템(title9)", desc: "concept아이템(desc9)", id: 9),
                .init(image: UIColor.random.image(), title: "concept아이템(title10)", desc: "concept아이템(desc10)", id: 10),
            ]
        ),
        MusicOriginSection.music(
            [
                .init(image: UIColor.random.image(), title: "music아이템(title1)", desc: "music아이템(desc1)", id: 11),
                .init(image: UIColor.random.image(), title: "music아이템(title2)", desc: "music아이템(desc2)", id: 12),
                .init(image: UIColor.random.image(), title: "music아이템(title3)", desc: "music아이템(desc3)", id: 13),
                .init(image: UIColor.random.image(), title: "music아이템(title4)", desc: "music아이템(desc4)", id: 14),
                .init(image: UIColor.random.image(), title: "music아이템(title5)", desc: "music아이템(desc5)", id: 15),
                .init(image: UIColor.random.image(), title: "music아이템(title6)", desc: "music아이템(desc6)", id: 16),
                .init(image: UIColor.random.image(), title: "music아이템(title7)", desc: "music아이템(desc7)", id: 17),
                .init(image: UIColor.random.image(), title: "music아이템(title8)", desc: "music아이템(desc8)", id: 18),
                .init(image: UIColor.random.image(), title: "music아이템(title9)", desc: "music아이템(desc9)", id: 19),
                .init(image: UIColor.random.image(), title: "music아이템(title10)", desc: "music아이템(desc10)", id: 20),
            ]
        ),
        MusicOriginSection.concept(
            [
                .init(image: UIColor.random.image(), title: "concept아이템(title1)", desc: "concept아이템(desc1)", id: 31),
                .init(image: UIColor.random.image(), title: "concept아이템(title2)", desc: "concept아이템(desc2)", id: 32),
                .init(image: UIColor.random.image(), title: "concept아이템(title3)", desc: "concept아이템(desc3)", id: 33),
                .init(image: UIColor.random.image(), title: "concept아이템(title4)", desc: "concept아이템(desc4)", id: 34),
                .init(image: UIColor.random.image(), title: "concept아이템(title5)", desc: "concept아이템(desc5)", id: 35),
                .init(image: UIColor.random.image(), title: "concept아이템(title6)", desc: "concept아이템(desc6)", id: 36),
                .init(image: UIColor.random.image(), title: "concept아이템(title7)", desc: "concept아이템(desc7)", id: 37),
                .init(image: UIColor.random.image(), title: "concept아이템(title8)", desc: "concept아이템(desc8)", id: 38),
                .init(image: UIColor.random.image(), title: "concept아이템(title9)", desc: "concept아이템(desc9)", id: 39),
                .init(image: UIColor.random.image(), title: "concept아이템(title10)", desc: "concept아이템(desc10)", id: 40),
            ]
        ),
        MusicOriginSection.concept(
            [
                .init(image: UIColor.random.image(), title: "concept아이템(title1)", desc: "concept아이템(desc1)", id: 41),
                .init(image: UIColor.random.image(), title: "concept아이템(title2)", desc: "concept아이템(desc2)", id: 42),
                .init(image: UIColor.random.image(), title: "concept아이템(title3)", desc: "concept아이템(desc3)", id: 43),
                .init(image: UIColor.random.image(), title: "concept아이템(title4)", desc: "concept아이템(desc4)", id: 44),
                .init(image: UIColor.random.image(), title: "concept아이템(title5)", desc: "concept아이템(desc5)", id: 45),
                .init(image: UIColor.random.image(), title: "concept아이템(title6)", desc: "concept아이템(desc6)", id: 46),
                .init(image: UIColor.random.image(), title: "concept아이템(title7)", desc: "concept아이템(desc7)", id: 47),
                .init(image: UIColor.random.image(), title: "concept아이템(title8)", desc: "concept아이템(desc8)", id: 48),
                .init(image: UIColor.random.image(), title: "concept아이템(title9)", desc: "concept아이템(desc9)", id: 49),
                .init(image: UIColor.random.image(), title: "concept아이템(title10)", desc: "concept아이템(desc10)", id: 50),
            ]
        )
    ]
}

extension UIColor {
    static var random: UIColor {
        UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
