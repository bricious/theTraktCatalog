//
//  ListCatalogTableViewController.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 07/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import UIKit
import SDWebImage

class ListCatalogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {

    @IBOutlet weak var tableMovies: UITableView!
    @IBOutlet weak var buttonReloadList: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // Objects
    let request = RequestData()
    var listObj: [ListObject] = []
    var objDetails: ListDetailsObject!
    var arrayList: NSMutableArray!
    var dicObj: NSDictionary = NSDictionary()
    
    // Movie Informations
    var idMovie: Int!
    var listObjImage:[CollectionDetailsObject]!

    
    //
    var filterObj: [ListObject] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        
        self.arrayList = NSMutableArray.init()
        
        requestList()
        self.tableMovies.dataSource = self
        self.tableMovies.delegate = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableMovies.tableHeaderView = searchController.searchBar
    }
    
    func requestList() {
        
        self.request.requestListHome() {responseObject, error in
            self.listObj = responseObject

            for i in 0..<self.listObj.count {
                self.requestListImagesPoster(id: self.listObj[i].ids.tmdb)
                
            }
       
        }

    }
    
    func requestListImagesPoster(id: Int) {
        
        self.request.requestListImages(idMovie: id) {responseObject, error in
            self.arrayList.add(responseObject)

            let delay = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tableMovies.reloadData()
                self.activityIndicator.stopAnimating()
            }
            
        }
        
    }


    func requestDetails(id: Int) {
        
        self.request.requestMoveDetails(idMovie: id) {responseObject, error in
            self.arrayList.add(responseObject)
            
        }
        
    }
    
    func filterContentSearchText(searchText: String, scope: String = "All") {
        self.filterObj = self.listObj.filter { obj in
            return obj.title.contains(searchText)
        }
    
        self.tableMovies.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive && self.searchController.searchBar.text != "" {
            return self.filterObj.count
        } else {
            
        }
        return self.listObj.count
    }

    
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        
        labelTitle.text = "List Popular Movies"
        labelTitle.textAlignment = .center
        
        return labelTitle
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCatalogTableViewCell

        
        if self.searchController.isActive && self.searchController.searchBar.text != "" {
        
            cell.labelName.text = self.filterObj[indexPath.row].title
            cell.labelYear.text = String(format: "%i",self.filterObj[indexPath.row].year)
        } else {
            cell.labelName.text = self.listObj[indexPath.row].title
            cell.labelYear.text = String(format: "%i",self.listObj[indexPath.row].year)
        
        }
        
        
        
        self.listObjImage = self.arrayList.object(at: indexPath.row) as! [CollectionDetailsObject]
        
        cell.imageMovie.sd_setImage(with: URL.init(string: String(format: "https://image.tmdb.org/t/p/w45/%@", self.listObjImage[0].imageListPoster[0].file_path)))
        
        return cell
    }

    //MARK: - TableView Delegate
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        self.idMovie = self.listObj[indexPath.row].ids.tmdb
        
        self.performSegue(withIdentifier: "segueDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueDetails") {
            
            let vc: DetailsMovieViewController = segue.destination as! DetailsMovieViewController
            vc.idMovie = self.idMovie
        }
        
    }
    
    
    //MARK: - Actions
    @IBAction func refreshTable() {
        self.activityIndicator.startAnimating()
        requestList()
    }
    
    
}

extension ListCatalogTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentSearchText(searchText: self.searchController.searchBar.text!)
    }
}
