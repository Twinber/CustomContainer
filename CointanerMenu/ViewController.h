//
//  ViewController.h
//  CointanerMenu
//
//  Created by iTwinber on 13/02/14.
//  Copyright (c) 2014 Daniel Aguilera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuBoton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menuConstraintDerecho;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menuConstraintIzquierdo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *containerConstraintIzquierdo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *containerConstraintDerecho;

- (IBAction)despliegaMenu:(id)sender;


@end
