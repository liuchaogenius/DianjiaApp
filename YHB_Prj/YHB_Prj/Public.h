//
//  QSS_Public.h
//  Quansoso
//
//  Created by  striveliu on 14-9-13.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#ifndef Public_h
#define Public_h

#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kBaseUrl @"http://115.28.136.170:8080/sapi4app.html"
#define kHubRequestUrl(path,outUrl) do{\
  outUrl = [NSString stringWithFormat:@"%@%@",kHubBaseUrl,path];\
}while(0)
#define isNull(a) [a isKindOfClass:[NSNull class]]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]

#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define kSofterViewsion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#ifdef DEBUG
#define MLOG(...)  printf("\n\t<%s line%d>\n%s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])

#else
#define MLOG(...)
#define NSLog(...) {}
#endif

#define kViewBackgroundColor RGBCOLOR(238,238,238) // 所有屏幕底色
#define kTabbarBackgroundColor RGBCOLOR(249,249,249) //tabbar的背景色
#define kIconNorColor RGBCOLOR(153,153,153) //所有icon未选中的颜色
#define kIconSelectColor RGBCOLOR(255,152,1) //所有icon选中的颜色
#define kLineColor RGBCOLOR(204,204,204) //所有线条的颜色

#define kClearColor [UIColor clearColor]

#define kCreateLabel(outLabel,aRect,aFontsize,aColor,aContent) do{\
UILabel *label = [[UILabel alloc] initWithFrame:aRect];\
label.backgroundColor = [UIColor clearColor];\
label.font = [UIFont systemFontOfSize:aFontsize];\
label.textColor = aColor;\
label.text = aContent;\
outLabel = label;\
}while(0)

#define kCreateImgView(outImgView,aFrame,aImg) do{\
UIImageView *imgView = [[UIImageView alloc] initWithFrame:aFrame];\
if (aImg){\
imgView.image = aImg;\
}\
outImgView = imgView;\
}while(0)

#define kFont10 [UIFont systemFontOfSize:10]
#define kFont11 [UIFont systemFontOfSize:11]
#define kFont12 [UIFont systemFontOfSize:12]
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont14 [UIFont systemFontOfSize:14]
#define kFont15 [UIFont systemFontOfSize:15]
#define kFont16 [UIFont systemFontOfSize:16]
#define kFont17 [UIFont systemFontOfSize:17]
#define kFont18 [UIFont systemFontOfSize:18]
#define kFont19 [UIFont systemFontOfSize:19]
#define kFont20 [UIFont systemFontOfSize:20]
#define kFont21 [UIFont systemFontOfSize:21]
#define kFont22 [UIFont systemFontOfSize:22]
#define kFont23 [UIFont systemFontOfSize:23]
#define kFont24 [UIFont systemFontOfSize:24]
#define kFont25 [UIFont systemFontOfSize:25]
#define kFont26 [UIFont systemFontOfSize:26]
#define kFont27 [UIFont systemFontOfSize:27]
#define kFont28 [UIFont systemFontOfSize:28]
#define kFont29 [UIFont systemFontOfSize:29]
#define kFont30 [UIFont systemFontOfSize:30]

#define kFontBold13 [UIFont fontWithName:@"Helvetica-Bold" size:13]
#define kFontBold15 [UIFont fontWithName:@"Helvetica-Bold" size:15]
#define kFontBold17 [UIFont fontWithName:@"Helvetica-Bold" size:17]
#define kFontBold18 [UIFont fontWithName:@"Helvetica-Bold" size:18]
#define kFontBold19 [UIFont fontWithName:@"Helvetica-Bold" size:19]
#define kFontBold20 [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define kFontBold21 [UIFont fontWithName:@"Helvetica-Bold" size:21]
#define kFontBold22 [UIFont fontWithName:@"Helvetica-Bold" size:22]
#define kFontBold23 [UIFont fontWithName:@"Helvetica-Bold" size:23]
#define kFontBold24 [UIFont fontWithName:@"Helvetica-Bold" size:24]
#define kFontBold25 [UIFont fontWithName:@"Helvetica-Bold" size:25]

#define kStringIsNotEmpty(aBool, str) do{\
if (!str) {\
aBool=false;\
} else {\
NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];\
NSString *trimedString = [str stringByTrimmingCharactersInSet:set];\
if ([trimedString length] == 0) {\
aBool=false;\
} else {\
aBool=true;\
}\
}\
}while(0)

#define kNSUDefaultSaveVauleAndKey(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define kNSUDefaultReadKey(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define kSafeid(id)  do{\
if(id)\
{\
id = nil;\
}\
}while(0)
#define kIntToString(str,a) do{\
str = [NSString stringWithFormat:@"%d", a];\
}while(0)

#define kFloatToString(str,a) do{\
str=[NSString stringWithFormat:@"%.2f", a];\
}while(0)

#define BaseLongLongToNSString(l){\
id V = [NSString stringWithFormat:@"%lld",[l longLongValue]];\
l = (V && !isNull(V) ? V : nil); \
}while(0)

#define BaseIntToNSString(l){\
id V = [NSString stringWithFormat:@"%d",[l intValue]];\
l = (V && !isNull(V) ? V : nil); \
}while(0)

#define BaseFloadToNSString(l){\
id V = [NSString stringWithFormat:@"%.2f",[l floatValue]];\
l = (V && !isNull(V) ? V : nil); \
}while(0)

#define AssignMentID(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? V : nil); \
} while(0)

#define AssignMentNSNumber(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V intValue] : 0); \
} while(0)

#define AssignMentNSNumberLong(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V longValue] : 0); \
} while(0)

#define AssignMentNSNumberFloat(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V floatValue] : 0); \
} while(0)

#define AssignMentNSNumberBool(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V boolValue] : 0); \
} while(0)

#define AssignMentNSNumberDouble(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V doubleValue] : 0); \
} while(0)

#define AssignMentNSNumberLonglong(l, r) do { \
id V = (r); \
l = (V && !isNull(V) ? [V longLongValue] : 0); \
} while(0)

#define PacketDictObject(i,dict,key) do { \
if(i) { \
[dict setObject:i forKey:key]; }\
}while(0)



#define PacketDictNumberInt(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithInt:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define PacketDictNumberFloat(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithFloat:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define PacketDictNumberDouble(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithDouble:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define PacketDictNumberBool(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithBool:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define PacketDictNumberLong(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithLong:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define PacketDictNumberLongLong(i, dict,key) do { \
NSNumber *iNum = [NSNumber numberWithLongLong:i];\
[dict setObject:iNum forKey:key]; \
}while(0)

#define KColor kIconSelectColor//RGBCOLOR(225, 44, 25)

#endif
