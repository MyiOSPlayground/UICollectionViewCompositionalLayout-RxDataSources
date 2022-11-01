//
//  TestViewController.swift
//  RxSwiftUICollectionViewCompositionalLayout
//
//  Created by Aaron Hanwe LEE on 2022/10/31.
//

import UIKit
import SnapKit
import Then


class TestViewController: UIViewController {
    private var collectionView: UICollectionView?
    
    private var dataSource = Mock.dataSource
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        ).then {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = true
            $0.contentInset = .zero
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
            $0.register(ConceptCell.self, forCellWithReuseIdentifier: "ConceptCell")
            $0.register(MusicCell.self, forCellWithReuseIdentifier: "MusicCell")
            $0.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView")
            $0.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
            $0.dataSource = self
            let layout = UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
                switch self.dataSource[section] {
                case .concept:
                    return self.getLayoutConceptSection()
                case .music:
                    return self.getLayoutMusicSection()
                }
            }
            $0.collectionViewLayout = layout
            self.collectionView = $0
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func getLayoutConceptSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(11)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header, footer]
        return section
        
    }
    
    private func getLayoutMusicSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/4.0)
        )
        
        let group = NSCollectionLayoutGroup.vertical( // 새로운 메서드 iOS 16부터임.. 게다가 동작이 동일하지 않음
            layoutSize: groupSize,
            subitem: item,
            count: 4
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        return section
        
    }
}

extension TestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case let .concept(concepts):
            return concepts.count
        case let .music(musics):
            return musics.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.dataSource[indexPath.section] {
        case let .concept(concepts):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptCell", for: indexPath) as! ConceptCell
            let item = concepts[indexPath.item]
            cell.prepare(image: item.image, titleText: item.title, descText: item.desc)
            return cell
        case let .music(musics):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
            let item = musics[indexPath.item]
            cell.prepare(image: item.image, titleText: item.title, descText: item.desc)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "TitleHeaderView",
                for: indexPath
            ) as! TitleHeaderView
            header.prepare(image: UIImage(named: "thumbnail"), descText: "desc 텍스트", titleText: "title 텍스트")
            return header
        case UICollectionView.elementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "FooterView",
                for: indexPath
            )
        default:
            return UICollectionReusableView()
        }
    }
    
}
