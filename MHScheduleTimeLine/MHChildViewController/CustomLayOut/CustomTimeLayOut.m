//
//  CustomTimeLayOut.m
//  MHScheduleTimeLine
//
//  Created by Melaniia Hulianovych on 11/17/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "CustomTimeLayOut.h"
#import "PositionModel.h"
#import "Program.h"
#import "MHParentController.h"

static CGFloat const kCellHalfHourHeight = 25.f;
static CGFloat const kCellProgramHeight = 65.f;
static NSInteger const kHalfHourMinutes = 30.f;
static NSInteger const kMinutesInHour = 60.f;


static NSString * const kProgramCollectionViewLayoutCellKind = @"ProgramCell";
static NSString * const kHalfHourCollectionViewLayoutCellKind = @"HalfHourCell";


@interface CustomTimeLayOut ()

@property (nonatomic) CGSize programItemSize;
@property (nonatomic) CGSize halfHourItemSize;
@property (readwrite, nonatomic, assign) NSInteger cellCountHalfHours;
@property (readwrite, nonatomic, assign) NSInteger cellCountPrograms;
@property (nonatomic, strong) NSMutableArray *xProgramFrames;
@property (nonatomic, weak) id <CustomTimeLayOutDelegate> delegate;

@end


@implementation CustomTimeLayOut

-(void)setUpWithHalfHourItems:(NSInteger)hItems andProgramItems:(NSInteger)pItems andArrayOfSchedules:(NSArray *)schedule {
    
    self.cellCountHalfHours = hItems;
    self.cellCountPrograms = pItems;
    self.halfHourItemSize = CGSizeMake(kHalfHourMinutes * kPixelsPerMinute, kCellHalfHourHeight);
    self.programItemSize = CGSizeMake(200.f, kCellProgramHeight);
    self.xProgramFrames = [self xPositionsForProgramLables:schedule];
}

- (id <CustomTimeLayOutDelegate> )delegate {
    return (id <CustomTimeLayOutDelegate> )self.collectionView.delegate;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellHalfHourLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellProgramLayoutInfo = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    
    for (NSInteger item = 0; item < self.cellCountHalfHours; item++) {
        indexPath = [NSIndexPath indexPathForItem:item inSection:1];
        
        UICollectionViewLayoutAttributes *itemAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        itemAttributes.frame = [self frameForItemAtIndexPath:indexPath];
        cellHalfHourLayoutInfo[indexPath] = itemAttributes;
    }
    newLayoutInfo[kProgramCollectionViewLayoutCellKind] = cellHalfHourLayoutInfo;
    for (NSInteger item = 0; item < self.cellCountPrograms; item++) {
        indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        
        UICollectionViewLayoutAttributes *itemAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        itemAttributes.frame = [self frameForItemAtIndexPath:indexPath];
        cellProgramLayoutInfo[indexPath] = itemAttributes;
    }
    
    newLayoutInfo[kHalfHourCollectionViewLayoutCellKind] = cellProgramLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemNumber = indexPath.item;
    
    NSIndexPath *newIndex = [NSIndexPath indexPathForItem:itemNumber inSection:indexPath.section];
    
    if(indexPath.section == 1) {
        return self.layoutInfo[kHalfHourCollectionViewLayoutCellKind][newIndex];
    }
    return self.layoutInfo[kProgramCollectionViewLayoutCellKind][newIndex];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return(YES);
}

#pragma mark - Private

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat originX;
    CGFloat originY = 0.f;
    CGFloat width;
    if(indexPath.section == 1) {
        originX = floorf(self.halfHourItemSize.width * indexPath.item);
        return CGRectMake(originX, originY, self.halfHourItemSize.width, self.halfHourItemSize.height);
    } else {
        originY = kCellHalfHourHeight;
        PositionModel *posCoordinates = self.xProgramFrames[indexPath.item];
        originX = floorf(posCoordinates.xStartPosition);
        width = floorf(posCoordinates.width);
    }
    return CGRectMake(originX, originY, width, self.programItemSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    if ([self.delegate respondsToSelector:@selector(layoutSubviewsWithAttributes:)]) {
        [self.delegate layoutSubviewsWithAttributes:allAttributes];
    }
    return allAttributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.cellCountHalfHours * self.halfHourItemSize.width, kCellProgramHeight + kCellHalfHourHeight);
}

-(NSMutableArray *)xPositionsForProgramLables:(NSArray *)array {
    NSMutableArray *schedule = [NSMutableArray new];
    for(int i = 0; i < array.count; i++) {
        Program *program = array[i];
        PositionModel *one = [PositionModel new];
        one.width = [program.endTime timeIntervalSinceDate:program.startTime] / kMinutesInHour * kPixelsPerMinute;
        one.xStartPosition = floorf([program.startTime timeIntervalSinceDate:self.startPoint] / kMinutesInHour * kPixelsPerMinute);
        [schedule addObject:one];
    }
    return schedule;
}

@end
