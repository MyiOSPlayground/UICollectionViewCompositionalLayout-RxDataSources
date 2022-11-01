//
//  RxTestViewController.swift
//  RxSwiftUICollectionViewCompositionalLayout
//
//  Created by Aaron Hanwe LEE on 2022/11/01.
//


import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import RxDataSources
import RxRelay

extension MusicOriginSection: AnimatableSectionModelType {
    
    typealias Item = MusicSectionItem
    typealias Identity = Int
    
    var items: [MusicSectionItem] {
        switch self {
        case .music(let items):
            let returnValue: [MusicSectionItem] = {
                var returnValue: [MusicSectionItem] = []
                for item in items {
                    let newEelement = MusicSectionItem.music(item)
                    returnValue.append(newEelement)
                }
                return returnValue
            }()
            return returnValue
        case .concept(let items):
            let returnValue: [MusicSectionItem] = {
                var returnValue: [MusicSectionItem] = []
                for item in items {
                    let newEelement = MusicSectionItem.concept(item)
                    returnValue.append(newEelement)
                }
                return returnValue
            }()
            return returnValue
        }
    }
    
    init(original: MusicOriginSection, items: [MusicSectionItem]) {
        self = original
        
    }
    
    var identity: Int {
//        return self.items.id
        return 0
    }
    
    
}


class RxTestViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(ConceptCell.self, forCellWithReuseIdentifier: "ConceptCell")
        $0.register(MusicCell.self, forCellWithReuseIdentifier: "MusicCell")
        $0.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView")
        
    }
    
    private let viewModel = RxTestViewModel()
    private let disposeBag = DisposeBag()
    
    typealias MusicSectionDataSource = RxCollectionViewSectionedAnimatedDataSource<MusicOriginSection>
    private lazy var dataSource: MusicSectionDataSource = {
        let configuration = AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
        let ds = MusicSectionDataSource(animationConfiguration: configuration) { datasource, collectionView, indexPath, item in
            var cell = self.makeCell(item, from: collectionView, indexPath: indexPath)
            return cell
        }

        return ds
    }()
    private var sections = BehaviorRelay<[MusicOriginSection]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        setupDatasource()
        self.viewModel.infoData
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { info in
                let layout = UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
                    switch info[section] {
                    case .concept:
                        return self.getLayoutConceptSection()
                    case .music:
                        return self.getLayoutMusicSection()
                    }
                }
                self.collectionView.collectionViewLayout = layout
                self.sections.accept(info)
            })
            .disposed(by: self.disposeBag)
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
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
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
    
    private func makeCell(_ info: MusicSectionItem, from collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        print("info: \(info)")
        switch info {
        case .music(let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as? MusicCell else { return UICollectionViewCell() }
            cell.prepare(image: info.image, titleText: info.title, descText: info.desc)
            return cell
        case .concept(let info):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptCell", for: indexPath) as? ConceptCell else { return UICollectionViewCell() }
            cell.prepare(image: info.image, titleText: info.title, descText: info.desc)
            return cell
        }
    }
    
    private func setupDatasource() {
        dataSource.configureSupplementaryView = { (dataSource, collectionView, kind, indexPath) in
            if kind == UICollectionView.elementKindSectionHeader {
                if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeaderView", for: indexPath) as? TitleHeaderView {
                    header.prepare(image: UIImage(named: "thumbnail"), descText: "desc 텍스트", titleText: "title 텍스트")
                    return header
                } else {
                    return UICollectionReusableView()
                }
            } else {
                return UICollectionReusableView()
            }
        }
        
        sections.bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
}
