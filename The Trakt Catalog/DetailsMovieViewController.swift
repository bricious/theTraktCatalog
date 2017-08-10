//
//  DetailsMovieViewController.swift
//  The Trakt Catalog
//
//  Created by Fabricio Dos Santos Rodrigues on 08/08/17.
//  Copyright © 2017 fabricio. All rights reserved.
//

import UIKit

class DetailsMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var labelTitleMovie: UILabel!
    @IBOutlet weak var labelDateMovie: UILabel!
    @IBOutlet weak var labelTagLine: UILabel!
    @IBOutlet weak var labelDurationMovie: UILabel!
    @IBOutlet weak var labelClassification: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var collectionImages: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //
    @IBOutlet weak var viewImageZoom: UIView!
    @IBOutlet weak var imageViewZoom: UIImageView!
    @IBOutlet weak var btCloseImage: UIButton!
    
    //
    var objDetails: ListDetailsObject!

    var image: String = ""
    var idMovie: Int = 0
    var objImage: CollectionDetailsObject!
    var listObjImage:[CollectionDetailsObject]!
    var arrayList: NSMutableArray!

    let request = RequestData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        self.viewImageZoom.isHidden = true
        
        self.arrayList = NSMutableArray.init()

        self.requestListImages()

        self.collectionImages.dataSource = self
        self.collectionImages.delegate = self
        
        requestDetails(id: self.idMovie)
        
        self.imagePoster.layer.cornerRadius = 10
        self.imagePoster.layer.borderColor = UIColor.lightGray.cgColor
        self.imagePoster.layer.masksToBounds = true
        
        
    }

    func requestDetails(id: Int) {
        
        self.request.requestMoveDetails(idMovie: id) {responseObject, error in

            self.objDetails = responseObject
            
            self.navigationItem.title = self.objDetails.originalTitle
            
            self.labelDateMovie.text = "Release date: \(self.objDetails.releaseDate as String)"
            self.labelTagLine.text = self.objDetails.tagLine
            self.labelDurationMovie.text = "Duration: \(String(format: "%i",self.objDetails.runTime)) min"
            self.labelClassification.text = "Classification: \(String(format: "%.1f",self.objDetails.voteAverage))"
            self.textViewOverview.text = self.objDetails.overview
            self.labelGenre.text = "Genre: \(self.objDetails.genres[0].name as String)"
            self.imagePoster.sd_setImage(with: URL.init(string: String(format: "https://image.tmdb.org/t/p/w92/%@", self.objDetails.posterMovie)))
            
        }
        
    }
    
    func requestListImages() {
        
        self.request.requestListImages(idMovie: self.idMovie) {responseObject, error in

            self.listObjImage = responseObject
            
            let delay = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.collectionImages.reloadData()
                self.activityIndicator.stopAnimating()

            }
        }
        
    }
    
    
    //MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.listObjImage == nil) {
            return 0
        } else {
            return self.listObjImage[0].imageListBackdrops.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! ListCollectionViewCell
        
        cell.images.sd_setImage(with: URL.init(string: String(format: "https://image.tmdb.org/t/p/w92/%@", self.listObjImage[0].imageListBackdrops[indexPath.row].file_path)))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.imageViewZoom.sd_setImage(with: URL.init(string: String(format: "https://image.tmdb.org/t/p/w500/%@", self.listObjImage[0].imageListBackdrops[indexPath.row].file_path)))
        
        self.viewImageZoom.isHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Actions
    @IBAction func closeImageZoom() {
        self.viewImageZoom.isHidden = true
        self.imageViewZoom.image = nil
    }
    

}
