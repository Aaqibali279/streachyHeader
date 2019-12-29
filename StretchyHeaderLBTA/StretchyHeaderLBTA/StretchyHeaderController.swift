//
//  StretchyHeaderController.swift
//  StretchyHeaderLBTA
//
//  Created by Brian Voong on 12/22/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class StretchyHeaderController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Courses"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: nil)
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil),UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil) ]
        
        setupCollectionViewLayout()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        print(contentOffsetY)
        
        var offset = scrollView.contentOffset.y / 150
                if offset > 0
                {
                    UIView.animate(withDuration: 0.2, animations: {
                        let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                        let navigationcolor = UIColor.init(hue: 0, saturation: offset, brightness: 1, alpha: offset)
                        
                        self.headerView?.heavyLabel.alpha = 1 - offset
                        self.headerView?.descriptionLabel.alpha = 1 - offset
                        
                        self.navigationController?.navigationBar.tintColor = navigationcolor
                        self.navigationController?.navigationBar.backgroundColor = color
                        self.setStatusBar(backgroundColor: color)
                        
                        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationcolor]
                        self.navigationController?.navigationBar.barStyle = .default
                    })
                }
                else
                {
                    UIView.animate(withDuration: 0.2, animations: {
                        let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                        self.navigationController?.navigationBar.tintColor = UIColor.white
                        self.navigationController?.navigationBar.backgroundColor = color
                        self.setStatusBar(backgroundColor: .clear)
                        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
                        self.navigationController?.navigationBar.barStyle = .black
                    })
                }
    }
    
    var headerView: HeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 340)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 50)
    }

}
