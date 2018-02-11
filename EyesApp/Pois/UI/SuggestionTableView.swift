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
    
    let viewModel = SuggestViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.viewModel.suggests.asObservable()
            .bind(to: self.viewModel.shownSuggests)
            .disposed(by: disposeBag)
        viewModel.shownSuggests.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "suggestCell")){
            _,suggest,cell in
            if let suggestCell = cell as? SuggestTableViewCell{
                    suggestCell.configCell(text:  suggest)
            }
            }.disposed(by: disposeBag)
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.viewModel.shownSuggests.value = self.viewModel.suggests.value.filter { $0.caseInsensitiveCompare(query) == ComparisonResult.orderedSame } // We now do our "API Request" to find cities.
                if query.isEmpty{
                    self.viewModel.shownSuggests.value = self.viewModel.suggests.value
                }
            })
            .disposed(by: disposeBag)
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
