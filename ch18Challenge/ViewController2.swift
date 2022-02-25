//
//  ViewController.swift
//  ch09PageControl
//
//  Created by 김규리 on 2022/01/19.
//

import UIKit

var images = [ "1.PNG", "2.PNG", "3.PNG", "4.PNG" ]

class ViewController2: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count // 전체 페이지 수
        pageControl.currentPage = 0 // 현재 페이지
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지를 표시하는 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red // 현재 페이지를 표시하는 색상
        
        imgView.image = UIImage(named: images[0])
        
        // 스와이프 기능
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController2.respondToSwipeGesture(_: )))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController2.respondToSwipeGesture(_: )))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        // 핀치 기능 추가
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController2.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    // 스와이프 기능
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer { // 제스처가 있다면

            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if (pageControl.currentPage < pageControl.numberOfPages - 1) {
                    pageControl.currentPage = pageControl.currentPage + 1
                }

            case UISwipeGestureRecognizer.Direction.right:
                if (pageControl.currentPage > 0) {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
            default:
                break
            }
            
            imgView.image = UIImage(named: images[pageControl.currentPage])
        }
    }
    
    // 핀치 기능
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale) // imgPinch를 스케일에 맞게 변환
        pinch.scale = 1 // 다음 변환을 위해 1로 다시 바꿔주기
    }

}

