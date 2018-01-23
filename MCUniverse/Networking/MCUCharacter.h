//
//  MCUCharacter.h
//  MCUniverse
//
//  Created by Max Ramirez on 1/22/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUCharacter : NSObject

@property (nonatomic, strong) NSURL *characterImageURL;
@property (nonatomic, strong) NSString *characterName;
@property (nonatomic, strong) NSString *characterDescription;
+ (instancetype) characterWithDictionary:(NSDictionary *) dictionary;

@end
