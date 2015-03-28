//
//  DocumentTool.m
//  HealthCare
//
//  Created by jewelz on 14-10-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "DocumentTool.h"

@implementation DocumentTool

//单例模式
static DocumentTool *document = nil;
+ (id)sharedDocumentTool
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        document = [[self alloc] init];
    });
    return document;
}


-(id)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    
    return self;
    
}

//写入一条记录
- (void) write:(NSDictionary *)dict ToFileWithFileName:(NSString *)name
{
    NSString *file = [NSString stringWithFormat:@"%@.plist", name];
    
    //获取沙盒目录
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _path = [document stringByAppendingPathComponent:file];
    
    if (!_path) {
        NSLog(@"目录未找到");
    }
    
    //拿到目录中的数组
    _array = [NSMutableArray arrayWithContentsOfFile:_path];
    
    //[_array addObject:dict];
    //将数据插入到最前面
    [_array insertObject:dict atIndex:0];

       //将新数据写到目录中
    BOOL su = [_array writeToFile:_path atomically:YES];
    if (!su) {
        
        NSMutableArray *array = [NSMutableArray array];
        [array insertObject:dict atIndex:0];
        [array writeToFile:_path atomically:YES];
        //NSLog(@"succeed");
    }
    
}

//删除一条记录
- (void)remove:(NSUInteger)index fromContentsOfFile:(NSString *)path
{
    _array = [NSMutableArray arrayWithContentsOfFile:path];
    //NSLog(@"delete row :%d, _array count: %d",index, _array.count);
    if (_array.count) {
        
        [_array removeObjectAtIndex:index];
        [_array writeToFile:path atomically:YES];
        // NSLog(@"array remove:%@",_array);
    }
    
    //NSLog(@"array count:%d",_array.count);
}

- (NSMutableArray *)openContentsOfDefaultFile
{
    return [NSMutableArray arrayWithContentsOfFile:_path];
}

- (NSMutableArray *)openContentsOfFile:(NSString *)path
{
   
   // NSMutableArray *array =
    return [NSMutableArray arrayWithContentsOfFile:path];
}

@end
