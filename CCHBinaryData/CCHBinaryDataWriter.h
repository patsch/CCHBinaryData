//
//  BinaryDataWriter.h
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


#import "CCHBinaryData.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Reads data from binary input.
 */
@interface CCHBinaryDataWriter : NSObject

/** Binary data used for writing */
@property (nonatomic, readonly) NSMutableData *data;

/** Endianess of multi-byte values. */
@property (nonatomic, getter = isBigEndian, readonly) BOOL bigEndian;

/** default initializer */
- (instancetype)init;

/**
 Initializes the writer with a given capacity
 @param cap the inititial capacity of the buffer
 */
- (instancetype)initWithCapacity:(NSUInteger)cap;

/**
 Initializes the writer with a given capacity
 @param cap the inititial capacity of the buffer
 @param options changes behavior of this class
 */
- (instancetype)initWithCapacity:(NSUInteger)cap andOptions:(CCHBinaryDataOptions)options;


/**
 Resets the output buffer
 */
- (void)reset;

/** Adds a char (byte) to the buffer */
- (void)addByte:(unsigned char)thebyte;


/** Adds a two byte unsigned int to the buffer */
- (void)addShort:(unsigned short)theshort;

/** Adds a four byte unsigned int to the buffer */
- (void)addInt:(unsigned int)theint;

/** Adds an eight byte long to the buffer */
-(void)addLong:(unsigned long long)thelong;


/**
 Adds a string with the given encoding until the value '\0' is encountered.
 @param string the string
 @param encoding string encoding
 */
- (void)addString:(NSString*)string withEncoding:(NSStringEncoding)encoding;

@end

NS_ASSUME_NONNULL_END