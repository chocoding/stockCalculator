import UIKit
import PagingKit
import GoogleMobileAds

// MARK: String Extension

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal//.currencyAccounting
        //formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}

// MARK: ViewController Extension

extension ViewController
{
    // pagingView
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
        let myMenuArray = ["?????? ?????????\n??????", "?????? ?????????\n??????", "??????\n?????????", "?????????\n?????????"]
        
        return myMenuArray.map{
            
            let title = $0
            
            switch title{
            case "?????? ?????????\n??????":
                let vc = UIStoryboard(name:"StockAvgViewController",bundle: nil).instantiateViewController(identifier: "StockAvgViewController") as! StockAvgViewController
                return (menu:title, content:vc)
            case "?????? ?????????\n??????":
                let vc = UIStoryboard(name:"StockRevenueViewController",bundle: nil).instantiateViewController(identifier: "StockRevenueViewController") as StockRevenueViewController
                return (menu:title, content:vc)
            case "??????\n?????????":
                let vc = UIStoryboard(name:"DebateViewController",bundle: nil).instantiateViewController(identifier: "DebateViewController") as DebateViewController
                return (menu:title, content:vc)
            case "?????????\n?????????":
                let vc = UIStoryboard(name: "StockKnowledgeViewContorller", bundle: nil).instantiateViewController(identifier: "StockKnowledgeViewContorller") as StockKnowledgeViewContorller
                return (menu:title, content:vc)
            default:
                let vc = UIStoryboard(name:"StockAvgViewController",bundle: nil).instantiateViewController(identifier: "StockAvgViewController") as! StockAvgViewController
                return (menu:title, content:vc)
            }
        }
    }
    
    // google ads
    func adMobStart()
    {
        // ????????? ???????????? ??????
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        
        // ?????? ????????? ????????? ??????
        bannerView.adUnitID = myID
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView)
    {
        // ????????????????????? ?????? ??????
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        // ???????????? ????????? ??????
        view.addSubview(bannerView)
        
        // ????????? ???????????? ?????????????????? ??????
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
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
