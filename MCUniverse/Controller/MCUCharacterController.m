//
//  MCUCharacterController.m
//  MCUniverse
//
//  Created by Max Ramirez on 1/18/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

#import "MCUCharacterController.h"
#import "MCUCharacterCell.h"
#import "MCUCharacter.h"
#import "NSString+MD5.h"

@interface MCUCharacterController ()
@property (strong, nonatomic) NSMutableArray  *characters;
@end

@implementation MCUCharacterController


static NSString * const reuseIdentifier = @"MCUCharacterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshImages];
}

- (void) refreshImages {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    NSString *PUBLIC_KEY = @"e5510da9c5d3c12104e53f189ecb6918";
    NSString *PRIVATE_KEY = @"2873d4d9f709e12885598b0d58f72061e19d3112";
    NSString *myDigestString = [NSString stringWithFormat:@"%@%@%@", timeStampObj, PRIVATE_KEY , PUBLIC_KEY];
    NSString *hash = [myDigestString MD5];

    NSString *urlString = [NSString stringWithFormat:@"https://gateway.marvel.com/v1/public/characters?limit=100&ts=%@&apikey=%@&hash=%@", timeStampObj, PUBLIC_KEY, hash];
    
    NSURL *url = [NSURL URLWithString:urlString];

    self.characters = [NSMutableArray array];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSLog(@"response dictionary: %@", dictionary);
        NSDictionary *dictionaries = [dictionary valueForKey:@"data"];
        NSArray *resultDictionaries = [dictionaries valueForKey:@"results"];
        
        for (NSDictionary *dict in resultDictionaries) {
            MCUCharacter *character = [MCUCharacter characterWithDictionary:dict];
            [self.characters addObject:character];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    [task resume];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.characters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCUCharacterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MCUCharacter *character = [self.characters objectAtIndex:indexPath.row];
    cell.character = character;
    
    return cell;
}



@end
