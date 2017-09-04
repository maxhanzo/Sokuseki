//
//  UIView+View2Image.h
//  Analytics
//
//  Created by Max Hiroyuki Ueda on 1/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "UIView+View2Image.h"

@implementation UIView (View2Image)

-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
