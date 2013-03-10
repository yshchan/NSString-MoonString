//
//  NSString+MoonString.h
//  Tsukimi
//
//  Created by Yashwant Chauhan on 3/8/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MoonString)

-(NSString*)stringBetweenString:(NSString*)start andString:(NSString*)end;
-(NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end;
-(NSArray*)splitString:(NSString*)string seperator:(NSString *)seperator;
-(NSString*)compileStrings:(NSArray*)chunks seperator:(NSString*)seperator;
-(NSUInteger)countWords;
-(NSString*)stripNewlines;
-(NSString*)removeSpacesFromString;
-(NSString *)trimWhitespaceFromEnds;
-(NSString *)inverseCapitalisationString;
-(NSString*)removeSubstring:(NSString*)substring;
-(NSUInteger)occurrencesOfString:(NSString *)needle;
-(BOOL)containsString: (NSString*)substring range:(NSRange*)range;
-(BOOL)containsString:(NSString *)substring;

@end
