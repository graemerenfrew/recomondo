//
//  PhotoSelectorController.swift
//  recomondo
//
//  Created by Graeme Renfrew on 20/11/2018.
//  Copyright © 2018 The Polestone Consulting Team. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .blue
        
        setupNavigationButtons()
        
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        //put the custom header in the view
        collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        
        //now we havea  seleced image, reload the view to populate the header
        self.collectionView?.reloadData()
        
        //once selected, scroll the grid cells back to the top
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        
    }
    
    var selectedImage:UIImage?
    var images = [UIImage]() //this holds the small thumbnails loading in to the selection grid quickly
    var assets = [PHAsset]() //better quality image for viewing on the header cell
    
    fileprivate func assetFetchOptions() -> PHFetchOptions
    {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 32
        //sort by most recent
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        return fetchOptions
    }
    
    fileprivate func fetchPhotos()
    {
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetFetchOptions())
     
        //create a queue on which to load the photos
        DispatchQueue.global(qos: .background).async{
            allPhotos.enumerateObjects( { (asset, count, stop) in
                print("DEBUG GETTING PHOTO: \(count)")
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        
                        self.images.append(image) //low-qty thumbnails
                        self.assets.append(asset) //for tracking the image assets, so we can get the decent quality one for the header
                        
                        //if there is no selected image, set one immediately from the arrage
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    //once we have the images, reload the view the main thread, otherwise the global thread takes about 15 secs to give focus back to the UI
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
                
            })
        }
        
    }
    
    //build the header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width  //square
        return CGSize(width: width, height: width)
    }
    
    var header: PhotoSelectorHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
        
        //put the header into the self.header variable above so we can pass it around
        self.header = header
        
        header.photoImageView.image = selectedImage  //blurry image
        //what's the index - have to do an if statement because otherwise I cannot use an optional value - selectedImage- in the index of function
        if let selectedImage = selectedImage {
            if let index = self.images.index(of: selectedImage) {
                let selectedAsset = self.assets[index]
            
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width:600, height:600)
                
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil) { (image, info) in
                    header.photoImageView.image = image
                }
            }
        }
       
        return header                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    }
    
    //how many elements in this collection view?
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 5
        return images.count
    }
    //what size will the items be?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    //what will the spacing be?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //the elements will be cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        
        //cell.backgroundColor = .blue
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleCancel()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNext()
    {
        print("handling next")
        //push the sharePhoto controller onto the stack
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedImage = header?.photoImageView.image
        
        navigationController?.pushViewController(sharePhotoController, animated: true)
    }
}
