//
//  HabitCollectionViewController.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import UIKit

private let reuseIdentifier = "Cell"

class HabitCollectionViewController: UICollectionViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
    
    enum ViewModel{
        enum Section: Hashable, Comparable{
            case favorites
            case category(_ category: Category)
            
            static func < (lhs: Section, rhs: Section) -> Bool{
                switch (lhs, rhs){
                case (.category(let l), .category(let r)):
                    return l.name < r.name
                case (.favorites, _):
                    return true
                case (_, .favorites):
                    return false
                }
            }
        }
        
        typealias Item = Habit
    }
    
    struct Model{
        var habitsByName = [String: Habit]()
        var favoriteHabits: [Habit]{
            return Settings.shared.favoriteHabits
        }
    }
    
    var dataSource: DataSourceType!
    var model = Model()
    
    var habitsRequestTask: Task<Void, Never>? = nil
    deinit { habitsRequestTask?.cancel() }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = createDataSource()
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = createLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
    }
    func createDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewListCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Habit", for: indexPath) as! UICollectionViewListCell
            
            var contents = cell.defaultContentConfiguration()
            contents.text = item.name
            cell.contentConfiguration = contents
            
            return cell
        }
        return dataSource
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    func update(){
        habitsRequestTask?.cancel()
        habitsRequestTask = Task{
            if let habits = try? await HabitRequest().send(){
                self.model.habitsByName = habits
            } else {
                // MARK: problem is here always habits is nil. see details on APIRequest.swift
                self.model.habitsByName = [:]
            }
            self.updateCollectionVew()
            habitsRequestTask = nil
        }
    }
    
    func updateCollectionVew(){
        var itemsBySection = model.habitsByName.values.reduce(into: [ViewModel.Section: [ViewModel.Item]]()) { partial, habit in
            let item = habit
            print(item)
            let section: ViewModel.Section
            if model.favoriteHabits.contains(habit){
                section = .favorites
            } else {
                section = .category(habit.category)
            }
            partial[section, default: []].append(item)
        }
        
        let sectionIDs = itemsBySection.keys.sorted()
        itemsBySection = itemsBySection.mapValues { $0.sorted() }
        dataSource.applySnapshotUsing(sectionIDs: sectionIDs, itemsBySection: itemsBySection)
    }
}
