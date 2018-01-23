//
//  MCUCharacterCell.h
//  MCUniverse
//
//  Created by Max Ramirez on 1/19/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCUCharacter;

@interface MCUCharacterCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backOfCardView;
@property (weak, nonatomic) IBOutlet UIView *frontOfCardView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) MCUCharacter *character;
@property (nonatomic, assign) BOOL *flippedCard;
@property (weak, nonatomic) IBOutlet UIButton *flipButton;

- (IBAction)flipCard:(UIButton *)sender;

@end
