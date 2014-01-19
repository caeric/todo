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
@property (nonatomic, strong) UITextView *toDoNewTextView;
@property (nonatomic, strong) NSString *toDoNewString;
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
    [self.tableView reloadData];

}

- (void)doneAddingToDo {
    self.isAddingToDo = false;
    self.navigationItem.rightBarButtonItem = self.buttonItemAdd;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%@", @"# of sections");
    if (self.isAddingToDo) {
        return 2;
    }
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%@", @"# of rows in section");
    if (self.isAddingToDo && section == 0) {
        return 1;
    } else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", @"in cell for row index pat");
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    if (self.isAddingToDo && indexPath.section == 0) {
        CellIdentifier = @"ToDoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        ((ToDoCell*)cell).toDoItemTextView.delegate = self;
        ((ToDoCell*)cell).toDoItemTextView.contentSize = CGSizeMake(((ToDoCell*)cell).toDoItemTextView.contentSize.width, 44);
        self.toDoNewTextView = ((ToDoCell*)cell).toDoItemTextView;
    } else {
        CellIdentifier = @"ToDoEnteredCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    }
   // static NSString *CellIdentifier = @"ToDoCell";
    
//    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    // Configure the cell...
    
    return cell;
}

- (void) textViewDidChange:(UITextView *)textView
{
    self.toDoNewString = textView.text;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isAddingToDo && self.toDoNewTextView && indexPath.section == 0 && indexPath.row == 0) {
//        NSLog(@"%f", self.toDoNewTextView.contentSize.height);
        if (self.toDoNewTextView.contentSize.height > 44) {
            return self.toDoNewTextView.contentSize.height;
        }
    }
    return self.tableView.rowHeight;
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
