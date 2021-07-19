#ifdef DEBUG

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LogResultType) {
    LogResultTypeNone       = 1 << 0,
    LogResultTypeString     = 1 << 1,
    LogResultTypeDictionary = 1 << 2,
    LogResultTypeArray      = 1 << 3,
    LogResultTypeSet        = 1 << 4,
};

/** 中间字符串拼接 */
void linkLogString(id obj, void (^getObjet)(LogResultType type, id result)) {
    if ([obj isKindOfClass:[NSString class]]) {
        if (getObjet) {
            getObjet(LogResultTypeString, obj);
        }
    } else if ([obj isKindOfClass:[NSArray class]]
               || [obj isKindOfClass:[NSDictionary class]]
               || [obj isKindOfClass:[NSSet class]]) {
        if (getObjet) {
            getObjet(LogResultTypeArray | LogResultTypeDictionary | LogResultTypeSet, obj);
        }
    } else if ([obj isKindOfClass:[NSData class]]) {
        //NSData类型，尝试解析
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:&error];
        if (error == nil && result != nil) {
            if ([result isKindOfClass:[NSArray class]]
                || [result isKindOfClass:[NSDictionary class]]
                || [result isKindOfClass:[NSSet class]]) {
                if (getObjet) {
                    getObjet(LogResultTypeArray | LogResultTypeDictionary | LogResultTypeSet, result);
                }
            } else if ([result isKindOfClass:[NSString class]]) {
                if (getObjet) {
                    getObjet(LogResultTypeString, result);
                }
            } else {
                if (getObjet) {
                    getObjet(LogResultTypeNone, result);
                }
            }
        } else {
            @try {
                NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                if (str != nil) {
                    if (getObjet) {
                        getObjet(LogResultTypeString, str);
                    }
                } else {
                    if (getObjet) {
                        getObjet(LogResultTypeNone, obj);
                    }
                }
                
            } @catch (NSException *exception) {
                if (getObjet) {
                    getObjet(LogResultTypeNone, obj);
                }
            } @finally {
            }
        }
    } else {
        if (getObjet) {
            getObjet(LogResultTypeNone, obj);
        }
    }
}

/** 打印日志显示中文编码（自动）*/

@implementation NSSet (Log)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; i++) {
        [tabString appendString:@"\t"];
    }

    NSString *tab;
    if (level > 0) {
        tab = [tabString stringByAppendingString:@"\t"];
    } else {
        tab = @"\t";
    }

    [desc appendString:@"{(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        linkLogString(obj, ^(LogResultType type, id result) {
            if (type == LogResultTypeString) {
                [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
            } else if (type == (LogResultTypeDictionary | LogResultTypeArray | LogResultTypeSet)) {
                id str;
                @try {
                    str = [obj descriptionWithLocale:locale indent:level + 1];
                } @catch (NSException *exception) {
                    str = obj;
                } @finally {
                    [desc appendFormat:@"%@\t%@,\n", tab, str];
                }
            }else {//LogResultTypeNone
                [desc appendFormat:@"%@\t%@,\n", tab, obj];
            }
        });
    }];

    if (level > 0) {
        tab = tabString;
    } else {
        tab = @"";
    }
    [desc appendFormat:@"%@)}", tab];
    if (self.count) {
        NSRange range = [desc rangeOfString:@"," options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            [desc deleteCharactersInRange:range];
        }
    }
    
    return desc;
}
@end
@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab;
    if (level > 0) {
        tab = [tabString stringByAppendingString:@"\t"];
    } else {
        tab = @"\t";
    }
    
    [desc appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        linkLogString(obj, ^(LogResultType type, id result) {
            if (type == LogResultTypeString) {
                [desc appendFormat:@"%@%@ = \"%@\";\n", tab, key, obj];
            } else if (type == (LogResultTypeDictionary | LogResultTypeArray | LogResultTypeSet)) {
                id str;
                @try {
                    str = [obj descriptionWithLocale:locale indent:level + 1];
                } @catch (NSException *exception) {
                    str = obj;
                } @finally {
                    [desc appendFormat:@"%@%@ = %@;\n", tab, key, str];
                }
            }else {//LogResultTypeNone
                [desc appendFormat:@"%@%@ = %@;\n", tab, key, result];
            }
        });
    }];
    if (level > 0) {
        tab = tabString;
    } else {
        tab = @"";
    }
    [desc appendFormat:@"%@}", tab];
    if (self.count) {
        NSRange range = [desc rangeOfString:@";" options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            [desc deleteCharactersInRange:range];
        }
    }
    return desc;
}

@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab;
    if (level > 0) {
        tab = [tabString stringByAppendingString:@"\t"];
    } else {
        tab = @"\t";
    }
    
    [desc appendString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        linkLogString(obj, ^(LogResultType type, id result) {
            if (type == LogResultTypeString) {
                [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
            } else if (type == (LogResultTypeDictionary | LogResultTypeArray | LogResultTypeSet)) {
                id str;
                @try {
                    str = [obj descriptionWithLocale:locale indent:level + 1];
                } @catch (NSException *exception) {
                    str = obj;
                } @finally {
                    [desc appendFormat:@"%@\t%@,\n", tab, str];
                }
            }else {//LogResultTypeNone
                [desc appendFormat:@"%@\t%@,\n", tab, result];
            }
        });
   
    }];
    
    if (level > 0) {
        tab = tabString;
    } else {
        tab = @"";
    }
    [desc appendFormat:@"%@)", tab];
    if (self.count) {
        NSRange range = [desc rangeOfString:@"," options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            [desc deleteCharactersInRange:range];
        }
    }

    return desc;
}

@end

#endif

