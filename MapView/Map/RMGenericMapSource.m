//
//  RMGenericMapSource.m
//
// Copyright (c) 2008-2012, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "RMGenericMapSource.h"

@implementation RMGenericMapSource
{
    NSString *_host, *_uniqueTilecacheKey;
}

- (id)initWithHost:(NSString *)host tileCacheKey:(NSString *)tileCacheKey minZoom:(float)minZoom maxZoom:(float)maxZoom
{
    if (!(self = [super init]))
        return nil;

    NSAssert(host != nil, @"Empty host parameter not allowed");
    NSAssert(tileCacheKey != nil, @"Empty tileCacheKey paramter not allowed");

    _host = host;
    _uniqueTilecacheKey = tileCacheKey;

    self.minZoom = minZoom;
    self.maxZoom = maxZoom;

    return self;
}

- (void)dealloc
{
     _uniqueTilecacheKey = nil;
     _host = nil;
}

- (NSURL *)URLForTile:(RMTile)tile
{
    NSAssert4(((tile.zoom >= self.minZoom) && (tile.zoom <= self.maxZoom)),
              @"%@ tried to retrieve tile with zoomLevel %d, outside source's defined range %f to %f",
              self, tile.zoom, self.minZoom, self.maxZoom);

    return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%d/%d/%d.png", _host, tile.zoom, tile.x, tile.y]];
}

- (NSString *)uniqueTilecacheKey
{
    return _uniqueTilecacheKey;
}

- (NSString *)shortName
{
	return @"Generic Map Source";
}

- (NSString *)longDescription
{
	return @"Generic Map Source";
}

- (NSString *)shortAttribution
{
	return @"n/a";
}

- (NSString *)longAttribution
{
	return @"n/a";
}

@end
