//
//  BinaryDataWriter.m
//  BinaryData
//
//  Copyright (C) 2015 Patrick Dockhorn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CCHBinaryDataWriter.h"

@interface CCHBinaryDataWriter()

@property (nonatomic) NSMutableData *data;
@property (assign) NSUInteger capacity;
@property (nonatomic, getter = isBigEndian) BOOL bigEndian;

@end

@implementation CCHBinaryDataWriter

- (instancetype)init
{
    return [self initWithCapacity:64 andOptions:0];
}

- (instancetype)initWithCapacity:(NSUInteger)cap
{
    return [self initWithCapacity:cap andOptions:0];
}


- (instancetype)initWithCapacity:(NSUInteger)cap andOptions:(CCHBinaryDataOptions)options
{
    self = [super init];
    if (self)
    {
        self.data = [[NSMutableData alloc] initWithCapacity:cap];
        self.bigEndian = (options & CCHBinaryDataBigEndian) != 0;
        self.capacity = cap;
    }
    return self;
}


- (void)reset
{
       self.data = [[NSMutableData alloc] initWithCapacity:self.capacity];
}

/** Adds a char (byte) to the buffer */
- (void)addByte:(unsigned char)thebyte
{
    unsigned char thebytebuf[1];
  
    thebytebuf[0] = thebyte;
    
    [self.data appendBytes:thebytebuf length:1];
}


/** Adds a two byte unsigned int to the buffer */
- (void)addShort:(unsigned short)theshort
{
    [self addLong:(unsigned long)theshort withLength:sizeof(unsigned short)/sizeof(unsigned char)];
}


/** Adds a four byte unsigned int to the buffer */
- (void)addInt:(unsigned int)theint
{
   [self addLong:(unsigned long)theint withLength:sizeof(unsigned int)/sizeof(unsigned char)];
}


/** Adds an eight byte long to the buffer */
-(void)addLong:(unsigned long long)thelong
{
    [self addLong:thelong withLength:sizeof(unsigned long long)/sizeof(unsigned char)];
}

/** Adds an eight byte long to the buffer */
-(void)addLong:(unsigned long long)thelong withLength:(NSUInteger)len
{
    unsigned long long ull = thelong;
    unsigned char *ucp = (unsigned char *) &ull;

    for (int i = 0 ; i < len ; i++)
    {
        if (!self.isBigEndian)
        {
            [self addByte:(unsigned char)*(ucp+i)];
        }
        else
        {
            [self addByte:(unsigned char)*(ucp+len-i-1)];
        }
    }
}


/**
 Adds a string with the given encoding until the value '\0' is encountered.
 @param string the string
 @param encoding string encoding
 */
- (void)addString:(NSString*)string withEncoding:(NSStringEncoding)encoding
{
    [self.data appendData:[string dataUsingEncoding:encoding]];
}


@end
