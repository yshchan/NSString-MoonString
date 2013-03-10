What is MoonString?
-------------------

MoonString is basically a `NSString` category with a bunch of nifty methods that I think should have been in the `NSString` class in the first place. 

MoonString's methods:

- (NSString*)stringBetweenString:(NSString*)start andString:(NSString*)end;
- (NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end;
- (NSArray*)splitString:(NSString*)string seperator:(NSString *)seperator;
- (NSString*)compileStrings:(NSArray*)chunks seperator:(NSString*)seperator;
- (NSUInteger)countWords;
- (NSString*)stripNewlines;
- (NSString*)removeSpacesFromString;
- (NSString *)trimWhitespaceFromEnds;
- (NSString *)inverseCapitalisationString;
- (NSString*)removeSubstring:(NSString*)substring;
- (NSUInteger)occurrencesOfString:(NSString *)needle;
- (BOOL)containsString: (NSString*)substring range:(NSRange*)range;
- (BOOL)containsString:(NSString *)substring;

To use them, just import them with 
	
	#import "NSString+MoonString.h"

May I note that I haven't written most of these methods. The ones I haven't written, I have collected from snippets on StackOverflow or somewhere else. 