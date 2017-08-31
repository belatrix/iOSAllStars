//
//  SWFrontGenericoViewController.m
//  UVK
//
//  Created by Kenyi Rodriguez on 6/11/15.
//  Copyright © 2015 Online Studio Productions. All rights reserved.
//

#import "SWFrontGenericoViewController.h"



@interface SWFrontGenericoViewController ()

@end

@implementation SWFrontGenericoViewController



-(IBAction)clicBtnReveal:(id)sender{
    
    if (self.revealViewController) {
    
        [self.revealViewController revealToggle:nil];
    }else{
     
        [self dismissViewControllerAnimated:true completion:nil];
    }
}



- (UIView *)vistaBloqueo{
    
    if (!_vistaBloqueo) {
        
        CGRect tamanoPantalla = [UIScreen mainScreen].bounds;
        _vistaBloqueo = [[UIView alloc] initWithFrame:CGRectMake(0, 64, tamanoPantalla.size.width, tamanoPantalla.size.height)];
        [_vistaBloqueo setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_vistaBloqueo];
    }
    
    return _vistaBloqueo;
}


-(void)cambiarEstadoFront:(FrontViewPosition)posicion{
    
    [self.view bringSubviewToFront:self.vistaBloqueo];
    
    if (posicion == FrontViewPositionLeft) {
        self.vistaBloqueo.alpha = 0;
    }else if (posicion == FrontViewPositionRight){
        self.vistaBloqueo.alpha = 1;
    }
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated{

    self.vistaBloqueo.alpha = 0;
    
    if (self.revealViewController) {
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
    [super viewWillAppear:animated];
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}


@end
