//
//  ContainerPrincipalViewController.m
//  CointanerMenu
//
//  Created by iTwinber on 13/02/14.
//  Copyright (c) 2014 Daniel Aguilera. All rights reserved.
//

#import "ContainerPrincipalViewController.h"

// Enumaracion que relaciona el indice del tableView con las pantallas a mostrar
typedef enum{
    PAGINA0,
    PAGINA1,
    PAGINA2
}ViewControllers;

@interface ContainerPrincipalViewController (){
    ViewControllers indiceVC;
}
@property (nonatomic, strong ) UIViewController * VCActual;
@property (nonatomic, strong ) UIViewController * pagina0VC;
@property (nonatomic, strong ) UIViewController * pagina1VC;
@property (nonatomic, strong ) UIViewController * pagina2VC;

@end

@implementation ContainerPrincipalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Instanaciamos desde el storyboard la pagina inicial
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _pagina0VC = [sb instantiateViewControllerWithIdentifier:@"0"];
    // La agreagamos como viewcontroller hijo al presente ViewController
    [self addChildViewController:_pagina0VC];
    // Agregamos la vista
    [self.view addSubview:_pagina0VC.view];
    // Le indicamos que va ha moverse al viewcontroller padre
    // Esta orden no es necesaria en este ejemplo, pero normalmente implementaramos una clase viewcontroller
    // por cada vista de nuestra aplicación y haciendo esta llamada podemos hacer que el viewcontroller especifico
    // sepa en que momento va a ser añadido al container padre y realizar alguna operacion que sea necesaria
    // Este mismo metodo es llamado cuando el viewcontroller hijo se va a retirar del container padre.
    [_pagina0VC didMoveToParentViewController:self];
    // Tomamos referencia del viewcontroller activo
    _VCActual = _pagina0VC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)irAViewController:(NSString *)storyboardID indice:(NSInteger)indice{
    // Instanciar el viewcontroller de destino
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VCDestino = nil;
    
    // Evitamos que se inicializen los viewcontrollers sucesivas veces
    switch (indice) {
        case PAGINA0:
            if (!_pagina0VC) {
                _pagina0VC = [sb instantiateViewControllerWithIdentifier:storyboardID];
            }
            VCDestino = _pagina0VC;
            
            break;
       
        case PAGINA1:
            if (!_pagina1VC) {
                _pagina1VC = [sb instantiateViewControllerWithIdentifier:storyboardID];
            }
            VCDestino = _pagina1VC;
            
            break;
        
        case PAGINA2:
            if (!_pagina2VC) {
                _pagina2VC = [sb instantiateViewControllerWithIdentifier:storyboardID];
            }
            VCDestino = _pagina2VC;
            
            break;
        
        default:
            break;
    }
    
    if (VCDestino!=_VCActual) {
        [self transicionConConstanteDe:_VCActual A:VCDestino];
    }
    

    
  
}
// Este metodo ha sido enlazado usando el proxy "First Responder" del storyboard
// Enlazando el boton de pagina 2 a este metodo. Para poder hacer esto el unico requisito
// es que el metodo empieze por (IBaction) y en ese momento podra ser enlazado por storyboard

-(IBAction)irA0:(id)sender{
    
    [self irAViewController:@"0" indice:0];
    
    
}

-(void) transicionConConstanteDe:(UIViewController *) deVC A:(UIViewController *) aVC{
    [deVC willMoveToParentViewController:nil];
    [self addChildViewController:aVC];
    
    aVC.view.frame = self.view.frame;
    
    // Transicion con efectos por defecto
    [self transitionFromViewController:deVC
                      toViewController:aVC
                              duration:0.4
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
                                [deVC removeFromParentViewController];
                                [aVC didMoveToParentViewController:self];
                                _VCActual = aVC;
                            }];
    
    // Si queremos hacer cualquier tipo de animación para la aparicion/desaparicion de las vistas debemos poner en
    // options:UIViewAnimationOptionTransitionNone y en animations el bloque de animación que queramos
    
}




@end
