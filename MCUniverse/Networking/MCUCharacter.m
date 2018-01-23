//
//  MCUCharacter.m
//  MCUniverse
//
//  Created by Max Ramirez on 1/22/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

#import "MCUCharacter.h"


@implementation MCUCharacter

+ (instancetype) characterWithDictionary: (NSDictionary *) dictionary {
    MCUCharacter *character = [[MCUCharacter alloc] init];
    
    if  ( character ) {
        character.characterName = [dictionary valueForKeyPath:@"name"];
        character.characterDescription = [dictionary valueForKeyPath:@"description"];
        character.characterImageURL = [NSURL URLWithString:[[dictionary valueForKeyPath:@"thumbnail.path"] stringByAppendingPathExtension:[dictionary valueForKeyPath:@"thumbnail.extension"]]];;
        NSLog(@"Character Image URL: %@", character.characterImageURL);
    }
    
    return character;
}


@end
