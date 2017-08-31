//
//  SWFrontGenericoViewController.h
//  UVK
//
//  Created by Kenyi Rodriguez on 6/11/15.
//  Copyright © 2015 Online Studio Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface SWFrontGenericoViewController : UIViewController

@property (nonatomic, strong) UIView *vistaBloqueo;

-(IBAction)clicBtnReveal:(id)sender;
-(void)cambiarEstadoFront:(FrontViewPosition)posicion;



@end
