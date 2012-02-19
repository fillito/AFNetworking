/* 
 Copyright 2012 Javier Soto (ios@javisoto.es)
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License. 
 */

#import "AFImageCache+AlternativeImageCacheForAFNetworking.h"

#import "EGOCache.h"

#define kImageCacheDurationInSeconds 1296000 // 15 days

static inline NSString * AFImageCacheKeyFromURLAndCacheName(NSURL *url, NSString *cacheName) {
    NSMutableString *cacheKeyName = [[[url absoluteString] mutableCopy] autorelease];
    if (cacheName)
    {
        [cacheKeyName appendFormat:@"#%@", cacheName];
    }
    
    return [cacheKeyName stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
}

@implementation AFImageCache (AlternativeImageCacheForAFNetworking)

- (void)cacheImageData:(NSData *)data forKey:(NSString *)key
{
    [[EGOCache currentCache] setData:data forKey:key withTimeoutInterval:kImageCacheDurationInSeconds];
}

- (NSData *)cachedImageDataForKey:(NSString *)key
{
    return [[EGOCache currentCache] dataForKey:key];
}

- (UIImage *)cachedImageForURL:(NSURL *)url cacheName:(NSString *)cacheName
{
    return [UIImage imageWithData:[self cachedImageDataForKey:AFImageCacheKeyFromURLAndCacheName(url, cacheName)]];
}

- (void)cacheImageData:(NSData *)imageData forURL:(NSURL *)url cacheName:(NSString *)cacheName
{
    [self cacheImageData:imageData forKey:AFImageCacheKeyFromURLAndCacheName(url, cacheName)];
}

@end
