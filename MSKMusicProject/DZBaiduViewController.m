//
//  DZBaiduViewController.m
//  MSKMusicProject
//
//  Created by msk on 13-9-2.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import "DZBaiduViewController.h"
#import "DZMusicCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "DZMusicModel.h"
#import "AFJSONRequestOperation.h"
#define MUSICSEARCH @"音乐搜索"
#define CANCELSEARCH @"取消"

@interface DZBaiduViewController (){
	NSMutableArray *musicArr;
	DZMusicModel *currentFile;
	MBProgressHUD *HUD;
	NSString *currentElement;
	NSString *rootElement;
	NSString *currentUrl;
}

@end

@implementation DZBaiduViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:MUSICSEARCH style:UIBarButtonItemStylePlain target:self action:@selector(showSearchBar)];
  self.navigationItem.rightBarButtonItem = item;
	
	musicArr = [[NSMutableArray alloc] init];
	CGRect rect = [[UIScreen mainScreen] bounds];
	self.searchBar  = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -44, CGRectGetWidth(rect), 44)];
	self.searchBar.delegate = self;
	self.searchBar.hidden = YES;
	self.searchBar.tag = 901;
	[self.view addSubview:self.searchBar];
	
	HUD = [[MBProgressHUD  alloc] initWithView:self.view];
	[HUD setLabelText:@"搜索中……"];
	[self.view addSubview:HUD];
	
}



//弹出、消失搜索框
-(void)showSearchBar{
	UIBarButtonItem *rightBar = self.navigationItem.rightBarButtonItem;

	CGRect rect = self.searchBar.frame;
	if (self.searchBar.tag == 901) {
rightBar.title = CANCELSEARCH;
		self.searchBar.hidden = NO;
		rect.origin.y = 0.0f;
	}else{
rightBar.title = MUSICSEARCH;		
		rect.origin.y = -44.0f;
	}
	
	[UIView animateWithDuration:0.3f animations:^{
    if (self.searchBar.tag == 901) {
			self.searchBar.tag = 900;
		}else{
			self.searchBar.tag = 901;
		}
		self.searchBar.frame = rect;
	} completion:^(BOOL finished) {
		if (self.searchBar.tag == 901) {
			[self.view endEditing:YES];	
		}
	}];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[self.view endEditing:YES];	
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self.view endEditing:YES];
	[HUD show:YES];
	__weak DZBaiduViewController *dazBaidu = self;
	Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
  if (reach.currentReachabilityStatus != NotReachable) {
			[self startRequestOpWithName:dazBaidu.searchBar.text];
	}else{
		[HUD hide:YES];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接错误" message:@"网络连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
}

-(void)startRequestOpWithName:(NSString *)string{

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:BAIDUMUSIC_API(string)]];
	NSDictionary *parameters = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@$$$$$",string] forKey:@"title"];

	// 2
		

		NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:BAIDUMUSIC_API(@"求佛")]];
	AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
		 XMLParser.delegate = self;
		[XMLParser parse];
		NSLog(@"111111111111111");
	} failure:nil];

	[operation start];
//
	AFXMLRequestOperation *operation1 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request1 success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser1) {
		 XMLParser1.delegate = self;
		[XMLParser1 parse];
		NSLog(@"22222222222222");
	} failure:nil];
	
	[operation1 start];
}


#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	currentElement = elementName;
	if([elementName isEqualToString:@"durl"]||[elementName isEqualToString:@"p2p"])
	{
		rootElement = elementName;
		currentFile = [[DZMusicModel alloc] init];
		currentFile.fileReceivedData = [[NSMutableData alloc] init];
		currentFile.fileReceivedSize=@"0";
		currentFile.fileID=@"";
		currentFile.fileName = self.searchBar.text;
		currentFile.fileSize=@"未知";
		currentFile.fileURL=@"";
		currentFile.isDownloading=NO;
		currentFile.isP2P=NO;
	}
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
	NSString *tmpurl=[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
	if([rootElement isEqualToString:@"durl"])
	{
		if([currentElement isEqualToString:@"encode"])
		{
			currentUrl=tmpurl;
			NSRange range=[currentUrl rangeOfString:[currentUrl lastPathComponent]];
			currentUrl=[currentUrl substringToIndex:range.location];
		}
		if([currentElement isEqualToString:@"decode"])
		{
			currentUrl=[currentUrl stringByAppendingString:tmpurl];
		}
		currentFile.fileURL=currentUrl;
	}
	if([rootElement isEqualToString:@"p2p"])
	{
		if([currentElement isEqualToString:@"url"])
		{
			currentUrl=tmpurl;
			currentFile.fileURL=currentUrl;
		}
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if([elementName isEqualToString:@"durl"]||[elementName isEqualToString:@"p2p"])
	{
		if((![currentFile.fileURL isEqualToString:@""])&&currentFile.fileURL!=nil)
		{
			[musicArr addObject:currentFile];
		}

		//self.rootElement=@"";
		//self.currentElement=@"";
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
	NSLog(@"string:%@",string);
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	
	for(DZMusicModel *file in musicArr)
	{
		if([file.fileSize isEqualToString:@"未知"]||file.fileSize==nil)
		{
			
			//			ASIHTTPRequest *urlRequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:file.fileURL]];
//			[urlRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//			urlRequest.delegate=self;
//			[urlRequest setUserInfo:[NSDictionary dictionaryWithObject:file forKey:@"File"]];
//			[NSThread detachNewThreadSelector:@selector(beginRequest:) toTarget:self withObject:urlRequest];
//			[self.connList addObject:urlRequest];
//			while (self.isFinished)
//			{
//				[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//			}
		}
	}
	
	[HUD hide:YES];
}

#pragma mark - UITableViewDdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return musicArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentify = @"musicCell";
    
    DZMusicCell *cell = (DZMusicCell *)[tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = (DZMusicCell *)[[[NSBundle mainBundle] loadNibNamed:@"DZMusicCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
