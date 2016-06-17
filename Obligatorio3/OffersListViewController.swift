import MapKit
import UIKit

class OffersListViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {
    
    let defaults = NSUserDefaults.standardUserDefaults()    
    var entries = [EntryOffer]()
    var selectedEntry: EntryOffer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting entries to show on table view
        loadEntries()
        
    }
    
    
    func loadEntries() {
        let entry1 = EntryOffer(title: "Te lo LLevo", name: "Maicol", lastName: "Diaz", price: "$1500", details: "LLevo todo calidad de confianza")
        let entry2 = EntryOffer(title: "Ahorra plata", name: "Jose", lastName: "Rastrilla", price: "$1200", details: "con 1 peon")
        entries += [entry1, entry2]
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
        cell.priceLable.text = " " + entry.price! + " "
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
