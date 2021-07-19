//
//  MDFDBStorage.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFDBStorage.h"
#import "FMDatabase.h"
#import "TMDiskCache.h"
#import "MDFDBStorageItem.h"
#import "NSArray+MDF.h"
#import "NSMutableArray+MDF.h"
#import "NSMutableDictionary+MDF.h"

static inline NSString *tableNameForNameSpace(NSString *nameSpace)
{
    if (!nameSpace) {
        return @"MDFDBStorage";
    }
    return [NSString stringWithFormat:@"MDFDBStorage_%@",nameSpace];
}

static dispatch_queue_t shareQueueForDBStorage()
{
    static dispatch_queue_t dbQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbQueue = dispatch_queue_create("com.mdf.dbstorage", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(dbQueue,"currentQueue",(__bridge void *)(dbQueue),NULL);
    });
    
    return dbQueue;
}

void mdf_safeSyncInDBQueue(dispatch_block_t block)
{
    void *currentContext = dispatch_get_specific("currentQueue");
    if (currentContext != NULL && (__bridge dispatch_queue_t)currentContext == shareQueueForDBStorage()) {
        if (block) {
            block();
        }
    } else {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_async(shareQueueForDBStorage(), ^{
            if (block) {
                block();
            }
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}


@interface MDFDBStorage ()

@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic, copy) NSString *nameSpace;
@property (nonatomic, strong) NSMutableArray *fieldMArray;

@end

@implementation MDFDBStorage

+ (NSString *)dataBasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths mdf_safeObjectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MDF_DBStorage.db"];
    return path;
}

+ (FMDatabase *)database
{
    static FMDatabase *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dataBasePath = [self dataBasePath];
        database = [[FMDatabase alloc] initWithPath:dataBasePath];
        [database open];
        if (dataBasePath.length > 0) {
            [[NSURL fileURLWithPath:dataBasePath] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
        }
    });
    
    return database;
}

- (instancetype)initWithNameSpace:(NSString *)nameSpace
{
    self = [super init];
    if (self) {
        _nameSpace = nameSpace;
        NSAssert(nameSpace != nil, @"name space should not be nil");
        _database = [[self class] database];
        [self.database executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (key TEXT, value BLOB,ext TEXT)", tableNameForNameSpace(self.nameSpace)]];
        [self.database executeUpdate:[NSString stringWithFormat:@"CREATE UNIQUE INDEX IF NOT EXISTS key ON %@(key)", tableNameForNameSpace(self.nameSpace)]];
    }
    
    return self;
}

// userInfo
- (BOOL)setUserInfo:(NSDictionary *)userInfo forKey:(NSString *)aKey error:(NSError **)error
{
    if (!aKey || !userInfo) {
        if (error) {
            NSError *returnError = [NSError errorWithDomain:NSCocoaErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey:@"USERINFO or aKey is nil"}];
            *error = returnError;
        }
        return NO;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:userInfo options:NSJSONWritingPrettyPrinted error:error];
    if (!data) {
        return NO;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!string) {
        if (!*error) {
            NSError *returnError = [NSError errorWithDomain:NSCocoaErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey:@"input value is not valid json"}];
            *error = returnError;
        }
        return NO;
    }
    
    __block BOOL rt = NO;
    mdf_safeSyncInDBQueue(^{
        if ([self isExistObjectForKey:aKey]) {
            rt = [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET ext = ? WHERE key = ?",tableNameForNameSpace(self.nameSpace)],string,aKey];
        } else {
            rt = [self.database executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (key, ext) VALUES (?, ?)",tableNameForNameSpace(self.nameSpace)],aKey,string];
        }
    });
    return rt;
}

- (NSDictionary *)userInfoForKey:(NSString *)aKey error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    __block id rt = nil;
    mdf_safeSyncInDBQueue(^{
        FMResultSet *rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT ext FROM %@ WHERE key = ?", tableNameForNameSpace(self.nameSpace)], aKey];
        NSString *string = nil;
        if ([rs next]) {
            string = [rs stringForColumn:@"ext"];
            [rs close];
        }
        if (string) {
            rt = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:error];
        }
    });
    return rt;
}

- (BOOL)setObject:(id)object forKey:(NSString *)aKey error:(NSError **)error
{
    NSData *data = dataWithObject(object);
    if (!aKey || !data) {
        if (error) {
            NSError *returnError = [NSError errorWithDomain:NSCocoaErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey:@"data or aKey is nil"}];
            *error = returnError;
        }
        return NO;
    }
    __block BOOL rt = NO;
    mdf_safeSyncInDBQueue(^{
        if ([self isExistObjectForKey:aKey]) {
            rt = [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET value = ? WHERE key = ?",tableNameForNameSpace(self.nameSpace)],data,aKey];
        } else {
            rt = [self.database executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (key, value) VALUES (?, ?)",tableNameForNameSpace(self.nameSpace)],aKey,data];
        }
    });
    return rt;
}

- (id)objectForKey:(NSString *)key error:(NSError **)error
{
    __block id rt = nil;
    mdf_safeSyncInDBQueue(^{
        FMResultSet *rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT value FROM %@ WHERE key = ?", tableNameForNameSpace(self.nameSpace)], key];
        
        if ([rs next]) {
            rt = [rs dataForColumn:@"value"];
            [rs close];
        }
    });
    
    id object = nil;
    @try {
        object = analyzeData(rt);
    }
    @catch (NSException *exception) {
        object = nil;
    }

    return object;
}

- (BOOL)removeObjectForKey:(NSString *)key error:(NSError **)error
{
    __block BOOL result = NO;
    mdf_safeSyncInDBQueue(^{
        result = [self.database executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE key = ?", tableNameForNameSpace(self.nameSpace)], key];
    });
    return result;
}

- (BOOL)isExistObjectForKey:(NSString *)key
{
    __block BOOL rt = NO;
    mdf_safeSyncInDBQueue(^{
        FMResultSet *rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT value FROM %@ WHERE key = ?", tableNameForNameSpace(self.nameSpace)], key];
        if ([rs next]) {
            rt = YES;
            [rs close];
        }
    });
    return rt;
}

+ (void)cleanNameSpace:(NSString *)nameSpace
{
    mdf_safeSyncInDBQueue(^{
        FMDatabase *database = [self database];
        [database executeUpdate:[NSString stringWithFormat:@"DROP TABLE %@",tableNameForNameSpace(nameSpace)]];
    });
}


#pragma mark - Common Store

- (instancetype)initWithNameSpace:(NSString *)nameSpace fields:(NSArray *)fieldArray
{
    self = [super init];
    if (self) {
        _nameSpace = nameSpace;
        NSAssert(self.nameSpace != nil, @"name space should not be nil");
        _fieldMArray = [NSMutableArray arrayWithCapacity:0];
        _database = [[self class] database];
        NSString *fieldStr = nil;
        if (fieldArray.count > 0) {
            NSDictionary *storageDict = @{@"storageFields" : fieldArray};
            MDFDBStorageItem *storageItem = [[MDFDBStorageItem alloc] init];
            [storageItem parseJSONValue:storageDict];
            NSArray *storageArray = storageItem.storageFields;
            if ([storageArray count] > 0) {
                fieldStr = @"";
                for (int i = 0; i < [storageArray count]; i++) {
                    MDFDBFieldInfo *fieldInfo = [storageArray mdf_safeObjectAtIndex:i];
                    if (0 == i) {
                        fieldStr = [fieldStr stringByAppendingFormat:@"%@ %@", fieldInfo.fieldName, fieldInfo.fieldType];
                    } else {
                        fieldStr = [fieldStr stringByAppendingFormat:@", %@ %@", fieldInfo.fieldName, fieldInfo.fieldType];
                    }
                    [self.fieldMArray mdf_safeAddObject:fieldInfo.fieldName];
                }
            }
        }
        if (fieldStr) {
            [self.database executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)", tableNameForNameSpace(self.nameSpace), fieldStr]];
        }
    }
    return self;
}

- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...
{
    va_list args;
    va_start(args, conditionKeys);
    
    BOOL result = [self setObjectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments
{
    return [self setObjectForKeys:keys conditionKeys:conditionKeys withArguments:arguments orVAList:nil];
}

- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args
{
    return [self setObjectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
}

- (BOOL)setObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args
{
    __block BOOL result = NO;
    NSString *updateResult = [self stringForKeys:keys componentsSeparatedByString:@","];
    NSString *conditionResult = [self stringForKeys:conditionKeys componentsSeparatedByString:@" AND"];
    if (updateResult) {
        NSArray *keyArray = [keys componentsSeparatedByString:@","];
        NSArray *conditionKeyArray = [conditionKeys componentsSeparatedByString:@","];
        NSMutableArray *argsMArray = [NSMutableArray arrayWithCapacity:0];
        if (arguments) {
            NSArray *arg = [arguments mdf_safeSubarrayWithRange:NSMakeRange(keyArray.count, conditionKeyArray.count)];
            [argsMArray mdf_safeAddObjectsFromArray:arg];
        } else if (args) {
            id obj;
            for (NSUInteger i = 0; i < [keyArray count] + [conditionKeyArray count]; i++) {
                obj = va_arg(args, id);
                if (i == [keyArray count]) {
                    [argsMArray mdf_safeAddObject:obj];
                }
            }
        }
        mdf_safeSyncInDBQueue(^{
            if ([self isExistObjectForKeys:keys conditionKeys:conditionKeys withArguments:argsMArray]) {
                if (conditionResult) {
                    result = [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@", tableNameForNameSpace(self.nameSpace), updateResult, conditionResult] withArgumentsInArray:arguments];
                } else {
                    result = [self.database executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@", tableNameForNameSpace(self.nameSpace), updateResult]];
                }
            } else {
                NSString *values = keys;
                if (conditionKeys) {
                    values = [values stringByAppendingFormat:@", %@", conditionKeys];
                }
                NSArray *keyCountArray = [values componentsSeparatedByString:@","];
                NSString *supposedStr = @"?";
                for (int i = 0; i < keyCountArray.count - 1; i++) {
                    supposedStr = [supposedStr stringByAppendingString:@", ?"];
                }
                if (arguments) {
                    result = [self.database executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableNameForNameSpace(self.nameSpace), values, supposedStr] withArgumentsInArray:arguments];
                } else if (args) {
                    result = [self.database executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableNameForNameSpace(self.nameSpace), values, supposedStr] withVAList:args];
                }
            }
        });
    }
    return result;
}

- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...
{
    va_list args;
    va_start(args, conditionKeys);
    
    id result = [self objectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments
{
    return [self objectForKeys:keys conditionKeys:conditionKeys withArguments:arguments orVAList:nil];
}

- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args
{
    return [self objectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
}

- (id)objectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args
{
    __block id result = nil;
    mdf_safeSyncInDBQueue(^{
        NSString *fieldResult = [self stringForKeys:conditionKeys componentsSeparatedByString:@" AND"];
        FMResultSet *rs;
        if (fieldResult) {
            if (arguments) {
                rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", keys, tableNameForNameSpace(self.nameSpace), fieldResult] withArgumentsInArray:arguments];
            } else if (args) {
                rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", keys, tableNameForNameSpace(self.nameSpace), fieldResult] withVAList:args];
            }
        } else {
            rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@", keys, tableNameForNameSpace(self.nameSpace)]];
        }
        NSArray *keyArray;
        if (![keys isEqualToString:@"*"]) {
            keyArray = [keys componentsSeparatedByString:@","];
        } else {
            keyArray = self.fieldMArray;
        }
        NSMutableArray *resultMArray = [NSMutableArray arrayWithCapacity:0];
        while ([rs next]) {
            NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:0];
            for (int i = 0; i < [keyArray count]; i++) {
                NSString *key = [keyArray mdf_safeObjectAtIndex:i];
                if (key) {
                    id object = [rs objectForColumnName:key];
                    [mDict mdf_safeSetObject:object forKey:key];
                    [resultMArray mdf_safeAddObject:mDict];
                }
            }
        }
        if ([resultMArray count] == 1) {
            result = [resultMArray mdf_safeObjectAtIndex:0];
        } else if ([resultMArray count] > 1) {
            result = resultMArray;
        }
    });
    return result;
}

- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys, ...
{
    va_list args;
    va_start(args, conditionKeys);
    
    BOOL result = [self removeObjectForConditionKeys:conditionKeys withArguments:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments
{
    return [self removeObjectForConditionKeys:conditionKeys withArguments:arguments orVAList:nil];
}

- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withVAList:(va_list)args
{
    return [self removeObjectForConditionKeys:conditionKeys withArguments:nil orVAList:args];
}

- (BOOL)removeObjectForConditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args
{
    __block BOOL result = NO;
    mdf_safeSyncInDBQueue(^{
        NSString *fieldResult = [self stringForKeys:conditionKeys componentsSeparatedByString:@" AND"];
        if (fieldResult) {
            if (arguments) {
                result = [self.database executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", tableNameForNameSpace(self.nameSpace), conditionKeys] withArgumentsInArray:arguments];
            } else if (args) {
                result = [self.database executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", tableNameForNameSpace(self.nameSpace), conditionKeys] withVAList:args];
            }
        }
    });
    return result;
}

- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys, ...
{
    va_list args;
    va_start(args, conditionKeys);
    
    BOOL result = [self isExistObjectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
    
    va_end(args);
    return result;
}

- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments
{
    return [self isExistObjectForKeys:keys conditionKeys:conditionKeys withArguments:arguments orVAList:nil];
}

- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withVAList:(va_list)args
{
    return [self isExistObjectForKeys:keys conditionKeys:conditionKeys withArguments:nil orVAList:args];
}

- (BOOL)isExistObjectForKeys:(NSString *)keys conditionKeys:(NSString *)conditionKeys withArguments:(NSArray *)arguments orVAList:(va_list)args
{
    __block BOOL result = NO;
    mdf_safeSyncInDBQueue(^{
        NSString *fieldResult = [self stringForKeys:conditionKeys componentsSeparatedByString:@" AND"];
        FMResultSet *rs;
        if (fieldResult) {
            if (arguments) {
                rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", keys, tableNameForNameSpace(self.nameSpace), fieldResult] withArgumentsInArray:arguments];
            } else if (args) {
                rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", keys, tableNameForNameSpace(self.nameSpace), fieldResult] withVAList:args];
            }
        } else {
            rs = [self.database executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM %@", keys, tableNameForNameSpace(self.nameSpace)]];
        }
        if ([rs next]) {
            result = YES;
            [rs close];
        }
    });
    return result;
}

- (NSString *)stringForKeys:(NSString *)keys componentsSeparatedByString:(NSString *)byString
{
    NSString *keyStr = nil;
    if (keys) {
        NSArray *array = [keys componentsSeparatedByString:@","];
        if ([array count] > 0) {
            for (int i = 0; i < [array count]; i++) {
                if (0 == i) {
                    keyStr = [NSString stringWithFormat:@"%@ = ?", [array mdf_safeObjectAtIndex:i]];
                } else {
                    keyStr = [NSString stringWithFormat:@"%@ %@ = ?", byString, [array mdf_safeObjectAtIndex:i]];
                }
            }
        }
    }
    return keyStr;
}

@end
