//
//  SWRevealViewControllerDelegate.m
//  UVK
//
//  Created by Kenyi Rodriguez on 6/11/15.
//  Copyright © 2015 Online Studio Productions. All rights reserved.
//

#import "SWRevealViewControllerDelegate.h"
#import "SWFrontGenericoViewController.h"

@interface SWRevealViewControllerDelegate ()

@end




@implementation SWRevealViewControllerDelegate




- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    /* Ejemplo de cómo manejar el delegado:
     *
     * SBSParentViewController_iPhone * parentViewController;
     * if ([revealController.frontViewController isMemberOfClass:UINavigationController.class] == YES)
     *    parentViewController = ((UINavigationController *)revealController.frontViewController).viewControllers[0];
     * else if ([revealController.frontViewController isMemberOfClass:SBSAboutUsViewController_iPhone.class] == YES)
     *    parentViewController = (SBSParentViewController_iPhone *)revealController.frontViewController;
     *
     * [parentViewController changeRevealToogleViewWidthForPosition:position];
     */
    
    /*HomeViewController * homeViewController = (HomeViewController *)revealController.originViewController;
     [homeViewController changeHamburgerIconForPosition:position];
     [homeViewController changeTitleForMainOptionIndexSelected];*/
    
    if ([revealController.frontViewController isKindOfClass:UINavigationController.class]) {
        
        SWFrontGenericoViewController * controller = (SWFrontGenericoViewController *)((UINavigationController *)revealController.frontViewController).topViewController;
        [controller cambiarEstadoFront:position];
    }
    
    
//    if (position == FrontViewPositionLeft) {
//        
//
//    }else if (position == FrontViewPositionRight){
//     
//        
//    }
}


- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    
}

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated {
    
}

- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated {
    
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController {

}


@end
