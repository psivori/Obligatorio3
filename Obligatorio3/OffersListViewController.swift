import MapKit
import UIKit
import Firebase

class OffersListViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {
    
    let defaults = NSUserDefaults.standardUserDefaults()    
    var entries = [EntryOffer]()
    var selectedEntry: EntryOffer?
    var entry: Entry!
    @IBOutlet weak var offersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        entries.removeAll()
        loadOffers()
    }
    
    func loadOffers() {
        var ref = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/offers")
        ref.queryOrderedByChild("entryId").observeEventType(.ChildAdded, withBlock: { snapshot in
            if var entryId = snapshot.value["entryId"] as? String {
                if entryId == self.entry.id {
                    var budget = snapshot.value["budget"] as! String
                    var des = snapshot.value["description"] as! String
                    var name = self.defaults.stringForKey("Name")!
                    var offer = EntryOffer(description : des, name : name, budget : budget)
                    self.entries.append(offer)
                    self.offersTable.reloadData()
                }
            }
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "entryViewCellCustom"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EntryOfferViewCellCustom
        
        // Fetches the appropriate meal for the data source layout.
        let entry = entries[indexPath.row]
        cell.titleLable.text = entry.name
        cell.priceLable.text = " " + entry.budget! + " "
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectedEntry = entries[indexPath.row]
        self.performSegueWithIdentifier("showOfferDetails", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        navigationItem.backBarButtonItem = backItem
        if let offerDetailsViewController = segue.destinationViewController as? OfferDetailsViewController
        {
            offerDetailsViewController.entry = selectedEntry!
        }
    }
    
    
}
