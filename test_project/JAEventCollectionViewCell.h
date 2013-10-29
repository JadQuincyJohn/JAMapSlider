//
//  JAEventCollectionViewCell.h
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAEventCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UIImageView * eventImageView;
@property (nonatomic, retain) IBOutlet UILabel * eventNameLabel;
@property (nonatomic, retain) IBOutlet UILabel * eventDistanceLabel;
@property (nonatomic, retain) IBOutlet UILabel * eventDescriptionLabel;

@end
