
//
//  HomePageViewController.swift
//  PazaramaBootcampHomework1
//
//  Created by Ahmet Yasin Atakan on 19.10.2023.
//

import UIKit
import DropDown

class HomePageViewController: UIViewController {
    
    let dropDown : DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = ["Hesabım", "Kullanıcı Bilgilerim", "Siparişlerim", "Favorilerim"]
        dropDown.textColor = .orange
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 15
        dropDown.clipsToBounds = true
        return dropDown
    }()
    let dropDownLogOut : DropDown = {
        let dropDownLogOut = DropDown()
        dropDownLogOut.dataSource = ["Log Out"]
        dropDownLogOut.textColor = .orange
        dropDownLogOut.backgroundColor = .white
        dropDownLogOut.cornerRadius = 15
        dropDownLogOut.clipsToBounds = true
        return dropDownLogOut
    }()
        
    let sections = Bundle.main.decode([Section].self, from: "data.json")
    var collectionView: UICollectionView!
    let searchController = UISearchController()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Shop>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DropDown Menu
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenu))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        dropDown.anchorView = navigationItem.leftBarButtonItem // Dropdownu iconun üzerinde açar.
        
        // DropDown Log Out
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: #selector(didTapLogOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
        dropDownLogOut.anchorView = navigationItem.rightBarButtonItem
        
        // Search Controller
        navigationItem.searchController = searchController
//        overrideUserInterfaceStyle = .light
        title = "Home"
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        collectionView.register(RecommendationsCell.self, forCellWithReuseIdentifier: RecommendationsCell.reuseIdentifier)
        collectionView.register(MostSoldOfWeekCell.self, forCellWithReuseIdentifier: MostSoldOfWeekCell.reuseIdentifier)
        collectionView.register(LastViewedCell.self, forCellWithReuseIdentifier: LastViewedCell.reuseIdentifier)
        
        createDataSource()
        reloadData()
    
    }
    
   @objc func didTapMenu(){
       dropDown.show()
    }
    @objc func didTapLogOut(){
        dropDownLogOut.show()
    }
    
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with shop: Shop, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: shop)
        return cell
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Shop>(collectionView: collectionView) { collectionView, indexPath, shop in
            switch self.sections[indexPath.section].type {
            case "Categories":
                return self.configure(CategoriesCell.self, with: shop, for: indexPath)
            case "Recommendations":
                return self.configure(RecommendationsCell.self, with: shop, for: indexPath)
            case "MostSoldItems":
                return self.configure(MostSoldOfWeekCell.self, with: shop, for: indexPath)
            default:
                return self.configure(LastViewedCell.self, with: shop, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                fatalError("Unexpected element kind")
            }
        
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { fatalError("Unexpected element kind") }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { fatalError("Unexpected element kind") }
            
            
            sectionHeader.title.text = section.title
            return sectionHeader
            
            
          
        }
    }
    
    func reloadData() {   // verileri collectionView'e ekler ve mevcut verileri günceller.
        var snapshot = NSDiffableDataSourceSnapshot<Section, Shop>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "Categories":
                return self.createCategoriesSection(using: section)
            case "Recommendations":
                return self.createRecommendationsSection(using: section)
            case "MostSoldItems":
                return self.createMostSoldSection(using: section)
            default:
                return self.createLastViewedSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20 // The amount of space between the sections in the layout.
        layout.configuration = config
        return layout
    }
    
    func createCategoriesSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(170))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: -20, trailing: 15)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.88), heightDimension: .absolute(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    
    func createRecommendationsSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1000))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 50, bottom: 5, trailing: 5)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createMostSoldSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 1, bottom: 0, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
      
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    func createLastViewedSection(using section: Section) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 22, bottom: 2, trailing: 22)
        
        let verticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: verticalItem ,count: 2)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem,verticalGroup])
        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 2, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let layoutSectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        
        return section
            
    }
    
    
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
        return layoutSectionHeader
    }
    
   
}
