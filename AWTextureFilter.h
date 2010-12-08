/*
 * AWSuite: http://forzefield.com
 *
 * Copyright (c) 2010 ForzeField Studios S.L.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */


#import "CCTexture2DMutable.h"

@interface AWTextureFilter : NSObject {}

/**
//	@param input: Original texture data
//	@param output: Empty (or not) buffer
//  @param format: Pixel format of the data
//	@param width: Real width (is a power of two)
//	@param height: Real height (is a power of two)
//	@param position: Top left vertex of the blur effect
//	@param size: The size of the blur effect
//	@param contentSize: 
//	@param radios: It's the radius of the blur effect
**/   

+ (void) blurInput:(void*)input output:(void*)output format:(CCTexture2DPixelFormat)format width:(int)width height:(int)height contentSize:(CGSize)contentSize radius:(int)radius rect:(CGRect)rect;
+ (CCTexture2DMutable*) blur:(CCTexture2DMutable*)texture radius:(int)radius rect:(CGRect)rect;
+ (CCTexture2DMutable*) blur:(CCTexture2DMutable*)texture radius:(int)radius;

@end
