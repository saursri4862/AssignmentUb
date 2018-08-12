//
//  ImagesCollectionViewController.swift
//  Saurabh_UB
//
//  Created by saurabh srivastava on 11/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var viewModel:ViewModel!
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
        viewModel.text = text
        viewModel.reload = {[weak self] () -> Void in
            self?.collectionView?.reloadData()
        }
        viewModel.showLoaderView = {[weak self] () -> Void in
            if self?.viewModel.showLoader == true{
                ProgressView.shared.showProgressView()
            }
            else{
                ProgressView.shared.hideProgressView()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imgObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let updateCell = cell as? ImageCollectionCell{
            let imgObj = viewModel.getImgObject(indexPath.item)
            updateCell.nameLabel.text = imgObj.title
            updateCell.imgView.image = #imageLiteral(resourceName: "download_img.png")
            viewModel.getImages(indexPath.item, completion: {[weak self] (img) -> Void in
                if img != nil{
                    if let updateCll =  collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
                        updateCll.imgView.image = img
                    }
                }
                
            })
        }
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        let imgObj = viewModel.getImgObject(indexPath.item)
        cell.nameLabel.text = imgObj.title
        cell.imgView.image = #imageLiteral(resourceName: "download_img.png")
        viewModel.getImages(indexPath.item, completion: {[weak self] (img) -> Void in
            if img != nil{
                if let updateCell =  collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
                    updateCell.imgView.image = img
                }
            }
            
        })
        return cell
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width-30)/3
        return CGSize(width: width, height: width+25)
    }
    

}
