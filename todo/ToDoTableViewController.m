//
//  ToDoTableViewController.m
//  todo
//
//  Created by Eric Hung on 1/15/14.
//  Copyright (c) 2014 Eric Hung. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "ToDoCell.h"
#import "ToDoEnteredCell.h"

@interface ToDoTableViewController ()
@property (nonatomic, assign) BOOL isAddingToDo;
@property (nonatomic, strong) UIBarButtonItem *buttonItemDone;
@property (nonatomic, strong) UIBarButtonItem *buttonItemAdd;
@end

@implementation ToDoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.buttonItemAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToDo)];
        self.buttonItemDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAddingToDo)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *toDoCellNib = [UINib nibWithNibName:@"ToDoCell" bundle:nil];
    [self.tableView registerNib:toDoCellNib forCellReuseIdentifier:@"ToDoCell"];
    UINib *toDoCellEnteredNib = [UINib nibWithNibName:@"ToDoEnteredCell" bundle:nil];
    [self.tableView registerNib:toDoCellEnteredNib forCellReuseIdentifier:@"ToDoEnteredCell"];
    self.navigationItem.rightBarButtonItem = self.buttonItemAdd;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addToDo {
    self.isAddingToDo = true;
    self.navigationItem.rightBarButtonItem = self.buttonItemDone;
}

- (void)doneAddingToDo {
    self.isAddingToDo = false;
    self.navigationItem.rightBarButtonItem = self.buttonItemAdd;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    ToDoEnteredCell *cell;
    if (indexPath.section == 0) {
        CellIdentifier = @"ToDoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    } else {
        CellIdentifier = @"ToDoEnteredCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
   // static NSString *CellIdentifier = @"ToDoCell";
    
//    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
