/*
 * This file is part of FRLayeredNavigationController.
 *
 * Copyright (c) 2012-2014, Johannes Weiß <weiss@tux4u.de>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * The name of the author may not be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Local Imports */
#import "FRDLog.h"
#import "UIViewController+FRLayeredNavigationController.h"
#import "FRLayerController.h"

@implementation UIViewController (FRLayeredNavigationController)

- (FRLayeredNavigationController *)layeredNavigationController
{
    UIViewController *here = self;

    while (here != nil) {
        if([here isKindOfClass:[FRLayeredNavigationController class]]) {
            return (FRLayeredNavigationController *)here;
        }

        here = here.parentViewController;
    }

    FRDLOG(@"WARNING: No instance of FRLayeredNavigationController in view controller hierachy!");
    FRDLOG(@"HINT: If you used [UIWindow addSubview:], change it to [UIWindow setRootViewController:]");

    return nil;
}

- (FRLayeredNavigationItem *)layeredNavigationItem
{
    UIViewController *here = self;

    while (here != nil) {
        if([here isKindOfClass:[FRLayerController class]]) {
            return ((FRLayerController *)here).layeredNavigationItem;
        }

        here = here.parentViewController;
    }

    FRDLOG(@"WARNING: No instance of FRLayerController in view controller hierachy!");
    FRDLOG(@"DEBUG: self: '%@', self.parentViewController: '%@'", self, self.parentViewController);
    FRDLOG(@"HINT: The layeredNavigationItem property is nil until the view controller is shown on the screen.");

    return nil;
}


@end
