

import UIKit

class ImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var model: ADModel?
    {
        
        didSet{
            
            self.imgView.image = UIImage(named: (model?.imgsrc)!)
            
            }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
  

}
