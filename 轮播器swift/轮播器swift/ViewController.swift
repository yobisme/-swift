

import UIKit

class ViewController: UICollectionViewController
{

    var adList: [ADModel]?
    
    var pagCon = UIPageControl.init()
    
    var timer = Timer.init()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adList =  [ADModel]()
        
        loadData()
    
        setFlowLayout()
        
        creatPageControl()
        
        creatTimer()
        
        self.collectionView?.register(UINib.init(nibName: "ImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView?.scrollToItem(at: IndexPath.init(item: 0, section: 1), at: [], animated: true)
    }
    
    func creatPageControl()
    {
        pagCon = UIPageControl(frame: CGRect.init(x: 50, y: 600, width: 100, height: 30))
        
        self.view?.addSubview(pagCon)
        
        pagCon.currentPage = 0
        
        pagCon.numberOfPages = (adList?.count)!
        
        
    }
    
    func creatTimer()
    {
        timer = Timer.init(timeInterval: 1, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func changeImg()
    {
        if pagCon.currentPage == 4 {
            collectionView?.scrollToItem(at: IndexPath.init(item: 0, section: 2), at: [], animated: true)
        }else
        {
            pagCon.currentPage += 1
            collectionView?.scrollToItem(at: IndexPath.init(item: pagCon.currentPage, section: 1), at: [], animated: true)
        }
    }
    
    func setFlowLayout()
    {
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.collectionView?.isPagingEnabled = true
        flowLayout.scrollDirection = .horizontal
        self.collectionView?.bounces = false
        flowLayout.itemSize = (self.collectionView?.bounds.size)!
        
    }
    
    func loadData()
    {
        let path = Bundle.main.path(forResource: "ad.plist", ofType: nil)
        
        let adlist = NSArray(contentsOfFile: path!)
        
        for dic in adlist!
        {
            let adModel = ADModel(dic: dic as! [String : Any])
            
            adList?.append(adModel)
        }
    
    }

}

//数据源方法
extension ViewController
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (adList?.count) ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImgCollectionViewCell

        cell.model = (adList?[indexPath.item])!
        
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        let indexM: Int = Int((collectionView?.contentOffset.x)! / ((collectionView?.bounds.size.width)! ))
        
        if indexM != 5
        {
            collectionView?.scrollToItem(at: IndexPath.init(item: Int(indexM) % 5, section: 1), at: [], animated: false)
        }else{
            return
        }
        pagCon.currentPage = indexM % 5
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.fireDate = NSDate.distantFuture
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = NSDate.init(timeIntervalSinceNow: 1) as Date
    }
    
    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       scrollViewDidEndDecelerating(scrollView)
    }
    
}
