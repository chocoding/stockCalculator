//
//  PagingViewFile.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/08.
//

import UIKit
import PagingKit

extension ViewController
{
    func pagingViewStart(){
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        
        menuViewController.cellAlignment = .left

        dataSource = makeDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PagingMenuViewController {
                menuViewController = vc
                menuViewController.dataSource = self
                menuViewController.delegate = self
            } else if let vc = segue.destination as? PagingContentViewController {
                contentViewController = vc
                contentViewController.dataSource = self
                contentViewController.delegate = self
            }
        }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)]{
        let myMenuArray = ["주식 평단가\n계산", "주식 이익금\n계산", "종목\n토론방", "주린이\n지식방"]
        
        return myMenuArray.map{
            
            let title = $0
            
            switch title{
            case "주식 평단가\n계산":
                let vc = UIStoryboard(name:"StockAvgViewController",bundle: nil).instantiateViewController(identifier: "StockAvgViewController") as! StockAvgViewController
                return (menu:title, content:vc)
            case "주식 이익금\n계산":
                let vc = UIStoryboard(name:"StockRevenueViewController",bundle: nil).instantiateViewController(identifier: "StockRevenueViewController") as StockRevenueViewController
                return (menu:title, content:vc)
            case "종목\n토론방":
                let vc = UIStoryboard(name:"DebateViewController",bundle: nil).instantiateViewController(identifier: "DebateViewController") as DebateViewController
                return (menu:title, content:vc)
            case "주린이\n지식방":
                let vc = UIStoryboard(name: "StockKnowledgeViewContorller", bundle: nil).instantiateViewController(identifier: "StockKnowledgeViewContorller") as StockKnowledgeViewContorller
                return (menu:title, content:vc)
            default:
                let vc = UIStoryboard(name:"StockAvgViewController",bundle: nil).instantiateViewController(identifier: "StockAvgViewController") as! StockAvgViewController
                return (menu:title, content:vc)
            }
        }
    }
}

// menu datasource
extension ViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menu
        cell.titleLabel.textColor = .black
        return cell
    }
}

// content datasource
extension ViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

// menu control delegate
extension ViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

// content control delegate
extension ViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
