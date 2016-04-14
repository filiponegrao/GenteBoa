//
//  Home_ViewController.swift
//  GenteBoaBeta
//
//  Created by Filipo Negrao on 06/11/15.
//  Copyright © 2015 Filipo Negrao. All rights reserved.
//

import UIKit
import Foundation

class Home_ViewController: UIViewController, UIViewControllerTransitioningDelegate, UIPopoverPresentationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    var nextButton : UIButton!
    
    var previousButton : UIButton!

    var staticBar : UIView!
    
    var currentCardView : CardView?
    
    var nextCardView : CardView?
    
    var previousCardView : CardView?
    
    var nextUser : People!
    
    var currentUser : People!
    
    var previousUser : People!
    
    var feedback : UIButton!
    
    var seemore : UIButton!
    
    var loadingView : LoadingView!
    
    var delay : Bool = false
    
    var bubbleTranstion = BubbleTransition()
    
    var menuButton : UIBarButtonItem!
    
    var searchButton : UIBarButtonItem!
    
    var blurView : UIVisualEffectView!
    
    var popOverMenu : PopOverMenu_ViewController!
    
    var filterPicker : UIPickerView!
    
    var cursos = [String]()
    
    var button: UIButton!
    
    var filterView : UIView!
    
    override func viewDidLoad()
    {
        self.cursos.append("Todos")
        self.cursos += Cursos.cursosDisponiveis()
        super.viewDidLoad()

        self.view.backgroundColor = GMColor.grey300Color()
        self.title = "Gente Boa"
        
        self.navigationController?.navigationBar.barStyle = .Default
        
        let navBar = self.navigationController?.navigationBar
        navBar?.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Arial Rounded MT Bold", size: 20)!]
        
        self.menuButton = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "openMenu")
        
        self.searchButton = UIBarButtonItem(image: UIImage(named: "icon_search"), style: UIBarButtonItemStyle.Done, target: self, action: "openSearch")
        
        self.navigationItem.leftBarButtonItem = self.menuButton
        self.navigationItem.rightBarButtonItem = self.searchButton
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        rightSwipe.direction = .Right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        leftSwipe.direction = .Left
        self.view.addGestureRecognizer(leftSwipe)
        
        //Componentes
        self.staticBar = UIView(frame: CGRectMake(0,screenHeight - 60,screenWidth, 60))
        self.staticBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.staticBar)
        
        self.nextButton = UIButton(frame: CGRectMake(self.staticBar.frame.size
            .width - self.staticBar.frame.size.height ,10,self.staticBar.frame.size.height,self.staticBar.frame.size.height - 20))
        self.nextButton.setImage(UIImage(named: "next"), forState: .Normal)
        self.nextButton.addTarget(self, action: "nextPerson", forControlEvents: .TouchUpInside)
        self.staticBar.addSubview(self.nextButton)
        
        self.previousButton = UIButton(frame: CGRectMake(0,10,self.staticBar.frame.size.height,self.staticBar.frame.size.height-20))
        self.previousButton.setImage(UIImage(named: "previous"), forState: .Normal)
        self.previousButton.addTarget(self, action: "previousPerson", forControlEvents: .TouchUpInside)
        self.staticBar.addSubview(self.previousButton)
        
        
        self.seemore = UIButton(frame: CGRectMake(self.previousButton.frame.size.width, 10, (screenWidth - self.previousButton.frame.size.width*2 - 20)/3, self.staticBar.frame.size.height-20))
        self.seemore.backgroundColor = GMColor.green400Color()
        self.seemore.layer.cornerRadius = self.seemore.frame.size.width/2
        self.seemore.setImage(UIImage(named: "icon_search"), forState: .Normal)
        self.seemore.addTarget(self, action: "seeMore", forControlEvents: .TouchUpInside)
//        self.staticBar.addSubview(self.seemore)

        
        self.feedback = UIButton(frame: CGRectMake(self.previousButton.frame.origin.x + self.previousButton.frame.size.width, 10, (screenWidth - self.previousButton.frame.size.width*2),self.staticBar.frame.size.height - 20))
        self.feedback.backgroundColor = GMColor.orange500Color()
        self.feedback.layer.cornerRadius = 8
        self.feedback.setTitle("Feedback", forState: .Normal)
        self.feedback.setTitle("Avaliado", forState: .Disabled)
        self.feedback.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.feedback.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        self.feedback.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        self.feedback.addTarget(self, action: "giveFeedback", forControlEvents: .TouchUpInside)
        self.staticBar.addSubview(self.feedback)
        
        self.previousUser = nil
        self.previousCardView = nil
        
        self.loadingView = LoadingView()
        self.navigationController!.view.addSubview(self.loadingView)
        
        DAOPeople.sharedInstance.getRandomUser(DAOUser.sharedInstance.getCourse()!) { (people) -> Void in
            
            if(people != nil)
            {
                self.currentUser = people!
                self.currentCardView = CardView(frame: CGRectMake(10, 80, screenWidth - 20, screenHeight - 80 - self.staticBar.frame.size.height - 10), people: self.currentUser)
//                self.currentCardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "swipeCard:"))
                self.view.addSubview(self.currentCardView!)
                self.loadingView?.removeFromSuperview()
                self.carregaProximo()
            }
            else
            {
                self.loadingView?.removeFromSuperview()
                
                SweetAlert().showAlert("Erro!", subTitle: "Não foram encontrados usuarios! O erro porde ter sido causado por falta de internet, problema no servidor ou inconsistencia. Tente reabrir o app!", style: AlertStyle.Warning, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPeopleProfile", name: "clickProfile", object: nil)
        
        self.filterView = UIView(frame: CGRectMake(0, screenHeight ,screenWidth, 220))
        self.filterView.backgroundColor = UIColor.clearColor()
        self.navigationController?.view.addSubview(self.filterView)
        
        self.filterPicker = UIPickerView(frame: CGRectMake(0,40,screenWidth, 180))
        self.filterPicker.delegate = self
        self.filterPicker.backgroundColor = UIColor.whiteColor()
        self.filterView.addSubview(self.filterPicker)
        
        self.button = UIButton(frame: CGRectMake(0,0, screenWidth, 40))
        self.button.backgroundColor = GMColor.green300Color()
        self.button.setTitle("Selecionar", forState: .Normal)
        self.button.addTarget(self, action: "selectFilter", forControlEvents: .TouchUpInside)
        self.filterView.addSubview(self.button)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func carregaProximo()
    {
        DAOPeople.sharedInstance.getRandomUser(DAOUser.sharedInstance.getCourse()!) { (people) -> Void in
            
            if(people != nil)
            {
                self.nextUser = people
            }
        }
    }
    
    
    func seeMore()
    {
        let alert = UIAlertController(title: "Ops!", message: "Ainda nao é possivel utilizar esta opção!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) -> Void in
            
        }))
        self.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    

    func openSearch()
    {
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        self.blurView.frame = self.view.bounds
        self.blurView.alpha = 0
        self.view.addSubview(self.blurView)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.blurView.alpha = 1
        }
        
        self.popOverMenu = PopOverMenu_ViewController(presentingController: self)
        popOverMenu.modalPresentationStyle = .Popover
        popOverMenu.preferredContentSize = CGSizeMake(300, 100)
        
        let popoverMenuViewController = self.popOverMenu.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.popOverMenu.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: screenWidth - 60,
            y: 30,
            width: 1,
            height: 1)
        presentViewController(
            self.popOverMenu,
            animated: true,
            completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
            return .None
    }
    
    
    func openMenu()
    {
        let settings = Settings_ViewController()
        
        let controller = UINavigationController(rootViewController: settings)
        
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
        
        self.presentViewController(controller, animated: true) { () -> Void in
            
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.bubbleTranstion.transitionMode = .Present
        self.bubbleTranstion.duration = 0.2
        self.bubbleTranstion.startingPoint = CGPointMake(20, 20)
        self.bubbleTranstion.bubbleColor = UIColor.whiteColor()
        return self.bubbleTranstion
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.bubbleTranstion.transitionMode = .Dismiss
        self.bubbleTranstion.startingPoint = CGPointMake(20, 20)
        self.bubbleTranstion.bubbleColor = UIColor.whiteColor()
        return self.bubbleTranstion
    }
    
    
    func nextPerson()
    {
        if(self.nextUser != nil && !self.delay)
        {
            self.delay = true
            self.nextCardView = CardView(frame: self.currentCardView!.frame, people: self.nextUser)
            self.nextCardView!.center.x = screenWidth + screenWidth/2
            self.view.addSubview(self.nextCardView!)
            
//            self.nextCardView!.transform = CGAffineTransformMakeRotation(-5.0)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.currentCardView!.frame.origin.x = -screenWidth
                self.currentCardView!.transform = CGAffineTransformMakeRotation(5.0)

                self.nextCardView!.center.x = screenWidth/2
//                self.nextCardView!.transform = CGAffineTransformMakeRotation(5.0)

                
                }, completion: { (success: Bool) -> Void in
                    
                    self.previousCardView?.removeFromSuperview()
                    
                    self.previousCardView = self.currentCardView
                    self.currentCardView = self.nextCardView
                    self.nextCardView = nil
                    
//                    print("Cartao anterios \(self.previousCardView), cartao presente \(self.currentCardView) e cartao proximo \(self.nextCardView)")
                    
                    self.previousUser = nil
                    self.previousUser = self.currentUser
                    self.currentUser = self.nextUser
                    self.nextUser = nil
                    
//                    print("User anterior: \(self.previousUser) atual: \(self.currentUser) e proximo: \(self.nextUser)")
                    
                    self.previousCardView!.transform = CGAffineTransformMakeRotation(0)

                    self.carregaProximo()
                    
                    self.delay = false
            })
        }
        else if(!self.delay)
        {
            if(currentCardView != nil)
            {
                self.delay = true
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.currentCardView!.frame.origin.x -= 15
                    
                    }, completion: { (success: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            
                            self.currentCardView!.frame.origin.x = 10
                            
                            }, completion: { (success: Bool) -> Void in
                                
                                self.delay = false
                        })
                        
                })
            }
        }
    }
    
    
    func previousPerson()
    {
        if(self.previousUser != nil)
        {
            self.previousCardView = CardView(frame: self.currentCardView!.frame, people: self.previousUser!)
            self.previousCardView!.frame.origin.x = -(screenWidth + 10)
            self.view.addSubview(self.previousCardView!)
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.currentCardView!.frame.origin.x = screenWidth + 10
                self.previousCardView!.frame.origin.x = 10
                
                }, completion: { (success: Bool) -> Void in
                    
                    self.nextCardView = self.currentCardView
                    self.currentCardView = self.previousCardView
                    self.previousCardView = nil
                    
                    self.nextUser = self.currentUser
                    self.currentUser = self.previousUser
                    self.previousUser = nil
            })
        }
        else
        {
            if(self.currentCardView != nil)
            {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.currentCardView!.frame.origin.x += 15
                    
                    }, completion: { (success: Bool) -> Void in
                        
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            
                            self.currentCardView!.frame.origin.x = 10
                            
                            }, completion: { (success: Bool) -> Void in
                                
                        })
                        
                })

            }
        }
    }
    
    
    func swipeRight(sender: UIPanGestureRecognizer)
    {
        self.previousPerson()
    }
    
    
    func swipeLeft(sender: UIPanGestureRecognizer)
    {
        self.nextPerson()
    }
    
    func giveFeedback()
    {
        if(self.currentCardView != nil)
        {
            let feedbackController = FeedBack_ViewController()
            
            feedbackController.modalPresentationStyle = .FullScreen
            feedbackController.modalTransitionStyle = .PartialCurl
            feedbackController.people = self.currentUser
            feedbackController.profileImage = self.currentCardView!.imageView.image
            
            self.presentViewController(feedbackController, animated: true) { () -> Void in
                
            }
        }
        else
        {
            SweetAlert().showAlert("Erro!", subTitle: "Não foram encontrados usuarios! O erro porde ter sido causado por falta de internet, problema no servidor ou inconsistencia. Tente reabrir o app!", style: AlertStyle.Warning, buttonTitle:"Ok", buttonColor: GMColor.orange300Color())

        }
    }
    
    func openPeopleProfile()
    {
        let profile = PeopleDetail_ViewController(people: self.currentUser)
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    
    func openFilter()
    {
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        self.blurView.frame = self.view.bounds
        self.blurView.alpha = 0
        self.navigationController?.view.addSubview(self.blurView)
        self.navigationController?.view.bringSubviewToFront(self.filterView)

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.blurView.alpha = 1
            self.filterView.frame.origin.y = screenHeight - self.filterView.frame.size.height
            
            }) { (success: Bool) -> Void in
                
        }
    }
    
    func closeFilter()
    {
        self.unBlur()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.filterView.frame.origin.y = screenHeight
            
            }) { (success: Bool) -> Void in
                
        }
    }
    
    func selectFilter()
    {
        let filter = self.cursos[self.filterPicker.selectedRowInComponent(0)]
        
        DAOPeople.sharedInstance.course = filter
        
        self.closeFilter()
        DAOPeople.sharedInstance.peopleSeen = [String]()
        self.nextUser = nil
        self.carregaProximo()
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
//    {
//        return self.cursos[row]
//    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel(frame: CGRectMake(0,0,screenWidth, 44))
        label.text = self.cursos[row]
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .Center
        
        return label
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.cursos.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func unBlur()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.blurView.alpha = 0
            
            
            }) { (success: Bool) -> Void in
                
                self.blurView.removeFromSuperview()
                
        }
    }
}




