//
//  OpenCloseBlurredViewControllerSegue.m
//  Sokuseki
//
//  Created by Max Hiroyuki Ueda on 9/21/15.
//  Copyright (c) 2015 UedaSoft IT Solutions. All rights reserved.
//

#import "OpenCloseBlurredViewControllerSegue.h"
#import "UIImage+ImageEffects.h"
#import "UIView+View2Image.h"


@implementation OpenCloseBlurredViewControllerSegue
- (void)perform
{
    //Strategy: Take a screenshot from the view controller behind the scene. Add the screenshot to a UIImageView
    //Object, and add this view as the bottommost view, to give the sensation that this scene is "made of glass"
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    UIView *sourceView = sourceViewController.tabBarController.view;
    UIView *destinationView = destinationViewController.view;
    
    destinationView.backgroundColor = [UIColor clearColor];
    
    float width = sourceView.frame.size.width;
    float height = sourceView.frame.size.height;
    
    
    UIImage *blurredSourceImage = [OpenCloseBlurredViewControllerSegue blurredImageOfView:sourceView];
    UIImageView *blurredImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, height, width, 0.0)];
    
    //    if ( blurredSourceImage == nil )
    //    {
    //        // fallback incase blurred image fails
    //        blurredImageView.backgroundColor = [UIColor clearColor];
    //    }
    
    blurredImageView.clipsToBounds = YES;
    blurredImageView.contentMode = UIViewContentModeBottom;
    blurredImageView.image = blurredSourceImage;
    
    
    // [sourceView addSubview:blurredImageView];
    // [sourceView addSubview:destinationView];
    
    CGPoint originalCenter = destinationView.center;
    destinationView.center = CGPointMake(originalCenter.x, originalCenter.y+sourceView.frame.size.height);
    
    blurredImageView.frame = sourceView.frame;
    //[destinationView removeFromSuperview];
    
    //Workarround: I didn't find a way to prevent presentViewController from executing RIGHT AFTER I tried
    //to remove destinationView, leading to it's completion (destinationView removal) waiting forever for
    //it's thread to confirm it was removed (because the destinationViewController was already presented).
    //I guess I'll have to work on a custom transition stuff.
    
    [self performSelector:@selector(presentViewControllerRemoveView:) withObject:@[destinationViewController, blurredImageView, destinationView] afterDelay:0];
}

//Perform the task to remove the blurred image View from the sourceViewController
//Also, it has the top to bottom animation & modal transition effects.
-(void)presentViewControllerRemoveView:(NSArray *)objects
{
    UIViewController *sourceViewController = self.sourceViewController;
    
    UIViewController * viewControllerToPresent = objects[0];
    UIView * blurredImageView = objects[1];
    UIView * destinationView = objects[2];
    [destinationView insertSubview:blurredImageView atIndex:0];
    
    CATransition *transition = [CATransition animation];
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    transition.fillMode = kCAFillModeBoth;
    transition.delegate = self;
    transition.removedOnCompletion = YES;
    self.sourceViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    viewControllerToPresent.definesPresentationContext = YES;
    viewControllerToPresent.providesPresentationContextTransitionStyle = YES;
    
    
    viewControllerToPresent.view.backgroundColor = [UIColor clearColor];
    
    [sourceViewController.view.window.layer addAnimation:transition forKey:nil];
    [sourceViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [sourceViewController presentViewController:viewControllerToPresent
                                       animated:NO
                                     completion:nil];
}



//Takes a screenshot of a view and returns an UIImage object
+ (UIImage *) blurredImageOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [[UIScreen mainScreen] scale]);
    
    BOOL success = [view drawViewHierarchyInRect:CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height) afterScreenUpdates:NO];
    
    if ( success )
    {
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //Blur method. There are other methods in the UIImage+ImageEffects category.
        UIImage *blurredImage = [image applyDarkEffect];
        return blurredImage;
    }
    else
    {
        return  nil;
    }
}


@end

