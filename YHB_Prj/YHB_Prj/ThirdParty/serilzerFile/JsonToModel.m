//
//  JsonToModel.m
//  Json2ModelDemo
//
//  Created by striveliu on 14-7-24.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import "JsonToModel.h"
#import <objc/runtime.h>
#define kClassType  @"class_type"
#define kValueKey   @"valueKey"
typedef NS_ENUM(NSInteger, JsonToModelDataType)
{
    JsonToModelDataTypeObject    = 0,
    JsonToModelDataTypeBOOL      = 1,
    JsonToModelDataTypeInteger   = 2,
    JsonToModelDataTypeFloat     = 3,
    JsonToModelDataTypeDouble    = 4,
    JsonToModelDataTypeLong      = 5,
    JsonToModelDataTypeNSString  = 6,
    JsonToModelDataTypeNSDictory = 7,
    JsonToModelDataTypeNSArray   = 8,
    JsonToModelDataTypeNSSet     = 9,
    JsonToModelDataTypeNSData    = 10,
    JsonToModelDataTypeNSNumber  = 17,
    JsonToModelDataTypeNSMutableString  = 11,
    JsonToModelDataTypeNSMutableDictory = 12,
    JsonToModelDataTypeNSMutableArray   = 13,
    JsonToModelDataTypeNSMutableSet     = 14,
    JsonToModelDataTypeNSMutableData    = 15,
    JsonToModelDataTypeCustomObject = 16
};

@implementation JsonToModel
#pragma mark  id序列号成字典
+ (NSDictionary *)dictionaryFromObject:(id)object key:(NSString *)aKey
{
    if (object == nil) {
        return nil;
    }
    NSMutableDictionary *baseValue = [JsonToModel baseObject:object key:aKey];
    if(baseValue && baseValue.count>0)
    {
        return baseValue;
    }
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *propertyAndValues = [[NSMutableDictionary alloc] init];
    [propertyAndValues setObject:@"cutomClass" forKey:kClassType];
    @try {
        NSString *className = NSStringFromClass([object class]);
        id classObject = objc_getClass([className UTF8String]);
        
        unsigned int count = 0;
        Ivar *properties = class_copyIvarList(classObject, &count);
        
        for (int i = 0; i < count; i++)
        {
            Ivar property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
            id propertyValue = nil;
            id valueObject = [object valueForKey:propertyName];
            const char *cEncodingType = ivar_getTypeEncoding(property);
            NSString *strEncodingType = [NSString stringWithUTF8String:cEncodingType];
            NSLog(@"encodeType = %@", strEncodingType);
            fprintf(stdout, "propertyname=%s\n", ivar_getName(property));
            JsonToModelDataType rtype = [JsonToModel invarEncodingType:strEncodingType];
            if ([valueObject isKindOfClass:[NSDictionary class]])
            {
                propertyValue = [JsonToModel serializeNSDictory:valueObject key:aKey];
            }
            else if ([valueObject isKindOfClass:[NSArray class]])
            {
                propertyValue = [JsonToModel serializeNSArray:valueObject key:aKey];
            }
            else if([valueObject isKindOfClass:[NSSet class]])
            {
                propertyValue = [valueObject allObjects];
                propertyValue = [JsonToModel serializeNSArray:propertyValue key:aKey];
            }
            else if([valueObject isKindOfClass:[NSData class]])
            {
                propertyValue = [NSData dataWithData:valueObject];
            }
            else if([valueObject isKindOfClass:[NSString class]])
            {
                propertyValue = [NSString stringWithFormat:@"%@",[object valueForKey:propertyName]];
            }
            else if(rtype == JsonToModelDataTypeCustomObject)//自定义类
            {
                NSDictionary *resultDict = [JsonToModel dictionaryFromObject:valueObject key:aKey];
                propertyValue = [NSDictionary dictionaryWithDictionary:resultDict];
            }
            else
            {
                propertyValue = [NSString stringWithFormat:@"%@",[object valueForKey:propertyName]];
            }
            
            [propertyAndValues setObject:propertyValue forKey:propertyName];
            [resultDict setObject:propertyAndValues forKey:aKey];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return [resultDict copy];
    }
}

+ (NSMutableDictionary *)baseObject:(id)object key:(NSString *)aKey
{
    NSMutableDictionary *propertyAndValues = [[NSMutableDictionary alloc] init];
    id propertyValue = nil;
    if ([object isKindOfClass:[NSDictionary class]])
    {
        [propertyAndValues setObject:@"NSDictionary" forKey:kClassType];
        propertyValue = [JsonToModel serializeNSDictory:object key:aKey];
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
        propertyValue = [JsonToModel serializeNSArray:object key:aKey];
    }
    else if([object isKindOfClass:[NSSet class]])
    {
        [propertyAndValues setObject:@"NSSet" forKey:kClassType];
        propertyValue = [object allObjects];
        propertyValue = [JsonToModel serializeNSArray:propertyValue key:aKey];
    }
    else if([object isKindOfClass:[NSData class]])
    {
        [propertyAndValues setObject:@"NSData" forKey:kClassType];
        propertyValue = [NSData dataWithData:object];
    }
    else if([object isKindOfClass:[NSString class]])
    {
        [propertyAndValues setObject:@"NSString" forKey:kClassType];
        propertyValue = [NSString stringWithFormat:@"%@",object];
    }
    if(propertyValue)
    {
        [propertyAndValues setObject:propertyValue forKey:aKey];
    }
    else
    {
        return nil;
    }
    return propertyAndValues;
}

+ (NSMutableDictionary *)serializeNSDictory:(NSDictionary *)aDict key:(NSString *)aKey
{
    NSMutableDictionary *properAndValues = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableDictionary *valueDict = [NSMutableDictionary dictionary];
    if(aDict)
    {
        NSArray *keyArry = [aDict allKeys];
        
        for(NSString *key in keyArry)
        {
            id value = aDict[key];
            NSString *className = NSStringFromClass([value class]);
            BOOL iscustom = NO;
            NSString *strClasstype = [JsonToModel ctypeForClassName:className isCustomObject:&iscustom];
            if(iscustom == NO)
            {
                if([strClasstype compare:@"NSArray"] == 0 ||
                   [strClasstype compare:@"NSMutableArray"] == 0)
                {
                    id arryValue = [JsonToModel serializeNSArray:value key:aKey];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:arryValue forKey:kValueKey];
                    [dict setObject:@"NSMutableArray" forKey:kClassType];
                    [valueDict setValue:dict forKey:key];
                }
                else if([strClasstype compare:@"NSMutableDictionary"] == 0 ||
                        [strClasstype compare:@"NSDictionary"] == 0)
                {
                    id dictValue = [JsonToModel serializeNSDictory:value key:aKey];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:dictValue forKey:kValueKey];
                    [dict setObject:@"NSMutableDictionary" forKey:kClassType];
                    [valueDict setValue:dict forKey:key];
                }
                else if([strClasstype compare:@"NSSet"] == 0 ||
                        [strClasstype compare:@"NSMutableSet"] == 0)
                {
                    value = [value allObjects];
                    id arryValue = [JsonToModel serializeNSArray:value key:aKey];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:arryValue forKey:kValueKey];
                    [dict setObject:@"NSMutableArray" forKey:kClassType];
                    [valueDict setValue:dict forKey:key];
                }
                else
                {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict setObject:value forKey:kValueKey];
                    [dict setObject:strClasstype forKey:kClassType];
                    [valueDict setValue:dict forKey:key];
                }
            }
            else
            {
                id customValue = [JsonToModel dictionaryFromObject:value key:aKey];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:customValue forKey:kValueKey];
                [dict setObject:className forKey:kClassType];
                [valueDict setValue:dict forKey:key];
            }
        }
    }
    [properAndValues setObject:valueDict forKey:kValueKey];
    [properAndValues setObject:@"NSDictionary" forKey:kClassType];
    return properAndValues;
}

+ (NSMutableDictionary *)serializeNSArray:(NSArray *)aArry key:(NSString *)aKey
{
    NSMutableDictionary *properAndValues = [NSMutableDictionary dictionaryWithCapacity:0];
    if(aArry && aArry.count>0)
    {
        NSMutableArray *valueArry = [NSMutableArray array];
        for(int i=0;i<aArry.count; i++)
        {
            id value = aArry[i];
            NSMutableDictionary *arryIndexDict = [NSMutableDictionary dictionaryWithCapacity:0];
            NSString *className = NSStringFromClass([value class]);
            NSLog(@"classname = %@", className);
            BOOL iscustom = NO;
            NSString *strClasstype = [JsonToModel ctypeForClassName:className isCustomObject:&iscustom];
            if(iscustom == YES)
            {
                value = [JsonToModel dictionaryFromObject:value key:aKey];
            }
            [arryIndexDict setObject:strClasstype forKey:kClassType];
            [arryIndexDict setObject:value forKey:kValueKey];
            [valueArry addObject:arryIndexDict];
        }
        [properAndValues setObject:valueArry forKey:kValueKey];
        [properAndValues setObject:@"NSArray" forKey:kClassType];
    }
    return properAndValues;
}

+ (NSString*)ctypeForClassName:(NSString *)aClassName isCustomObject:(BOOL *)aCustom
{
    NSString *strClasstype = nil;
    if([aClassName compare:@"__NSCFConstantString"] == 0)
    {
        strClasstype = @"NSString";
    }
    else if([aClassName compare:@"__NSCFString"] == 0)
    {
        strClasstype = @"NSMutableString";
    }
    else if([aClassName compare:@"__NSArrayI"] == 0)
    {
        strClasstype = @"NSArray";
    }
    else if([aClassName compare:@"__NSArrayM"] == 0)
    {
        strClasstype = @"NSMutableArray";
    }
    else if([aClassName compare:@"__NSDictionaryI"] == 0)
    {
        strClasstype = @"NSDictionary";
    }
    else if([aClassName compare:@"__NSDictionaryM"] == 0)
    {
        strClasstype = @"NSMutableDictionary";
    }
    else if([aClassName compare:@"__NSSetI"] == 0)
    {
        strClasstype = @"NSSet";
    }
    else if([aClassName compare:@"__NSSetM"] == 0)
    {
        strClasstype = @"NSMutableSet";
    }
    else if([aClassName compare:@"_NSZeroData"] == 0 ||
            [aClassName compare:@"NSConcreteMutableData"] == 0)
    {
        strClasstype = @"NSMutableData";
    }
    else if([aClassName compare:@"__NSCFBoolean"] == 0 || [aClassName compare:@"__NSCFNumber"] == 0)
    {
        strClasstype = @"NSNumber";
    }
    else
    {
        strClasstype = aClassName;
        *aCustom = YES;
    }
    return strClasstype;
}
#pragma mark 从字典中读取数据
+ (id)objectFromDictionary:(NSDictionary *)dictionary
                 className:(NSString *)name
                       key:(NSString *)aKey
                     valid:(BOOL)isValid
{
    if (dictionary == nil || name == nil || name.length == 0) {
        return nil;
    }
    NSDictionary *dictValue = nil;
    if(isValid)
    {
        dictValue = dictionary;
    }
    else
    {
        dictValue = [dictionary objectForKey:aKey];
    }
    id resultObject = [JsonToModel deserializationObject:name dict:dictValue key:aKey];
    if(resultObject)
    {
        return resultObject;
    }
    id object = [[NSClassFromString(name) alloc]init];
    
    @try {
        id classObject = objc_getClass([name UTF8String]);
        
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList(classObject, &count);
        for (int i = 0; i < count; i ++)
        {
            NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            const char *type = ivar_getTypeEncoding(ivars[i]);
            NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            
            id propertyValue = [dictValue objectForKey:memberName];
            NSLog(@"Data %@ type: %@",memberName,dataType);
            
            JsonToModelDataType rtype = [JsonToModel invarEncodingType:dataType];

            propertyValue = [JsonToModel objectValue:rtype value:propertyValue key:aKey className:dataType];
            [object setValue:propertyValue forKey:memberName];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }@finally {
        return object;
    }
}

+ (id)deserializationObject:(NSString *)aClassType
                         dict:(NSDictionary *)aDict
                          key:(NSString*)aKey
{
    id resultVaule = nil;
   
    NSString *classType = [aDict objectForKey:kClassType];
    if([classType compare:@"NSArray"] == 0 || [classType compare:@"NSMutableArray"] == 0)
    {
        NSArray *valueArry = [aDict objectForKey:kValueKey];
        NSMutableArray *mutarry = [NSMutableArray array];
        for(NSDictionary *indexDict in valueArry)
        {
            NSString *strClassType = [indexDict objectForKey:kClassType];
            JsonToModelDataType rtype = [JsonToModel judegBaseNSObject:strClassType];
            if(rtype == JsonToModelDataTypeNSArray ||
               rtype == JsonToModelDataTypeNSMutableArray)
            {
                id idvalue= [JsonToModel deserializationObject:aClassType dict:indexDict key:aKey];
                [mutarry addObject:idvalue];
            }
            else if(rtype == JsonToModelDataTypeNSMutableString || rtype == JsonToModelDataTypeNSString)
            {
                [mutarry addObject:[indexDict objectForKey:kValueKey]];
            }
            else if(rtype == JsonToModelDataTypeCustomObject)//自定一类
            {
                id value = [JsonToModel objectFromDictionary:[indexDict valueForKey:kValueKey] className:strClassType key:aKey valid:NO];
                [mutarry addObject:value];
            }
            else ///基础类型
            {
                [mutarry addObject:[indexDict objectForKey:kValueKey]];
            }
        }
        resultVaule = mutarry;
    }
    else if([classType compare:@"NSDictionary"] == 0 ||
            [classType compare:@"NSMutableDictionary"] == 0)
    {
        NSMutableDictionary *dictValue = [NSMutableDictionary dictionaryWithCapacity:0];
        NSDictionary *dict = [aDict objectForKey:kValueKey];
        NSArray *keyArry = [dict allKeys];
        for (NSString *key in keyArry)
        {
            id keyValue = dict[key];
            NSString *strClassType = [keyValue objectForKey:kClassType];
            id valueDict = [keyValue objectForKey:kValueKey];
            JsonToModelDataType rtype = [JsonToModel judegBaseNSObject:strClassType];
            if(rtype == JsonToModelDataTypeNSArray ||
               rtype == JsonToModelDataTypeNSMutableArray)
            {
                id idvalue= [JsonToModel deserializationObject:aClassType dict:valueDict key:aKey];
                [dictValue setObject:idvalue forKey:key];
            }
            else if(rtype == JsonToModelDataTypeNSMutableString || rtype == JsonToModelDataTypeNSString)
            {
                [dictValue setObject:valueDict forKey:key];
            }
            else if(rtype == JsonToModelDataTypeNSDictory ||
                    rtype == JsonToModelDataTypeNSMutableDictory)
            {
                id idvalue= [JsonToModel deserializationObject:aClassType dict:valueDict key:aKey];
                [dictValue setObject:idvalue forKey:key];
            }
            else if(rtype == JsonToModelDataTypeCustomObject)///自定义类
            {
                id value = [JsonToModel objectFromDictionary:valueDict className:strClassType key:aKey valid:NO];
                [dictValue setObject:value forKey:key];
            }
            else //基础类
            {
                [dictValue setObject:valueDict forKey:key];
            }
        
        }
        resultVaule = dictValue;
    }
    else if([classType compare:@"NSString"] == 0 || [classType compare:@"NSMutableString"] == 0)
    {
        resultVaule = [aDict objectForKey:kValueKey];
    }
    else if([classType compare:@"NSSet"] == 0 || [classType compare:@"NSMutableSet"] == 0)
    {
        NSArray *valueArry = [aDict objectForKey:kValueKey];
        NSMutableArray *mutarry = [NSMutableArray array];
        for(NSDictionary *indexDict in valueArry)
        {
            NSString *strClassType = [indexDict objectForKey:kClassType];
            JsonToModelDataType rtype = [JsonToModel judegBaseNSObject:strClassType];
            if(rtype == JsonToModelDataTypeNSArray ||
               rtype == JsonToModelDataTypeNSMutableArray)
            {
                id idvalue= [JsonToModel deserializationObject:aClassType dict:indexDict key:aKey];
                [mutarry addObject:idvalue];
            }
            else if(rtype == JsonToModelDataTypeNSMutableString || rtype == JsonToModelDataTypeNSString)
            {
                [mutarry addObject:[indexDict objectForKey:kValueKey]];
            }
            else if(rtype == JsonToModelDataTypeCustomObject)//自定一类
            {
                id value = [JsonToModel objectFromDictionary:[indexDict valueForKey:kValueKey] className:strClassType key:aKey valid:NO];
                [mutarry addObject:value];
            }
            else ///基础类型
            {
                [mutarry addObject:[indexDict objectForKey:kValueKey]];
            }
        }
        NSMutableSet *set = [NSMutableSet setWithArray:mutarry];
        resultVaule = set;
    }
    else
    {
        resultVaule = [aDict objectForKey:kValueKey];
    }
    return resultVaule;
}

+ (JsonToModelDataType)judegBaseNSObject:(NSString *)aClassName
{
    if([aClassName compare:@"NSMutableDictionary"] == 0||
       [aClassName compare:@"NSArray"] == 0)
    {
        return JsonToModelDataTypeNSArray;
    }
    else if([aClassName compare:@"NSString"] == 0 ||
             [aClassName compare:@"NSMutableString"] == 0)
    {
        return JsonToModelDataTypeNSString;
    }
    else if([aClassName compare:@"NSDictionary"] == 0||
            [aClassName compare:@"NSMutableArray"] == 0)
    {
        return JsonToModelDataTypeNSDictory;
    }
    else if([aClassName compare:@"NSSet"] == 0||
            [aClassName compare:@"NSMutableSet"] == 0)
    {
        return JsonToModelDataTypeNSMutableSet;
    }
    else if([aClassName compare:@"NSData"] == 0||
       [aClassName compare:@"NSMutableData"] == 0)
    {
        return JsonToModelDataTypeNSData;
    }
    else if([aClassName compare:@"NSNumber"] == 0 || [aClassName compare:@"__NSCFBoolean"] == 0 || [aClassName compare:@"__NSCFNumber"] == 0)
    {
        return JsonToModelDataTypeNSNumber;
    }
    else
    {
        return JsonToModelDataTypeCustomObject;
    }
    return 0;
}
+ (JsonToModelDataType)invarEncodingType:(NSString *)aDataType
{
    JsonToModelDataType rtype = JsonToModelDataTypeObject;
    if([aDataType hasPrefix:@"@"])
    {
        if([aDataType compare:@"@\"NSDictionary\""] == 0)
        {
            rtype = JsonToModelDataTypeNSDictory;
        }
        else if([aDataType compare:@"@\"NSMutableDictionary\""] == 0)
        {
            rtype = JsonToModelDataTypeNSMutableDictory;
        }
        else if([aDataType compare:@"@\"NSString\""] == 0)
        {
            rtype = JsonToModelDataTypeNSString;
        }
        else if([aDataType compare:@"@\"NSMutableString\""] == 0)
        {
            rtype = JsonToModelDataTypeNSMutableString;
        }
        else if([aDataType compare:@"@\"NSArray\""] == 0)
        {
            rtype = JsonToModelDataTypeNSArray;
        }
        else if([aDataType compare:@"@\"NSMutableArray\""] == 0)
        {
            rtype = JsonToModelDataTypeNSMutableArray;
        }
        else if([aDataType compare:@"@\"NSSet\""] == 0)
        {
            rtype = JsonToModelDataTypeNSSet;
        }
        else if([aDataType compare:@"@\"NSMutableSet\""] == 0)
        {
            rtype = JsonToModelDataTypeNSMutableSet;
        }
        else if([aDataType compare:@"@\"NSData\""] == 0)
        {
            rtype = JsonToModelDataTypeNSData;
        }
        else if([aDataType compare:@"@\"NSMutableData\""] == 0)
        {
            rtype = JsonToModelDataTypeNSMutableData;
        }
        else if([aDataType compare:@"@\"NSNumber\""] == 0)
        {
            rtype = JsonToModelDataTypeNSNumber;
        }
        else
        {
            rtype = JsonToModelDataTypeCustomObject;
        }
    }
    else if ([aDataType hasPrefix:@"c"])
    {
        // BOOL
        rtype = JsonToModelDataTypeBOOL;
    }
    else if ([aDataType hasPrefix:@"i"])
    {
        // int
        rtype = JsonToModelDataTypeInteger;
    }
    else if ([aDataType hasPrefix:@"f"])
    {
        // float
        rtype = JsonToModelDataTypeFloat;
    }
    else if ([aDataType hasPrefix:@"d"])
    {
        // double
        rtype = JsonToModelDataTypeDouble;
    }
    else if ([aDataType hasPrefix:@"l"] || [aDataType hasPrefix:@"q"])
    {
        // long or long long
        rtype = JsonToModelDataTypeLong;
    }
    return rtype;
}

+ (id)objectValue:(JsonToModelDataType)aType
            value:(id)aPropertyValue
              key:(NSString *)aKey
        className:(NSString *)aClassName
{
    id propertyValue = nil;
    switch (aType) {
        case JsonToModelDataTypeNSString:
        {
            propertyValue = [NSString stringWithFormat:@"%@",aPropertyValue];
            break;
        }
        case JsonToModelDataTypeNSMutableString:
        {
            propertyValue = [NSMutableString stringWithFormat:@"%@",aPropertyValue];
            break;
        }
        case JsonToModelDataTypeNSDictory:
        case JsonToModelDataTypeNSMutableDictory:
        {
            propertyValue = [JsonToModel deserializationObject:aClassName dict:aPropertyValue key:aKey];//[NSDictionary dictionaryWithDictionary:aPropertyValue];
            break;
        }
        case JsonToModelDataTypeNSArray:
        case JsonToModelDataTypeNSMutableArray:
        {
            propertyValue = [JsonToModel deserializationObject:aClassName dict:aPropertyValue key:aKey];
            break;
        }
        case JsonToModelDataTypeNSSet:
        case JsonToModelDataTypeNSMutableSet:
        {
            propertyValue = [JsonToModel deserializationObject:aClassName dict:aPropertyValue key:aKey];
            break;
        }
        case JsonToModelDataTypeNSData:
        {
            propertyValue = [NSData dataWithData:aPropertyValue];
            break;
        }
        case JsonToModelDataTypeNSMutableData:
        {
            propertyValue = [NSMutableData dataWithData:aPropertyValue];
            break;
        }
        case  JsonToModelDataTypeNSNumber:
        {
            double temp = [[NSString stringWithFormat:@"%@",aPropertyValue] doubleValue];
            propertyValue = [NSNumber numberWithDouble:temp];
            break;
        }
        case JsonToModelDataTypeCustomObject:
        {
            NSDictionary *idDict = [NSDictionary dictionaryWithDictionary:aPropertyValue];
            NSRange rang;
            rang.location = 2;
            rang.length = aClassName.length-3;
            NSString *className = [aClassName substringWithRange:rang];
            propertyValue = [JsonToModel objectFromDictionary:idDict className:className key:aKey valid:YES];
            break;
        }
        case JsonToModelDataTypeBOOL:
        {
            BOOL temp = [[NSString stringWithFormat:@"%@",aPropertyValue] boolValue];
            propertyValue = [NSNumber numberWithBool:temp];
        }
            break;
        case JsonToModelDataTypeInteger:
        {
            int temp = [[NSString stringWithFormat:@"%@",aPropertyValue] intValue];
            propertyValue = [NSNumber numberWithInt:temp];
        }
            break;
        case JsonToModelDataTypeFloat:
        {
            float temp = [[NSString stringWithFormat:@"%@",aPropertyValue] floatValue];
            propertyValue = [NSNumber numberWithFloat:temp];
        }
            break;
        case JsonToModelDataTypeDouble:
        {
            double temp = [[NSString stringWithFormat:@"%@",aPropertyValue] doubleValue];
            propertyValue = [NSNumber numberWithDouble:temp];
        }
            break;
        case JsonToModelDataTypeLong:
        {
            long long temp = [[NSString stringWithFormat:@"%@",aPropertyValue] longLongValue];
            propertyValue = [NSNumber numberWithLongLong:temp];
        }
            break;
            
        default:
            break;
    }
    return propertyValue;
}

@end
