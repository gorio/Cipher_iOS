//
//  ViewController.m
//  Cipher
//
//  Created by GORIO Engenharia on 6/26/15.
//  Copyright (c) 2015 Cipher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    array = [[NSMutableArray alloc]init];
    
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://tmp.eidoscode.com/cipher/ws.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
    {
        webData = [[NSMutableData alloc]init];
    }

    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *alldata = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *conteudo = [alldata objectForKey:@"conteudo"];
    
    for (NSDictionary *diction in conteudo) {
        NSString *result = [NSString stringWithFormat: @"%@ %@ %@ %@", [diction objectForKey:@"title"], [diction objectForKey:@"description"], [diction objectForKey:@"valor"],[diction objectForKey:@"image"]];
        
        
        [array addObject:result];
    }
    
    [[self myTableView]reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)buttonLoad:(id)sender {
//    
//    [array removeAllObjects];
//    
//    NSURL *url = [NSURL URLWithString:@"http://tmp.eidoscode.com/cipher/ws.json"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    
//    if (connection)
//    {
//        webData = [[NSMutableData alloc]init];
//    }
//    
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

@end
