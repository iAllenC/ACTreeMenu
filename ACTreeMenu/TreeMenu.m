//
//  TreeMenu.m
//  TreeMenu
//
//  Created by Allen on 2018/3/19.
//  Copyright © 2018年 Cpsdna. All rights reserved.
//

#import "TreeMenu.h"
#import "UIButton+Add.h"

#define MENU_TITLE_HEIGHT 44

#define MENU_SUB_TITLE_HEIGHT 44

#define ANIMATION_DURATION 0.5
@class TreeMenuCell;

@protocol TreeMenuCellDelegate<NSObject>

- (void)treeMenuCellClicked:(TreeMenuCell *)menuCell;

@end

@interface TreeMenuCell: UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIImageView *arrow;

@property (nonatomic, weak) id<TreeMenuCellDelegate> delegate;

@end

@implementation TreeMenuCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)open {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:nil];
}

- (void)close {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.arrow.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)setup {
    CGFloat titleWidth = 120, subTitleWidth = 100, titleHeight = 20, imageWidth = 20, margin = 20;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - titleWidth)/2, (MENU_TITLE_HEIGHT - titleHeight)/2, titleWidth, titleHeight)];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - imageWidth - subTitleWidth - margin * 2, _titleLabel.frame.origin.y, subTitleWidth, titleHeight)];
    _subTitleLabel.font = [UIFont systemFontOfSize:10];
    _subTitleLabel.textAlignment = NSTextAlignmentRight;
    _subTitleLabel.textColor = [UIColor lightGrayColor];
    _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_icon_choose_arrow_n_4a"]];
    _arrow.frame = CGRectMake(SCREEN_WIDTH - imageWidth - margin, (MENU_TITLE_HEIGHT - imageWidth)/2, imageWidth, imageWidth);
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_subTitleLabel];
    [self.contentView addSubview:_arrow];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tapGR];
}

- (void)onTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(treeMenuCellClicked:)]) {
        [self.delegate treeMenuCellClicked:self];
    }
}


@end

@interface TreeMenuSubCell: UITableViewCell

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation TreeMenuSubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat numberWidth = 25, margin = 10, subWidth = 80, titleHeight = 20;
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, (self.frame.size.height - numberWidth) / 2, numberWidth, numberWidth)];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.layer.cornerRadius = numberWidth/2;
    _numberLabel.layer.masksToBounds = YES;
    _numberLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _numberLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:_numberLabel];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin * 2 + numberWidth, (self.frame.size.height - titleHeight)/2, SCREEN_WIDTH - margin * 4 - numberWidth - subWidth, titleHeight)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - subWidth - margin * 2, (self.frame.size.height - titleHeight)/2, subWidth, titleHeight)];
    _subTitleLabel.textAlignment = NSTextAlignmentRight;
    _subTitleLabel.font = [UIFont systemFontOfSize:10];
    _subTitleLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_subTitleLabel];
    
}

@end
@interface TreeMenu()<UITableViewDelegate, UITableViewDataSource, TreeMenuCellDelegate>

@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, strong) NSArray<PracticeCategory *> *categories;

@property (nonatomic, strong) TreeMenuCell *displayingMenuCell;

@end


@implementation TreeMenu

- (CGSize)intrinsicContentSize {
    return CGSizeMake(200, 44);
}

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView practiceCategories:(NSArray<PracticeCategory *> *)categories delegate:(id<TreeMenuDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        _delegate = delegate;
        _currentIndex = -1;
        _superView = superView;
        _categories = categories;
        _bgColor = [UIColor clearColor];
        _titleColor = [UIColor darkGrayColor];
        _titleFont = [UIFont boldSystemFontOfSize:16];
        _menuBGColor = [UIColor whiteColor];
        _menuFont = [UIFont systemFontOfSize:14];
        _menuColor = [UIColor darkGrayColor];
        _menuDetailFont = [UIFont systemFontOfSize:10];
        _menuDetailColor = [UIColor lightGrayColor];
        _subMenuBGColor = [UIColor whiteColor];
        _subMenuFont = [UIFont systemFontOfSize:12];
        _subMenuColor = [UIColor darkGrayColor];
        _subMenuDetailFont = [UIFont systemFontOfSize:10];
        _subMenuDetailColor = [UIColor lightGrayColor];
        [self setup];
    }
    return self;

}

- (void)setup {
    _titleBtn = [[UIButton alloc] initWithFrame:self.bounds];
    _titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_titleBtn addTarget:self action:@selector(onTitleClick:) forControlEvents:UIControlEventTouchUpInside];
    [_titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_titleBtn setTitle:self.categories.firstObject.name forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:@"cell_icon_choose_arrow_n_4a"] forState:UIControlStateNormal];
    [_titleBtn setImageDirection:ImageDirectionRight withSpan:5];
    [self addSubview:_titleBtn];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_BAR_HEIGHT - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_BAR_HEIGHT)];
    _tableView.hidden = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = self.bgColor;
    [_tableView registerClass:TreeMenuCell.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(TreeMenuCell.class)];
    [_tableView registerClass:TreeMenuSubCell.class forCellReuseIdentifier:NSStringFromClass(TreeMenuSubCell.class)];
    [self.superView addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)onTitleClick:(UIButton *)sender {
    if (self.tableView.hidden) {
        [self open];
    } else {
        [self close];
    }
}

- (void)open {
    if (!self.superView) return;
    self.tableView.hidden = NO;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        self.tableView.frame = CGRectMake(0, NAVI_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_BAR_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.titleBtn.imageView.transform = CGAffineTransformIdentity;
        self.tableView.frame = CGRectMake(0, NAVI_BAR_HEIGHT - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_BAR_HEIGHT);
    } completion:^(BOOL finished) {
        self.tableView.hidden = YES;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentIndex == section ) {
        return self.categories[section].practices.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  MENU_TITLE_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TreeMenuCell *menuCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(TreeMenuCell.class)];
    menuCell.delegate = self;
    menuCell.tag = section;
    menuCell.contentView.backgroundColor = self.menuBGColor;
    menuCell.titleLabel.textColor = self.menuColor;
    menuCell.titleLabel.font = self.menuFont;
    menuCell.subTitleLabel.textColor = self.menuDetailColor;
    menuCell.subTitleLabel.font = self.menuDetailFont;
    menuCell.titleLabel.text = self.categories[section].name;
    menuCell.subTitleLabel.text = [NSString stringWithFormat:@"%ld题", self.categories[section].totalCount];
    return menuCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeMenuSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TreeMenuSubCell.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.subMenuBGColor;
    cell.titleLabel.font = self.subMenuFont;
    cell.titleLabel.textColor = self.subMenuColor;
    cell.subTitleLabel.font = self.subMenuDetailFont;
    cell.subTitleLabel.textColor = self.subMenuDetailColor;
    cell.titleLabel.text = self.categories[indexPath.section].practices[indexPath.row].name;
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld题",self.categories[indexPath.section].practices[indexPath.row].itemCount];
    UIColor *circleColor = [UIColor greenColor];
    NSInteger i = indexPath.row % 3;
    if (i == 0) {
        circleColor = [UIColor redColor];
    } else if (i == 1) {
        circleColor = [UIColor yellowColor];
    } else {
        circleColor = [UIColor blueColor];
    }
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.numberLabel.textColor = circleColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.titleBtn setTitle:self.categories[indexPath.section].name forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(treeMenu:didSelectItemAtIndexPath:)]) {
        [self.delegate treeMenu:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - TreeMenuCellDelegate
- (void)treeMenuCellClicked:(TreeMenuCell *)menuCell {
    if (self.categories[menuCell.tag].practices.count < 1) {
        [self.titleBtn setTitle:self.categories[menuCell.tag].name forState:UIControlStateNormal];
    }
    if (self.currentIndex == menuCell.tag) {
        [menuCell close];
        self.displayingMenuCell = nil;
        NSInteger pre = self.currentIndex;
        self.currentIndex = -1;
        NSInteger rows = self.categories[pre].practices.count;
        NSMutableArray *ips = [NSMutableArray array];
        for (int i = 0; i < rows; i ++) {
            [ips addObject:[NSIndexPath indexPathForRow:i inSection:pre]];
        }
        [self.tableView deleteRowsAtIndexPaths:ips withRowAnimation:UITableViewRowAnimationTop];
    } else {
        if (self.displayingMenuCell) {
            [self.displayingMenuCell close];
        }
        [menuCell open];
        self.displayingMenuCell = menuCell;
        NSInteger pre = self.currentIndex;
        self.currentIndex = -1;
        if (pre != -1) {
            NSInteger rows = self.categories[pre].practices.count;
            NSMutableArray *ips = [NSMutableArray array];
            for (int i = 0; i < rows; i ++) {
                [ips addObject:[NSIndexPath indexPathForRow:i inSection:pre]];
            }
            [self.tableView deleteRowsAtIndexPaths:ips withRowAnimation:UITableViewRowAnimationTop];
        }
        self.currentIndex = menuCell.tag;
        if (self.currentIndex != -1) {
            NSMutableArray *ips = [NSMutableArray array];
            NSInteger rows = self.categories[self.currentIndex].practices.count;
            for (int i = 0; i < rows; i ++) {
                [ips addObject:[NSIndexPath indexPathForRow:i inSection:self.currentIndex]];
            }

            [self.tableView insertRowsAtIndexPaths:ips withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}
@end
