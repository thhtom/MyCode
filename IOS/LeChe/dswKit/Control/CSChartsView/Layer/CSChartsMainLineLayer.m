//
//  CSChartsMainLineLayer.m
//  ImgGetter
//
//  Created by 沈凯 on 14-3-4.
//  Copyright (c) 2014年 CruiseShen. All rights reserved.
//

#import "CSChartsMainLineLayer.h"
#import "NSString+BoundingRect.h"
#import "CSChartsPoint.h"

@implementation CSChartsMainLineLayer

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];

    // 绘制主线条
    [self drawMainLines:ctx];

    // 绘制点
    [self drawPoints:ctx];

    // 绘制detail
    [self drawDetailRect:ctx];
}

- (void)drawDetailRect:(CGContextRef)ctx {
    NSArray *pointArray = self.charts.mainLine.pointArray;

    for (int i = 0; i < pointArray.count; i++) {
        CSChartsPoint *tempPoint = [pointArray objectAtIndex:i];

        if (tempPoint.shouldShowDetail) {
            CGFloat detailRectWidth = self.charts.mainLine.detailRect.size.width;
            CGFloat detailRectHeight = self.charts.mainLine.detailRect.size.height;
            CGPoint detailRectPoint = [self calculateDetalRectPosition:self.charts->points[i]];
            CGFloat detailRectX = detailRectPoint.x;
            CGFloat detailRectY = detailRectPoint.y;
            // draw detail rect
            // set line color
            CGContextSetFillColorWithColor(ctx, self.charts.mainLine.detailRect.color.CGColor);
            // set fill rect
            CGContextBeginPath(ctx);
            // set 4 points for the rect
            // 1
            CGContextMoveToPoint(ctx, detailRectX, detailRectY);
            // 2
            CGContextAddLineToPoint(ctx, detailRectX + detailRectWidth, detailRectY);
            // 3
            CGContextAddLineToPoint(ctx, detailRectX + detailRectWidth, detailRectY + detailRectHeight);
            // 4
            CGContextAddLineToPoint(ctx, detailRectX, detailRectY + detailRectHeight);

            CGContextClosePath(ctx);
            // commit draw
            CGContextFillPath(ctx);

            // draw detail rect triangle
            // set line color
            CGContextSetFillColorWithColor(ctx, self.charts.mainLine.detailRect.color.CGColor);
            // set fill triangle
            CGContextBeginPath(ctx);
            // set 3 points for the triangle
            CGFloat point1Y = detailRectY - self.charts->points[i].y < 0 ? self.charts->points[i].y - CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING : self.charts->points[i].y + CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING;
            CGFloat point2Y = detailRectY - self.charts->points[i].y < 0 ? detailRectY + detailRectHeight - 1 : detailRectY + 1;
            // 1
            CGContextMoveToPoint(ctx, self.charts->points[i].x, point1Y);
            // 2
            CGContextAddLineToPoint(ctx, self.charts->points[i].x - 6, point2Y);
            // 3
            CGContextAddLineToPoint(ctx, self.charts->points[i].x + 6, point2Y);

            CGContextClosePath(ctx);
            // commit draw
            CGContextFillPath(ctx);

            // draw detail text
            // set Anti alias
            CGContextSetShouldAntialias(ctx, YES);
            CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
            UIGraphicsPushContext(ctx);

            NSString    *drawString = [NSString stringWithFormat:self.charts.mainLine.detailRect.textFormat, tempPoint.y];
            CGSize      drawStringSize = [drawString boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.charts.mainLine.detailRect.font withLineSpacing:3];
            NSString    *unitString = self.charts.mainLine.detailRect.unitString;
            CGSize      unitStringSize = [unitString boundingRectWithSize:CGSizeMake(200, 200) withTextFont:self.charts.mainLine.detailRect.unitFont withLineSpacing:3];

            // draw characters
            [drawString drawAtPoint:CGPointMake(detailRectX + (detailRectWidth - drawStringSize.width - unitStringSize.width) / 2, detailRectY + (detailRectHeight - drawStringSize.height) / 2) withAttributes:@{NSFontAttributeName :self.charts.mainLine.detailRect.font, NSForegroundColorAttributeName:[UIColor whiteColor]}];

            // draw unit

            [unitString drawAtPoint:CGPointMake(detailRectX + (detailRectWidth - drawStringSize.width - unitStringSize.width) / 2 + drawStringSize.width, detailRectY + (detailRectHeight - unitStringSize.height) / 2) withAttributes:@{NSFontAttributeName :self.charts.mainLine.detailRect.unitFont, NSForegroundColorAttributeName:[UIColor whiteColor]}];

            UIGraphicsPopContext();
        }
    }
}

- (void)drawPoints:(CGContextRef)ctx {
    NSArray *pointArray = self.charts.mainLine.pointArray;

    for (int i = 0; i < pointArray.count; i++) {
        // set line width

        CGContextSetLineWidth(ctx, 1.8);
        // set line color
        CGContextSetStrokeColorWithColor(ctx, self.charts.mainLine.color.CGColor);
        // draw points
        CSChartsPoint *tempPoint = [pointArray objectAtIndex:i];

        if (tempPoint.pointStyle == CSChartsPointStyleSolid) {
            // draw solid point
            CGContextSetFillColorWithColor(ctx, self.charts.mainLine.color.CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 3, 0, 360, 0);
            CGContextStrokePath(ctx);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 3, 0, 360, 0);
            CGContextFillPath(ctx);
        } else if (tempPoint.pointStyle == CSChartsPointStyleHollow) {
            // draw hollow point
            CGContextSetFillColorWithColor(ctx, self.charts.mainLine.color.CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 3, 0, 360, 0);
            CGContextStrokePath(ctx);
            CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 3, 0, 360, 0);
            CGContextFillPath(ctx);
        } else if (tempPoint.pointStyle == CSChartsPointStyleSolidWhite) {
            // draw SolidWhite point
            CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 6, 0, 360, 0);
            CGContextFillPath(ctx);
            CGContextSetFillColorWithColor(ctx, tempPoint.color.CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 4, 0, 360, 0);
            CGContextFillPath(ctx);
        } else if (tempPoint.pointStyle == CSChartsPointStyleSolidWhiteBorder) {
            // draw SolidWhiteBorder point
            CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 6, 0, 360, 0);
            CGContextFillPath(ctx);
            CGContextSetFillColorWithColor(ctx, tempPoint.color.CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 3, 0, 360, 0);
            CGContextFillPath(ctx);
            CGContextSetStrokeColorWithColor(ctx, tempPoint.color.CGColor);
            CGContextAddArc(ctx, self.charts->points[i].x, self.charts->points[i].y, 6, 0, 360, 0);
            CGContextStrokePath(ctx);
        }
    }
}

#pragma mark - private
- (CGPoint)calculateDetalRectPosition:(CGPoint)point {
    CGFloat detailRectWidth = self.charts.mainLine.detailRect.size.width;
    CGFloat detailRectHeight = self.charts.mainLine.detailRect.size.height;
    CGFloat detailRectX = point.x - detailRectWidth / 2;

    if (detailRectX < 10) {
        detailRectX = 10;
    } else if (detailRectX + detailRectWidth > self.charts.frame.size.width - 10) {
        detailRectX = self.charts.frame.size.width - 2 - detailRectWidth;
    }

    CGFloat detailRectY = point.y - detailRectHeight / 3 - CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING - detailRectHeight;

    if (detailRectY < 0) {
        detailRectY = point.y + CSCHARTS_DETAILRECT_FROM_MAINLINE_SPACING + 10;
    }

    return CGPointMake(detailRectX, detailRectY);
}

#pragma mark -- draw method

// 绘制折线
- (void)drawMainLines:(CGContextRef)ctx {
    NSArray *pointArray = self.charts.mainLine.pointArray;
    CGFloat allLeftSpacing = xOrign;

    // set line width
    CGContextSetLineWidth(ctx, self.charts.mainLine.lineWidth);
    // set anti alias off
    CGContextSetShouldAntialias(ctx, YES);
    // set line color
    CGContextSetStrokeColorWithColor(ctx, self.charts.mainLine.color.CGColor);

    CSChartsPoint *curPoint;

    for (int i = 0; i < pointArray.count; i++) {
        curPoint = [pointArray objectAtIndex:i];
        CGFloat percentOfHeight = (yAxisMax - curPoint.y) / (yAxisMax - yAxisMin);
        self.charts->points[i].y = topSpacing + chartsContentHeight * percentOfHeight;
        self.charts->points[i].x = allLeftSpacing + curPoint.x * verticalSpacing;
    }

    CGContextAddLines(ctx, self.charts->points, pointArray.count);
    // commit draw
    CGContextStrokePath(ctx);
}

@end
