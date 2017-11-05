//
//  SuggestionTableView.swift
//  EyesApp
//
//  Created by simo on 15/10/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift  
class SuggestionTableView: UITableViewController {
    let disposeBag = DisposeBag()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Frankfurt", "Prag", "Berlin", "Philadelphia", "Sao Paulo", "Milan", "Manila", "Tokio", "Los Angeles", "Paris", "Portland"] // Mocked API data
    var shownCities = [String]()
    let viewModel = PoiViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.viewModel.suggests.value = self.allCities
        viewModel.suggests.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "suggestCell")){
            _,suggest,cell in
            if let suggestCell = cell as? SuggestTableViewCell{
                    suggestCell.configCell(text:  suggest)
            }
            }.addDisposableTo(disposeBag)
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.viewModel.suggests.value = self.shownCities
                if query.isEmpty{
                    self.viewModel.suggests.value = self.allCities
                }
            })
            .addDisposableTo(disposeBag)
//        invoiceTableView.rx.modelSelected(Invoice.self).subscribe(onNext:{
//            invoice in
//            self.navigator.navigateToWebView(rootControlleur: self, url: invoice.url, title: "Facture", isFromHtml: false)
//            
//        }).addDisposableTo(disposeBag)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
