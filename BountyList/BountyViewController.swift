//
//  BountyViewController.swift
//  BountyList
//
//  Created by 혜리 on 2022/05/18.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    
    
    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기,, BountyInfo들
    
//    let bountyInfoList: [BountyInfo] = [
//        BountyInfo(name: "brook", bounty: 33000000),
//        BountyInfo(name: "chopper", bounty: 50),
//        BountyInfo(name: "franky", bounty: 44000000),
//        BountyInfo(name: "luffy", bounty: 30000000),
//        BountyInfo(name: "nami", bounty: 16000000),
//        BountyInfo(name: "robin", bounty: 80000000),
//        BountyInfo(name: "sanji", bounty: 77000000),
//        BountyInfo(name: "zoro", bounty: 120000000)
//    ]
    
    let viewModel = BountyViewModel()
    
    
//    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
//    let bountyList = [33000000, 50, 44000000, 30000000, 16000000, 80000000, 77000000, 120000000]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄 거예요
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
//                let bountyInfo = bountyInfoList[index]
                let bountyInfo = viewModel.bountyInfo(at: index)

                
//                vc?.name = nameList[index]
//                vc?.bounty = bountyList[index]
//                vc?.name = bountyInfo.name
//                vc?.bounty = bountyInfo.bounty
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // UICollectionViewDataSource
    // 몇 개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 셀을 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭되었을 때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    
    // UICollectionViewDelegateFlowLayout
    // cell size를 계산할거다 (목표 : 다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
    
    
    
    
    // UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return bountyList.count
////        return bountyInfoList.count
//        return viewModel.numOfBountyInfoList
//
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
//            return UITableViewCell()
//        }
////        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
////        cell.imgView.image = img
////        cell.nameLabel.text = nameList[indexPath.row]
////        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
//
////        let bountyInfo = bountyInfoList[indexPath.row]
//        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
//        cell.update(info: bountyInfo)
////        cell.imgView.image = bountyInfo.image
////        cell.nameLabel.text = bountyInfo.name
////        cell.bountyLabel.text = "\(bountyInfo.bounty)"
//
//        return cell
//
//
////        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell {
////            let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
////            cell.imgView.image = img
////            cell.nameLabel.text = nameList[indexPath.row]
////            cell.bountyLabel.text = "\(bountyList[indexPath.row])"
//        return cell
//       } else {
//            return UITableViewCell()
//        }
//    }
//
//    // UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("--> \(indexPath.row)")
//        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
//    }
}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}

class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 30000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}
