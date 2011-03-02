//
//  DetailViewController.h
//  FontsBook
//
//  Created by Giovambattista Fazioli on 02/03/11.
//  Copyright 2011 Saidmade Srl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController {
	IBOutlet UILabel	*label;
}

@property(nonatomic, retain) IBOutlet UILabel	*label;

- (IBAction)sliderDidChangeValue:(UISlider *)aSlider;

@end
