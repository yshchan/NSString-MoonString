//
//  NSString+MoonString.m
//  Tsukimi
//
//  Created by Yashwant Chauhan on 3/8/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "NSString+MoonString.h"

@implementation NSString (MoonString)

-(NSUInteger)occurrencesOfString:(NSString *)needle {
    NSString *haystack = (NSString*)self;
    const char * rawNeedle = [needle UTF8String];
    NSUInteger needleLength = strlen(rawNeedle);
    
    const char * rawHaystack = [haystack UTF8String];
    NSUInteger haystackLength = strlen(rawHaystack);
    
    NSUInteger needleCount = 0;
    NSUInteger needleIndex = 0;
    for (NSUInteger index = 0; index < haystackLength; ++index) {
        const char thisCharacter = rawHaystack[index];
        if (thisCharacter != rawNeedle[needleIndex]) {
            needleIndex = 0; //they don't match; reset the needle index
        }
        
        //resetting the needle might be the beginning of another match
        if (thisCharacter == rawNeedle[needleIndex]) {
            needleIndex++; //char match
            if (needleIndex >= needleLength) {
                needleCount++; //we completed finding the needle
                needleIndex = 0;
            }
        }
    }
    return needleCount;
}

-(BOOL)containsString:(NSString *)substring range:(NSRange *)range{
    
    NSRange r = [self rangeOfString : substring];
    BOOL found = ( r.location != NSNotFound );
    if (range != NULL) *range = r;
    return found;
}

-(BOOL)containsString:(NSString *)substring
{
    return [self containsString:substring range:NULL];
}

- (NSString *) inverseCapitalisationString
{
    // This is a quick hack to convert upper case letters to lowercase, and vice versa
    // It uses the standard C character manipulation functions so it will obviously not
    // work on anything other than basic ASCII strings.
    
    // get the length of the string that is to be manipulated
    int len = (int)[self length];
    
    // create a string to hold our modified text
    NSMutableString *capitalisedString = [NSMutableString stringWithCapacity:len];
    
    // iterate over the original string, pulling out each character for inspection
    for (int i = 0; i < len; i++)
    {
        // get the next character in the original string
        char ch = [self characterAtIndex:i];
        
        // convert upper-case to lower-case, and lower-case to upper-case
        if (isupper(ch))
        {
            ch = tolower(ch);
        }
        else if (islower(ch))
        {
            ch = toupper(ch);
        }
        
        // append the manipulated character to the modified string
        [capitalisedString appendString:[NSString stringWithFormat:@"%c", ch]];
    }
    
    // return the newly modified string
    return capitalisedString;
}

-(NSString*)removeSubstring:(NSString*)substring {
    NSString *stringWithoutSubstring = [self stringByReplacingOccurrencesOfString:substring withString:@""];
    return stringWithoutSubstring;
}

-(NSString*)stringBetweenString:(NSString*)start andString:(NSString*)end {
    NSRange startRange = [self rangeOfString:start];
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [self length] - targetRange.location;
        NSRange endRange = [self rangeOfString:end options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            return [self substringWithRange:targetRange];
        }
    }
    return nil;
}

-(NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end
{
    NSMutableArray* strings = [NSMutableArray arrayWithCapacity:0];
    NSRange startRange = [self rangeOfString:start];
    for( ;; )
    {
        if (startRange.location != NSNotFound)
        {
            NSRange targetRange;
            
            targetRange.location = startRange.location + startRange.length;
            targetRange.length = [self length] - targetRange.location;
            
            NSRange endRange = [self rangeOfString:end options:0 range:targetRange];
            
            if (endRange.location != NSNotFound)
            {
                targetRange.length = endRange.location - targetRange.location;
                [strings addObject:[self substringWithRange:targetRange]];
                
                NSRange restOfString;
                
                restOfString.location = endRange.location + endRange.length;
                restOfString.length = [self length] - restOfString.location;
                
                startRange = [self rangeOfString:start options:0 range:restOfString];
            }
            else
            {
                break;
            }
        }
        else
        {
            break;
        }
    }
    return strings;
}

-(NSString*)compileStrings:(NSArray*)chunks seperator:(NSString*)seperator {
    NSString *compiledString = [chunks componentsJoinedByString:seperator];
    return compiledString;
}

-(NSUInteger)countWords {
    __block NSUInteger wordCount = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByWords usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
        wordCount++;
    }];
    return wordCount;
}

-(NSString*)stripNewlines {
    NSMutableString *mstring = [NSMutableString stringWithString:self];
    NSRange wholeShebang = NSMakeRange(0, [mstring length]);
    [mstring replaceOccurrencesOfString: @"" withString: @"" options: 0 range: wholeShebang];
    return [NSString stringWithString: mstring];
}

-(NSString*)removeSpacesFromString {
    return [self stringByReplacingOccurrencesOfString: @" " withString: @""];
}

-(NSString *)trimWhitespaceFromEnds {
    NSString *trimmed = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmed;
}

-(NSArray*)splitString:(NSString*)string seperator:(NSString *)seperator {
    NSArray *chunks = [string componentsSeparatedByString:seperator];
    return chunks;
}

@end
