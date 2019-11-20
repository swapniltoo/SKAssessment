
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arr : [[String:Any]] = [[:]]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView()
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        GlobalMethod.sharedInstance.getPopulerViews(availableperiod: "1") { (isResult, result) in
            print(result ?? "Error")
            DispatchQueue.main.async {
            self.arr = result!["results"] as! [[String : Any]]
            self.tableView.reloadData()
                //  stop activity indicator
                myActivityIndicator.stopAnimating()
                myActivityIndicator.removeFromSuperview()
            }
        }
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr.count > 1
        {
            return arr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SkTableViewCell
        if arr.count > 0
        {
            let dir = arr[indexPath.row]
            cell.cellData = dir
            cell.title.text = dir["title"] as? String
            cell.byline.text = dir["byline"] as? String
            cell.published_date.text = dir["published_date"] as? String
            
            cell.img.layer.cornerRadius = cell.img.frame.size.height/2


        }
        return cell
    }
    
}

