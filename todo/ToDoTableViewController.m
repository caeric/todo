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

static NSString *TODO_KEY = @"TODO_KEY";

@interface ToDoTableViewController ()
@property (nonatomic, assign) BOOL isAddingToDo;
@property (nonatomic, strong) UIBarButtonItem *buttonItemDone;
@property (nonatomic, strong) UIBarButtonItem *buttonItemDoneEdit;
@property (nonatomic, strong) UIBarButtonItem *buttonItemAdd;
@property (nonatomic, strong) UITextView *toDoNewTextView;
@property (nonatomic, strong) UITextField *toDoTextField;
@property (nonatomic, strong) NSString *toDoNewString;
@property (nonatomic, strong) NSMutableArray *todosArray;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (strong, nonatomic) UIBarButtonItem *buttonItemEdit;
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
        self.buttonItemDoneEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingTodo)];
        self.buttonItemEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onEditTapped:)];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.todosArray = [[self.userDefaults arrayForKey:TODO_KEY] mutableCopy];
        if (!self.todosArray) {
            self.todosArray = [[NSMutableArray alloc]init];
            
        }
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
    self.navigationItem.leftBarButtonItem = self.buttonItemEdit;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addToDo {
    self.isAddingToDo = true;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.buttonItemDone;
    [self.tableView reloadData];

}

- (void)doneEditingTodo {
    [self setEditing:false animated:YES];
    self.navigationItem.leftBarButtonItem = self.buttonItemEdit;
}

- (void)doneAddingToDo {
    if (self.toDoNewTextView.text.length > 0) {
        NSString *todo = self.toDoNewTextView.text;
        [self.todosArray insertObject:todo atIndex:0];
        self.toDoNewTextView.text = @"";
        [self.userDefaults setObject:self.todosArray forKey:TODO_KEY];
        [self.userDefaults synchronize];
    }
    self.isAddingToDo = false;
    self.navigationItem.rightBarButtonItem = self.buttonItemAdd;
    self.navigationItem.leftBarButtonItem.enabled = YES;
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
        return self.todosArray.count;
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
        [self.toDoNewTextView becomeFirstResponder];
    } else {
        CellIdentifier = @"ToDoEnteredCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.showsReorderControl = YES;
        self.toDoTextField = ((ToDoEnteredCell*)cell).todo;
        ((ToDoEnteredCell*)cell).todo.delegate = self;
        ((ToDoEnteredCell*)cell).todo.tag = indexPath.row;
        ((ToDoEnteredCell*)cell).todo.text = [self.todosArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void) textViewDidChange:(UITextView *)textView
{
    self.toDoNewString = textView.text;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.todosArray replaceObjectAtIndex:textField.tag withObject:textField.text];
    [self.userDefaults setObject:self.todosArray forKey:TODO_KEY];
    [self.userDefaults synchronize];
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

- (void)onEditTapped:(id)sender {
    self.navigationItem.leftBarButtonItem = self.buttonItemDoneEdit;
    [self setEditing: YES animated: YES];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    NSArray *visibleCells = [self.tableView visibleCells];
    if (editing) {
        self.buttonItemAdd.enabled = NO;
    } else {
        self.buttonItemAdd.enabled = YES;
    }
    for (ToDoEnteredCell *cell in visibleCells)
        cell.todo.enabled = editing;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    NSLog(@"");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todosArray removeObjectAtIndex:indexPath.row];
        [self.userDefaults setObject:self.todosArray forKey:TODO_KEY];
        [self.userDefaults synchronize];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSString *srcString = [self.todosArray objectAtIndex:sourceIndexPath.row];
    NSString *destString = [self.todosArray objectAtIndex:proposedDestinationIndexPath.row];
    [self.todosArray replaceObjectAtIndex:proposedDestinationIndexPath.row withObject:srcString];
    [self.todosArray replaceObjectAtIndex:sourceIndexPath.row withObject:destString];
    [self.userDefaults setObject:self.todosArray forKey:TODO_KEY];
    [self.userDefaults synchronize];
    return proposedDestinationIndexPath;
}

@end
