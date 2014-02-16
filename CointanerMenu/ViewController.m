//
//  ViewController.m
//  CointanerMenu
//
//  Created by iTwinber on 13/02/14.
//  Copyright (c) 2014 Daniel Aguilera. All rights reserved.
//

#import "ViewController.h"
#import "ContainerPrincipalViewController.h"

// Enumaracion que relaciona el indice del tableView con las pantallas a mostrar
typedef enum{
    PAGINA0,
    PAGINA1,
    PAGINA2
}ViewControllers;

@interface ViewController (){
    ViewControllers indiceVC;
    BOOL menuAbierto;
}

@property (nonatomic, weak)ContainerPrincipalViewController * ContainerVC;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuAbierto =NO;
    _menuConstraintDerecho.constant = _menuView.bounds.size.width;
    _menuConstraintIzquierdo.constant = -_menuView.bounds.size.width;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark segues
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // Este Segue, es un embed Segue y es llamado al cargarse la vista que contiene el container View
    // En este caso lo aprovechamos para tomar referencia al viewcontroller que va a gestionar
    // la carga de las vistas de la aplicación
    if ([segue.identifier isEqualToString:@"vistaInicial"]) {
        self.ContainerVC = segue.destinationViewController;
    }
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row ==0) {
        indiceVC = PAGINA0;
        [self.ContainerVC irAViewController:@"0" indice:indiceVC];
    }
    if (indexPath.row==1) {
        indiceVC = PAGINA1;
        [self.ContainerVC irAViewController:@"1" indice:indiceVC];
        
    } else if (indexPath.row == 2){
        indiceVC = PAGINA2;
        [self.ContainerVC irAViewController:@"2" indice:indiceVC];
    }
    // Hacemos que el menu desaparezca
    [self cerrarMenu];
    // Deseleccionamos la celda para que no quede marcada
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Ir a %d", indexPath.row]];
    
    return cell;
    
}

- (IBAction)despliegaMenu:(id)sender {
    if (!menuAbierto) {
        // Deshabilitamos el botón para evitar que mientras se esta desplegando se pueda pulsar
        [_menuBoton setEnabled:NO];
        
        // ANIMACION POR CONSTRAINTS
        // Animamos el menu
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _menuConstraintDerecho.constant = 0;
            _menuConstraintIzquierdo.constant = 0;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL ok){
            if (ok) {
                
                [_menuBoton setEnabled:YES];
            }
        }];
        // Animamos el container
        [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            _containerConstraintDerecho.constant = -self.menuView.bounds.size.width;
            _containerConstraintIzquierdo.constant = self.menuView.bounds.size.width;
            [self.view layoutIfNeeded];
            
        } completion:nil];

       menuAbierto = YES;
    }
    
    
}
- (void)cerrarMenu{
        [_menuBoton setEnabled:NO];
    CGRect frame = CGRectMake(0, 44, self.menuView.bounds.size.width, self.menuView.bounds.size.height);
    self.menuView.frame = frame;
    
    
    //ANIMACION POR CONSTRAINTS
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _menuConstraintDerecho.constant = _menuView.bounds.size.width;
        _menuConstraintIzquierdo.constant = -_menuView.bounds.size.width;
        _containerConstraintDerecho.constant = 0;
        _containerConstraintIzquierdo.constant = 0;

        [self.view layoutIfNeeded];
        
    } completion:^(BOOL ok){
        if (ok) {
            [_menuBoton setEnabled:YES];
        }
    }];
    
   
    menuAbierto=NO;
    
}
@end
