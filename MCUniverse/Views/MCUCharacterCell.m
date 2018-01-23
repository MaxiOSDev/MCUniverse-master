//
//  MCUCharacterCell.m
//  MCUniverse
//
//  Created by Max Ramirez on 1/19/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

#import "MCUCharacterCell.h"
#import "MCUCharacter.h"


@implementation MCUCharacterCell

- (void) setCharacter:(MCUCharacter *)character {
    _character = character;
    
    self.nameLabel.text = [character characterName];
    self.descriptionLabel.text = [character characterDescription];
    [self downloadImageWithURL:character.characterImageURL];
    [self setupGestures];
}

- (void)setupGestures {
    UISwipeGestureRecognizer *swipeFlip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFlip)];
    
    [self.frontOfCardView addGestureRecognizer:swipeFlip];
    [self.backOfCardView addGestureRecognizer:swipeFlip];
}

- (void)swipeFlip {
    
    [_flipButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    NSLog(@"Swipped");
    
}

- (void)downloadImageWithURL:(NSURL*)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    [task resume];
}


- (IBAction)flipCard:(UIButton *)sender {
    
    self.flippedCard = _flippedCard == YES ? NO : YES;

    UIView *frontView = _flippedCard ? _frontOfCardView : _backOfCardView;
    UIView *toView = _flippedCard ? _backOfCardView : _frontOfCardView;

    [UIView transitionFromView:frontView toView:toView duration:0.5 options: UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews completion:nil];
}
@end
